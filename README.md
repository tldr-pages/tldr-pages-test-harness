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

This is a Bats test-suite that validates if a tldr-pages client is compatible with the [client specifications](https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md) set out in the [tldr](https://github.com/tldr-pages/tldr) repository.

## Results

| Client | Compliance |
|---|---|
| [tealdeer](https://github.com/dbrgn/tealdeer) | ![tldr-pages compliance level for tealdeer](https://SethFalco.github.io/tldr-pages-test-harness/tealdeer.png) |
| [tldr-node-client](https://github.com/tldr-pages/tldr-node-client) | ![tldr-pages compliance level for tldr-node-client](https://SethFalco.github.io/tldr-pages-test-harness/tldr-node-client.png) |

## Usage

You can run the `validate` task to test the `tldr` command found on your path:

```sh
make validate
```

Alternatively, you can test any arbitrary binary by specifying the `PATH_TO_TLDR_CLIENT` environment variable before hand:

```sh
PATH_TO_TLDR_CLIENT={{path/to/binary}} make validate
```

There are also the `validate-level-2` and `validate-level-3` tasks to check if clients adhere to optional parts of the spec.

## Dependencies

* [Bats](https://github.com/bats-core/bats-core)
* [Make](https://www.gnu.org/software/make/)

### Debian

```sh
sudo apt install bats make
```
