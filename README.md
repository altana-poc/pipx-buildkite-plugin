# Pipx Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) that ensures **pipx** and **Python 3** are installed before running a build step.

This plugin will:
- Ensure **Python 3** is installed (supports `dnf`, `apt-get`, `yum` and `apk`).
- Ensure **pipx** is installed and available in `PATH`.

## Example Usage

This will install `pipx` before running your build step.

```yml
steps:
  - command: ./run_python_checks.sh
    plugins:
      - altana-poc/pipx#v1.0.0
