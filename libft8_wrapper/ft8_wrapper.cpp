#include <cstdint>
#include <cstring>
extern "C" {
    // Fortran subroutines have a trailing underscore in the symbol name.
    // These prototypes match the ones defined in the FT8 Fortran sources.
    void ft8code_(const char* msg, int* toneArray, int* nTone);
    void genft8_(const char* msg, int* msgbits);
    void encode174_91_(int* msgbits, int* codeword);
    void decode174_91_(int* codeword, int* msgbits);
}

extern "C" int gen_ft8_message(const char* message, uint8_t* out_bits, int* out_tones) {
    // FT8 expects a fixed‑length string (max 13 chars). Pad with spaces.
    char msg[13];
    std::size_t len = std::strlen(message);
    if (len > 13) len = 13;
    std::memcpy(msg, message, len);
    if (len < 13) std::memset(msg + len, ' ', 13 - len);

    int msgbits[10]; // 77 bits → 10 integers (32‑bit each, extra bits ignored)
    genft8_(msg, msgbits);
    std::memcpy(out_bits, msgbits, 10 * sizeof(int));

    int tones[79];
    int nTone = 0;
    ft8code_(msg, tones, &nTone);
    std::memcpy(out_tones, tones, nTone * sizeof(int));
    return 0; // success
}

extern "C" int encode_ft8(const uint8_t* bits, uint8_t* out_codeword) {
    // bits points to the 10 ints produced by gen_ft8_message
    int* msgbits = (int*)bits;
    int codeword[22]; // 174 bits → 22 ints
    encode174_91_(msgbits, codeword);
    std::memcpy(out_codeword, codeword, 22 * sizeof(int));
    return 0;
}

extern "C" int decode_ft8(const uint8_t* codeword, uint8_t* out_bits) {
    int* cw = (int*)codeword;
    int msgbits[10];
    decode174_91_(cw, msgbits);
    std::memcpy(out_bits, msgbits, 10 * sizeof(int));
    return 0;
}
