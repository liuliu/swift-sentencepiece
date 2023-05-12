#include "C_sentencepiece.h"
#include "src/sentencepiece_processor.h"
#include "src/builtin_pb/sentencepiece.pb.h"

void* sentencepiece_load(const char* const model)
{
	sentencepiece::SentencePieceProcessor* sp = new sentencepiece::SentencePieceProcessor();
	sp->Load(model);
	return (void*)sp;
}

sentence_piece_t* sentencepiece_encode(void* const sentencepiece, const char* const line, int* const size)
{
	sentencepiece::SentencePieceProcessor* sp = (sentencepiece::SentencePieceProcessor*)sentencepiece;
	sentencepiece::SentencePieceText spt;
	sp->Encode(line, &spt);
	std::vector<std::string> pieces;
	std::vector<std::string> surfaces;
	std::vector<int> ids;
	for (const auto &sp : spt.pieces()) {
		pieces.emplace_back(sp.piece());
		ids.emplace_back(sp.id());
		surfaces.emplace_back(sp.surface());
	}
	sentence_piece_t* const result = (sentence_piece_t*)malloc(sizeof(sentence_piece_t) * ids.size());
	for (int i = 0; i < ids.size(); i++)
	{
		const size_t piece_length = pieces[i].length();
		char *piece = (char *)malloc(piece_length + 1);
		memcpy(piece, pieces[i].c_str(), piece_length + 1);
		result[i].piece = piece;
		result[i].id = ids[i];
		const size_t surface_length = surfaces[i].length();
		char *surface = (char *)malloc(surface_length + 1);
		memcpy(surface, surfaces[i].c_str(), surface_length + 1);
		result[i].surface = surface;
	}
	*size = ids.size();
	return result;
}

void sentencepiece_free(void* sentencepiece)
{
	sentencepiece::SentencePieceProcessor* sp = (sentencepiece::SentencePieceProcessor*)sentencepiece;
	delete sp;
}
