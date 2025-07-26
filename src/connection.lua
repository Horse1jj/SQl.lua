local sqlite3 = require("lsqlite3")
local Errors = require("src.errors")
local Statement = require("src.statement")

local Connection = {}
Connection.__index = Connection

function Connection.connect(filename)
    local db = sqlite3.open(filename)
    if not db then
        Errors.raise(Errors.DatabaseError("Failed to open database: " .. filename))
    end
    return setmetatable({ db = db }, Connection)
end

function Connection:exec(sql)
    local ok, err = self.db:exec(sql)
    if ok ~= sqlite3.OK then
        Errors.raise(Errors.DatabaseError(err or "Unknown exec error"))
    end
end

function Connection:prepare(sql)
    local stmt = self.db:prepare(sql)
    if not stmt then
        Errors.raise(Errors.StatementError("Failed to prepare: " .. sql))
    end
    return Statement.new(stmt)
end

function Connection:query(sql, params)
    local stmt = self:prepare(sql)
    stmt:bind(params or {})
    local rows = {}
    for row in stmt:rows() do
        table.insert(rows, row)
    end
    stmt:finalize()
    return rows
end

function Connection:close()
    self.db:close()
end

return Connection
