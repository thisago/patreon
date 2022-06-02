
# Package

version       = "0.1.0"
author        = "Thiago Navarro"
description   = "Download Patreon data"
license       = "mit
srcDir        = "src"


# Dependencies

requires "nim >= 1.5.1"
requires "https://github.com/thisago/useragent"
requires "cligen"

bin = @["patreon"]
binDir = "build"

task build_release, "Builds the release version":
  exec "nimble -d:release build"
task build_danger, "Builds the danger version":
  exec "nimble -d:danger build"
