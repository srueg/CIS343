/** 
    Author: Simon Rüegg
    Assignment: C Coding 2
    DuaDate: Monday, October 10, 2016
**/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

#define LINE_BUFFER_SIZE 256
#define MAX_LABEL_LENGTH 7
#define MAX_LINE_LENGTH 74

FILE *open_file(const char *filename, const char *mode);
uint8_t read_lines(FILE *input_file, FILE *output_file);
bool validate_line(const char *line, char *error_message);
bool validate_label(const char *label, char *error_message);
bool validate_opcode(const char *line, char *error_message);
bool validate_operand(const char *line, char *error_message);

const char *OUTPUT_FILENAME = "BMSOut.txt", *END = "END";

const char ASTERISK = '*', SPACE = ' ';

const char *VALID_OPCODES[] = { "DFHMDI", "DFHMDF", "DFHMSD" };
const uint8_t VALID_OPCODES_COUNT = 3;

typedef enum {
    COMMENT,
    LABEL,
    OPERAND,
    OPCODE,
    ENDED
} STATE_T;

int main(int argc, char *argv[]) {

    if(argc != 2){
        fprintf(stderr, "Invalid count of command line arguments. Usgae: bmsc <input-file>\n");
        return EXIT_FAILURE;
    }
    
    FILE *input_file = open_file(argv[1], "r");
    FILE *output_file = open_file(OUTPUT_FILENAME, "w");

    uint8_t error_count = read_lines(input_file, output_file);

    // close file handles
    fclose(output_file);
    fclose(input_file);

    printf("End of Processing - %d errors encountered\n", error_count);
    return EXIT_SUCCESS;
}

/*
 * Author: Simon Rüegg
 * Purpose: Opens a given file in 'mode' and returns the file handle.
 * Inputs: Path to file.
 * Outputs: Open file handle.
 * Error Handling: If the file couldn't be opend, exits and prints error message.
 */
FILE *open_file(const char *filename, const char *mode){
    FILE *fp;
    fp = fopen(filename, mode);
    if(fp == NULL){
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    return fp;
}


/*
 * Author: Simon Rüegg
 * Purpose: Loops through all the lines in the input_file and checks them for errors.
 * Inputs: File handle for input- and output file.
 * Outputs: occured error count
 * Error Handling: If errors occure, exits and prints error message.
 */
uint8_t read_lines(FILE *input_file, FILE *output_file){
    char line[LINE_BUFFER_SIZE];
    char error_message[64];
    uint8_t errors = 0;

    while (fgets(line, LINE_BUFFER_SIZE, input_file)) {
        if(validate_line(line, error_message)){
            fprintf(output_file, "%s", line);
        }else{
            line[strcspn(line, "\n")-1] = 0;
            fprintf(output_file, "%s %s\n", line, error_message);
            errors++;
        }
    }
    return errors;
}

/*
 * Author: Simon Rüegg
 * Purpose: Checks a line for validity.
 * Inputs: Line to check and pointer to pass error message.
 * Outputs: true if line valid, false for invalid (error message stored to *error_message).
 * Error Handling: If line is invalid, error message is saved to error_message pointer.
 */
bool validate_line(const char *line, char *error_message){
    static STATE_T state;

    // check for comment
    if(line[0] == ASTERISK){
        state = COMMENT;
        return true;
    }

    // check if 'END' appeared before
    if(state == ENDED && strlen(line) > 0){
        strcpy(error_message, "Code after END");
        return false;
    }

    if(strncmp(&line[9], END, 3) == 0){
        state = ENDED;
        return true;
    }

    if(line[0] == SPACE){
        if(line[9] == SPACE){
            state = OPERAND;
            if(!validate_operand(line, error_message)){
                return false;
            }
        }else{
            state = OPCODE;
            if(!validate_opcode(line, error_message)){
                return false;
            }
        }
    } else if (isalpha(line[0])){
        state = LABEL;
        if(!validate_label(line, error_message)){
            return false;
        }
    } else{
        strcpy(error_message, "Non valid character in column 1");
        return false;
    }
    if(state != COMMENT && (line[7] != SPACE || line[8] != SPACE)){
        strcpy(error_message, "Non-Blank characters in columns 8 or 9");
        return false;
    }
    return true;
}


/*
 * Author: Simon Rüegg
 * Purpose: Checks a label for validity: 1 to 7 upper case letters.
 * Inputs: Label to check and pointer to pass error message.
 * Outputs: true if label is valid, false for invalid (error message stored to *error_message).
 * Error Handling: If label is invalid, error message is saved to error_message pointer.
 */
bool validate_label(const char *label, char *error_message){
    for(int i=0; i<strlen(label) && label[i] != SPACE; i++){
        if(!isalpha(label[i])){
            strcpy(error_message, "Label contains non alphabetic character");
            return false;
        }
        if(!isupper(label[i])){
            strcpy(error_message, "Label contains lowercase character");
            return false;
        }
        if(i>MAX_LABEL_LENGTH-1){
            strcpy(error_message, "Label too long");
            return false;
        }
    }
    return true;
}

/*
 * Author: Simon Rüegg
 * Purpose: Checks a line for valid op-code.
 * Inputs: Line to check and pointer to pass error message.
 * Outputs: true if op-code in line is valid, false for invalid (error message stored to *error_message).
 * Error Handling: If Opcode is invalid, error message is saved to error_message pointer.
 */
bool validate_opcode(const char *line, char *error_message){
    char opcode[7];

    for(int i=0; i<9; i++){
        if(line[i] != SPACE){
            strcpy(error_message, "Op-code in wrong column");
            return false;
        }
    }

    strncpy(opcode, &line[9], 6);
    opcode[6] = 0;
    for(uint8_t i=0; i<VALID_OPCODES_COUNT; i++){
        if(strcmp(opcode, VALID_OPCODES[i]) == 0){
            if(strlen(line) < 17 || strlen(line) > MAX_LINE_LENGTH || line[15] != SPACE || line[16] == SPACE){
                strcpy(error_message, "Op-code in wrong column");
                return false;
            }
            return true;
        }
    }
    strcpy(error_message, "Illegal Op-code");
    return false;
}

/*
 * Author: Simon Rüegg
 * Purpose: Checks a line for valid operand
 * Inputs: Line to check and pointer to pass error message.
 * Outputs: true if operand in line is valid, false for invalid (error message stored to *error_message).
 * Error Handling: If operand is invalid, error message is saved to error_message pointer.
 */
bool validate_operand(const char *line, char *error_message){
    size_t line_length = strlen(line);
    for(uint8_t i=0; i<15; i++){
        if(line[i] != SPACE){
            strcpy(error_message, "Operand in wrong column");
            return false;
        }
    }
    if(line_length < 16 || line_length > MAX_LINE_LENGTH || line[16] == SPACE){
        strcpy(error_message, "Illegal operand");
        return false;
    }
    return true;
}
