local IsRequestSended = false
local CurLanguage = "Portuguese"

local Translations = {
	["Portuguese"] = {
		Title = "Entrevista de emprego da Fundação S.C.P.",
		Intro = "Boas Vindas à nossa entrevista de emprego! Responda a estas perguntas abaixo:",
		NameLabel = "Qual o seu nome completo?",
		RoleLabel = "Qual cargo você está interessado(a)?",
		RoleList = {
			O5Commander = "Comadante O5",
			MTFGuard = "Guarda M.T.F.",
			Searcher = "Pesiquisador(a)"
		},
		ExpeLabel = "Descreva sua experiência com seu emprego anterior:",
		Submit = "Enviar formulário",
		MoreInfo = "Ver informações",
		RuleLabel = "Ao ser aceito, você irá receber benefícios de acordo com a legislação local. Clique no botão abaixo para saber mais!",
		RuleList = {
			"Para que nosso ambiente seja seguro, siga essas diretrizes:\n\n",
			"1. Siga as ordens dos comandantes O5 e superiores sem questionar. A segurança da Fundação depende da sua lealdade e obediência.\n\n",
			"2. Em hipótese alguma, libere, transporte ou entre em contato com uma anomalia S.C.P sem autorização expressa dos comandantes O5. As consequências de falhas neste protocolo são imprevisíveis e potencialmente catastróficas.\n\n",
			"3. Sempre utilize os equipamentos de segurança fornecidos, como trajes de proteção, dispositivos de contenção e comunicações seguras. Ignorar os protocolos de segurança pode resultar em acidentes fatais.\n\n",
			"4. Toda informação sobre as anomalias e operações da Fundação é estritamente confidencial. Não discuta ou compartilhe dados com ninguém que não tenha autorização específica para acessá-los.\n\n",
			"5. Em caso de contato com qualquer substância ou anomalia desconhecida, evite o contato com outras pessoas e informe imediatamente sua equipe de segurança. O uso de métodos de descontaminação pode ser necessário.\n\n",
			"6. Nunca se aproxime de uma anomalia S.C.P fora de contenção sem as devidas precauções. A Fundação disponibiliza protocolos de contenção específicos que devem ser seguidos rigorosamente.\n\n",
			"7. Todos os membros da Fundação devem passar por treinamentos periódicos. A falta de atualização nos procedimentos de segurança pode comprometer a integridade física e psicológica dos envolvidos.\n\n",
			"8. Em caso de emergência ou falha na contenção de qualquer anomalia S.C.P, siga os protocolos de evacuação imediata. A integridade do local e da equipe é a prioridade número um.\n\n",
			"9. Se você sentir qualquer alteração no seu estado mental ou psicológico devido ao trabalho com anomalias, procure assistência imediatamente. A Fundação oferece suporte psicológico a todos os seus funcionários.\n\n",
			"Além disso, a Fundação disponibiliza benefícios obrigatórios, sujeitos às condições locais e acordos de contratação, incluindo:\n\n",
			"1. Seguro de vida robusto, com cobertura para incidentes dentro da Fundação e eventos inesperados envolvendo anomalias.\n\n",
			"2. Vale-refeição que pode ser utilizado nas instalações da Fundação, com restrições para refeições durante situações de contenção.\n\n",
			"3. Assistência psicológica e médica, com especial atenção ao impacto do trabalho em ambientes de alto risco, incluindo consultas confidenciais.\n\n",
			"4. Direito ao 13º salário, sujeito à avaliação de desempenho e de conformidade com as normas de segurança da Fundação.\n\n",
			"Por favor, revise estas condições com cuidado antes de prosseguir com sua candidatura."
		},
		ErrorMsg = "Por favor, preencha todos os campos!",
		WarnMsg = "Por favor, espere sua solicitação ser lida!",
		SuccessMsg = "Formulário enviado com sucesso!",
		ToggleLang = "Mudar idioma"
	},
	["English"] = {
		Title = "S.C.P. Foundation job interview",
		Intro = "Welcome to our job interview! Please answer the questions below:",
		NameLabel = "What is your full name?",
		RoleLabel = "Which position are you interested in?",
		RoleList = {
			O5Commander = "Commander O5",
			MTFGuard = "M.T.F. Guard",
			Searcher = "Searcher"
		},
		ExpeLabel = "Describe your experience with your previous job",
		Submit = "Submit form",
		MoreInfo = "View useful information",
		RuleLabel = "Upon acceptance, you will receive benefits according to local laws. Click the button below to learn more!",
		RuleList = {
			"To ensure our environment remains safe, follow these guidelines:\n\n",
			"1. Follow the orders of the O5 commanders and superiors without question. The Foundation's safety depends on your loyalty and obedience.\n\n",
			"2. Under no circumstances release, transport, or interact with an S.C.P anomaly without explicit authorization from O5 commanders. Failures in this protocol can have catastrophic and unpredictable consequences.\n\n",
			"3. Always use the provided safety equipment, such as protective suits, containment devices, and secure communication tools. Ignoring safety protocols may result in fatal accidents.\n\n",
			"4. All information regarding anomalies and Foundation operations is strictly confidential. Do not discuss or share data with anyone who does not have specific clearance to access it.\n\n",
			"5. In case of contact with any unknown substance or anomaly, avoid contact with other people and immediately inform your security team. Decontamination methods may be required.\n\n",
			"6. Never approach an S.C.P anomaly outside containment without proper precautions. The Foundation provides specific containment protocols that must be rigorously followed.\n\n",
			"7. All Foundation members must undergo periodic training. Failure to update safety procedures may compromise the physical and psychological integrity of those involved.\n\n",
			"8. In case of an emergency or containment failure of any S.C.P anomaly, follow immediate evacuation protocols. The integrity of the facility and team is the number one priority.\n\n",
			"9. If you experience any alteration in your mental or psychological state due to working with anomalies, seek assistance immediately. The Foundation offers psychological support to all employees.\n\n",
			"In addition, the Foundation provides mandatory benefits, subject to local conditions and hiring agreements, including:\n\n",
			"1. Comprehensive life insurance, covering incidents within the Foundation and unexpected events involving anomalies.\n\n",
			"2. Meal vouchers that can be used in Foundation facilities, with restrictions during containment situations.\n\n",
			"3. Psychological and medical assistance, with special attention to the impact of working in high-risk environments, including confidential consultations.\n\n",
			"4. Eligibility for a 13th salary, subject to performance evaluation and compliance with Foundation safety standards.\n\n",
			"Please carefully review these conditions before proceeding with your application."
		},
		ErrorMsg = "Please fill in all fields!",
		WarnMsg = "Form submitted successfully!",
		SuccessMsg = "Form successfully submitted!",
		ToggleLang = "Switch language"
	}
}

