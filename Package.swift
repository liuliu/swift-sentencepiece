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
        .package(url: "https://github.com/weiyanlin117/swift-package-support-sentencepiece", revision: "a39a5be0b3e3ad9bcb19b085af7dd891c00aa3d2"),
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
                .product(name: "swift-package-support-sentencepiece", package: "swift-package-support-sentencepiece"),
            ],
            path: "Sources/C_sentencepiece",
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("."),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
