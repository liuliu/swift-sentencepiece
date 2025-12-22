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
        .package(url: "https://github.com/weiyanlin117/swift-package-wrapper-sentencepiece", revision: "1b3f57c33dac8329f7a69fdc16ec6f2bcc0b20fe"),
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
                .headerSearchPath("."),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
