# Contributing

## Getting Started

Clone the repository with Git.

```sh
git clone https://github.com/tldr-pages/tldr-pages-test-harness.git
```

Install all dependencies listed in the [README](./README.md#dependencies).

You should now be ready to develop!

## Project Structure

### Bats

The bulk of the code is in the `main.bats` file, which is a test suite that run over a given tldr client. Read the [Bats documentation](https://bats-core.readthedocs.io/en/stable/writing-tests.html) for more information on how to write tests.

In the `main.bats` file, there is a convention to prefix a test description with the compliance level it's associated with. There are currently three levels of compliance a specification can fall under.

| | |
|---|---|
| Required | Must be fulfilled by the tldr client. |
| Optional | A nice to have for tldr clients. |
| Recommends | Recommended to aid user-experience. |

**Optional** and **Recommends** have a lot of overlap, so this may be revised in future.

### Makefile

If you're familiar with Node.js development, you may be aware of [`package.json` scripts](https://docs.npmjs.com/cli/v9/using-npm/scripts). A Makefile can be used for a similar purpose, but is stack agnostic and pre-installed on most Linux distributions.

We use the Makefile to define any tasks or dependencies.

To run the tests you can do the following command:

```sh
make validate
```
