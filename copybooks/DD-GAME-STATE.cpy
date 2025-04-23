       01 GAME-STATE.

      * Map position in pixels
           05 MAP-POS.
             10 MAP-X            PIC 99 VALUE ZERO.
             10 MAP-Y            PIC 99 VALUE ZERO.

      * Map size in pixels
           05 MAP-SIZE.
             10 MAP-WIDTH        PIC 999 VALUE ZERO.
             10 MAP-HEIGHT       PIC 999 VALUE ZERO.

      * Map ratio
           05 MAP-RATIO.
             10 MAP-RATIO-X      COMP-1 VALUE ZERO.
             10 MAP-RATIO-Y      COMP-1 VALUE ZERO.

      * Player points in world coordinates
           05 PLAYER.
             10 PLAYER-X         COMP-1 VALUE ZERO.
             10 PLAYER-Y         COMP-1 VALUE ZERO.
