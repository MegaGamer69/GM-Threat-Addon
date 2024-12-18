util.AddNetworkString("JobApplication")
util.AddNetworkString("ApplicationResponse")

-- Tabela Temporária de Aplicações de Trabalhos
local JobApplications = {}

-- Receive job applications from clients
net.Receive("JobApplication", function(Length, Player)
	local Name = string.sub(net.ReadString(), 1, 100)
	local Role = string.sub(net.ReadString(), 1, 50)
	local Expe = string.sub(net.ReadString(), 1, 750)
	
	JobApplications[Player:SteamID()] = {
		Name = Name,
		Role = Role,
		Experience = Expe
	}
	
	print("[Job Application Received]")
	print("Full name: " .. Name)
	print("Desired role: " .. Role)
	print("Experience: " .. Expe)
	print("-----------------------------------")
	
	Player:ChatPrint("Your job application has been sent! Please wait for a response.")
end)

-- Comando de Console para Aceitar
concommand.Add("threat_addon_accept_application", function(Sender, Command, Args)
	if not Sender:IsAdmin() then
		Sender:ChatPrint("[ERROR] You are not an admin!")
		
		return
	end
	
	local TargetName = Args[1]
	
	if not TargetName then
		Sender:ChatPrint("[ERROR] Please provide a player's name or SteamID.")
		
		return
	end
	
	local TargetPlayer = nil
	
	for _, CurPlayer in ipairs(player.GetAll()) do
		if string.find(string.lower(CurPlayer:Nick()), string.lower(TargetName)) or CurPlayer:SteamID() == TargetName then
			TargetPlayer = CurPlayer
			
			break
		end
	end
	
	if not TargetPlayer then
		Sender:ChatPrint("[ERROR] Player not found! Please check the name or SteamID.")
		
		return
	end
	
	local AppData = JobApplications[TargetPlayer:SteamID()]
	
	if not AppData then
		Sender:ChatPrint("[ERROR] Looks like that no application found for this player.")
		
		return
	end
	
	print("[INFO] Accepting job application for " .. AppData.Name .. "...")
	Sender:ChatPrint("Accepted application for: " .. AppData.Name)
	
	net.Start("ApplicationResponse")
	net.WriteString("Congratulations, your application for the role '" .. AppData.Role .. "' has been accepted!")
	net.Send(TargetPlayer)
	
	JobApplications[TargetPlayer:SteamID()] = nil
end)

hook.Add("PlayerInitialSpawn", "OnPlayerSpawn_RunJobInterview", function(Player)
	if not Player.HasInterviewJobCommandRun then
		RunConsoleCommand("threat_addon_scp_job_interview")
		Player.HasInterviewJobCommandRun = true
	end
end)
