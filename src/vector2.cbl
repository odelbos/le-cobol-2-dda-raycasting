      * -----------------------------------------------------------
      * Add two vector2
      * -----------------------------------------------------------
       IDENTIFICATION DIVISION.
       FUNCTION-ID. VEC2-ADD.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.

       LINKAGE SECTION.

       01 LK-A.
           05 LK-A-X       COMP-1 VALUE ZERO.
           05 LK-A-Y       COMP-1 VALUE ZERO.

       01 LK-B.
           05 LK-B-X       COMP-1 VALUE ZERO.
           05 LK-B-Y       COMP-1 VALUE ZERO.

       01 LK-R.
           05 LK-R-X       COMP-1 VALUE ZERO.
           05 LK-R-Y       COMP-1 VALUE ZERO.

       PROCEDURE DIVISION USING LK-A LK-B RETURNING LK-R.

           COMPUTE LK-R-X = LK-A-X + LK-B-X.
           COMPUTE LK-R-Y = LK-A-Y + LK-B-Y.

           EXIT FUNCTION.

       END FUNCTION VEC2-ADD.


      * -----------------------------------------------------------
      * Substract two vector2
      * -----------------------------------------------------------
       IDENTIFICATION DIVISION.
       FUNCTION-ID. VEC2-SUB.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.

       LINKAGE SECTION.

       01 LK-A.
           05 LK-A-X       COMP-1 VALUE ZERO.
           05 LK-A-Y       COMP-1 VALUE ZERO.

       01 LK-B.
           05 LK-B-X       COMP-1 VALUE ZERO.
           05 LK-B-Y       COMP-1 VALUE ZERO.

       01 LK-R.
           05 LK-R-X       COMP-1 VALUE ZERO.
           05 LK-R-Y       COMP-1 VALUE ZERO.

       PROCEDURE DIVISION USING LK-A LK-B RETURNING LK-R.

           COMPUTE LK-R-X = LK-A-X - LK-B-X.
           COMPUTE LK-R-Y = LK-A-Y - LK-B-Y.

           EXIT FUNCTION.

       END FUNCTION VEC2-SUB.


      * -----------------------------------------------------------
      * Multiply two vector2
      * -----------------------------------------------------------
       IDENTIFICATION DIVISION.
       FUNCTION-ID. VEC2-MUL.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.

       LINKAGE SECTION.

       01 LK-A.
           05 LK-A-X       COMP-1 VALUE ZERO.
           05 LK-A-Y       COMP-1 VALUE ZERO.

       01 LK-B.
           05 LK-B-X       COMP-1 VALUE ZERO.
           05 LK-B-Y       COMP-1 VALUE ZERO.

       01 LK-R.
           05 LK-R-X       COMP-1 VALUE ZERO.
           05 LK-R-Y       COMP-1 VALUE ZERO.

       PROCEDURE DIVISION USING LK-A LK-B RETURNING LK-R.

           COMPUTE LK-R-X = LK-A-X * LK-B-X.
           COMPUTE LK-R-Y = LK-A-Y * LK-B-Y.

           EXIT FUNCTION.

       END FUNCTION VEC2-MUL.


      * -----------------------------------------------------------
      * Scale a vector2
      * -----------------------------------------------------------
       IDENTIFICATION DIVISION.
       FUNCTION-ID. VEC2-SCALE.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.

       LINKAGE SECTION.

       01 LK-A.
           05 LK-A-X       COMP-1 VALUE ZERO.
           05 LK-A-Y       COMP-1 VALUE ZERO.

       01 LK-FACTOR        COMP-1 VALUE ZERO.

       01 LK-R.
           05 LK-R-X       COMP-1 VALUE ZERO.
           05 LK-R-Y       COMP-1 VALUE ZERO.

       PROCEDURE DIVISION USING LK-A LK-FACTOR RETURNING LK-R.

           COMPUTE LK-R-X = LK-A-X * LK-FACTOR.
           COMPUTE LK-R-Y = LK-A-Y * LK-FACTOR.

           EXIT FUNCTION.

       END FUNCTION VEC2-SCALE.
