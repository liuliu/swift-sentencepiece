#ifdef __cplusplus
extern "C" {
#endif
void* sentencepiece_load(const char* const model);
int* sentencepiece_encode(void* const sentencepiece, const char* const line, int* const size);
void sentencepiece_free(void* sentencepiece);
#ifdef __cplusplus
}
#endif
