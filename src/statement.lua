local Errors = require("src.errors")

local Statement = {}
Statement.__index = Statement

function Statement.new(stmt)
    return setmetatable({ stmt = stmt }, Statement)
end

function Statement:bind(params)
    for k, v in pairs(params) do
        local success = self.stmt:bind(k, v)
        if not success then
            Errors.raise(Errors.BindError("Failed to bind: " .. tostring(k)))
        end
    end
end

function Statement:step()
    return self.stmt:step()
end

function Statement:finalize()
    self.stmt:finalize()
end

function Statement:row()
    local row = {}
    for i = 1, self.stmt:columns() do
        local name = self.stmt:get_name(i)
        row[name] = self.stmt:get_value(i)
    end
    return row
end

function Statement:rows()
    return coroutine.wrap(function()
        while self:step() == sqlite3.ROW do
            coroutine.yield(self:row())
        end
    end)
end

return Statement
