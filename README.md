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

A Bats test-suite that validates if a tldr-pages client is compatible with the [client specifications](https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md) set out in the [tldr](https://github.com/tldr-pages/tldr) repository.

You can see a summary of each test, including links to the relevant sections of the specification in the [`tldr.bats`](./tldr.bats) file.

## Results

| Client | Compliance |
|---|---|
| [tealdeer](https://github.com/dbrgn/tealdeer) | ![tldr-pages compliance level for tealdeer](https://tldr.sh/tldr-pages-test-harness/tealdeer.png) |
| [tldr-c-client](https://github.com/tldr-pages/tldr-c-client) | ![tldr-pages compliance level for tldr-c-client](https://tldr.sh/tldr-pages-test-harness/tldr-c-client.png) |
| [tldr-node-client](https://github.com/tldr-pages/tldr-node-client) | ![tldr-pages compliance level for tldr-node-client](https://tldr.sh/tldr-pages-test-harness/tldr-node-client.png) |
| [tldr-python-client](https://github.com/tldr-pages/tldr-python-client) | ![tldr-pages compliance level for tldr-python-client](https://tldr.sh/tldr-pages-test-harness/tldr-python-client.png) |
| [tlrc](https://github.com/tldr-pages/tlrc) | ![tldr-pages compliance level for tlrc](https://tldr.sh/tldr-pages-test-harness/tlrc.png) |

## Running Against Local Builds

This is for if you want to check the results for a particular client, or are a maintainer of a tldr-pages client and want to run your development build against our compliance test suite.

Run the `validate` task to test the `tldr` command found on your path:

```sh
make validate
```

Alternatively, you can test any arbitrary binary by specifying the `PATH_TO_TLDR_CLIENT` environment variable:

```sh
PATH_TO_TLDR_CLIENT={{path/to/binary}} make validate
```

There are also the `validate-level-2` and `validate-level-3` tasks to check if clients adhere to optional parts of the spec.

### Docker

You can execute the tests for a predefined tldr-pages client even if you don't have it installed, so long as the Dockerfile is available for the client.

Check the contents of the `dockerfiles/` directory, and run the `CLIENT={{client}} docker-validate` command, populating the `CLIENT` environment variable with the client to test. For example:

```sh
CLIENT=tldr-c-client make docker-validate
```

You can also run `docker-validate-level-2` or `docker-validate-level-3` to check optional parts of the spec.

## Dependencies

* [Bats](https://github.com/bats-core/bats-core)
* [Make](https://www.gnu.org/software/make/)

### Debian

```sh
sudo apt install bats make
```
