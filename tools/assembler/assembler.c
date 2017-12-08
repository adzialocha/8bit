/*
 * assembler.c
 * ------
 * Reads a 8bit cpu assembler file and writes a compiled executable
 * for our architecture.
 *
 * Compile project via: clang assembler.c -o assembler
 *
 * Usage: ./assembler program.asm program.o
 */

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VERSION                 "0.1"

#define PROGRAM_MEMORY_SIZE     256

#define MAX_JUMP_COUNT          64
#define MAX_LABEL_COUNT         32
#define MAX_LABEL_LENGTH        32
#define MAX_LINE_LENGTH         128
#define OPCODE_COUNT            25


/*
 * Struct: label
 * ------
 * Placeholder for occurring label and jump declaration, mapping
 * the address in the program memory to the label name.
 */

struct label
{
    int memory_addr;
    char label[MAX_LABEL_LENGTH];
};


/*
 * Struct: opcode
 * ------
 * Holds data about opcode mnemonic and its microcode addresses
 * for the regarding addressing modes.
 */

typedef struct
{
    char mnemonic[3];   // Mnemonic of opcode

    int a;              // Single-byte instruction (no operand)

    int a_abs;          // Absolute  $00
    int a_imm;          // Immediate #$00
    int a_idx;          // Indexed   $00,b
    // int a_ind;       // Indirect  ($00) @TODO

    int a_label;        // Labelled
} opcode;


/*
 * Table: OPCODES[]
 * ------
 * Lists all given opcodes of our architecture defining
 * their microcode addresses in the control unit (CU).
 */

static const opcode OPCODES[] =
{
    { "add", 0x00, 0x01, 0x02, 0x00, 0x00 },
    { "and", 0x00, 0x03, 0x04, 0x00, 0x00 },
    { "asl", 0x00, 0x05, 0x06, 0x00, 0x00 },
    { "beq", 0x00, 0x00, 0x00, 0x00, 0xd1 },
    { "cmp", 0x00, 0x07, 0x08, 0x00, 0x00 },
    { "dec", 0x3e, 0x00, 0x00, 0x00, 0x00 },
    { "eor", 0x00, 0x09, 0x0a, 0x00, 0x00 },
    { "inc", 0x3c, 0x00, 0x00, 0x00, 0x00 },
    { "jmp", 0x00, 0x0b, 0x0c, 0x00, 0xd2 },
    { "jsr", 0x00, 0x00, 0x00, 0x00, 0xd3 },
    { "lda", 0x00, 0x0e, 0x0f, 0x00, 0x00 },
    { "ldb", 0x00, 0x10, 0x11, 0x00, 0x00 },
    { "lsl", 0x00, 0x12, 0x13, 0x00, 0x00 },
    { "lsr", 0x00, 0x14, 0x15, 0x00, 0x00 },
    { "ora", 0x00, 0x16, 0x17, 0x00, 0x00 },
    { "pha", 0x00, 0x18, 0x19, 0x00, 0x00 },
    { "pla", 0x00, 0x1a, 0x1b, 0x00, 0x00 },
    { "rol", 0x00, 0x1c, 0x1d, 0x00, 0x00 },
    { "ror", 0x00, 0x1e, 0x1f, 0x00, 0x00 },
    { "rts", 0x3d, 0x00, 0x00, 0x00, 0x00 },
    { "sta", 0x00, 0x22, 0x23, 0x40, 0x00 },
    { "stb", 0x00, 0x24, 0x25, 0x00, 0x00 },
    { "sub", 0x00, 0x26, 0x27, 0x00, 0x00 },
    { "tab", 0x00, 0x28, 0x29, 0x00, 0x00 },
    { "tba", 0x00, 0x2a, 0x2b, 0x00, 0x00 }
};


/*
 * Function: print_syntax_error
 * ------
 * Prints a formatted error message for the user.
 *
 * message: Error message string
 * token: Related artefact
 * line_index: Line number in code (-1 when not given)
 */

void print_syntax_error (char *message, char *token, int line_index)
{
    if (line_index > -1)
    {
        printf(
            "Found syntax error in '%s' @ line %i (%s)!\n",
            token,
            line_index,
            message
        );
    }
    else
    {
        printf(
            "Found syntax error in '%s' (%s)!\n",
            token,
            message
        );
    }
}


/*
 * Function: remove_comments
 * ------
 * Removes all assembler-style comments (;) from a string
 *
 * str: The processed string
 */

void remove_comments (char *str)
{
    int i;

    for (i = 0; str[i] != 00; i++)
    {
        if (str[i] == ';')
        {
            str[i] = 00;
            break;
        }
    }
}


