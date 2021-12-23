import std/unittest
import patreon

suite "patreon":
  test "Can say":
    const msg = "Hello from patreon test"
    check msg == say msg
