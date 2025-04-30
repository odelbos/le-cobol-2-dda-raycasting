       IDENTIFICATION DIVISION.
       PROGRAM-ID. MINIMAP-CAST-RAYS.
       AUTHOR. Olivier Delbos.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION VEC2-ADD
           FUNCTION VEC2-SCALE
           FUNCTION CAST-RAY
           FUNCTION WORLD-TO-MAP.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       COPY DD-WINDOW-SIZE.
       COPY DD-CAST-RESULT.

       01 WS-W1.
           05 WS-W1-X      COMP-1 VALUE ZERO.
           05 WS-W1-Y      COMP-1 VALUE ZERO.

       01 WS-P1.
           05 WS-P1-X      PIC 9(3) VALUE ZERO.
           05 WS-P1-Y      PIC 9(3) VALUE ZERO.

       01 WS-P2.
           05 WS-P2-X      PIC 9(3) VALUE ZERO.
           05 WS-P2-Y      PIC 9(3) VALUE ZERO.

       01 WS-RADIUS        COMP-1 VALUE ZERO.
       01 WS-DEPTH         COMP-1 VALUE ZERO.
       01 WS-X             PIC 9(4) VALUE ZERO.

       LINKAGE SECTION.

       COPY DD-GAME-STATE.

       PROCEDURE DIVISION USING GAME-STATE.

           MOVE WORLD-TO-MAP (GAME-STATE, PLAYER) TO WS-P1.

           PERFORM VARYING WS-X FROM 1 BY 10
                   UNTIL WS-X > (WS-WINDOW-WIDTH - 1)

               COMPUTE WS-DEPTH = 2 * WS-X / 960 - 1
               MOVE FUNCTION VEC2-SCALE (CAM-PLANE, WS-DEPTH) TO WS-W1
               MOVE FUNCTION VEC2-ADD (CAM-DIR, WS-W1) TO WS-W1

               MOVE CAST-RAY (GAME-STATE, WS-W1) TO CAST-RESULT
               IF CR-WALL > 0 THEN
                 MOVE WORLD-TO-MAP (GAME-STATE, CR-HIT) TO WS-P2
                 CALL "rlDrawLine" USING
                   BY VALUE WS-P1-X WS-P1-Y WS-P2-X WS-P2-Y 4

                 MOVE 2.5 TO WS-RADIUS
                 CALL "rlDrawCircle" USING
                   BY VALUE WS-P2-X WS-P2-Y WS-RADIUS 7
               ELSE
                 MOVE FUNCTION VEC2-ADD (PLAYER, WS-W1) TO WS-W1
                 MOVE WORLD-TO-MAP (GAME-STATE, WS-W1) TO WS-P2
                 CALL "rlDrawLine" USING
                   BY VALUE WS-P1-X WS-P1-Y WS-P2-X WS-P2-Y 8
               END-IF
           END-PERFORM.

           EXIT PROGRAM.

       END PROGRAM MINIMAP-CAST-RAYS.
