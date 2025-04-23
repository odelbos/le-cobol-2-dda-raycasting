#include <raylib.h>

#define BACKGROUND CLITERAL(Color){20, 20, 20, 255}

// Trick to choose color using an integer index instead
// of having to pass Color struct from COBOL to C.
Color colors[] = {
  BACKGROUND,
  RED,
};

void rlInitWindow(int width, int height, const char* title) {
  InitWindow(width, height, title);
}

void rlSetTargetFPS(int fps) {
  SetTargetFPS(fps);
}

int rlWindowShouldClose() {
  return WindowShouldClose();
}

void rlCloseWindow() {
  CloseWindow();
}

void rlBeginDrawing() {
  BeginDrawing();
}

void rlEndDrawing() {
  EndDrawing();
}

void rlClearBackground(int colorIdx) {
  ClearBackground(colors[colorIdx]);
}

void rlDrawRectangle(int x, int y, int width, int height, int colorIdx) {
  DrawRectangle(x, y, width, height, colors[colorIdx]);
}
