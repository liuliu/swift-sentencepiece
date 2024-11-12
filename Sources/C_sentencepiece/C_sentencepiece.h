#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif
void* sentencepiece_load(const char* const model);
void* sentencepiece_load_bytes(const char* const bytes, const size_t size);
typedef struct {
	int id;
	char* piece;
	char* surface;
} sentence_piece_t;
sentence_piece_t* sentencepiece_encode(void* const sentencepiece, const char* const line, int* const size);
const char* sentencepiece_decode(void* const sentencepiece, const int* const ids, const int size);
void sentencepiece_free(void* sentencepiece);
#ifdef __cplusplus
}
#endif
