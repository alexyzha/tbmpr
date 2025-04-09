#include "universal/frame.h"

#ifdef C_FRAME

frame::frame() : rows(0), cols(0), img(nullptr) {};

frame::frame(int x, int y, uint8_t* img_) : cols(x), rows(y), img(img_) {};

frame::~frame() {
    delete[] img;
}

frame& frame::operator=(frame const& f) {
    this->rows = f.rows;
    this->cols = f.cols;
    this->img = f.img;
}

uint8_t* frame_malloc(int x, int y, frame_format f) {
    int channels = 0;
    switch(f) {
        case frame_format::GRAYSCALE:
            channels = 1;
            break;
        case frame_format::RGB:
            channels = 3;
            break;
        case frame_format::RGBA:
            channels = 4;
            break;
    }
    uint8_t* empty_img = new uint8_t[x * y * channels];
    return empty_img;
}

#endif