cc_library(
    name = "C_sentencepiece",
    srcs = glob([
        "src/builtin_pb/*.cc",
        "src/builtin_pb/*.h",
        "src/*.cc",
    ]),
    hdrs = glob(["src/*.h"]),
    copts = ["-fPIC"],
    includes = [
        "src",
        "src/builtin_pb",
    ],
    linkopts = [],
    local_defines = [
        "_GNU_SOURCE",
        "CCD_STATIC_DEFINE",
    ],
    tags = ["swift_module=C_sentencepiece"],
    visibility = ["//visibility:public"],
    deps = [],
)
