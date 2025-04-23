#include <raylib.h>

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

void rlClearBackground() {
  ClearBackground(RAYWHITE);
}

void rlDrawRectangle(int x, int y, int width, int height) {
  DrawRectangle(x, y, width, height, RED);
}
