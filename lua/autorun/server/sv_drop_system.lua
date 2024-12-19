-- Chance de Invocar algumas dessas Armas
local Drops = {
	["weapon_crowbar"] = {Chance = 0.44, Max = 2},
	["arc9_uplp_knife"] = {Chance = 0.282, Max= 2},
	["arc9_uplp_spas"] = {Chance = 0.12, Max = 2},
	["arc9_uplp_deagle"] = {Chance = 0.2, Max = 1},
	["arc9_uplp_grenade_flash"] = {Chance = 0.33, Max = 2},
	["arc9_uplp_grenade_frag"] = {Chance = 0.22, Max = 3},
	["arc9_uplp_mp5"] = {Chance = 0.24, Max = 2},
	["arc9_uplp_ar15"] = {Chance = 0.302, Max = 2},
	["arc9_uplp_ak"] = {Chance = 0.122, Max = 2},
	["arc9_uplp_aug"] = {Chance = 0.152, Max = 2},
	["arc9_uplp_ak12"] = {Chance = 0.111, Max = 1},
	["arc9_uplp_m9"] = {Chance = 0.375, Max = 2},
	["arc9_uplp_fn57"] = {Chance = 0.325, Max = 2},
	["arc9_uplp_fal"] = {Chance = 0.22, Max = 2},
	["arc9_uplp_molot"] = {Chance = 0.095, Max = 2}, -- não Confunda com a Molotov
	["arc9_uplp_scar"] = {Chance = 0.22, Max = 1}
}

-- Quando um Jogador Entrar
hook.Add("PlayerSpawn", "On Player Spawn", function(ply)
	ply:StripWeapons()
	ply:Give("mg_fist")
end)

-- Obtenha uma Arma Baseado em Raridade
function GetRandomWeapon()
	local TotalChance = 0
	
	for _, Info in pairs(Drops) do
		TotalChance = TotalChance + Info.Chance
	end
	
	local RandomChance = math.Rand(0, TotalChance)
	local CumulativeChance = 0
	
	for Weapon, Info in pairs(Drops) do
		CumulativeChance = CumulativeChance + Info.Chance
		
		if RandomChance <= CumulativeChance then
			return Weapon, math.random(1, Info.Max)
		end
	end
end

-- Obtenha alguma Posição do Navmesh
function GetRandomNavmeshPosition()
	local NavAreas = navmesh.GetAllNavAreas()
	
	if not NavAreas or #NavAreas == 0 then
		return nil
	end
		
	local RandomArea = NavAreas[math.random(#NavAreas)]
	
	return RandomArea:GetRandomPoint()
end

-- Invoca uma Arma
function SpawnWeapon()
	local RandomWeapon, Amount = GetRandomWeapon()
	
	for I = 1, Amount do
		local SpawnPosition = GetRandomNavmeshPosition()
		
		if RandomWeapon and SpawnPosition then
			local WeaponEntity = ents.Create(RandomWeapon)
			
			if IsValid(WeaponEntity) then
				WeaponEntity:SetPos(SpawnPosition)
				WeaponEntity:Spawn()
				
				print("[INFO] Invocando " .. Amount .. "x " .. WeaponEntity:GetPrintName() .. " em " .. tostring(WeaponEntity:GetPos()))
			else
				print("[ERRO] Meh, parece que deu errado ao tentar invocar uma arma :(")
			end
		end
	end
end

-- Adiciona um Comando do Modo para o Console
concommand.Add("threat_addon_spawn_random_weapon", function(ply, cmd, args)
	if ply:IsAdmin() and IsValid(ply) then
		SpawnWeapon()
	else
		print("[ERRO] Nenhuma evidência de Admin = Não pode >:(")
	end
end)

-- Adiciona outro Comando para o Console
concommand.Add("teleport_to", function(ply, cmd, args)
	if ply:IsAdmin() and IsValid(ply) then
		ply:SetPos(Vector(args[1], args[2], args[3]))
	else
		print("[ERRO] Nenhuma evidênica de Admin = Não pode >:(")
	end
end)
