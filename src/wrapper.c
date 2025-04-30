#include <stdio.h>
#include <raylib.h>

#define BACKGROUND CLITERAL(Color){20, 20, 20, 255}

// Trick to choose color using an integer index instead
// of having to pass Color struct from COBOL to C.
Color colors[] = {
  BACKGROUND,
  BLACK,          // Mini map background
  GRAY,           // Mini map lines
  BLUE,           // Wall colors
  GREEN,          // ...
  MAGENTA,
  RED,
  YELLOW,
  ORANGE,
};

void rlInitWindow(int width, int height, const char* title) {
  InitWindow(width, height, title);
}

void rlSetTargetFPS(int fps) {
  SetTargetFPS(fps);
}

int rlWindowShouldClose() {
  return (int)WindowShouldClose();
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

int rlIsKeyDown(int key) {
  return (int)IsKeyDown(key);
}

void rlClearBackground(int colorIdx) {
  ClearBackground(colors[colorIdx]);
}

void rlDrawRectangle(int x, int y, int width, int height, int colorIdx) {
  DrawRectangle(x, y, width, height, colors[colorIdx]);
}

void rlDrawLine(int x1, int y1, int x2, int y2, int colorIdx) {
  DrawLine(x1, y1, x2, y2, colors[colorIdx]);
}

void rlDrawLineEx(int x1, int y1, int x2, int y2, float stroke,  int colorIdx) {
  DrawLineEx((Vector2){x1, y1}, (Vector2){x2, y2}, stroke, colors[colorIdx]);
}

void rlDrawCircle(int x, int y, float r, int colorIdx) {
  DrawCircle(x, y, r, colors[colorIdx]);
}

void printFrameTime() {
  float t = GetFrameTime();
  printf("t = %f\n", t);
}
