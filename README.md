# 🔄 GitHub Workflows for cvxgrp

[![Apache 2.0 License](https://img.shields.io/badge/License-APACHEv2-brightgreen.svg)](LICENSE)

A collection of reusable GitHub Actions workflows and configurations
for the cvxgrp organization and beyond.

## 📋 Overview

This repository contains standardized GitHub Actions workflows
that can be reused across multiple projects.
These workflows help automate common tasks such as:

- 🧪 Running tests and generating coverage reports
- 📄 Building LaTeX documents
- 📚 Generating documentation
- 🔍 Code quality checks and linting
- 📦 Building and publishing packages

## ⚠️ Important Notes

### 🔒 Private Repositories

Be careful when using actions in private repositories.
The group has a limited number of minutes per month.
In public repositories, actions are free.

### 🚫 Removed Actions

We have removed the poetry-based actions:

- actions/test@main
- actions/sphinx@main
- actions/setup-environment@main
- actions/pdoc@main
- actions/jupyter@main
- actions/coverage@main
- actions/book@main

You have two options:

1. Use cvxgrp/.github/actions/test@v1.4.0 where all those
actions are still present
2. Move to uv (recommended)

## 🛠️ Package Management

### uv

To take full advantage of the actions provided here,
we recommend using [uv](https://github.com/astral-sh/uv).
uv is a modern package manager for Python that allows you
to create and manage virtual environments efficiently.

A more dated alternative is [poetry](https://python-poetry.org/).

## 🔄 Available Workflows

GitHub workflows help robustify and automate the process
of creating software and documents. We recommend
reading the [GitHub Actions introduction](https://docs.github.com/actions)
for more information.

Here are some example actions created for cvxgrp:

### 📄 [latex](https://github.com/cvxgrp/.github/blob/main/actions/latex/action.yml)

This workflow compiles *.tex files and uploads the generated documents
to the draft branch.

### 🧪 [test](https://github.com/cvxgrp/.github/blob/main/actions/test/action.yml)

This workflow installs pytest and related packages, runs tests,
and uploads the test results as artifacts.

### 📚 [book](https://github.com/cvxgrp/.github/blob/main/actions/book/action.yml)

This workflow builds and publishes documentation for your
repository.

### 🔍 [pre-commit](https://github.com/cvxgrp/.github/blob/main/actions/pre-commit/action.yml)

This workflow runs code quality checks and linting on your codebase.

## 📋 Using Workflows

Creating workflows for your own repository is simple:

1. Create the `.github/workflows` folder in your repository
2. Create a YAML file with the name of the workflow you want to use (e.g., `basic.yml`)
3. Define your workflow using the example below:

```yaml
name: "basic"

on:
  push:

jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
      - uses: cvxgrp/.github/actions/pre-commit@v2.2.4

  test:
    runs-on: ubuntu-latest
    steps:
    - name: "Build the virtual environment for ${{ github.repository }}"
      uses: cvxgrp/.github/actions/environment@v2.2.4

    - uses: cvxgrp/.github/actions/coverage@v2.2.4
      with:
        coveralls: 'true'
```

Every push to the repository will trigger the workflow.
It will run all jobs defined in the workflow:

- The `pre-commit` job runs code quality checks
- The `test` job builds a virtual environment, runs tests, and measures test coverage

## 📊 Examples

There are many examples of workflow files in these repositories:

- [cvxmarkowitz](https://github.com/cvxgrp/cvxmarkowitz/tree/main/.github/workflows)
- [cvxsimulator](https://github.com/cvxgrp/simulator/tree/main/.github/workflows)

Note the strong overlap between both projects.
Rather than coding the same workflow twice,
repositories point to the actions defined here.

For a paper repository, we use the LaTeX workflow. For example:

- [cov_pred_finance](https://github.com/cvxgrp/cov_pred_finance_paper/tree/main/.github/workflows)

Note that paper repositories tend to be private and are hence
only visible to members of the group.

## 🤝 Contributing

Contributions to improve these workflows are welcome.
Please feel free to submit issues or pull requests.
