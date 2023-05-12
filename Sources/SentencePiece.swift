import C_sentencepiece

class SentencePieceStorage {
  let sentencepiece: UnsafeMutableRawPointer?
  init(model: String) {
    sentencepiece = sentencepiece_load(model)
  }
  deinit {
    sentencepiece_free(sentencepiece)
  }
}

public struct SentencePiece {
  private let storage: SentencePieceStorage
  public init(file: String) {
    storage = SentencePieceStorage(model: file)
  }
  public func encode(_ line: String) -> [(piece: String, id: Int32, surface: String)] {
    var count: Int32 = 0
    guard let out = sentencepiece_encode(storage.sentencepiece, line, &count) else {
      return []
    }
    var result = [(piece: String, id: Int32, surface: String)]()
    for i in 0..<Int(count) {
      result.append((piece: String(cString: out[i].piece), id: out[i].id, surface: String(cString: out[i].surface)))
      out[i].piece.deallocate()
      out[i].surface.deallocate()
    }
    out.deallocate()
    return result
  }
}
