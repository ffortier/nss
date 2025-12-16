load("@rules_cc//cc:cc_library.bzl", _cc_library = "cc_library")

def cc_library(name, local_defines = [], deps = [], **kwargs):
    kwargs.setdefault("visibility", ["//lib:__subpackages__"])

    return _cc_library(
        name = name,
        local_defines = local_defines + select(
            {
                "//lib:linux_x86_64": [
                    "HAVE_STRERROR",
                    "LINUX",
                    "XP_UNIX",
                    "_REENTRANT",
                    "_DEFAULT_SOURCE",
                    "_BSD_SOURCE",
                    "_POSIX_SOURCE",
                    "SDB_MEASURE_USE_TEMP_DIR",
                    "NSS_DISABLE_SSE3",
                    "NSS_NO_INIT_SUPPORT",
                    "USE_UTIL_DIRECTLY",
                    "NO_NSPR_10_SUPPORT",
                    "SSL_DISABLE_DEPRECATED_CIPHER_SUITE_NAMES",
                ],
            },
        ),
        deps = deps + [
            "//lib/private/nss:headers",
            "//lib/public/nss:headers",
        ],
        **kwargs
    )
