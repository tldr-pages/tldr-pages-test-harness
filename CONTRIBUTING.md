# Contributing

## Getting Started

Clone the repository with Git.

```sh
git clone https://github.com/tldr-pages/tldr-pages-test-harness.git
```

Install all dependencies listed in the [README](./README.md#dependencies).

You should now be ready to develop!

## Project Structure

### Test Cases

Tests are maintained in `main.bats`, which all run run over a given tldr-pages clients. Read the [Bats documentation](https://bats-core.readthedocs.io/en/stable/writing-tests.html) for more information on how to write tests.

In `main.bats`, there is a convention to prefix a test description with the compliance level it's associated with. There are currently three levels of compliance a specification can fall under.

| | |
|---|---|
| Required | Must be fulfilled by the tldr-pages clients. |
| Optional | A nice to have for tldr clients. |
| Recommends | Recommended to aid user-experience. |

**Optional** and **Recommends** have a lot of overlap, so this may be revised in future.

### Dockerfiles

Popular clients have a Dockerfile defined in the `dockerfiles/` directory. This allows us to test how clients perform against the test suite locally or in CI.

It's preferred to get the binary from the latest release or an authoritative source. Avoid distribution specific releases as they are often outdated. As a guideline: 

* Use the first-party tooling for the client's language. Such as npm for a Node.js client, or Cargo for a Rust client.
* If that's not available, clone the sources from the client's git repository and compile from source.

You can execute a Dockerfile with the following commands:

```sh
docker build -t tldr-test:client-name -f dockerfiles/client-name/Dockerfile .
docker run -it tldr-test:client-name make validate
```

### Makefile

If you're familiar with Node.js development, you may be aware of [`package.json` scripts](https://docs.npmjs.com/cli/v9/using-npm/scripts). A Makefile can be used for a similar purpose, but is stack agnostic and pre-installed on most Linux distributions.

We use the Makefile to define any tasks or dependencies.

To run the tests, execute the following command:

```sh
make validate
```
