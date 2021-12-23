# Package

version       = "0.1.0"
author        = "Luciano Lorenzo"
description   = "Download Patreon data"
license       = "gpl-3.0"
srcDir        = "src"


# Dependencies

requires "nim >= 1.5.1"
requires "https://gitlab.com/lurlo/useragent"
requires "cligen"

bin = @["patreon"]
binDir = "build"

task build_release, "Builds the release version":
  exec "nimble -d:release build"
task build_danger, "Builds the danger version":
  exec "nimble -d:danger build"
