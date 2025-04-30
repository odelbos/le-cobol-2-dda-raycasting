       IDENTIFICATION DIVISION.
       FUNCTION-ID. CAST-RAY.
       AUTHOR. Olivier Delbos.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION VEC2-ADD
           FUNCTION VEC2-MUL.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       COPY DD-WORLD-SIZE.
       COPY DD-WORLD-DATA.

       01 WS-DELTA-X           COMP-1 VALUE ZERO.
       01 WS-DELTA-Y           COMP-1 VALUE ZERO.

       01 WS-STEP-X            PIC S9 VALUE ZERO.
       01 WS-STEP-Y            PIC S9 VALUE ZERO.

       01 WS-DIST-X            COMP-1 VALUE ZERO.
       01 WS-DIST-Y            COMP-1 VALUE ZERO.

       01 WS-MAX               PIC 99 VALUE ZERO.

       01 WS-A.
           05 WS-A-X           COMP-1 VALUE ZERO.
           05 WS-A-Y           COMP-1 VALUE ZERO.

       01 WS-CELL.
           05 WS-CELL-X        PIC 99 VALUE ZERO.
           05 WS-CELL-Y        PIC 99 VALUE ZERO.

       LINKAGE SECTION.

       COPY DD-GAME-STATE.

       01 LK-RAY-DIR.
           05 LK-RAY-DIR-X     COMP-1 VALUE ZERO.
           05 LK-RAY-DIR-Y     COMP-1 VALUE ZERO.

       COPY DD-CAST-RESULT.

       PROCEDURE DIVISION USING GAME-STATE LK-RAY-DIR
                          RETURNING CAST-RESULT.
           MOVE ZERO TO CR-WALL.
           MOVE FUNCTION INTEGER (PLAYER-X) TO CR-CELL-X.
           MOVE FUNCTION INTEGER (PLAYER-Y) TO CR-CELL-Y.

           IF LK-RAY-DIR-X = 0 THEN
               MOVE 1000000000000000000000000 TO WS-DELTA-X
           ELSE
               COMPUTE WS-DELTA-X = FUNCTION ABS (1 / LK-RAY-DIR-X)
           END-IF.

           IF LK-RAY-DIR-Y = 0 THEN
               MOVE 1000000000000000000000000 TO WS-DELTA-Y
           ELSE
               COMPUTE WS-DELTA-Y = FUNCTION ABS (1 / LK-RAY-DIR-Y)
           END-IF.

           MOVE 1 TO WS-STEP-X.
           MOVE 1 TO WS-STEP-Y.

           IF LK-RAY-DIR-X < 0 THEN
               MOVE -1 TO WS-STEP-X
               COMPUTE WS-DIST-X = (PLAYER-X - CR-CELL-X) * WS-DELTA-X
           ELSE
               COMPUTE WS-DIST-X =
                 (CR-CELL-X + 1 - PLAYER-X) * WS-DELTA-X
           END-IF.

           IF LK-RAY-DIR-Y < 0 THEN
               MOVE -1 TO WS-STEP-Y
               COMPUTE WS-DIST-Y = (PLAYER-Y - CR-CELL-Y) * WS-DELTA-Y
           ELSE
               COMPUTE WS-DIST-Y =
                 (CR-CELL-Y + 1 - PLAYER-Y) * WS-DELTA-Y
           END-IF.

           MOVE ZERO TO CR-WALL.
           MOVE ZERO TO WS-MAX.

           PERFORM UNTIL WS-MAX > 15 OR CR-WALL > 0
             IF WS-DIST-X < WS-DIST-Y THEN
               ADD WS-DELTA-X TO WS-DIST-X
               ADD WS-STEP-X TO CR-CELL-X
               MOVE 0 TO CR-SIDE
             ELSE
               ADD WS-DELTA-Y TO WS-DIST-Y
               ADD WS-STEP-Y TO CR-CELL-Y
               MOVE 1 TO CR-SIDE
             END-IF

             IF CR-CELL-X >= 0 AND CR-CELL-X < WS-WORLD-WIDTH AND 
                 CR-CELL-Y >= 0 AND CR-CELL-Y < WS-WORLD-HEIGHT THEN
               COMPUTE WS-CELL-X = CR-CELL-X + 1
               COMPUTE WS-CELL-Y = CR-CELL-Y + 1
               MOVE WS-WORLD(WS-CELL-Y, WS-CELL-X) TO CR-WALL
             END-IF

             IF CR-CELL-X < 0 OR CR-CELL-Y < 0 THEN
               MOVE 16 TO WS-MAX
             END-IF

             IF CR-CELL-X > 7 OR CR-CELL-Y > 7 THEN
               MOVE 16 TO WS-MAX
             END-IF

             ADD 1 TO WS-MAX

           END-PERFORM.

           IF CR-WALL > 0 THEN
             ADD 1 TO CR-CELL-X
             ADD 1 TO CR-CELL-Y

             IF CR-SIDE = 0 THEN
                 COMPUTE WS-A-X = WS-DIST-X - WS-DELTA-X
             ELSE
                 COMPUTE WS-A-X = WS-DIST-Y - WS-DELTA-Y
             END-IF

             MOVE WS-A-X TO WS-A-Y
             MOVE WS-A-X TO CR-RAY-DIST

             MOVE FUNCTION VEC2-MUL (LK-RAY-DIR, WS-A) TO CR-HIT
             MOVE FUNCTION VEC2-ADD (CR-HIT, PLAYER) TO CR-HIT
           END-IF.

           EXIT FUNCTION.

       END FUNCTION CAST-RAY.
