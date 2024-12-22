-- Script de Aliança ao Combine com Base no seu Modelo atual

-- Lista de Modelos Aceitos
local CombineAllyModels = {
	"models/player/combine_soldier.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/police.mdl",
	"models/player/police_fem.mdl"
}

-- Tempo de Intervalo em Segundos para Verificar o Modelo
local AllyCheckInterval = 0.1

-- Função para Verificar o Modelo do Jogador
local function IsCombineAlly(Player)
	if not IsValid(Player) or not Player:IsPlayer() then
		return false
	end
	
	local PlayerMdl = Player:GetModel()
	
	for _, Model in ipairs(CombineAllyModels) do
		if string.lower(PlayerMdl) == string.lower(Model) then
			return true
		end
	end
	
	return false
end

-- Atualiza os Aliados do Combine
function UpdateCombineAllies()
	for _, Ent in ipairs(ents.FindByClass("npc_combine_s")) do
		if IsValid(Ent) then
			for _, Player in ipairs(player.GetAll()) do
				if IsCombineAlly(Player) then
					Ent:AddEntityRelationship(Player, D_LI, 99)
				else
					Ent:AddEntityRelationship(Player, D_HT, 99)
				end
			end
		end
	end
	
	for _, Ent in ipairs(ents.FindByClass("npc_metropolice")) do
		if IsValid(Ent) then
			for _, Player in ipairs(player.GetAll()) do
				if IsCombineAlly(Player) then
					Ent:AddEntityRelationship(Player, D_LI, 99)
				else
					Ent:AddEntityRelationship(Player, D_HT, 99)
				end
			end
		end
	end
end

-- Temporizador Regular para Verificar os Jogadores Aliados no Lado do Cliente
timer.Create("Check Allies", AllyCheckInterval, 0, UpdateCombineAllies)

-- Comando para Atualizar Manualmente
concommand.Add("update_combine_ally", function()
	UpdateCombineAllies()
end)
