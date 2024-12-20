# [.github](https://docs.github.com/en/actions/using-workflows/creating-starter-workflows-for-your-organization#creating-a-starter-workflow)

Reusable workflows (not only) for cvxgrp

## :warning: Private repositories

Be careful when using actions in private repositories.
The group has a limited number of minutes per month.
In public repositories, actions are free.

## uv

To take full advantage of the actions given here we recommend using
[uv](https://github.com/astral-sh/uv). uv is a modern package manager for Python.
It allows to create and manage virtual environments.
A more dated alternative is [poetry](https://python-poetry.org/).

## taskfile

We highly recommend [task](https://taskfile.dev). We offer central taskfiles [here](tasks)

## Action workflows

Github workflows can help to robustify and to automate
the process of creating software and documents.
We recommend [Github introduction](https://docs.github.com/actions).

We go through an incomplete list of example actions created for cvxgrp:

### [latex](https://github.com/cvxgrp/.github/blob/main/actions/latex/action.yml)

This workflow is used to compile *.tex files.
It uploads the generated documents to the draft branch.

### [build](https://github.com/cvxgrp/.github/blob/main/actions/build/action.yml)

This workflow is used to support the release of packages (to pypi).
It assumes the project is built with poetry. It publishes the produced
'dist' folder to a dedicated branch.

### [test](https://github.com/cvxgrp/.github/blob/main/actions/test/action.yml)

This workflow install pytest and some its friends.
It uploads the test results as artifacts.
It assumes the project is built with poetry.

## Using workflows

Creating workflows for your own repository is simple.
Please follow:

- Create the '.github/workflows' folder.

In this folder create a yml file with the name of the workflow
you want to use, e.g. basic.yml.

```yaml
name: "basic"

on:
  push:

jobs:
  pre-commit:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4
    - uses: pre-commit/action@v3.0.1
      with:
        extra_args: '--verbose --all-files'

  test:
    runs-on: ubuntu-latest
    steps:
    - uses: cvxgrp/.github/actions/test@main

    - name: Coveralls GitHub Action
      uses: coverallsapp/github-action@v2
      with:
        files: artifacts/tests/coverage/coverage.info
        format: lcov
```

Every push to the repository will trigger the workflow.
It will run all jobs in the workflow.
There are two jobs defined here: pre-commit and test.
Both these jobs run on a ubuntu machine.
Each job consists of at least one step.
The steps are the actions that will be executed.

In pre-commit job we checkout the repository first and then
run the 3rd party pre-commit/action step.

In the test job we run the cvxgrp action performing
all tests. The action would checkout the repository first.
In the second step we share the coverage results
with yet another 3rdd party GitHub action.

It is very common to use external GitHub actions.

There are many more examples of such workflow files in the repositories:

- [cvxmarkowitz](https://github.com/cvxgrp/cvxmarkowitz/tree/main/.github/workflows)
- [cvxsimulator](https://github.com/cvxgrp/simulator/tree/main/.github/workflows)

Note the strong overlap between both projects.
The jobs are essentially all the same.
Rather than coding the same workflow twice we point from both places to the actions
defined here.

For a paper repository we use the LaTeX workflow. For an example

- [cov_pred_finance](https://github.com/cvxgrp/cov_pred_finance_paper/tree/main/.github/workflows)

All paper repos tend to be private and are hence only
visible to members of the group.
