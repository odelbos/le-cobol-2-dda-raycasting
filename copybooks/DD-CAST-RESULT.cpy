       01 CAST-RESULT.

      * Hit position in world coordinates
           05 CR-HIT.
             10 CR-HIT-X       COMP-1 VALUE ZERO.
             10 CR-HIT-Y       COMP-1 VALUE ZERO.

           05 CR-RAY-DIST      COMP-1 VALUE ZERO.

           05 CR-CELL.
             10 CR-CELL-X      PIC S99 VALUE ZERO.
             10 CR-CELL-Y      PIC S99 VALUE ZERO.

           05 CR-WALL          PIC 9 VALUE ZERO.

           05 CR-SIDE          PIC 9 VALUE ZERO.
