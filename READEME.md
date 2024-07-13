# Project Name: Binary Builder

## Overview
Binary Builder is a compiler project designed to parse and evaluate arithmetic expressions, leveraging Bison/Yacc for parsing and Flex for lexical analysis. This project aims to process input expressions and generate corresponding output.

## Features
- Parsing and evaluation of arithmetic expressions
- Support for basic operators (+, -, *, /)
- Error handling for syntax errors
- Command-line interface for ease of use

## Getting Started
To compile and run Binary Builder on your local machine, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/mohitdudhat22/BinaryBuilder.git
   cd binary-builder
   ```

2. **Build the Compiler:**
    ```bash
    flex lexer.l              # Generate lex.yy.c from lexer.l
    bison -d parser.y         # Generate parser.tab.c and parser.tab.h from parser.y
    gcc lex.yy.c parser.tab.c -o binary-builder   # Compile lexer and parser into an executable named 'binary-builder'
    ```
3. **Run the Compiler::**
    ```bash
    ./binary-builder
    ```

4. **Example Usage:**
    ```bash
    $ ./binary-builder
    2 + 5
    Result: 7
    ```