<div align="center">
  <h1>tldr-pages-test-harness</h1>

[![Matrix chat][matrix-image]][matrix-url]
[![license][license-image]][license-url]

[matrix-url]: https://matrix.to/#/#tldr-pages:matrix.org
[matrix-image]: https://img.shields.io/matrix/tldr-pages:matrix.org?label=Chat+on+Matrix
[license-url]: https://github.com/tldr-pages/tldr-translation-pairs-gen/blob/main/LICENSE
[license-image]: https://img.shields.io/badge/license-MIT-blue.svg?label=License
</div>

## About

This is a Bats test-suite that validates if a tldr-client is compatible with the [client specifications](https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md) set out in the [tldr](https://github.com/tldr-pages/tldr) repository.

## Usage

You can run the `validate` task to test the `tldr` command found on your path:

```sh
make validate
```

Alternatively, you can test any arbitrary binary by specifying the `PATH_TO_TLDR_CLIENT` environment variable before hand:

```sh
PATH_TO_TLDR_CLIENT={{path/to/file}} make validate
```

## Dependencies

* [Bats](https://github.com/bats-core/bats-core)
* [Make](https://www.gnu.org/software/make/)

### Debian

```sh
sudo apt install bats make
```
