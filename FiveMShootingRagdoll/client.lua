local BONES = {
	--[[RB_L_ThighRoll]][23639] = true,
	--[[RB_R_ThighRoll]][6442] = true,
	--[[Pelvis]][11816] = true,
	--[[SKEL_L_Thigh]][58271] = true,
	--[[SKEL_L_Calf]][63931] = true,
	--[[MH_L_Knee]][46078] = true,
	--[[SKEL_R_Thigh]][51826] = true,
	--[[SKEL_R_Calf]][36864] = true,
	--[[MH_R_Knee]][16335] = true,
}


Citizen.CreateThread(function()
	local hitmaara = 0

	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
			if HasEntityBeenDamagedByAnyPed(ped) then
				hitmaara = hitmaara + 1
					if hitmaara == 3 then
						if math.random(1,2) == 2 then -- 50/50 to fall
							falldownSmall(ped)
							hitmaara = 0 -- Reset the hit amount
						end
					elseif hitmaara >= 4 then
						if math.random(1, 2) == 1 then -- 50% chance to fall for 2 seconds or 5 seconds
							falldown(ped)
							hitmaara = 0 -- Reset the hit amount
						else
							falldownBig(ped)
							hitmaara = 0 -- Reset the hit amount
						end

					end
			end
			ClearEntityLastDamageEntity(ped)
	 end
end)



function Bool (num) return num == 1 or num == true end

-- weapon offsets
local function GetDisarmOffsetsForPed (ped)
	local v

	if IsPedWalking(ped) then v = { 0.6, 4.7, -0.1 }
	elseif IsPedSprinting(ped) then v = { 0.6, 5.7, -0.1 }
	elseif IsPedRunning(ped) then v = { 0.6, 4.7, -0.1 }
	else v = { 0.4, 4.7, -0.1 } end

	return v
end

function falldown (ped)
	if IsEntityDead(ped) then return false end -- if dead don't fall

	local boneCoords
	local hit, bone = GetPedLastDamageBone(ped)

	hit = Bool(hit)

	if hit then
		if BONES[bone] then
			boneCoords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, bone))
			SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
			return true
		end
	end
	return false
end

function falldownSmall (ped)
	if IsEntityDead(ped) then return false end -- if dead don't fall

	local boneCoords
	local hit, bone = GetPedLastDamageBone(ped)

	hit = Bool(hit)

	if hit then
		if BONES[bone] then
			boneCoords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, bone))
			SetPedToRagdoll(GetPlayerPed(-1), 500, 500, 0, 0, 0, 0)
			return true
		end
	end
	return false
end

function falldownBig (ped)
	if IsEntityDead(ped) then return false end -- if dead don't fall

	local boneCoords
	local hit, bone = GetPedLastDamageBone(ped)

	hit = Bool(hit)

	if hit then
		if BONES[bone] then
			boneCoords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, bone))
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
			return true
		end
	end
	return false
end