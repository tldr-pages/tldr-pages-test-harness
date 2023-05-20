#!/usr/bin/env bats

# Tests expect the envvar PATH_TO_TLDR_CLIENT to be set, exits if not.
# If an update command exists, do it before running through tests.
setup_file() {
  if [[ -z $PATH_TO_TLDR_CLIENT ]]
  then
    echo "Expected envvar PATH_TO_TLDR_CLIENT to be set. Exiting!"
    return 1
  fi

  $PATH_TO_TLDR_CLIENT --update || :
}

# Set the language envvars to English explicitly.
setup() {
  export LANG="en_US.UTF-8"
  export LANGUAGE="en_GB:en"
  echo -e "Running test suite for $PATH_TO_TLDR_CLIENT\n"
}

# bats test_tags=required

# Don't include curly braces in tests, clients are free to remove/replace them.
@test "REQUIRED: show tldr-page for tldr" {
  run $PATH_TO_TLDR_CLIENT tldr
  [[ $? -eq 0 ]]
  [[ "$output" = *"Display simple help pages for command-line tools from the tldr-pages project."* ]]
  [[ "$output" = *"https://tldr.sh"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#page-names
@test "REQUIRED: show tldr-page for TLDR (must be treated as lowercase)" {
  run $PATH_TO_TLDR_CLIENT TLDR
  [[ $? -eq 0 ]]
  [[ "$output" = *"Display simple help pages for command-line tools from the tldr-pages project."* ]]
  [[ "$output" = *"https://tldr.sh"* ]]
}

@test "REQUIRED: show tldr-page for git-switch (hyphenated page names)" {
  run $PATH_TO_TLDR_CLIENT git-switch
  [[ $? -eq 0 ]]
  [[ "$output" = *"Switch between Git branches. Requires Git version 2.23+."* ]]
  [[ "$output" = *"https://git-scm.com/docs/git-switch"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#page-names
@test "REQUIRED: show tldr-page for git switch (hyphen is implied and must be inserted transparently)" {
  run $PATH_TO_TLDR_CLIENT git switch
  [[ $? -eq 0 ]]
  [[ "$output" = *"Switch between Git branches. Requires Git version 2.23+."* ]]
  [[ "$output" = *"https://git-scm.com/docs/git-switch"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#if-a-page-is-not-found
@test "REQUIRED: non-zero exit status for page that does not exist" {
  run $PATH_TO_TLDR_CLIENT this-page-will-never-exist
  [[ $status -ne 0 ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#page-names
@test "REQUIRED: non-zero exit status when page that does exist is not first argument" {
  run $PATH_TO_TLDR_CLIENT this-page-will-never-exist tldr
  [[ $status -ne 0 ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: show client version with --version" {
  run $PATH_TO_TLDR_CLIENT --version
  [[ $? -eq 0 ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: show client version with -v (version shorthand)" {
  run $PATH_TO_TLDR_CLIENT -v
  [[ $? -eq 0 ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: show platform specific version of page with --platform" {
  run $PATH_TO_TLDR_CLIENT --platform windows mkdir
  [[ $? -eq 0 ]]
  [[ "$output" = *"Creates a directory."* ]]
  [[ "$output" = *"https://learn.microsoft.com/windows-server/administration/windows-commands/mkdir"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: show platform specific version of page with -p (platform shorthand)" {
  run $PATH_TO_TLDR_CLIENT -p windows mkdir
  [[ $? -eq 0 ]]
  [[ "$output" = *"Creates a directory."* ]]
  [[ "$output" = *"https://learn.microsoft.com/windows-server/administration/windows-commands/mkdir"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: non-zero exit status with -p (platform shorthand) should error without value" {
  run $PATH_TO_TLDR_CLIENT -p
  [[ $status -ne 0 ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: non-zero exit status with --platform (platform) should error without value" {
  run $PATH_TO_TLDR_CLIENT --platform
  [[ $status -ne 0 ]]
}

# If the -l or --list argument is supported, it must show one command per line.
# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "REQUIRED: if list argument supported, output shows one page per line (succeeds if not supported)" {
  run $PATH_TO_TLDR_CLIENT --list

  if [[ $status -ne 0 ]]
  then
    return 0
  fi

  LINES=$(echo "$output" | wc -l)

  [[ $LINES -gt 1 ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#language
@test "REQUIRED: if LANG and LANGUAGE envvars are set to a supported language, output must use that language" {
  export LANG="nl.UTF-8"
  export LANGUAGE="nl"
  run $PATH_TO_TLDR_CLIENT 7z
  [[ $status -eq 0 ]]
  [[ "$output" = *"7z"* ]]
  [[ "$output" = *"Een bestandsarchiveerder met een hoge compressieratio."* ]]
  [[ "$output" = *"https://manned.org/7z"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#language
@test "REQUIRED: if LANG and LANGUAGE envvars are not set, output must be in English" {
  export LANG=""
  export LANGUAGE=""
  run $PATH_TO_TLDR_CLIENT 7z
  [[ $status -eq 0 ]]
  [[ "$output" = *"7z"* ]]
  [[ "$output" = *"File archiver with a high compression ratio."* ]]
  [[ "$output" = *"https://manned.org/7z"* ]]
}

# bats test_tags=optional

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "OPTIONAL: supports --list argument to list all pages" {
  run $PATH_TO_TLDR_CLIENT --list
  [[ "$output" = *"tldr"* ]]
  [[ "$output" = *"apt"* ]]
  [[ "$output" = *"mkdir"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "OPTIONAL: supports -l (list shorthand) argument to list all pages" {
  run $PATH_TO_TLDR_CLIENT --list
  [[ "$output" = *"tldr"* ]]
  [[ "$output" = *"apt"* ]]
  [[ "$output" = *"mkdir"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "OPTIONAL: supports --language argument" {
  run $PATH_TO_TLDR_CLIENT --language nl 7z
  [[ $status -eq 0 ]]
  [[ "$output" = *"7z"* ]]
  [[ "$output" = *"Een bestandsarchiveerder met een hoge compressieratio."* ]]
  [[ "$output" = *"https://manned.org/7z"* ]]
}

# Source: https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#arguments
@test "OPTIONAL: supports -L (language shorthand) argument" {
  run $PATH_TO_TLDR_CLIENT -L nl 7z
  [[ $status -eq 0 ]]
  [[ "$output" = *"7z"* ]]
  [[ "$output" = *"Een bestandsarchiveerder met een hoge compressieratio."* ]]
  [[ "$output" = *"https://manned.org/7z"* ]]
}

# bats_test_tags=recommends

# https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md#directory-structure
@test "RECOMMENDS: treats macos platform as osx" {
  run $PATH_TO_TLDR_CLIENT --platform macos applecamerad
  [[ $status -eq 0 ]]
  [[ "$output" = *"applecamerad"* ]]
  [[ "$output" = *"Camera manager."* ]]
  [[ "$output" = *"https://www.theiphonewiki.com/wiki/Services"* ]]
}
