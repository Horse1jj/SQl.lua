local Errors = {}

function Errors.DatabaseError(message)
    return { type = "DatabaseError", message = message }
end

function Errors.StatementError(message)
    return { type = "StatementError", message = message }
end

function Errors.BindError(message)
    return { type = "BindError", message = message }
end

function Errors.RuntimeError(message)
    return { type = "RuntimeError", message = message }
end

function Errors.raise(err)
    error(string.format("[%s] %s", err.type, err.message))
end

return Errors
