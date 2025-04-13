#include "utility/util.h"

char pixel_to_char(uint8_t brightness) {
    int index = (brightness * (ASCII.size() - 1)) / 255;
    return ASCII[index];
}

void frame_to_terminal(config* conf, const cv::Mat& frame) {
    // Resize frame based on conf
    cv::Mat rsz;
    cv::resize(frame, rsz, cv::Size(conf->TERM_COLS, conf->TERM_ROWS));

    // Make frame (prototype just output)
    for(int y = 0; y < rsz.rows; ++y) {
        for(int x = 0; x < rsz.cols; ++x) {
            cv::Vec3b pixel = rsz.at<cv::Vec3b>(y, x);
            uint8_t r = pixel[2];
            uint8_t g = pixel[1];
            uint8_t b = pixel[0];
            uint8_t brightness = static_cast<uint8_t>(
                (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
            );
            char c = pixel_to_char(brightness);
            
            // If color option enabled
            if(conf->DO_COLOR) {
                std::cout << "\x1b[38;2;" << (int)r << ";" << (int)g << ";" << (int)b << "m";
            }
            std::cout << c;
        }
        std::cout << std::endl;
    }

    // ANSI esc code for color reset
    if(conf->DO_COLOR) {
        std::cout << "\x1b[0m";
    }
}