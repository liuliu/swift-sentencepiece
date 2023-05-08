#include "C_sentencepiece.h"
#include "src/sentencepiece_processor.h"

void* sentencepiece_load(const char* const model)
{
	sentencepiece::SentencePieceProcessor* sp = new sentencepiece::SentencePieceProcessor();
	sp->Load(model);
	return (void*)sp;
}

int* sentencepiece_encode(void* const sentencepiece, const char* const line, int* const size)
{
	sentencepiece::SentencePieceProcessor* sp = (sentencepiece::SentencePieceProcessor*)sentencepiece;
	std::vector<int> ids;
	sp->Encode(line, &ids);
	int* const result = (int*)malloc(sizeof(int) * ids.size());
	for (int i = 0; i < ids.size(); i++)
		result[i] = ids[i];
	*size = ids.size();
	return result;
}

void sentencepiece_free(void* sentencepiece)
{
	sentencepiece::SentencePieceProcessor* sp = (sentencepiece::SentencePieceProcessor*)sentencepiece;
	delete sp;
}
