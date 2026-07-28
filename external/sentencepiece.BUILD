_ABSL_DEPS = [
    "@com_google_absl//absl/base:core_headers",
    "@com_google_absl//absl/cleanup",
    "@com_google_absl//absl/container:btree",
    "@com_google_absl//absl/container:fixed_array",
    "@com_google_absl//absl/container:flat_hash_map",
    "@com_google_absl//absl/container:flat_hash_set",
    "@com_google_absl//absl/flags:flag",
    "@com_google_absl//absl/flags:parse",
    "@com_google_absl//absl/flags:usage",
    "@com_google_absl//absl/functional:any_invocable",
    "@com_google_absl//absl/functional:function_ref",
    "@com_google_absl//absl/hash",
    "@com_google_absl//absl/log:check",
    "@com_google_absl//absl/log:globals",
    "@com_google_absl//absl/log:initialize",
    "@com_google_absl//absl/log:log",
    "@com_google_absl//absl/numeric:bits",
    "@com_google_absl//absl/random",
    "@com_google_absl//absl/status:status",
    "@com_google_absl//absl/status:status_builder",
    "@com_google_absl//absl/status:status_macros",
    "@com_google_absl//absl/strings",
    "@com_google_absl//absl/strings:str_format",
    "@com_google_absl//absl/synchronization",
    "@com_google_absl//absl/time",
    "@com_google_absl//absl/types:span",
]

genrule(
    name = "config",
    outs = ["config.h"],
    cmd = "echo '#define VERSION \"0.2.2\"\n#define PACKAGE \"sentencepiece\"\n#define PACKAGE_STRING \"sentencepiece\"\n#define INSTALL_DATADIR \"\"' > $(OUTS)",
)

cc_library(
    name = "darts_clone",
    hdrs = glob(["third_party/darts_clone/darts.h"]),
    linkopts = [],
    strip_include_prefix = "third_party/darts_clone",
    deps = [],
)

cc_library(
    name = "esaxx",
    hdrs = glob(["third_party/esaxx/*.hxx"]),
    linkopts = [],
    strip_include_prefix = "third_party/esaxx",
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

cc_library(
    name = "sentencepiece",
    srcs = glob([
        "src/builtin_pb/*.cc",
        "src/builtin_pb/*.h",
    ]) + [
        "src/bpe_model.cc",
        "src/char_model.cc",
        "src/filesystem.cc",
        "src/init.cc",
        "src/model_factory.cc",
        "src/model_interface.cc",
        "src/normalizer.cc",
        "src/sentencepiece_processor.cc",
        "src/unigram_model.cc",
        "src/util.cc",
        "src/word_model.cc",
        "src/bpe_model.h",
        "src/char_model.h",
        "src/common.h",
        "src/filesystem.h",
        "src/freelist.h",
        "src/init.h",
        "src/model_factory.h",
        "src/model_interface.h",
        "src/normalizer.h",
        "src/testharness.h",
        "src/unigram_model.h",
        "src/util.h",
        "src/word_model.h",
    ],
    hdrs = [
        "src/sentencepiece_processor.h",
        ":config",
    ],
    copts = [
        "-fPIC",
        "-Isrc",
    ],
    includes = [
        "src/builtin_pb",
    ],
    linkopts = [],
    local_defines = [
        "_GNU_SOURCE",
    ],
    visibility = ["//visibility:public"],
    deps = _ABSL_DEPS + [
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
    deps = _ABSL_DEPS + [
        ":darts_clone",
        ":esaxx",
        ":protobuf_lite",
        ":sentencepiece",
    ],
)
