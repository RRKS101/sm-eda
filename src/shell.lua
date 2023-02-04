bpChilds = bp["bodies"][1]["childs"]
if not selected then
    selected = {}
    for i=1,#bpChilds do
        selected[i] = true
    end
end

local cmds = {}


io.write("SM EDA Shell  ", "    Ver 0.0.0   ", "    Starting\n")
-- Load all commands
function loadCmds()
    io.write("Added Hard Command \"exit\"/\"quit\"/\"q\"\n")
    io.write("Added Hard Command \"clear\"\n")
    io.write("Added Hard Command \"reload\"\n")

    local p = "./src/cmds/"
    for dir in io.popen('dir "'..p..'" /b /a-d'):lines() do
        local f,err = loadfile(p .. dir, "bt", _G)
        cmds[dir:sub(1,#dir-4)] = f
        if f then io.write("Added Command \"" .. dir:sub(1,#dir-4) .. "\"\n")
        else io.write(err .. "\n") end
    end
end
loadCmds()



local RUNNING = true

while RUNNING do 
    local input = io.read("*l")
    
    local cmd = ""
    local args = {}
    local cmd_dontHandle = false

    -- Generate command and arguments
    local inQuotes = false
    for i in input:gmatch("[^ ]+") do
        if #cmd == 0 then cmd = i
        else
            if inQuotes then
                if i:sub(#i,#i) == "\"" and not(i:sub(#i-1,#i-1) == "\\") then
                    args[#args] = args[#args] .. " " .. i:sub(1,#i-1)
                    inQuotes = false
                else
                    args[#args] = args[#args] .. " " .. i
                end
            else
                if i:sub(1,1) == "\"" then
                    args[#args+1] = i:sub(2,#i)
                    inQuotes = true
                else
                    args[#args+1] = i
                end
            end
        end
    end

    if cmd == "exit" or cmd == "quit" or cmd == "q" then 
        RUNNING = false
        cmd_dontHandle = true
        break
    elseif cmd == "clear" then
        io.write("\027[H\027[2J")
        cmd_dontHandle = true
    elseif cmd == "reload" then
        loadCmds()
        cmd_dontHandle = true
    end

    if not cmd_dontHandle then
        if cmds[cmd] then 
            local ret = cmds[cmd](args)
            if type(ret) == "string" then io.write("  -> \"" .. ret .. "\"\n") 
            else end
        else 
            io.write("  -> \"" .. cmd .. "\" Is An Unknown Command\n") 
        end
    end
end