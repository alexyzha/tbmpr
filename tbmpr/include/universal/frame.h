#include "universal/util.h"

#ifndef C_FRAME
#define C_FRAME

enum class frame_format {
    GRAYSCALE,
    RGB,
    RGBA
};

class frame {
public:
    frame();
    frame(int x, int y, uint8_t* img_);
    ~frame();
    frame& operator=(frame const& f);
    int cols;                               // x
    int rows;                               // y
    uint8_t* img;

};

uint8_t* frame_malloc(int x, int y, frame_format f);

#endif