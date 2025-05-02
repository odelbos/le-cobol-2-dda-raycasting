       IDENTIFICATION DIVISION.
       PROGRAM-ID. RENDER-WORLD.
       AUTHOR. Olivier Delbos.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION VEC2-ADD
           FUNCTION VEC2-SCALE
           FUNCTION CAST-RAY.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       COPY DD-WINDOW-SIZE.
       COPY DD-CAST-RESULT.

       01 WS-RAY-SIZE      PIC 9 VALUE 3.

       01 WS-W1.
           05 WS-W1-X      COMP-1 VALUE ZERO.
           05 WS-W1-Y      COMP-1 VALUE ZERO.

       01 WS-DEPTH         COMP-1 VALUE ZERO.
       01 WS-X             PIC 9(4) VALUE ZERO.

       01 WS-H             PIC 9(4) VALUE ZERO.
       01 WS-Y1            PIC S9(4) VALUE ZERO.
       01 WS-Y2            PIC S9(4) VALUE ZERO.
       01 WS-STROKE        COMP-1 VALUE 1.1.

       LINKAGE SECTION.

       COPY DD-GAME-STATE.

       PROCEDURE DIVISION USING GAME-STATE.

           MOVE WS-RAY-SIZE TO WS-STROKE

           PERFORM VARYING WS-X FROM 1 BY WS-RAY-SIZE
                   UNTIL WS-X > (WS-WINDOW-WIDTH - 1)

               COMPUTE WS-DEPTH = 2 * WS-X / 960 - 1
               MOVE FUNCTION VEC2-SCALE (CAM-PLANE, WS-DEPTH) TO WS-W1
               MOVE FUNCTION VEC2-ADD (CAM-DIR, WS-W1) TO WS-W1

               MOVE CAST-RAY (GAME-STATE, WS-W1) TO CAST-RESULT
               IF CR-WALL > 0 THEN
                 COMPUTE WS-H = WS-WINDOW-HEIGHT / CR-RAY-DIST

                 COMPUTE WS-Y1 =  WS-WINDOW-HEIGHT / 2 - WS-H / 2
                 IF WS-Y1 < 0 THEN
                     MOVE 0 TO WS-Y1
                 END-IF

                 COMPUTE WS-Y2 = WS-WINDOW-HEIGHT / 2 + WS-H / 2
                 IF WS-Y2 >= WS-WINDOW-HEIGHT THEN
                     COMPUTE WS-Y2 = WS-WINDOW-HEIGHT - 1
                 END-IF

                 CALL "rlDrawLineEx" USING
                   BY VALUE WS-X WS-Y1 WS-X WS-Y2 WS-STROKE CR-WALL
               END-IF
           END-PERFORM.

           EXIT PROGRAM.

       END PROGRAM RENDER-WORLD.
