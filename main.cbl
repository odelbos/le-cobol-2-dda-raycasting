       IDENTIFICATION DIVISION.
       PROGRAM-ID. RAYCAST.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-WINDOW-WIDTH  PIC 9(4) VALUE 960.
       01 WS-WINDOW-HEIGHT PIC 9(4) VALUE 540.
       01 WS-WINDOW-TITLE   PIC X(21) VALUE "COBOL Flat Raycasting".
       01 WS-SHOULD-CLOSE  PIC 9 VALUE 0.

       COPY DD-WORLD-SIZE.
       COPY DD-WORLD-DATA.

       01 WS-MAP-WIDTH    PIC 9(3) VALUE 300.
       01 WS-MAP-HEIGHT   PIC 9(3) VALUE 300.

       01 WS-MAP-X        PIC 9(2) VALUE 20.
       01 WS-MAP-Y        PIC 9(2) VALUE 20.

       01 WS-MAP-CELL-W   COMP-1 VALUE ZERO.
       01 WS-MAP-CELL-H   COMP-1 VALUE ZERO.

       01 WS-MAP-WALL     PIC 9(1) VALUE ZERO.

       01 WS-X            PIC 9(2) VALUE ZERO.
       01 WS-Y            PIC 9(2) VALUE ZERO.

       01 WS-P1-X        PIC 9(3) VALUE ZERO.
       01 WS-P1-Y        PIC 9(3) VALUE ZERO.

       01 WS-P2-X        PIC 9(3) VALUE ZERO.
       01 WS-P2-Y        PIC 9(3) VALUE ZERO.

       01 WS-RECT-W       PIC 9(3) VALUE ZERO.
       01 WS-RECT-H       PIC 9(3) VALUE ZERO.

       PROCEDURE DIVISION.

           CALL "rlInitWindow" USING
               BY VALUE WS-WINDOW-WIDTH
               BY VALUE WS-WINDOW-HEIGHT
               BY REFERENCE WS-WINDOW-TITLE.

           PERFORM UNTIL WS-SHOULD-CLOSE = 1
               CALL "rlBeginDrawing"
               CALL "rlClearBackground" USING BY VALUE 0
               PERFORM RENDER-WORLD-MAP
               CALL "rlEndDrawing"
               CALL "rlWindowShouldClose" RETURNING WS-SHOULD-CLOSE
           END-PERFORM.

           CALL "rlCloseWindow".

           STOP RUN.

       RENDER-WORLD-MAP.

         CALL "rlDrawRectangle" USING
               BY VALUE WS-MAP-X WS-MAP-Y WS-MAP-WIDTH
               WS-MAP-HEIGHT, 1

         COMPUTE WS-MAP-CELL-W = WS-MAP-WIDTH / WS-WORLD-WIDTH
         COMPUTE WS-MAP-CELL-H = WS-MAP-HEIGHT / WS-WORLD-HEIGHT

         PERFORM VARYING WS-Y FROM 1 BY 1
                   UNTIL WS-Y > WS-WORLD-HEIGHT

               PERFORM VARYING WS-X FROM 1 BY 1
                     UNTIL WS-X > WS-WORLD-WIDTH

                   MOVE WS-WORLD(WS-Y, WS-X) TO WS-MAP-WALL

                   IF WS-MAP-WALL > 0 THEN
                      COMPUTE WS-P1-X =
                         (WS-X - 1) * WS-MAP-CELL-W + WS-MAP-X

                      COMPUTE WS-P1-Y =
                         (WS-Y - 1) * WS-MAP-CELL-H + WS-MAP-Y

                      COMPUTE WS-RECT-W =
                         FUNCTION INTEGER(WS-MAP-CELL-W)
                      COMPUTE WS-RECT-H =
                         FUNCTION INTEGER(WS-MAP-CELL-H)

                      CALL "rlDrawRectangle" USING
                         BY VALUE WS-P1-X WS-P1-Y WS-RECT-W
                         WS-RECT-H, WS-MAP-WALL
                   END-IF
               END-PERFORM
         END-PERFORM.

         PERFORM VARYING WS-X FROM 1 BY 1
                   UNTIL WS-X > (WS-WORLD-WIDTH + 1)

                   COMPUTE WS-P1-X =
                       (WS-X - 1) * WS-MAP-CELL-W + WS-MAP-X

                   COMPUTE WS-P2-Y = WS-MAP-Y + WS-MAP-HEIGHT

                   CALL "rlDrawLine" USING
                       BY VALUE WS-P1-X WS-MAP-Y
                       WS-P1-X WS-P2-Y
                       2
         END-PERFORM.

         PERFORM VARYING WS-Y FROM 1 BY 1
                   UNTIL WS-Y > (WS-WORLD-WIDTH + 1)

                   COMPUTE WS-P1-Y =
                       (WS-Y - 1) * WS-MAP-CELL-H + WS-MAP-Y

                   COMPUTE WS-P2-X = WS-MAP-X + WS-MAP-WIDTH

                   CALL "rlDrawLine" USING
                       BY VALUE WS-MAP-X WS-P1-Y
                       WS-P2-X WS-P1-Y
                       2
         END-PERFORM.

       END PROGRAM RAYCAST.
