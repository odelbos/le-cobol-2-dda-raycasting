       IDENTIFICATION DIVISION.
       PROGRAM-ID. RAYCAST.
       AUTHOR. Olivier Delbos.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION VEC2-ROTATE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Constants from Raylib
       01 C-KEY-LEFT          PIC 9(3) VALUE 263.
       01 C-KEY-RIGHT         PIC 9(3) VALUE 262.
       01 C-KEY-UP            PIC 9(3) VALUE 265.
       01 C-KEY-DOWN          PIC 9(3) VALUE 264.

       COPY DD-WINDOW-SIZE.
       01 WS-WINDOW-TITLE     PIC X(21) VALUE "COBOL Flat Raycasting".
       01 WS-SHOULD-CLOSE     PIC 9 VALUE 0.

       COPY DD-WORLD-SIZE.
       COPY DD-WORLD-DATA.
       COPY DD-GAME-STATE.

       01 IS-KEY-ACTIVE       PIC 9 VALUE ZERO.

       01 MOVE-SPEED          COMP-1 VALUE ZERO.
       01 ROT-SPEED           COMP-1 VALUE ZERO.
       01 NEG-ROT-SPEED       COMP-1 VALUE ZERO.

       PROCEDURE DIVISION.

      * Initialize game state
           MOVE 20 TO MAP-X.
           MOVE 20 TO MAP-Y.

           MOVE 300 TO MAP-WIDTH.
           MOVE 300 TO MAP-HEIGHT.

           COMPUTE MAP-RATIO-X = MAP-WIDTH / WS-WORLD-WIDTH.
           COMPUTE MAP-RATIO-Y = MAP-HEIGHT / WS-WORLD-HEIGHT.

           MOVE 5.5 TO PLAYER-X.
           MOVE 6.5 TO PLAYER-Y.

           MOVE -1 TO CAM-DIR-X.
           MOVE 0 TO CAM-DIR-Y.

           MOVE 0 TO CAM-PLANE-X.
           MOVE -0.66 TO CAM-PLANE-Y

           MOVE 0.025 TO MOVE-SPEED.
           MOVE 0.02 TO ROT-SPEED.
           MOVE -0.02 TO NEG-ROT-SPEED.

      * Create window
           CALL "rlInitWindow" USING
               BY VALUE WS-WINDOW-WIDTH
               BY VALUE WS-WINDOW-HEIGHT
               BY REFERENCE WS-WINDOW-TITLE.

      * Main event loop
           CALL "rlSetTargetFPS" USING BY VALUE 60.

           PERFORM UNTIL WS-SHOULD-CLOSE = 1

               MOVE ZERO TO IS-KEY-ACTIVE

               CALL "rlIsKeyDown" USING
                 BY VALUE C-KEY-UP RETURNING IS-KEY-ACTIVE
               IF IS-KEY-ACTIVE = 1 THEN
                 PERFORM MOVE-UP
               END-IF

               CALL "rlIsKeyDown" USING
                 BY VALUE C-KEY-DOWN RETURNING IS-KEY-ACTIVE
               IF IS-KEY-ACTIVE = 1 THEN
                 PERFORM MOVE-DOWN
               END-IF

               CALL "rlIsKeyDown" USING
                 BY VALUE C-KEY-LEFT RETURNING IS-KEY-ACTIVE
               IF IS-KEY-ACTIVE = 1 THEN
                 PERFORM MOVE-LEFT
               END-IF

               CALL "rlIsKeyDown" USING
                 BY VALUE C-KEY-RIGHT RETURNING IS-KEY-ACTIVE
               IF IS-KEY-ACTIVE = 1 THEN
                 PERFORM MOVE-RIGHT
               END-IF

               CALL "rlBeginDrawing"
               CALL "rlClearBackground" USING BY VALUE 0
               CALL 'MINIMAP' USING GAME-STATE
               CALL 'MINIMAP-CAST-RAYS' USING GAME-STATE
               CALL "rlEndDrawing"
               CALL "rlWindowShouldClose" RETURNING WS-SHOULD-CLOSE
           END-PERFORM.

           CALL "rlCloseWindow".
           STOP RUN.

       MOVE-UP.
           COMPUTE PLAYER-X = PLAYER-X + CAM-DIR-X * MOVE-SPEED.
           COMPUTE PLAYER-Y = PLAYER-Y + CAM-DIR-Y * MOVE-SPEED.

       MOVE-DOWN.
           COMPUTE PLAYER-X = PLAYER-X - CAM-DIR-X * MOVE-SPEED.
           COMPUTE PLAYER-Y = PLAYER-Y - CAM-DIR-Y * MOVE-SPEED.

       MOVE-LEFT.
           MOVE VEC2-ROTATE (CAM-DIR, NEG-ROT-SPEED) TO CAM-DIR.
           MOVE VEC2-ROTATE (CAM-PLANE, NEG-ROT-SPEED) TO CAM-PLANE.

       MOVE-RIGHT.
           MOVE VEC2-ROTATE (CAM-DIR, ROT-SPEED) TO CAM-DIR.
           MOVE VEC2-ROTATE (CAM-PLANE, ROT-SPEED) TO CAM-PLANE.

       END PROGRAM RAYCAST.
