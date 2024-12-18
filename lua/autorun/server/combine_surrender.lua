-- Script para Permitir os Soldados do Combine se Renderem

-- Função para checar se o Inventário está Vazío
function GetEntityInventoryEmpty(Ent)
	local Inventory = {}
	
	for W in pairs(Ent:GetWeapons()) do
		table.insert(Inventory, W)
	end
	
	return table.IsEmpty(Inventory)
end

-- Função para Obter a Área do NavMesh mais Distante
function GetMostDistantNavPoint(Origin, Pos1, Pos2)
	local Areas = navmesh.FindInBox(Pos1, Pos2)

	local MostDistantPoint = nil
	local MaxDistance = 0

	for _, LocalArea in ipairs(Areas) do
		local Point = LocalArea:GetRandomPoint()
		local CurDistance = Origin:DistToSqr(Point)

		if CurDistance > MaxDistance then
			MaxDistance = CurDistance
			MostDistantPoint = Point
		end
	end

	return MostDistantPoint
end

-- Manipula o Comportamento
function HandleCombineBehaviour(Ent)
	if not IsValid(Ent) or Ent:GetClass() ~= "npc_combine_s" then
		return
	end
	
	local IsDisarmed = GetEntityInventoryEmpty(Ent)
	
	local NearbyAllies = 0
	
	for _, Ally in pairs(ents.FindInSphere(Ent:GetPos(), 640)) do
		if Ally:GetClass() == "npc_combine_s" and Ally ~= Ent then
			NearbyAllies = NearbyAllies + 1
		end
	end
	
	if IsDisarmed or NearbyAllies == 0 then
		if math.random(1, 100) <= 100 then
			Ent:SetSchedule(SCHED_RUN_FROM_ENEMY)
			
			Ent:SetEnemy(nil)
			
			local Angle = math.random(0.0, 360.0)

			local Pos1 = Ent:GetPos() + Vector(6400, 6400, 0)
			local Pos2 = Ent:GetPos() - Vector(6400, 6400, 0)
			
			local FleeDir = GetMostDistantNavPoint(Ent:GetPos(), Pos1, Pos2)

			if not FleeDir == nil then
			    Ent:SetLastPosition(FleeDir)
			else
				print("[ERRO] nenhuma Área do NavMesh foi Encontrada :(")
			end
			
			Ent:SetSchedule(SCHED_FORCED_GO_RUN)
			
			return
		end
	end
	
	if IsDisarmed then
		if math.random(1, 100) <= 100 then
			Ent:SetSchedule(SCHED_HANDS_UP)
			
			Ent:SetEnemy(nil)
		end
	end
end

-- Adiciona um Gancho para quando um NPC sofre Dano
hook.Add("EntityTakeDamage", "Combine Surrender", function(target, dmginfo)
	if target:IsNPC() then
		HandleCombineBehaviour(target)
	end
end)

-- Adiciona um Comando de Console para Forçar a Rendição
concommand.Add("threat_combine_surrender", function(ply, cmd, args)
	if ply:IsAdmin() and IsValid(ply) then
		for _, Target in pairs(ents.FindByClass("npc_combine_s")) do
			if IsValid(Target) then
				for W in pairs(Target:GetWeapons()) do
					if IsValid(W) then
						Target:StripWeapon(W)
					end
				end
				
				HandleCombineBehaviour(Target)
			end
		end
	end
end)
