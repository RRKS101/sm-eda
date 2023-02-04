local args = ...
blueprint_path = args[1]

local buf,err = readAll(blueprint_path)
if not buf then return "false, " .. err end

bp, err = json:decode(buf)

return "true , Loaded \"" .. blueprint_path .. "\""