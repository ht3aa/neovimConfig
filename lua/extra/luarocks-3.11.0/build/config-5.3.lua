-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/usr/local" };
}
variables = {
   LUA_DIR = "/usr";
   LUA_BINDIR = "/usr/bin";
   LUA_VERSION = "5.3";
   LUA = "/usr/bin/lua5.3";
}
