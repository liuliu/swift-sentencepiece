// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "swift-sentencepiece",
    products: [
        .library(
            name: "SentencePiece",
            targets: ["SentencePiece"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/weiyanlin117/swift-package-wrapper-sentencepiece", revision: "f2953e2cf222923b6ed1907bf597318cff724b13"),
    ],
    targets: [
        .target(
            name: "SentencePiece",
            dependencies: ["C_sentencepiece"],
            path: "Sources",
            exclude: ["BUILD.bazel", "C_sentencepiece"],
            sources: ["SentencePiece.swift"]
        ),
        .target(
            name: "C_sentencepiece",
            dependencies: [
                .product(name: "sentencepiece", package: "swift-package-wrapper-sentencepiece"),
            ],
            path: "Sources/C_sentencepiece",
            publicHeadersPath: ".",
            cxxSettings: [
                .define("SPM_BUILD"),
                .headerSearchPath("."),
                .headerSearchPath("../../.build/checkouts/swift-package-wrapper-sentencepiece/third_party/protobuf-lite"),
                .headerSearchPath("../../.build/checkouts/swift-package-wrapper-sentencepiece/third_party"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
