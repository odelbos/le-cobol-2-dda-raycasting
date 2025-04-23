       IDENTIFICATION DIVISION.
       PROGRAM-ID. RAYCAST.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-WINDOW-WIDTH  PIC 9(4) VALUE 640.
       01 WS-WINDOW-HEIGHT PIC 9(4) VALUE 480.
       01 WS-WINDOW-TITLE  PIC X(20) VALUE "Cobol Raycast".
       01 WS-SHOULD-CLOSE  PIC 9 VALUE 0.

       PROCEDURE DIVISION.

           CALL "rlInitWindow" USING
               BY VALUE WS-WINDOW-WIDTH
               BY VALUE WS-WINDOW-HEIGHT
               BY REFERENCE WS-WINDOW-TITLE.

           PERFORM UNTIL WS-SHOULD-CLOSE = 1
               CALL "rlBeginDrawing"
               CALL "rlClearBackground" USING BY VALUE 0
               CALL "rlDrawRectangle" USING BY VALUE 50 50 100 100 1
               CALL "rlEndDrawing"
               CALL "rlWindowShouldClose" RETURNING WS-SHOULD-CLOSE
           END-PERFORM.

           CALL "rlCloseWindow".

           STOP RUN.

       END PROGRAM RAYCAST.
