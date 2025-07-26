package = "SQl.lua"
version = "1.0-1"
source = {
    url = "https://github.com/Horse1jj/SQl.lua"
}
description = {
    summary = "A clean, modern SQLite wrapper for Lua",
    homepage = "https://github.com/Horse1jj/SQL.lua",
    license = "MIT"
}
dependencies = {
    "lua >= 5.3",
    "lsqlite3"
}
build = {
    type = "builtin",
    modules = {
        ["src.init"] = "src/init.lua",
        ["src.connection"] = "src/connection.lua",
        ["src.statement"] = "src/statement.lua",
        ["src.errors"] = "src/errors.lua"
    }
}
