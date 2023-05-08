cc_library(
    name = "absl",
    hdrs = glob(["third_party/absl/**/*.h"]),
    includes = [
        "third_party/absl",
    ],
    linkopts = [],
    deps = [],
)

cc_library(
    name = "darts_clone",
    hdrs = glob(["third_party/darts_clone/darts.h"]),
    linkopts = [],
    deps = [],
)

cc_library(
    name = "esaxx",
    hdrs = glob(["third_party/esaxx/*.hxx"]),
    linkopts = [],
    deps = [],
)

cc_library(
    name = "protobuf_lite",
    srcs = glob([
        "third_party/protobuf-lite/*.cc",
    ]),
    hdrs = glob([
        "third_party/protobuf-lite/**/*.h",
        "third_party/protobuf-lite/**/*.inc",
    ]),
    copts = ["-fPIC"],
    includes = [
        "third_party/protobuf-lite",
    ],
    linkopts = [],
    local_defines = [
        "_GNU_SOURCE",
        "HAVE_PTHREAD",
    ],
    deps = [],
)

genrule(
    name = "config",
    outs = ["src/config.h"],
    cmd = "echo '#define VERSION \"0.1.99\"' > $(OUTS)",
)

cc_library(
    name = "sentencepiece",
    srcs = glob([
        "src/builtin_pb/*.cc",
        "src/builtin_pb/*.h",
    ]) + [
        "src/bpe_model.cc",
        "src/char_model.cc",
        "src/error.cc",
        "src/filesystem.cc",
        "src/model_factory.cc",
        "src/model_interface.cc",
        "src/normalizer.cc",
        "src/sentencepiece_processor.cc",
        "src/unigram_model.cc",
        "src/util.cc",
        "src/word_model.cc",
    ],
    hdrs = [
        "src/bpe_model.h",
        "src/char_model.h",
        "src/common.h",
        "src/filesystem.h",
        "src/freelist.h",
        "src/init.h",
        "src/model_factory.h",
        "src/model_interface.h",
        "src/normalizer.h",
        "src/sentencepiece_processor.h",
        "src/testharness.h",
        "src/unigram_model.h",
        "src/util.h",
        "src/word_model.h",
        ":config",
    ],
    copts = ["-fPIC"],
    includes = [
        "src",
        "src/builtin_pb",
    ],
    linkopts = [],
    local_defines = [
        "_GNU_SOURCE",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":absl",
        ":darts_clone",
        ":protobuf_lite",
    ],
)

cc_library(
    name = "sentencepiece_train",
    srcs = [
        "src/bpe_model_trainer.cc",
        "src/builder.cc",
        "src/char_model_trainer.cc",
        "src/pretokenizer_for_training.cc",
        "src/sentencepiece_trainer.cc",
        "src/spec_parser.h",
        "src/trainer_factory.cc",
        "src/trainer_interface.cc",
        "src/unicode_script.cc",
        "src/unigram_model_trainer.cc",
        "src/word_model_trainer.cc",
    ],
    hdrs = [
        "src/bpe_model_trainer.h",
        "src/builder.h",
        "src/char_model_trainer.h",
        "src/normalization_rule.h",
        "src/pretokenizer_for_training.h",
        "src/sentencepiece_trainer.h",
        "src/trainer_factory.h",
        "src/trainer_interface.h",
        "src/unicode_script.h",
        "src/unicode_script_map.h",
        "src/unigram_model_trainer.h",
        "src/word_model_trainer.h",
    ],
    copts = ["-fPIC"],
    includes = [
        "src",
    ],
    linkopts = [],
    local_defines = [
        "_GNU_SOURCE",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":C_sentencepiece",
        ":absl",
        ":darts_clone",
        ":esaxx",
        ":protobuf_lite",
    ],
)
