local args = ...

if not shapeIDs then
    shapeIDs, logicEnum = loadfile("./dat/shapeIDs.lua", "bt", _G)()
end

local opTbl = {}
opTbl['=='] = function (a,b) return a==b end
opTbl['!='] = function (a,b) return not(a==b) end
opTbl['>'] = function (a,b) return a>b end
opTbl['>='] = function (a,b) return a>=b end
opTbl['<'] = function (a,b) return a<b end
opTbl['<='] = function (a,b) return a<=b end

if args[1] == "color" or args[1] == "colour" then
    local channel = "rgb"
    if args[2] == "r" then channel = args[2]
    elseif args[2] == "g" then channel = args[2]
    elseif args[2] == "b" then channel = args[2] end

    local cntRemoved = 0
    local cntRemaining = 0

    if channel == "rgb" then
        if not opTbl[args[2]] then return "false, Unknown Operator \'" .. args[2] .. "'" end
        if not(#args[3] == 6) then return "false, The Third Argument Should Have A Length Of 6" end

        local sNums = {tonumber(args[3]:sub(1,2),16), tonumber(args[3]:sub(3,4),16), tonumber(args[3]:sub(5,6),16)}
        for i,k in pairs(sNums) do if not k then return "false, Unknown Hex In Channel " .. tostring(i) end end
        
        for i,k in pairs(selected) do
            if k then
                local _sBp = bpChilds[i]["color"]
                local sBp = {tonumber(_sBp:sub(1,2),16), tonumber(_sBp:sub(3,4),16), tonumber(_sBp:sub(5,6),16)}

                if not(opTbl[args[2]](sBp[1], sNums[1]) and opTbl[args[2]](sBp[2], sNums[2]) and opTbl[args[2]](sBp[3], sNums[3])) then
                    selected[i] = false
                    cntRemoved = cntRemoved + 1
                else
                    selected[i] = true
                    cntRemaining = cntRemaining + 1
                end
            end
        end
        return "true , Removed " .. tostring(cntRemoved) .. ", Leaving " .. tostring(cntRemaining)
    else
        local sVal = tonumber(args[4]:sub(1,2),16)
        local chPos = {1,2}
        if channel == "r" then
            chPos = {1,2}
        elseif channel == "g" then
            chPos = {3,4}
        elseif channel == "b" then
            chPos = {5,6}
        else
            return "false, How Did You Get Here?! 2nd Edition"
        end

        for i,k in pairs(selected) do
            if k then
                local _sBp = bpChilds[i]["color"]
                if not (opTbl[args[3]](tonumber(_sBp:sub(chPos[1], chPos[2]), 16), sVal)) then 
                    selected[i] = false
                    cntRemoved = cntRemoved + 1
                else
                    selected[i] = true
                    cntRemaining = cntRemaining + 1
                end
            end
        end
        return "true , Removed " .. tostring(cntRemoved) .. ", Leaving " .. tostring(cntRemaining)
    end

    return "false, How Did You Get Here?!"
elseif args[1] == "active" then
    local b = nil
    if args[3] == "t" or args[3] == "true" or args[3] == "1" then
        b = true
    elseif args[3] == "f" or args[3] == "false" or args[3] == "0" then
        b = false
    end

    if (b == nil) then return "false, '" .. args[3] .. "' is an invalid argument, expected a t/true/1 or f/false/0" end
    if not opTbl[args[2]] then return "false, '" .. args[2] .. "'' is an unknown operator" end
    
    local cntRemoved = 0
    local cntRemaining = 0
    for i,k in pairs(selected) do 
        if k then
            local _b = bpChilds[i]
            if not _b["controller"] then 
                selected[i] = b
                if b then cntRemaining = cntRemaining + 1
                else cntRemoved = cntRemoved + 1 end
            end
            if not _b["controller"]["active"] then
                
            end

            if not opTbl[args[2]](_b["controller"]["active"], b) then
                selected[i] = false
                cntRemoved = cntRemoved + 1
            else
                selected[i] = true
                cntRemaining = cntRemaining + 1
            end
        end
    end

    return "true , Removed " .. tostring(cntRemoved) .. ", Leaving " .. tostring(cntRemaining)
elseif args[1] == "controllers" then

    return "false, Not Implemented"
elseif args[1] == "id" then

    return "false, Not Implemented"
elseif args[1] == "joints" then

    return "false, Not Implemented"
elseif args[1] == "mode" then

    return "false, Not Implemented"
elseif args[1] == "pos" then
    
    return "false, Not Implemented"
elseif args[1] == "shapeid" then

    return "false, Not Implemented"
elseif args[1] == "rot" then
    
    return "false, Not Implemented"
elseif args[1] == "time" then
    
    return "false, Not Implemented"
elseif args[1] == "clear" or args[1] == "reset" or args[1] == "all" then
    for i=1,#bpChilds do
        selected[i] = true
    end
    return "true , Added "..tostring(#bpChilds).. " Blocks To Selection"
elseif args[1] == "none" then
    for i,_ in pairs(selected) do 
        selected[i] = false
    end
    return "true , Removed All Blocks From Selection. Use select reset or select all to add all blocks to selection for future searches"
elseif args[1] == "log" or args[1] == "print" then
    local cnt = 0
    for i,k in pairs(selected) do
        if k then
            
            if args[2] == "p" or args[2] == "pretty" then 
                io.write(json:encode_pretty(bpChilds[i]) .. "\n")
            else
                io.write(json:encode(bpChilds[i]) .. "\n")
            end
            cnt = cnt + 1
        end
    end
    return "true , Logged " .. tostring(cnt) .. " Entries"
else
    if #args == 0 then return "false, You Must Provide A Sub-Command Or Field" end
    return "false, Field '" .. args[1] .. "' Is Unknown"
end