-- Script de aliança ao Combine com base no seu modelo atual

-- Lista de modelos aceitos
local CombineAllyModels = {
	"models/player/combine_soldier.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/combine_soldier_prisonguard.mdl"
}

-- Tempo de intervalo em segundos para verificar o modelo
local AllyCheckInterval = 0.25

-- Função para verificar o modelo do jogador
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

-- Atualiza os aliados do Combine
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
end

-- Temporizador regular para verificar os jogadores aliados
timer.Create("CombineAllyCheck", AllyCheckInterval, 0, function()
	UpdateCombineAllies()
end)

-- Comando para atualizar manualmente
concommand.Add("update_combine_ally", function()
	UpdateCombineAllies()
end)