# 🔄 [.github](https://docs.github.com/en/actions/using-workflows/creating-starter-workflows-for-your-organization#creating-a-starter-workflow)

[![Apache 2.0
License](https://img.shields.io/badge/License-APACHEv2-brightgreen.svg)](LICENSE)

Reusable workflows (not only) for cvxgrp

## :warning: Private repositories

Be careful when using actions in private repositories.
The group has a limited number of minutes per month.
In public repositories, actions are free.

## :warning: Removed actions

We have removed the poetry based action

- actions/test@main
- actions/sphinx@main
- actions/setup-environment@main
- actions/pdoc@main
- actions/jupyter@main
- actions/coverage@main
- actions/book@main

You have two options. You can either use cvxgrp/.github/actions/test@v1.4.0
where all those actions are still present or move to uv.

## 🛠️ uv

To take full advantage of the actions given here we recommend using
[uv](https://github.com/astral-sh/uv). uv is a modern package manager for Python.
It allows to create and manage virtual environments.
A more dated alternative is [poetry](https://python-poetry.org/).

## 🔄 Action workflows

Github workflows can help to robustify and to automate
the process of creating software and documents.
We recommend [Github introduction](https://docs.github.com/actions).

We list two example actions created for cvxgrp:

### 📄 [latex](https://github.com/cvxgrp/.github/blob/main/actions/latex/action.yml)

This workflow is used to compile *.tex files.
It uploads the generated documents to the draft branch.

### 🧪 [test](https://github.com/cvxgrp/.github/blob/main/actions/test/action.yml)

This workflow install pytest and some its friends.
It uploads the test results as artifacts.
It assumes the project is built with poetry.

## 📋 Using workflows

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
It will run all jobs in the workflow.
There are two jobs defined here: pre-commit and test.
Both these jobs run on a ubuntu machine.
Each job consists of at least one step.
The steps are the actions that will be executed.

In the test job we run the cvxgrp action building a
virtual environment before performing all tests
and measuring test coverage.

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
