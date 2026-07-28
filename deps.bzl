load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

def _maybe(repo_rule, name, **kwargs):
    """Executes the given repository rule if it hasn't been executed already.
    Args:
      repo_rule: The repository rule to be executed (e.g., `http_archive`.)
      name: The name of the repository to be defined by the rule.
      **kwargs: Additional arguments passed directly to the repository rule.
    """
    if not native.existing_rule(name):
        repo_rule(name = name, **kwargs)

def swift_sentencepiece_deps():
    """Loads common dependencies needed to compile the swift-sentencepiece library."""

    _maybe(
        git_repository,
        name = "com_google_absl",
        commit = "5650e9cf76d3be4318d5fa3af38ee483ddfd5e4a",
        remote = "https://github.com/abseil/abseil-cpp.git",
        shallow_since = "1780339832 -0400",
    )

    _maybe(
        new_git_repository,
        name = "sentencepiece",
        build_file = "@swift-sentencepiece//:external/sentencepiece.BUILD",
        commit = "e0cce7d37b065b5140349dbe12c6bcf6192fdd78",
        patch_args = ["-p1"],
        patches = ["@swift-sentencepiece//:external/sentencepiece-0.2.2.patch"],
        remote = "https://github.com/google/sentencepiece.git",
        shallow_since = "1782924763 +0900",
    )
