#!/usr/bin/env bats

setup() {
  # Ensure the environment script is executable
  chmod +x hooks/environment

  load '/opt/homebrew/lib/bats-support/load.bash'
  load '/opt/homebrew/lib/bats-assert/load.bash'

  load "$PWD/hooks/environment"
}

@test "Check if Python 3 is installed" {
  run bash -c "command -v python3"
  assert_success
  assert_output --regexp "python3"
}

@test "Install Python 3 if missing" {
  if ! command -v python3 &> /dev/null; then
    run bash -c "bash hooks/environment"
    assert_success
  else
    skip "Python 3 is already installed."
  fi
}

@test "Ensure pipx is installed" {
  run bash -c "bash hooks/environment && command -v pipx"
  assert_success
  assert_output --regexp "pipx"
}

@test "Ensure PATH includes pipx's bin directory" {
  run bash -c "bash hooks/environment && echo \$PATH"
  assert_success
  assert_output --regexp "$HOME/.local/bin"
}

@test "Ensure pipx installs and runs correctly" {
  run bash -c "bash hooks/environment && pipx --version"
  assert_success
  assert_output --regexp "pipx"
}
