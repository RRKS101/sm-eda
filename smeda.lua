function readAll(path)
    local f = io.open(path, "rb"), "Failed To Open " .. path
    if not f then return nil, "Failed To Open File" end

    local d = f:read("*all")
    f:close()
    return d
end

json = require("json")

blueprint_path = ""
bp = {}
if #arg > 0 then
    blueprint_path = arg[#arg]
    bp = json:decode(readAll(blueprint_path))
    assert(bp, "Failed To Open " .. blueprint_path)
end
workingDir = io.popen("cd"):read()

-- Enter into the interactive shell
loadfile("./src/shell.lua", "bt", _G)()