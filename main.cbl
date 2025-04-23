       IDENTIFICATION DIVISION.
       PROGRAM-ID. RAYCAST.
       AUTHOR. Olivier Delbos.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-HELLO PIC X(5) VALUE "hello".
       01 WS-WORLD PIC X(13) VALUE "world from C!".

       PROCEDURE DIVISION.

           CALL "say" USING WS-HELLO WS-WORLD.

           STOP RUN.

       END PROGRAM RAYCAST.
