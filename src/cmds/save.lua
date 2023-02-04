local args = ...

if not blueprint_path or #blueprint_path < 1 then return "false, Please Open A Blueprint Before Trying To Save" end
local p
if #args == 0 then
    p = blueprint_path
else
    p = args[1]
end

local f, err = io.open(p, "wb")
if not f then return "false, " .. err end

f:write(json:encode(bp))
f:close()

return "true , Saved To \"" .. p .. "\""