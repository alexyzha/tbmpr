#pragma once
#include <opencv2/opencv.hpp>
#include <algorithm>
#include <cctype>
#include <cstdint>
#include <fstream>
#include <inttypes.h>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <stdlib.h>
#include <string>
#include <vector>
#include "utility/config.h"

#ifndef CHAR_BANK
#define CHAR_BANK
const std::string ASCII = " `.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@";
#endif CHAR_BANK

char pixel_to_char(uint8_t brightness);

void frame_to_terminal(config* conf, const cv::Mat& frame);