       IDENTIFICATION DIVISION.
       PROGRAM-ID. MINIMAP.
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
       COPY DD-WORLD-SIZE.
       COPY DD-WORLD-DATA.

       COPY DD-CAST-RESULT.

       01 WS-MAP-WALL      PIC 9(1) VALUE ZERO.

       01 WS-X             PIC 9(2) VALUE ZERO.
       01 WS-Y             PIC 9(2) VALUE ZERO.

       01 WS-W1.
           05 WS-W1-X      COMP-1 VALUE ZERO.
           05 WS-W1-Y      COMP-1 VALUE ZERO.

       01 WS-P1.
           05 WS-P1-X      PIC 9(3) VALUE ZERO.
           05 WS-P1-Y      PIC 9(3) VALUE ZERO.

       01 WS-P2.
           05 WS-P2-X      PIC 9(3) VALUE ZERO.
           05 WS-P2-Y      PIC 9(3) VALUE ZERO.

       01 WS-RECT-W        PIC 9(3) VALUE ZERO.
       01 WS-RECT-H        PIC 9(3) VALUE ZERO.

       01 WS-RADIUS        COMP-1 VALUE ZERO.

       01 WS-DEPTH         COMP-1 VALUE ZERO.

       01 WS-XX            PIC 9(4) VALUE ZERO.

       LINKAGE SECTION.

       COPY DD-GAME-STATE.

       PROCEDURE DIVISION USING GAME-STATE.

           PERFORM RENDER-MAP.
           PERFORM RENDER-MAP-PLAYER.
           PERFORM CAST-MANY-RAYS.

           EXIT PROGRAM.

       RENDER-MAP.

         CALL "rlDrawRectangle" USING
               BY VALUE MAP-X MAP-Y MAP-WIDTH MAP-HEIGHT, 1

         PERFORM VARYING WS-Y FROM 1 BY 1
                   UNTIL WS-Y > WS-WORLD-HEIGHT

               PERFORM VARYING WS-X FROM 1 BY 1
                     UNTIL WS-X > WS-WORLD-WIDTH

                   MOVE WS-WORLD(WS-Y, WS-X) TO WS-MAP-WALL
                   IF WS-MAP-WALL > 0 THEN
                      COMPUTE WS-P1-X = (WS-X - 1) * MAP-RATIO-X + MAP-X
                      COMPUTE WS-P1-Y = (WS-Y - 1) * MAP-RATIO-Y + MAP-Y

                      COMPUTE WS-RECT-W = FUNCTION INTEGER(MAP-RATIO-X)
                      COMPUTE WS-RECT-H = FUNCTION INTEGER(MAP-RATIO-Y)
                      CALL "rlDrawRectangle" USING
                         BY VALUE WS-P1-X WS-P1-Y WS-RECT-W
                         WS-RECT-H, WS-MAP-WALL
                   END-IF
               END-PERFORM
         END-PERFORM.

         PERFORM VARYING WS-X FROM 1 BY 1
                   UNTIL WS-X > (WS-WORLD-WIDTH + 1)

            COMPUTE WS-P1-X = (WS-X - 1) * MAP-RATIO-X + MAP-X
            COMPUTE WS-P2-Y = MAP-Y + MAP-HEIGHT
            CALL "rlDrawLine" USING
                BY VALUE WS-P1-X MAP-Y WS-P1-X WS-P2-Y 2
         END-PERFORM.

         PERFORM VARYING WS-Y FROM 1 BY 1
                   UNTIL WS-Y > (WS-WORLD-WIDTH + 1)

            COMPUTE WS-P1-Y = (WS-Y - 1) * MAP-RATIO-Y + MAP-Y
            COMPUTE WS-P2-X = MAP-X + MAP-WIDTH
            CALL "rlDrawLine" USING
                BY VALUE MAP-X WS-P1-Y WS-P2-X WS-P1-Y 2
         END-PERFORM.

       RENDER-MAP-PLAYER.

           MOVE WORLD-TO-MAP (GAME-STATE, PLAYER) TO WS-P1.

           MOVE 5.0 TO WS-RADIUS.
           CALL "rlDrawCircle" USING
             BY VALUE WS-P1-X WS-P1-Y WS-RADIUS 6.

           MOVE VEC2-ADD (CAM-DIR, PLAYER) TO WS-W1.
           MOVE WORLD-TO-MAP (GAME-STATE, WS-W1) TO WS-P2.
           CALL "rlDrawLine" USING
             BY VALUE WS-P1-X WS-P1-Y WS-P2-X WS-P2-Y 3.

       CAST-MANY-RAYS.

           MOVE WORLD-TO-MAP (GAME-STATE, PLAYER) TO WS-P1.

           PERFORM VARYING WS-XX FROM 1 BY 10
                   UNTIL WS-XX > (WS-WINDOW-WIDTH - 1)

               COMPUTE WS-DEPTH = 2 * WS-XX / 960 - 1
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

       END PROGRAM MINIMAP.
