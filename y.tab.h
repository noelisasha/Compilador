
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     CONS_ENTERO = 258,
     CONS_FLOAT = 259,
     CONS_STRING = 260,
     PR_WRITE = 261,
     PR_READ = 262,
     PR_WHILE = 263,
     PR_IF = 264,
     PR_ELSE = 265,
     PR_STR_DECLARA = 266,
     PR_END_DECLARA = 267,
     PR_INT = 268,
     PR_FLOAT = 269,
     PR_STRING = 270,
     PR_BETWEEN = 271,
     PR_AVG = 272,
     ID = 273,
     COMA = 274,
     PUNTOCOMA = 275,
     PUNTO = 276,
     DOS_PUNTOS = 277,
     APAR = 278,
     CPAR = 279,
     ALLV = 280,
     CLLV = 281,
     ACOR = 282,
     CCOR = 283,
     OP_ASIG = 284,
     OP_SUMA = 285,
     OP_REST = 286,
     OP_PROD = 287,
     OP_DIVI = 288,
     OP_MEN = 289,
     OP_MAY = 290,
     OP_MAYI = 291,
     OP_MENI = 292,
     OP_EQ = 293,
     OP_NEQ = 294,
     OP_AND = 295,
     OP_OR = 296,
     OP_NOT = 297
   };
#endif
/* Tokens.  */
#define CONS_ENTERO 258
#define CONS_FLOAT 259
#define CONS_STRING 260
#define PR_WRITE 261
#define PR_READ 262
#define PR_WHILE 263
#define PR_IF 264
#define PR_ELSE 265
#define PR_STR_DECLARA 266
#define PR_END_DECLARA 267
#define PR_INT 268
#define PR_FLOAT 269
#define PR_STRING 270
#define PR_BETWEEN 271
#define PR_AVG 272
#define ID 273
#define COMA 274
#define PUNTOCOMA 275
#define PUNTO 276
#define DOS_PUNTOS 277
#define APAR 278
#define CPAR 279
#define ALLV 280
#define CLLV 281
#define ACOR 282
#define CCOR 283
#define OP_ASIG 284
#define OP_SUMA 285
#define OP_REST 286
#define OP_PROD 287
#define OP_DIVI 288
#define OP_MEN 289
#define OP_MAY 290
#define OP_MAYI 291
#define OP_MENI 292
#define OP_EQ 293
#define OP_NEQ 294
#define OP_AND 295
#define OP_OR 296
#define OP_NOT 297




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 27 "Sintactico.y"

    char* str;



/* Line 1676 of yacc.c  */
#line 142 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


