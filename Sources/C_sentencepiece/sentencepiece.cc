#include "C_sentencepiece.h"
#ifdef SPM_BUILD
#include "sentencepiece_processor.h"
#include "builtin_pb/sentencepiece.pb.h"
#include "absl/strings/string_view.h"
#else
#include "src/sentencepiece_processor.h"
#include "src/builtin_pb/sentencepiece.pb.h"
#include "third_party/absl/strings/string_view.h"
#endif

void* sentencepiece_load(const char* const model)
{
	sentencepiece::SentencePieceProcessor* sp = new sentencepiece::SentencePieceProcessor();
	sp->Load(model);
	return (void*)sp;
}

void* sentencepiece_load_bytes(const char* const bytes, const size_t size)
{
	sentencepiece::SentencePieceProcessor* sp = new sentencepiece::SentencePieceProcessor();
	sp->LoadFromSerializedProto(absl::string_view(bytes, size));
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

const char* sentencepiece_decode(void* const sentencepiece, const int* const ids, const int size)
{
	sentencepiece::SentencePieceProcessor* sp = (sentencepiece::SentencePieceProcessor*)sentencepiece;
	std::vector<int> vec;
	std::copy(ids, ids + size, back_inserter(vec));
	std::string text;
	sp->Decode(vec, &text);
	const size_t text_length = text.length();
	char* text_cstr = (char *)malloc(text_length + 1);
	memcpy(text_cstr, text.c_str(), text_length + 1);
	return text_cstr;
}

void sentencepiece_free(void* sentencepiece)
{
	sentencepiece::SentencePieceProcessor* sp = (sentencepiece::SentencePieceProcessor*)sentencepiece;
	delete sp;
}
