      * World data.
       01 WS-WORLD-DATA.
           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 4.
           05 FILLER PIC 9 VALUE 5.

           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 4.
           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 3.

           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 3.

           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 5.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 5.

           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 4.
           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.

           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.

           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 3.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.

           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 0.
           05 FILLER PIC 9 VALUE 5.

      * Redifines as Array[8][8]
       01 WS-WORLD-ARRAY REDEFINES WS-WORLD-DATA.
           05 WS-WORLD-ROWS OCCURS 8 TIMES.
              10 WS-WORLD-COLS OCCURS 8 TIMES.
                15 WS-WORLD PIC 9.
