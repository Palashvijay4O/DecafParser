/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_DECAF_TAB_H_INCLUDED
# define YY_YY_DECAF_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CLASS = 258,
    PROGRAM = 259,
    VOID = 260,
    IF = 261,
    FOR = 262,
    ELSE = 263,
    RETURN = 264,
    BREAK = 265,
    CONTINUE = 266,
    CALLOUT = 267,
    INT_DECLARATION = 268,
    BOOLEAN_DECLARATION = 269,
    ID = 270,
    STRING = 271,
    ASSIGN_OP = 272,
    ADD = 273,
    SUB = 274,
    DIV = 275,
    MUL = 276,
    MOD = 277,
    EQUAL = 278,
    SMALLER = 279,
    GREATER = 280,
    ESMALLER = 281,
    EGREATER = 282,
    EQUALEQUAL = 283,
    NOTEQUAL = 284,
    AND = 285,
    OR = 286,
    INT = 287,
    BOOLEAN = 288,
    CHARACTER = 289,
    USUB = 290
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 17 "decaf.y" /* yacc.c:1915  */

    int ival;
    bool bval;
    char cval;
    char *sval;

#line 97 "decaf.tab.h" /* yacc.c:1915  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_DECAF_TAB_H_INCLUDED  */
