local shapeIDs = {}

shapeIDs["9f0f56e8-2c31-4d83-996c-d00a9b296c3f"] = "logic_gate"
shapeIDs["1e8d93a4-506b-470d-9ada-9c0a321e2db5"] = "button"
shapeIDs["7cf717d7-d167-4f2d-a6e7-6b2c70aa3986"] = "switch"
shapeIDs["add3acc6-a6fd-44e8-a384-a7a16ce13c81"] = "sensor"
shapeIDs["8f7fd0e7-c46e-4944-a414-7ce2437bb30f"] = "timer"
shapeIDs["161786c1-1290-4817-8f8b-7f80de755a06"] = "head_bass"
shapeIDs["4c6e27a2-4c35-4df3-9794-5e206fef9012"] = "head_drum"
shapeIDs["a052e116-f273-4d73-872c-924a97b86720"] = "head_synth"
shapeIDs["1c04327f-1de4-4b06-92a8-2c9b40e491aa"] = "head_blip"
shapeIDs["260b4597-f1ac-409c-8e6b-90c998c5fe94"] = "piston"
shapeIDs["0229f59d-1ba3-446a-8f9c-df8b0f816e51"] = "spudgun"

local logicGateState = {}
logicGateState[0] = "AND"
logicGateState[1] = "OR"
logicGateState[2] = "XOR"
logicGateState[3] = "NAND"
logicGateState[4] = "NOR"
logicGateState[5] = "XNOR"

-- Enable indexing via name or ID
for i,k in pairs(shapeIDs) do shapeIDs[k] = i end

return shapeIDs, logicGateState
