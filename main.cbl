       IDENTIFICATION DIVISION.
       PROGRAM-ID. RAYCAST.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-WINDOW-WIDTH     PIC 9(4) VALUE 960.
       01 WS-WINDOW-HEIGHT    PIC 9(4) VALUE 540.
       01 WS-WINDOW-TITLE     PIC X(21) VALUE "COBOL Flat Raycasting".
       01 WS-SHOULD-CLOSE     PIC 9 VALUE 0.

       COPY DD-WORLD-SIZE.
       COPY DD-WORLD-DATA.
       COPY DD-GAME-STATE.

       PROCEDURE DIVISION.

      * Initialize game state
           MOVE 20 TO MAP-X.
           MOVE 20 TO MAP-Y.

           MOVE 300 TO MAP-WIDTH.
           MOVE 300 TO MAP-HEIGHT.

           MOVE 5.5 TO PLAYER-X.
           MOVE 6.5 TO PLAYER-Y.

      * Create window
           CALL "rlInitWindow" USING
               BY VALUE WS-WINDOW-WIDTH
               BY VALUE WS-WINDOW-HEIGHT
               BY REFERENCE WS-WINDOW-TITLE.

      * Main event loop
           PERFORM UNTIL WS-SHOULD-CLOSE = 1
               CALL "rlBeginDrawing"
               CALL "rlClearBackground" USING BY VALUE 0
               CALL "MINIMAP" USING GAME-STATE
               CALL "rlEndDrawing"
               CALL "rlWindowShouldClose" RETURNING WS-SHOULD-CLOSE
           END-PERFORM.

           CALL "rlCloseWindow".
           STOP RUN.

       END PROGRAM RAYCAST.