-- Abre uma janela para a entrevista de emprego
local function OpenJobInterview()
	local Window = vgui.Create("DFrame")
	Window:SetTitle(Translations[CurLanguage].Title)
	Window:SetSize(640, 460)
	Window:Center()
	Window:MakePopup()
	
	local Intro = vgui.Create("DLabel", Window)
	Intro:SetText(Translations[CurLanguage].Intro)
	Intro:SetPos(20, 30)
	Intro:SizeToContents()
	
	local NameLabel = vgui.Create("DLabel", Window)
	NameLabel:SetText(Translations[CurLanguage].NameLabel)
	NameLabel:SetPos(20, 70)
	NameLabel:SizeToContents()
	
	local NameEntry = vgui.Create("DTextEntry", Window)
	NameEntry:SetPos(20, 90)
	NameEntry:SetSize(460, 25)
	
	local RoleLabel = vgui.Create("DLabel", Window)
	RoleLabel:SetText(Translations[CurLanguage].RoleLabel)
	RoleLabel:SetPos(20, 130)
	RoleLabel:SizeToContents()
	
	local RoleEntry = vgui.Create("DComboBox", Window)
	RoleEntry:SetPos(20, 150)
	RoleEntry:SetSize(460, 25)
	RoleEntry:AddChoice(Translations[CurLanguage].RoleList.Searcher)
	RoleEntry:AddChoice(Translations[CurLanguage].RoleList.MTFGuard)
	RoleEntry:AddChoice(Translations[CurLanguage].RoleList.O5Commander)
	
	local ExpeLabel = vgui.Create("DLabel", Window)
	ExpeLabel:SetText(Translations[CurLanguage].ExpeLabel)
	ExpeLabel:SetPos(20, 190)
	ExpeLabel:SizeToContents()
	
	local ExpeEntry = vgui.Create("DTextEntry", Window)
	ExpeEntry:SetPos(20, 210)
	ExpeEntry:SetSize(460, 60)
	ExpeEntry:SetMultiline(true)
	
	local RuleLabel = vgui.Create("DLabel", Window)
	RuleLabel:SetText(Translations[CurLanguage].RuleLabel)
	RuleLabel:SetPos(20, 330)
	RuleLabel:SizeToContents()
	
	local MoreInfo = vgui.Create("DButton", Window)
	MoreInfo:SetText(Translations[CurLanguage].MoreInfo)
	MoreInfo:SetSize(460, 30)
	MoreInfo:SetPos(20, 350)
	MoreInfo.DoClick = function()
		local Info = vgui.Create("DFrame")
		Info:SetSize(640, 460)
		Info:Center()
		Info:MakePopup()
		
		local ScrollText = vgui.Create("DScrollPanel", Info)
		ScrollText:SetSize(600, 460)
		ScrollText:SetPos(20, 40)
		
		local Text = ScrollText:Add("RichText")
		Text:SetSize(560, 460)
		
		for _, Rule in ipairs(Translations[CurLanguage].RuleList) do
			Text:AppendText(Rule)
		end
		
		function Text:PerformLayout()
			self:SetFontInternal("DermaDefault")
			self:SetFGColor(Color(255, 255, 255))
		end
	end
	
	local Submit = vgui.Create("DButton", Window)
	Submit:SetText(Translations[CurLanguage].Submit)
	Submit:SetPos(20, 290)
	Submit:SetSize(460, 30)
	Submit.DoClick = function()
		local Name = NameEntry:GetValue()
		local Role = RoleEntry:GetSelected()
		local Expe = ExpeEntry:GetValue()
		
		if Name == "" or not Role then
			notification.AddLegacy(Translations[CurLanguage].ErrorMsg, NOTIFY_ERROR, 5)
			return
		elseif IsRequestSended then
			notification.AddLegacy(Translations[CurLanguage].WarnMsg, NOTIFY_ERROR, 5)
			return
		end
		
		Submit:SetEnabled(false)
		IsRequestSended = true
		
		net.Start("JobApplication")
		net.WriteString(Name)
		net.WriteString(Role)
		net.WriteString(Expe)
		net.SendToServer()
		
		Window:Close()
		notification.AddLegacy(Translations[CurLanguage].SucessMsg, NOTIFY_GENERIC, 5)
	end
	
	-- Toggle lang button
	local ToggleLang = vgui.Create("DButton", Window)
	ToggleLang:SetText((CurLanguage == "Portuguese") and "Mudar para PT-BR (Toggle to PT-BR)" or "Toggle to EN-US (Mudar para EN-US)")
	ToggleLang:SetPos(20, 400)
	ToggleLang:SetSize(460, 25)
	ToggleLang.DoClick = function()
		CurLanguage = (CurLanguage == "Portuguese") and "English" or "Portuguese"
		local LangButtonText = (CurLanguage == "English") and "Toggle to EN-US (Mudar para EN-US)" or "Mudar para PT-BR (Toggle to PT-BR)"
		ToggleLang:SetText(LangButtonText)
		Window:Close()
		OpenJobInterview()
	end
end

net.Receive("JobApplicationResponse", function(Length, Player)
	Player.IsJobAccepted = string.sub(net.ReadBit)
end)

concommand.Add("threat_addon_scp_job_interview", function(Player, Command, Args)
	OpenJobInterview()
end)
