#include "parsers/pgm.h"

frame read_pgm(std::string file_path) {
    // File handle
    std::fstream file(file_path, std::ios::in | std::ios::binary);
    if(!file.is_open()) {
        throw std::runtime_error("Invalid file path.");
    }
    auto skip_comments = [&](std::istream& file) {
        std::string temp;
        while(file >> std::ws && file.peek() == '#') {
            std::getline(file, temp);
        }
    };

    // Read header
    std::string tag;
    std::string comment;
    int x;
    int y;
    int max_gray;
    std::getline(file, tag);
    skip_comments(file);
    file >> x;
    skip_comments(file);
    file >> y;
    skip_comments(file);
    file >> max_gray;
    file.ignore();
    
    // Max gray values > 255 are unsupported (uint8_t -> 8 byte max = 0xff = 255)
    if((tag != "P2" && tag != "P5") || max_gray > 255) {
        throw std::runtime_error("Invalid .pgm file.");
    }

    // Read actual image
    uint8_t* img = frame_malloc(x, y, frame_format::GRAYSCALE);
    if(tag == "P2") {
        for(int i = 0; i < x; ++i) {
            for(int j = 0; j < y; ++j) {
                file >> img[i * x + y];
            }
        }
    } else {
        file.read(reinterpret_cast<char*>(img), x * y);
    }
    return frame(x, y, img);
}