/*
 * Function: remove_comments
 * ------
 * Checks if string holds only symbols describing a hexadecimal number
 *
 * str: The processed string
 *
 * returns: 1 if string represents a hexadecimal number, otherwise 0
 */

bool is_hex_str (char *str)
{
    int i;
    bool result = 1;

    for (i = 0; str[i] != 00; i++)
    {
        if (!isxdigit(str[i]))
        {
            result = 0;
            break;
        }
    }

    return result;
}


/*
 * Function: find_opcode_index
 * ------
 * Returns the index of the opcode lookup table
 *
 * mnemonic: The mnemonic of the opcode
 *
 * returns: index of opcode in lookup table
 */

int find_opcode_index (char *mnemonic)
{
    int i;
    int found_index = -1;

    for (i = 0; i < OPCODE_COUNT; i++)
    {
        if (strncmp(OPCODES[i].mnemonic, mnemonic, 3) == 0)
        {
            found_index = i;
            break;
        }
    }

    return found_index;
}


/*
 * Function: handle_opcode
 * ------
 * Adds the single opcode (1byte) microcode instruction to the program.
 *
 * program: The program
 * index: Index of the current line in program
 * op: Index of the opcode in lookup-table
 */

void handle_opcode (int *program, int index, int op)
{
    program[index] = OPCODES[op].a;
}


/*
 * Function: handle_opcode_and_operand
 * ------
 * Adds the opcode + operand (2byte) microcode instruction to the program.
 *
 * program: The program
 * index: Index of the current line in program
 * op: Index of the opcode in lookup-table
 * addr: Operand / address
 */

void handle_opcode_and_operand (int *program, int index, int op, char *addr)
{
    char* stripped_addr;

    if (addr[0] == '#')
    {
        // Immediate adressing mode
        program[index] = OPCODES[op].a_imm;
        stripped_addr = addr + 2;
    }
    else if (strlen(addr) > 3 && addr[strlen(addr) - 2] == ',')
    {
        // Indexed adressing mode
        program[index] = OPCODES[op].a_idx;
        stripped_addr = addr + 1;
        stripped_addr[strlen(stripped_addr) - 2] = 0;
    }
    else
    {
        // Absolute adressing mode
        program[index] = OPCODES[op].a_abs;
        stripped_addr = addr + 1;
    }

    if (!is_hex_str(stripped_addr))
    {
        print_syntax_error("Invalid address format", addr, 0);
        exit(EXIT_FAILURE);
    }

    int hex_int = (int) strtol(stripped_addr, NULL, 16);

    if (hex_int < 0 || hex_int > PROGRAM_MEMORY_SIZE - 1)
    {
        print_syntax_error("Invalid address range", addr, 0);
        exit(EXIT_FAILURE);
    }

    program[index + 1] = hex_int;
}


/*
 * Function: print_and_save_program
 * ------
 * Writes the compiled program to a file and
 * prints the result to the screen.
 *
 * file: Write file
 * program: The compiled program
 * size: Length of the program (in bytes)
 */

void print_and_save_program (FILE *file, int *program, int size)
{
    int i;

    for (i = 0; i < size; i++)
    {
        fprintf(file, "%02x ", program[i]);
        printf("%02x", program[i]);

        // Pretty print for screen
        if (i % 16 == 15)
        {
            printf("\n");
        }
        else
        {
            printf(" ");
        }
    }
}


/*
 * Function: main
 * ------
 * Reads a 8bit cpu assembler file and writes a compiled executable
 * for our architecture.
 *
 * Usage: ./assembler program.asm program.o
 */

