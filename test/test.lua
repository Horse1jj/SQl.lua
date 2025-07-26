local SQL = require("src.init")

local db = SQL.connect("test.db")

db:exec([[
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT
);
]])

local stmt = db:prepare("INSERT INTO users (name, email) VALUES (:name, :email)")
stmt:bind({ name = "foste1jj", email = "foste1jj@example.com" })
stmt:step()
stmt:finalize()

local results = db:query("SELECT * FROM users")
for _, row in ipairs(results) do
    print(("ID: %d | Name: %s | Email: %s"):format(row.id, row.name, row.email))
end

db:close()
