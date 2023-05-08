load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

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
        new_git_repository,
        name = "sentencepiece",
        build_file = "@swift-sentencepiece//:external/sentencepiece.BUILD",
        commit = "3863f7648e5d8edb571ac592f3ac4f5f0695275a",
        remote = "https://github.com/google/sentencepiece.git",
        shallow_since = "1682876235 +0000",
    )