int main (int argc, char **argv)
{
    printf("===============================================\n");
    printf("            8bit cpu assembler v%s\n", VERSION);
    printf("===============================================\n");

    // Get input file
    char *file_path = argv[1];
    FILE *file;

    file = fopen(file_path, "r");

    if (file == 0)
    {
        printf("Error: Please specify a valid file path.\n");
        exit(EXIT_FAILURE);
    }

    // Check output file
    char *write_file_path = argv[2];

    if (!write_file_path)
    {
        printf("Error: Please specify a valid out file path.\n");
        exit(EXIT_FAILURE);
    }

    // Variables for stream reading
    char line[MAX_LINE_LENGTH];
    char *token = NULL;

    // Variables for parsing and error output
    int opcode_index = -1;
    int current_line_index = 1;

    // The compiled program variables
    int program[PROGRAM_MEMORY_SIZE];
    int program_adr = 0;

    // Lookup table for labels
    struct label label_table[MAX_LABEL_COUNT];
    int label_table_count = 0;

    // Lookup table for labelled jump instructions
    struct label jump_table[MAX_JUMP_COUNT];
    int jump_table_count = 0;

    // Read file line by line
    while (fgets(line, sizeof line, file) != NULL)
    {
        remove_comments(line);
        token = strtok(line, "\n\t\r ");

        while (token)
        {
            // Expects operand (address or label) of two-byte instruction
            if (opcode_index > -1)
            {
                if
                (
                    (
                        OPCODES[opcode_index].a_idx &&
                        token[0] == '$' &&
                        token[strlen(token) - 2] == ',' &&
                        token[strlen(token) - 1] == 'b'
                    ) ||
                    (
                        OPCODES[opcode_index].a_abs &&
                        token[0] == '$' &&
                        token[strlen(token) - 2] != ','
                    ) ||
                    (
                        OPCODES[opcode_index].a_imm &&
                        token[0] == '#'
                    )
                )
                {
                    // Found an address
                    handle_opcode_and_operand(
                        program,
                        program_adr,
                        opcode_index,
                        token
                    );
                }
                else if
                (
                    OPCODES[opcode_index].a_label
                )
                {
                    // Found a label
                    if (jump_table_count > MAX_JUMP_COUNT)
                    {
                        print_syntax_error(
                            "Exceeded jump count",
                            token,
                            current_line_index
                        );

                        exit(EXIT_FAILURE);
                    }
                    else if (strlen(token) > MAX_LABEL_LENGTH)
                    {
                        print_syntax_error(
                            "Label name is too long",
                            token,
                            current_line_index
                        );

                        exit(EXIT_FAILURE);
                    }

                    // Write instruction to program with placeholder
                    program[program_adr] = OPCODES[opcode_index].a_label;
                    program[program_adr + 1] = 0x00;

                    // Store position for final processing
                    jump_table[jump_table_count].memory_addr = program_adr + 1;
                    strcpy(jump_table[jump_table_count].label, token);
                    jump_table_count += 1;
                }
                else
                {
                    print_syntax_error(
                        "Invalid or missing operand",
                        token,
                        current_line_index
                    );

                    exit(EXIT_FAILURE);
                }

                opcode_index = -1;
                program_adr += 2;
            }
            else
            {
                // Handle label or opcode
                int op = find_opcode_index(token);

                // Is token an opcode?
                if (op > -1)
                {
                    // Will an operand be expected in next token?
                    if (!OPCODES[op].a)
                    {
                        // Prepare two-byte instruction
                        opcode_index = op;
                    }
                    else
                    {
                        // Handle single byte instruction
                        handle_opcode(
                            program,
                            program_adr,
                            op
                        );

                        program_adr += 1;
                    }
                }
                else if (token[(strlen(token) - 1)] == ':')
                {
                    // Token is a label, strip the last character (:)
                    token[strlen(token) - 1] = 0;

                    if (label_table_count > MAX_LABEL_COUNT)
                    {
                        print_syntax_error(
                            "Exceeded label count",
                            token,
                            current_line_index
                        );

                        exit(EXIT_FAILURE);
                    }
                    else if (strlen(token) > MAX_LABEL_LENGTH)
                    {
                        print_syntax_error(
                            "Label name is too long",
                            token,
                            current_line_index
                        );

                        exit(EXIT_FAILURE);
                    }

                    // Store it in table for later processing
                    label_table[label_table_count].memory_addr = program_adr;
                    strcpy(label_table[label_table_count].label, token);

                    label_table_count += 1;
                }
                else
                {
                    print_syntax_error(
                        "Unkown opcode",
                        token,
                        current_line_index
                    );

                    exit(EXIT_FAILURE);
                }
            }

            if (program_adr > PROGRAM_MEMORY_SIZE)
            {
                print_syntax_error(
                    "Program exceeds memory size",
                    token,
                    current_line_index
                );

                exit(EXIT_FAILURE);
            }

            token = strtok(NULL, "\n\t\r ");
        }

        current_line_index += 1;
    }

    fclose(file);

    // Finally replace labels with memory addresses
    int i, n;
    bool found_label;

    for (i = 0; i < jump_table_count; i++)
    {
        found_label = 0;

        for (n = 0; n < label_table_count; n++)
        {
            if (strcmp(jump_table[i].label, label_table[n].label) == 0)
            {
                // Replace label with actual memory location in program
                program[jump_table[i].memory_addr] = label_table[n].memory_addr;
                found_label = 1;
                break;
            }
        }

        if (!found_label)
        {
            print_syntax_error("Could not find label", jump_table[i].label, -1);
            exit(EXIT_FAILURE);
        }
    }

    // Save binary to file and print result
    printf(
        "Successfully compiled program (%i bytes):\n\n",
        program_adr
    );

    FILE * write_file = fopen(write_file_path, "w+");
    print_and_save_program(write_file, program, program_adr);
    fclose(write_file);

    printf("\n\nWrite output to '%s'.\n", write_file_path);

    return 0;
}
