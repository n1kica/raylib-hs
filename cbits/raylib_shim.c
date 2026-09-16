#include <stdint.h>
#include "raylib.h"

void HSClearBackground(uint32_t color) {
    ClearBackground(GetColor(color));
}

void HSDrawText(const char *text, int x, int y, int fontSize, uint32_t color) {
    DrawText(text, x, y, fontSize, GetColor(color));
}

void HSGetFontDefault(Font *result) {
    *result = GetFontDefault();
}

void HSMeasureTextEx(const Font *font, const char *text, float fontSize,
    float spacing, Vector2 *result) {
    *result = MeasureTextEx(*font, text, fontSize, spacing);
}

void HSDrawTextEx(const Font *font, const char *text, const Vector2 *position,
    float fontSize, float spacing, uint32_t tint) {
    DrawTextEx(*font, text, *position, fontSize, spacing, GetColor(tint));
}

void HSDrawRectangle(int posX, int posY, int width, int height,
    uint32_t color) {
    DrawRectangle(posX, posY, width, height, GetColor(color));
}

void HSDrawRectangleRec(const Rectangle *rect, uint32_t color) {
    DrawRectangleRec(*rect, GetColor(color));
}

void HSGetMousePosition(Vector2 *result) {
    *result = GetMousePosition();
}

void HSPlayAudioStream(AudioStream *stream) {
    PlayAudioStream(*stream);
}

bool HSIsAudioStreamProcessed(AudioStream *stream) {
    return IsAudioStreamProcessed(*stream);
}

void HSUpdateAudioStream(AudioStream *stream, const void *data, int frameCount) {
    UpdateAudioStream(*stream, data, frameCount);
}

void HSLoadAudioStream(unsigned int sampleRate, unsigned int sampleSize,
                        unsigned int channels, AudioStream *result) {
    *result = LoadAudioStream(sampleRate, sampleSize, channels);
}
