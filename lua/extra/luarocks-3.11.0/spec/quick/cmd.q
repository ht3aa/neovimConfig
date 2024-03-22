SUITE: luarocks CLI

================================================================================
TEST: warns but continues if given an invalid version

RUN: luarocks --lua-version 1.0

STDOUT:
--------------------------------------------------------------------------------
Version    : 1.0
LUA        : (interpreter not found)
--------------------------------------------------------------------------------



================================================================================
TEST: reports if lua.h header is not found

RUN: luarocks LUA_INCDIR=/bad/dir

STDOUT:
--------------------------------------------------------------------------------
LUA_INCDIR : /bad/dir (lua.h not found)
--------------------------------------------------------------------------------



================================================================================
TEST: reports if Lua library is not found

RUN: luarocks LUA_LIBDIR=/bad/dir

STDOUT:
--------------------------------------------------------------------------------
LUA_LIBDIR : /bad/dir (Lua library itself not found)
--------------------------------------------------------------------------------