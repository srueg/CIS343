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

#define BUFFER_SIZE 256

FILE *open_file(const char *filename, const char *mode);
uint8_t read_lines(FILE *input_file, FILE *output_file);
bool validate_line(const char *line, char *error_message);

const char *output_filename = "BMSOut.txt";

const char ASTERISK = '*', SPACE = ' ';

enum STATE{
    COMMENT,
    LABEL,
    OPERAND,
    ERROR
};

int main(int argc, char *argv[]) {

    if(argc != 2){
        fprintf(stderr, "Invalid count of command line arguments. Usgae: bmsc <input-file>\n");
        return EXIT_FAILURE;
    }
    
    FILE *input_file = open_file(argv[1], "r");
    FILE *output_file = open_file(output_filename, "w");

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
    char line[BUFFER_SIZE];
    char error_message[BUFFER_SIZE];
    uint8_t errors = 0;

    while (fgets(line, BUFFER_SIZE, input_file)) {
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
    if(line[0] != SPACE && line[0] != ASTERISK && !isalpha(line[0])){
        strcpy(error_message, "Non valid character in column 1");
        return false;
    }
    return true;
} 
