       PROCESS NOSEQ LIB OPTIMIZE(FULL)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PCUSTWVB.
      * ----------------------------------------------------------------
      * A SAMPLE PROGRAM TO GENERATE A SEQUENTIAL FILE
      *
      * PROGRAM TAKES THE NUMBER OF RECORDS TO PRODUCE AS AN ARGUMENT
      * AND THEN GENERATES DATA RANDOMLY TO PRODUCE A FILE WITH THE
      * REQUESTED NUMBER OF RECORDS.
      * ----------------------------------------------------------------
      * WRITES IN A RECFM=VB FILE
      * COBOL LOGICAL LENGTH IS BETWEEN 58 AND 183
      * QSAM LOGICAL RECORD IS BETWEEN 62 AND 187 (COBOL + RDW)
      * ----------------------------------------------------------------

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      *SOURCE-COMPUTER. IBM-390 WITH DEBUGGING MODE.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUTPUT-FILE
           ASSIGN TO OUTFILE
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS W-OUTPUT-FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD OUTPUT-FILE
           RECORDING MODE IS V
           BLOCK CONTAINS 2 RECORDS
           RECORD CONTAINS 58 TO 183 CHARACTERS.
       COPY RCUSTDAT.

       WORKING-STORAGE SECTION.
       01  W-OUTPUT-FILE-STATUS       PIC 9(2).
       01  W-I                        PIC 9(4) COMP.
       01  W-J                        PIC 9(4) COMP.
       01  W-K                        PIC 9(4) COMP.
       01  W-L                        PIC 9(4) COMP.
       01  W-RANDOM-SEED              PIC 9(8).
       01  W-RANDOM                   PIC V9(18).
       01  W-FIRST-NAMES.
           05 FILLER                  PIC X(5) VALUE 'JOHN'.
           05 FILLER                  PIC X(5) VALUE 'BILL'.
           05 FILLER                  PIC X(5) VALUE 'FRED'.
           05 FILLER                  PIC X(5) VALUE 'BOB'.
           05 FILLER                  PIC X(5) VALUE 'RORY'.
       01  FILLER REDEFINES W-FIRST-NAMES.
           05 W-FIRST-NAME OCCURS 5   PIC X(5).
       01  W-LAST-NAMES.
           05 FILLER                  PIC X(15) VALUE 'SMITH'.
           05 FILLER                  PIC X(15) VALUE 'JOHNSON'.
           05 FILLER                  PIC X(15) VALUE 'WILLIAMS'.
           05 FILLER                  PIC X(15) VALUE 'JONES'.
           05 FILLER                  PIC X(15) VALUE 'BROWN'.
       01  FILLER REDEFINES W-LAST-NAMES.
           05 W-LAST-NAME OCCURS 5    PIC X(15).
       01  W-ADDRESSES.
           05 FILLER                  PIC X(20) VALUE 'CAMBRIDGE'.
           05 FILLER                  PIC X(20) VALUE 'BOSTON'.
           05 FILLER                  PIC X(20) VALUE 'NEW YORK'.
           05 FILLER                  PIC X(20) VALUE 'SAN FRANCISCO'.
           05 FILLER                  PIC X(20) VALUE 'SEATTLE'.
       01  FILLER REDEFINES W-ADDRESSES.
           05 W-ADDRESS OCCURS 5      PIC X(20).
       01  W-PHONES.
           05 FILLER                  PIC X(8) VALUE '25663488'.
           05 FILLER                  PIC X(8) VALUE '38791206'.
           05 FILLER                  PIC X(8) VALUE '67159589'.
           05 FILLER                  PIC X(8) VALUE '54845428'.
           05 FILLER                  PIC X(8) VALUE '48952235'.
       01  FILLER REDEFINES W-PHONES.
           05 W-PHONE OCCURS 5        PIC X(8).
       01  W-DATES.
           05 FILLER                  PIC X(8) VALUE '10/04/11'.
           05 FILLER                  PIC X(8) VALUE '01/12/09'.
           05 FILLER                  PIC X(8) VALUE '30/10/10'.
           05 FILLER                  PIC X(8) VALUE '09/03/02'.
           05 FILLER                  PIC X(8) VALUE '13/02/05'.
       01  FILLER REDEFINES W-DATES.
           05 W-DATE OCCURS 5         PIC X(8).

       LINKAGE SECTION.
       01  L-PARM.
           05 FILLER                  PIC 9(4) COMP.
           05 L-RECORD-NBR            PIC 9(9).
       
       PROCEDURE DIVISION USING L-PARM.
       
           DISPLAY 'STARTED. GENERATING ' L-RECORD-NBR ' RECORDS'.
           OPEN OUTPUT OUTPUT-FILE.
           IF W-OUTPUT-FILE-STATUS NOT = ZERO
              DISPLAY 'ERROR OPENING OUTPUT-FILE='
                      W-OUTPUT-FILE-STATUS
              GO TO PROGRAM-EXIT
           END-IF.

           MOVE FUNCTION CURRENT-DATE (9:8) TO W-RANDOM-SEED.
           COMPUTE W-RANDOM = FUNCTION RANDOM (W-RANDOM-SEED).

           PERFORM VARYING W-I FROM 1 BY 1 UNTIL W-I > L-RECORD-NBR
               MOVE W-I          TO CUSTOMER-ID
               COMPUTE W-K = 1 + (4 * FUNCTION RANDOM)
               COMPUTE W-L = 1 + (4 * FUNCTION RANDOM)
               STRING W-FIRST-NAME(W-K) W-LAST-NAME(W-L)
                   DELIMITED BY SIZE INTO CUSTOMER-NAME
               COMPUTE W-K = 1 + (4 * FUNCTION RANDOM)
               MOVE W-ADDRESS(W-K) TO CUSTOMER-ADDRESS
               COMPUTE W-K = 1 + (4 * FUNCTION RANDOM)
               MOVE W-PHONE(W-K) TO CUSTOMER-PHONE
               COMPUTE TRANSACTION-NBR = 5 * FUNCTION RANDOM
               PERFORM VARYING W-J FROM 1 BY 1
                       UNTIL W-J > TRANSACTION-NBR
                   COMPUTE W-K = 1 + (4 * FUNCTION RANDOM)
                   MOVE W-DATE(W-K) TO TRANSACTION-DATE(W-J)
                   COMPUTE TRANSACTION-AMOUNT(W-J)
                         = 235.56 * FUNCTION RANDOM
                   MOVE '*********' TO TRANSACTION-COMMENT(W-J)
               END-PERFORM

               WRITE CUSTOMER-DATA
               IF W-OUTPUT-FILE-STATUS NOT = ZERO
                  DISPLAY 'ERROR WRITING TO OUTPUT-FILE='
                          W-OUTPUT-FILE-STATUS
                  GO TO PROGRAM-EXIT
               END-IF
           END-PERFORM.

       PROGRAM-EXIT.

           CLOSE OUTPUT-FILE.

           GOBACK.

       END PROGRAM PCUSTWVB.