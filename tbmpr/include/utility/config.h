#include "utility/util.h"

#ifndef C_CONFIG
#define C_CONFIG

struct config {
public:
    int TERM_COLS;
    int TERM_ROWS;
    int FPS;
    bool DO_COLOR;
    bool DO_REPLAY;

};

#endif