local version, build, date, tocversion = GetBuildInfo()

function PCPFrame_OnLoad(self)
    -- Output the game version for debugging
    if string.find(version, "^1.12") then
        DEFAULT_CHAT_FRAME:AddMessage("Running on WoW Vanilla: " .. version)
        
        -- Use 'this' for 1.12.x (Vanilla)
        this:SetMovable(true)
        this:SetUserPlaced(true)
        this:EnableMouse(true)
        this:RegisterForDrag("LeftButton")

        -- Dragging behavior for 1.12.x
        this:SetScript("OnDragStart", function()
            this:StartMoving()
        end)

        this:SetScript("OnDragStop", function()
            this:StopMovingOrSizing()
        end)
		PCPFrame:Hide()
    else
        -- Code for WoW Classic Era (1.14+)
        DEFAULT_CHAT_FRAME:AddMessage("Running on WoW Classic: " .. version)
        
        -- Use 'self' for 1.14+
        self:SetMovable(true)
        self:SetUserPlaced(true)
        self:EnableMouse(true)
        self:RegisterForDrag("LeftButton")

        -- Dragging behavior for 1.14+
        self:SetScript("OnDragStart", function()
            self:StartMoving()
        end)

        self:SetScript("OnDragStop", function()
            self:StopMovingOrSizing()
        end)
		PCPFrame:Hide()		
    end
end






------------------------------------------------------------------------
-- Create the PCPButtonFrame if it doesn't already exist
if not PCPButtonFrame then

    if string.find(version, "^1.14") then
		PCPButtonFrame = CreateFrame("Button", "PCPButtonFrame", Minimap, "BackdropTemplate")	
	else 
		PCPButtonFrame = CreateFrame("Button", "PCPButtonFrame", Minimap)

		PCPButtonFrame:SetWidth(100)
		PCPButtonFrame:SetHeight(100)

		PCPButtonFrame:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		})

		PCPButtonFrame:SetBackdropColor(0, 0, 0, 0.5)
		PCPButtonFrame:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
		
	end
    

	PCPButtonFrame:SetWidth(32)
	PCPButtonFrame:SetHeight(32)

    PCPButtonFrame:SetPoint("TOP", Minimap, "TOP", 0, 0)  -- Position relative to the minimap
    PCPButtonFrame:EnableMouse(true)
    PCPButtonFrame:SetMovable(true)
    PCPButtonFrame:SetUserPlaced(true)
    PCPButtonFrame:RegisterForDrag("RightButton")  
    PCPButtonFrame:SetFrameStrata("LOW")
    PCPButtonFrame:Show()

    -- Set the icon/texture directly on the frame (since it now acts as a button)
    PCPButtonFrame:SetNormalTexture("Interface\\AddOns\\PCP\\img\\SoloCraft")
    PCPButtonFrame:SetPushedTexture("Interface\\AddOns\\PCP\\img\\SoloCraft")
    PCPButtonFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")



    -- Function to save and restore button position
    local function SaveButtonPosition()
        local point, relativeTo, relativePoint, xOffset, yOffset = PCPButtonFrame:GetPoint()
        PCPButtonFrame.position = {point, relativeTo, relativePoint, xOffset, yOffset}
    end

    local function RestoreButtonPosition()
        if PCPButtonFrame.position then
            local point, relativeTo, relativePoint, xOffset, yOffset = unpack(PCPButtonFrame.position)
            PCPButtonFrame:ClearAllPoints()
            PCPButtonFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset)
        end
    end

    -- Dragging behavior

-- Set the frame scripts for dragging
    if string.find(version, "^1.12") then
		-- WoW 1.12.x (Vanilla) behavior
		PCPButtonFrame:SetScript("OnDragStart", function()
			this:StartMoving()
		end)

		PCPButtonFrame:SetScript("OnDragStop", function()
			this:StopMovingOrSizing()
			SaveButtonPosition()
		end)

		-- OnClick behavior for WoW 1.12.x
		PCPButtonFrame:SetScript("OnClick", function()
			PCPButtonFrame_Toggle() 
		end)

		-- Tooltip display for WoW 1.12.x
		PCPButtonFrame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText("PartyBot Control Panel \nPress Left Click to Open/Close \nHold Right Click to move the icon")
			GameTooltip:Show()
		end)

		PCPButtonFrame:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

	else
		-- WoW 1.14+ (Classic Era) behavior
		PCPButtonFrame:SetScript("OnDragStart", function(self)
			self:StartMoving()
		end)

		PCPButtonFrame:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing()
			SaveButtonPosition()
		end)

		PCPButtonFrame:SetScript("OnClick", function(self)
			PCPButtonFrame_Toggle()  
		end)


		PCPButtonFrame:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText("PartyBot Control Panel \nPress Left Click to Open/Close \nHold Right Click to move the icon")
			GameTooltip:Show()
		end)

		PCPButtonFrame:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	end


    -- Restore saved position on load
    RestoreButtonPosition()

end

-- Toggle frame visibility
local PCPFrameShown = false  -- Start with PCPFrame hidden

function PCPButtonFrame_Toggle()
    if PCPFrameShown then
        PCPFrame:Hide()
    else
        PCPFrame:Show()
    end
    PCPFrameShown = not PCPFrameShown
end

--------------------------------------------
-- Create the PCPButtonFrame directly in Lua





BINDING_HEADER_CCP = "PartyBot Control Panel";
BINDING_NAME_CP = "Show/Hide PCP";

-- cmd
CMD_PARTYBOT_CLONE = ".partybot clone";
CMD_PARTYBOT_REMOVE = ".partybot remove";
CMD_PARTYBOT_ADD = ".partybot add ";
CMD_PARTYBOT_MAll = ".partybot moveall";
CMD_PARTYBOT_SAll = ".partybot stayall";
CMD_BATTLEGROUND_GO = ".go ";
CMD_BATTLEBOT_ADD = ".battlebot add ";
CMD_TOGGLE_HELM = ".partybot togglehelm ";
CMD_TOGGLE_CLOAK = ".partybot togglecloak ";
CMD_GENERAL = ".partybot ";

AddCmd = ""
CmdItr = 1
function CmdStackHide()
	CmdAll:Hide()
	CmdTank:Hide()
	CmdHealer:Hide()
	CmdDPS:Hide()
	CmdMDPS:Hide()
	CmdRDPS:Hide()
	CmdWarrior:Hide()
	CmdPaladin:Hide()
	CmdHunter:Hide()
	CmdRogue:Hide()
	CmdPriest:Hide()
	CmdShaman:Hide()
	CmdMage:Hide()
	CmdWarlock:Hide()
	CmdDruid:Hide()
end

function CmdADD()
	Cmds = { "", "tank", "healer", "dps", "mdps", "rdps", "warrior", "paladin", "hunter", "rogue", "priest", "shaman", "mage", "warlock", "druid" }

	CmdItr = CmdItr + 1	
	if CmdItr >= table.getn(Cmds) + 1 then CmdItr = 1 end
	AddCmd = Cmds[CmdItr]

	if Cmds[CmdItr] == "" then CmdStackHide() CmdAll:Show() end
	if Cmds[CmdItr] == "tank" then CmdStackHide() CmdTank:Show() end
	if Cmds[CmdItr] == "healer" then CmdStackHide() CmdHealer:Show() end
	if Cmds[CmdItr] == "dps" then CmdStackHide() CmdDPS:Show() end
	if Cmds[CmdItr] == "mdps" then CmdStackHide() CmdMDPS:Show() end
	if Cmds[CmdItr] == "rdps" then CmdStackHide() CmdRDPS:Show() end
	if Cmds[CmdItr] == "warrior" then CmdStackHide() CmdWarrior:Show() end
	if Cmds[CmdItr] == "paladin" then CmdStackHide() CmdPaladin:Show() end
	if Cmds[CmdItr] == "hunter" then CmdStackHide() CmdHunter:Show() end
	if Cmds[CmdItr] == "rogue" then CmdStackHide() CmdRogue:Show() end
	if Cmds[CmdItr] == "priest" then CmdStackHide() CmdPriest:Show() end
	if Cmds[CmdItr] == "shaman" then CmdStackHide() CmdShaman:Show() end
	if Cmds[CmdItr] == "mage" then CmdStackHide() CmdMage:Show() end
	if Cmds[CmdItr] == "warlock" then CmdStackHide() CmdWarlock:Show() end
	if Cmds[CmdItr] == "druid" then CmdStackHide() CmdDruid:Show() end
end

function CmdSUB()
	Cmds = { "", "tank", "healer", "dps", "mdps", "rdps", "warrior", "paladin", "hunter", "rogue", "priest", "shaman", "mage", "warlock", "druid" }

	CmdItr = CmdItr - 1	
	if CmdItr <= 0 then CmdItr = table.getn(Cmds) end
	AddCmd = Cmds[CmdItr]

	if Cmds[CmdItr] == "" then CmdStackHide() CmdAll:Show() end
	if Cmds[CmdItr] == "tank" then CmdStackHide() CmdTank:Show() end
	if Cmds[CmdItr] == "healer" then CmdStackHide() CmdHealer:Show() end
	if Cmds[CmdItr] == "dps" then CmdStackHide() CmdDPS:Show() end
	if Cmds[CmdItr] == "mdps" then CmdStackHide() CmdMDPS:Show() end
	if Cmds[CmdItr] == "rdps" then CmdStackHide() CmdRDPS:Show() end
	if Cmds[CmdItr] == "warrior" then CmdStackHide() CmdWarrior:Show() end
	if Cmds[CmdItr] == "paladin" then CmdStackHide() CmdPaladin:Show() end
	if Cmds[CmdItr] == "hunter" then CmdStackHide() CmdHunter:Show() end
	if Cmds[CmdItr] == "rogue" then CmdStackHide() CmdRogue:Show() end
	if Cmds[CmdItr] == "priest" then CmdStackHide() CmdPriest:Show() end
	if Cmds[CmdItr] == "shaman" then CmdStackHide() CmdShaman:Show() end
	if Cmds[CmdItr] == "mage" then CmdStackHide() CmdMage:Show() end
	if Cmds[CmdItr] == "warlock" then CmdStackHide() CmdWarlock:Show() end
	if Cmds[CmdItr] == "druid" then CmdStackHide() CmdDruid:Show() end
end

function SetCommand(arg)
		SendChatMessage(CMD_GENERAL .. arg);
end

function SetPause()
		SendChatMessage(CMD_GENERAL .. " pause ");
end

function SetUnpause()
		SendChatMessage(CMD_GENERAL .. " unpause ");
end

AddMark = "ccmark"
MarkItr = 1
function MarkStackHide()
	ccmark:Hide()
	focusmark:Hide()
end

function MarkADD()
	Marks = { "ccmark", "focusmark" }

	MarkItr = MarkItr + 1	
	if MarkItr >= table.getn(Marks) + 1 then MarkItr = 1 end
	AddMark = Marks[MarkItr]

	if Marks[MarkItr] == "ccmark" then MarkStackHide() ccmark:Show() end
	if Marks[MarkItr] == "focusmark" then MarkStackHide() focusmark:Show() end
end

function MarkSUB()
	Marks = { "ccmark", "focusmark" }

	MarkItr = MarkItr - 1	
	if MarkItr <= 0 then MarkItr = table.getn(Marks) end
	AddMark = Marks[MarkItr]

	if Marks[MarkItr] == "ccmark" then MarkStackHide() ccmark:Show() end
	if Marks[MarkItr] == "focusmark" then MarkStackHide() focusmark:Show() end
end

function SetMark(self, arg)
	SendChatMessage(CMD_GENERAL .. AddMark .. " " .. arg);
end

function ShowMark()
	SendChatMessage(CMD_GENERAL .. AddMark);
end

function ClearMark()
	SendChatMessage(CMD_GENERAL .. "clear " .. AddMark);
end

function ClearAllMark()
	SendChatMessage(CMD_GENERAL .. "clear");
end

AddToggle = "aoe"
ToggleItr = 1
function ToggleStackHide()
	ToggleAOE:Hide()
	ToggleHelmCloak:Hide()
	helm:Hide()
	cloak:Hide()
end

function ToggleADD()
	Toggles = { "aoe", "ToggleHelmCloak", "helm", "cloak" }

	ToggleItr = ToggleItr + 1	
	if ToggleItr >= table.getn(Toggles) + 1 then ToggleItr = 1 end
	AddToggle = Toggles[ToggleItr]

	if Toggles[ToggleItr] == "aoe" then ToggleStackHide() ToggleAOE:Show() end
	if Toggles[ToggleItr] == "ToggleHelmCloak" then ToggleStackHide() ToggleHelmCloak:Show() end
	if Toggles[ToggleItr] == "helm" then ToggleStackHide() helm:Show() end
	if Toggles[ToggleItr] == "cloak" then ToggleStackHide() cloak:Show() end
end

function ToggleSUB()
	Toggles = { "aoe", "ToggleHelmCloak", "helm", "cloak" }

	ToggleItr = ToggleItr - 1	
	if ToggleItr <= 0 then ToggleItr = table.getn(Toggles) end
	AddToggle = Toggles[ToggleItr]

	if Toggles[ToggleItr] == "aoe" then ToggleStackHide() ToggleAOE:Show() end
	if Toggles[ToggleItr] == "ToggleHelmCloak" then ToggleStackHide() ToggleHelmCloak:Show() end
	if Toggles[ToggleItr] == "helm" then ToggleStackHide() helm:Show() end
	if Toggles[ToggleItr] == "cloak" then ToggleStackHide() cloak:Show() end
end

function SetToggle()
	SendChatMessage(CMD_GENERAL .."toggle " .. AddToggle);
end

function SubPartyBotClone(self)
	SendChatMessage(CMD_PARTYBOT_CLONE);
end

function SubPartyBotRemove(self)
	SendChatMessage(CMD_PARTYBOT_REMOVE);
end

function SubPartyBotMoveAll()
	SendChatMessage(CMD_PARTYBOT_MAll);
end

function SubPartyBotStayAll()
	SendChatMessage(CMD_PARTYBOT_SAll);
end

AddClass = "warrior"
ClassItr = 1
function SetClassADD()
	Classes = { "warrior" , "paladin", "hunter", "rogue", "priest", "shaman", "mage", "warlock", "druid" }
		
	ClassItr = ClassItr + 1	
	if ClassItr == 10 then ClassItr = 1 end
	
	if UnitFactionGroup("player") == "Alliance" then
		if Classes[ClassItr] == "shaman" then 
			ClassItr = ClassItr + 1 
			AddClass = Classes[ClassItr]
		end
	else AddClass = Classes[ClassItr]
	end
	
	if UnitFactionGroup("player") == "Horde" then
		if Classes[ClassItr] == "paladin" then 
			ClassItr = ClassItr + 1 
			AddClass = Classes[ClassItr]
		end
	else AddClass = Classes[ClassItr]
	end	
	
	if Classes[ClassItr] == "warrior" then druid:Hide() warrior:Show() end
	if UnitFactionGroup("player") == "Alliance" then 
		if Classes[ClassItr] == "paladin" then warrior:Hide() paladin:Show() end
		if Classes[ClassItr] == "hunter" then paladin:Hide() hunter:Show() end	
	else
		if Classes[ClassItr] == "hunter" then warrior:Hide() hunter:Show() end
	end	
	if Classes[ClassItr] == "rogue" then hunter:Hide() rogue:Show() end
	if Classes[ClassItr] == "priest" then rogue:Hide() priest:Show() end
	if UnitFactionGroup("player") == "Horde" then 
		if Classes[ClassItr] == "shaman" then priest:Hide() shaman:Show() end
		if Classes[ClassItr] == "mage" then shaman:Hide() mage:Show() end	
	else
		if Classes[ClassItr] == "mage" then priest:Hide() mage:Show() end
	end	
	if Classes[ClassItr] == "warlock" then mage:Hide() warlock:Show() end
	if Classes[ClassItr] == "druid" then warlock:Hide() druid:Show() end
	
	RoleUpdate()
	RoleItr = 1
end

function SetClassSUB()
	Classes = { "warrior" , "paladin", "hunter", "rogue", "priest", "shaman", "mage", "warlock", "druid" }

	ClassItr = ClassItr - 1		
	if ClassItr == 0 then ClassItr = 9 end
	
	if UnitFactionGroup("player") == "Alliance" then
		if Classes[ClassItr] == "shaman" then 
			ClassItr = ClassItr - 1 
			AddClass = Classes[ClassItr]
		end
	else AddClass = Classes[ClassItr]
	end
	
	if UnitFactionGroup("player") == "Horde" then
		if Classes[ClassItr] == "paladin" then 
			ClassItr = ClassItr - 1 
			AddClass = Classes[ClassItr]
		end
	else AddClass = Classes[ClassItr]
	end		
		
	if UnitFactionGroup("player") == "Alliance" then
		if Classes[ClassItr] == "warrior" then paladin:Hide() warrior:Show() end
		if Classes[ClassItr] == "paladin" then hunter:Hide() paladin:Show() end
	else 
		if Classes[ClassItr] == "warrior" then hunter:Hide() warrior:Show() end
	end
	if Classes[ClassItr] == "hunter" then rogue:Hide() hunter:Show() end	
	if Classes[ClassItr] == "rogue" then priest:Hide() rogue:Show() end
	if UnitFactionGroup("player") == "Horde" then 
		if Classes[ClassItr] == "priest" then shaman:Hide() priest:Show() end
		if Classes[ClassItr] == "shaman" then mage:Hide() shaman:Show() end
	else 
		if Classes[ClassItr] == "priest" then mage:Hide() priest:Show() end
	end
	if Classes[ClassItr] == "mage" then warlock:Hide() mage:Show() end		
	if Classes[ClassItr] == "warlock" then druid:Hide() warlock:Show() end
	if Classes[ClassItr] == "druid" then warrior:Hide() druid:Show() end
	
	RoleUpdate()
	RoleItr = 1
end

function RaceUpdate()
	if Classes[ClassItr] == "warrior" then 
		if UnitFactionGroup("player") == "Alliance" then 
			RaceStackHide()
			human:Show()
			AddRace = "human" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			orc:Show()
			AddRace = "orc"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end
	end

	if Classes[ClassItr] == "paladin" then 
		RaceStackHide()
		human:Show()		
		AddRace = "human" 
	end

	if Classes[ClassItr] == "hunter" then 
		if UnitFactionGroup("player") == "Alliance" then
			RaceStackHide()	
			dwarf:Show()			
			AddRace = "dwarf" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			orc:Show()		
			AddRace = "orc"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end	
	end
	if Classes[ClassItr] == "rogue" then 
		if UnitFactionGroup("player") == "Alliance" then
			RaceStackHide()	
			human:Show()			
			AddRace = "human" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			orc:Show()		
			AddRace = "orc"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end		
	end
	if Classes[ClassItr] == "priest" then 
		if UnitFactionGroup("player") == "Alliance" then
			RaceStackHide()	
			human:Show()			
			AddRace = "human" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			undead:Show()		
			AddRace = "undead"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end		
	end
	if Classes[ClassItr] == "shaman" then 
		RaceStackHide()
		orc:Show()		
		AddRace = "orc"
	end
	if Classes[ClassItr] == "mage" then 
		if UnitFactionGroup("player") == "Alliance" then
			RaceStackHide()	
			human:Show()			
			AddRace = "human" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			undead:Show()		
			AddRace = "undead"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end		 
	end
	if Classes[ClassItr] == "warlock" then 
		if UnitFactionGroup("player") == "Alliance" then
			RaceStackHide()	
			human:Show()			
			AddRace = "human" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			orc:Show()		
			AddRace = "orc"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end		
	end
	if Classes[ClassItr] == "druid" then 
		if UnitFactionGroup("player") == "Alliance" then
			RaceStackHide()	
			nightelf:Show()			
			AddRace = "nightelf" 
		elseif UnitFactionGroup("player") == "Horde" then 
			RaceStackHide()
			tauren:Show()		
			AddRace = "tauren"
		else
			RaceStackHide()
			race:Show()
			AddRace = "race"
		end	
	end
end

function RoleUpdate()
	if Classes[ClassItr] == "warrior" then 
		RoleStackHide()
		tank:Show()
		AddRole = "tank"
	end
	if Classes[ClassItr] == "paladin" then 
		RoleStackHide()
		tank:Show()
		AddRole = "tank"
	end
	if Classes[ClassItr] == "hunter" then 
		RoleStackHide()
		rangedps:Show()
		AddRole = "rangedps"
	end
	if Classes[ClassItr] == "rogue" then 
		RoleStackHide()
		meleedps:Show()
		AddRole = "meleedps"
	end
	if Classes[ClassItr] == "priest" then 
		RoleStackHide()
		healer:Show()
		AddRole = "healer"
	end
	if Classes[ClassItr] == "shaman" then 
		RoleStackHide()
		tank:Show()
		AddRole = "tank"
	end
	if Classes[ClassItr] == "mage" then 
		RoleStackHide()
		rangedps:Show()
		AddRole = "rangedps" 
	end
	if Classes[ClassItr] == "warlock" then 
		RoleStackHide()
		rangedps:Show()
		AddRole = "rangedps"	
	end
	if Classes[ClassItr] == "druid" then 
		RoleStackHide()
		tank:Show()
		AddRole = "tank"
	end	
end

function RaceStackHide()
	race:Hide()
	human:Hide()
	dwarf:Hide()
	nightelf:Hide()
	gnome:Hide()
	orc:Hide()
	undead:Hide()
	tauren:Hide()
	troll:Hide()	
end

AddRace = "race"
RaceItr = 0
function SetRaceADD()
	if AddClass == "warrior" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "dwarf", "nightelf", "gnome", "race" }			
		else 			
			Races = { "orc", "undead", "tauren", "troll", "race" }		
		end		
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end		
		
	elseif AddClass == "paladin" then		
		Races = { "human", "dwarf", "race" }
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		
	elseif AddClass == "hunter" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "dwarf", "nightelf", "race" }			
		else 			
			Races = { "orc", "tauren", "troll", "race" }		
		end		
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "rogue" then		
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "dwarf", "nightelf", "gnome", "race" }			
		else 			
			Races = { "orc", "undead", "troll", "race" }		
		end
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]	

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "priest" then
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "dwarf", "nightelf", "race" }			
		else 			
			Races = { "undead", "troll", "race" }		
		end	
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "shaman" then			
		Races = { "orc", "tauren", "troll", "race" }
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "mage" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "gnome", "race" }			
		else 			
			Races = { "undead", "troll", "race" }		
		end	
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end

		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end	

	elseif AddClass == "warlock" then			
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "gnome", "race" }			
		else 			
			Races = { "orc", "undead", "race" }		
		end
		
		RaceItr = RaceItr + 1	
		if RaceItr >= table.getn(Races) + 1 then RaceItr = 1 end
		AddRace = Races[RaceItr]		

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end		

	elseif AddClass == "druid" then		
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "nightelf" }			
		else 			
			Races = { "tauren" }		
		end

		AddRace = Races[RaceItr]		
	
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
	end
end

function SetRaceSUB()
	if RaceItr == 0 then RaceItr = 5 end

	if AddClass == "warrior" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "dwarf", "nightelf", "gnome", "race" }			
		else 			
			Races = { "orc", "undead", "tauren", "troll", "race" }		
		end
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end	

	elseif AddClass == "paladin" then		
		Races = { "human", "dwarf", "race" }
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end

	elseif AddClass == "hunter" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "dwarf", "nightelf", "race" }			
		else 			
			Races = { "orc", "tauren", "troll", "race" }		
		end		
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "rogue" then		
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "dwarf", "nightelf", "gnome", "race" }			
		else 			
			Races = { "orc", "undead", "troll", "race" }		
		end
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]	

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "priest" then
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "dwarf", "nightelf", "race" }			
		else 			
			Races = { "undead", "troll", "race" }		
		end	
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]
		
		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "dwarf" then RaceStackHide() dwarf:Show() end
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "shaman" then		
		Races = { "orc", "tauren", "troll", "race" }
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end

	elseif AddClass == "mage" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "gnome", "race" }			
		else 			
			Races = { "undead", "troll", "race" }		
		end	
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end

		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end
		if Races[RaceItr] == "troll" then RaceStackHide() troll:Show() end	

	elseif AddClass == "warlock" then		
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "human", "gnome", "race" }			
		else 			
			Races = { "orc", "undead", "race" }		
		end
		
		RaceItr = RaceItr - 1	
		if RaceItr <= 0 then RaceItr = table.getn(Races) end
		AddRace = Races[RaceItr]		

		if Races[RaceItr] == "race" then RaceStackHide() race:Show() end

		if Races[RaceItr] == "human" then RaceStackHide() human:Show() end
		if Races[RaceItr] == "gnome" then RaceStackHide() gnome:Show() end
		
		if Races[RaceItr] == "orc" then RaceStackHide() orc:Show() end
		if Races[RaceItr] == "undead" then RaceStackHide() undead:Show() end		

	elseif AddClass == "druid" then	
		if UnitFactionGroup("player") == "Alliance" then 
			Races = { "nightelf" }			
		else 			
			Races = { "tauren" }		
		end

		AddRace = Races[RaceItr]		
	
		if Races[RaceItr] == "nightelf" then RaceStackHide() nightelf:Show() end
		
		if Races[RaceItr] == "tauren" then RaceStackHide() tauren:Show() end			
	end
end

function RoleStackHide()
	tank:Hide()
	healer:Hide()
	meleedps:Hide()
	rangedps:Hide()
end

AddRole = "tank"
RoleItr = 1
function SetRoleADD()
	if AddClass == "warrior" then
		Roles = { "tank", "meleedps" }
		
		RoleItr = RoleItr + 1	
		if RoleItr >= table.getn(Roles) + 1 then RoleItr = 1 end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end

	elseif AddClass == "paladin" then
		Roles = { "tank", "healer", "meleedps" }
		
		RoleItr = RoleItr + 1	
		if RoleItr >= table.getn(Roles) + 1 then RoleItr = 1 end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end		
	
	elseif AddClass == "hunter" then		
		Roles = { "rangedps" }
		
		AddRole = "rangedps"

		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end

	elseif AddClass == "rogue" then
		Roles = { "meleedps" }

		AddRole = "meleedps" 

		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end
		
	elseif AddClass == "priest" then
		Roles = { "healer", "rangedps" }

		RoleItr = RoleItr + 1	
		if RoleItr >= table.getn(Roles) + 1 then RoleItr = 1 end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end

	elseif AddClass == "shaman" then
		Roles = { "tank", "healer", "meleedps", "rangedps" }

		RoleItr = RoleItr + 1	
		if RoleItr >= table.getn(Roles) + 1 then RoleItr = 1 end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end
		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end
		
	elseif AddClass == "mage" then	
		Roles = { "rangedps" }
		
		AddRole = "rangedps"

		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end	
		
	elseif AddClass == "warlock" then
		Roles = { "rangedps" }
		
		AddRole = "rangedps"

		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end
	
	elseif AddClass == "druid" then	
		Roles = { "tank", "healer", "meleedps", "rangedps" }
		
		RoleItr = RoleItr + 1	
		if RoleItr >= table.getn(Roles) + 1 then RoleItr = 1 end
		AddRole = Roles[RoleItr]
	
		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end		
		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end
	end
end

function SetRoleSUB()
	if AddClass == "warrior" then
		Roles = { "tank", "meleedps" }
		
		RoleItr = RoleItr - 1	
		if RoleItr <= 0 then RoleItr = table.getn(Roles) end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end

	elseif AddClass == "paladin" then
		Roles = { "tank", "healer", "meleedps" }
		
		RoleItr = RoleItr - 1	
		if RoleItr <= 0 then RoleItr = table.getn(Roles) end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end		
	
	elseif AddClass == "hunter" then		
		Roles = { "rangedps" }
		
		AddRole = "rangedps"

		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end

	elseif AddClass == "rogue" then
		Roles = { "meleedps" }

		AddRole = "meleedps" 

		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end
		
	elseif AddClass == "priest" then
		Roles = { "healer", "rangedps" }

		RoleItr = RoleItr - 1	
		if RoleItr <= 0 then RoleItr = table.getn(Roles) end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end

	elseif AddClass == "shaman" then
		Roles = { "tank", "healer", "meleedps", "rangedps" }

		RoleItr = RoleItr - 1	
		if RoleItr <= 0 then RoleItr = table.getn(Roles) end
		AddRole = Roles[RoleItr]

		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end
		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end
		
	elseif AddClass == "mage" then	
		Roles = { "rangedps" }
		
		AddRole = "rangedps"

		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end	
		
	elseif AddClass == "warlock" then
		Roles = { "rangedps" }
		
		AddRole = "rangedps"

		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end
	
	elseif AddClass == "druid" then	
		Roles = { "tank", "healer", "meleedps", "rangedps" }
		
		RoleItr = RoleItr - 1	
		if RoleItr <= 0 then RoleItr = table.getn(Roles) end
		AddRole = Roles[RoleItr]
	
		if Roles[RoleItr] == "tank" then RoleStackHide() tank:Show() end
		if Roles[RoleItr] == "healer" then RoleStackHide() healer:Show() end
		if Roles[RoleItr] == "meleedps" then RoleStackHide() meleedps:Show() end		
		if Roles[RoleItr] == "rangedps" then RoleStackHide() rangedps:Show() end
	end
end

function GenderStackHide()
	gender:Hide()
	male:Hide()
	female:Hide()
end

AddGender = "gender"
GenderItr = 1
function SetGenderADD()
		Genders = { "gender", "male", "female" }
		
		GenderItr = GenderItr + 1	
		if GenderItr >= table.getn(Genders) + 1 then GenderItr = 1 end
		AddGender = Genders[GenderItr]

		if Genders[GenderItr] == "gender" then GenderStackHide() gender:Show() end
		if Genders[GenderItr] == "male" then GenderStackHide() male:Show() end
		if Genders[GenderItr] == "female" then GenderStackHide() female:Show() end
end

function SetGenderSUB()
		Genders = { "gender", "male", "female" }

		GenderItr = GenderItr - 1	
		if GenderItr <= 0 then GenderItr = table.getn(Genders) end
		AddGender = Genders[GenderItr]

		if Genders[GenderItr] == "gender" then GenderStackHide() gender:Show() end
		if Genders[GenderItr] == "male" then GenderStackHide() male:Show() end
		if Genders[GenderItr] == "female" then GenderStackHide() female:Show() end
end

AddBG = "warsong"
BGItr = 1
function BGStackHide()
	warsong:Hide()
	arathi:Hide()
	alterac:Hide()
end

function SetBGADD()
	BGS = { "warsong", "arathi", "alterac" }
	
	BGItr = BGItr + 1	
	if BGItr == 4 then BGItr = 1 end
	AddBG = BGS[BGItr]
	
	if BGS[BGItr] == "warsong" then BGStackHide() warsong:Show() end
	if BGS[BGItr] == "arathi" then BGStackHide() arathi:Show() end
	if BGS[BGItr] == "alterac" then BGStackHide() alterac:Show() end
end

function SetBGSUB()
	BGS = { "warsong", "arathi", "alterac" }
	
	BGItr = BGItr - 1	
	if BGItr == 0 then BGItr = 3 end
	AddBG = BGS[BGItr]
	
	if BGS[BGItr] == "warsong" then BGStackHide() warsong:Show() end
	if BGS[BGItr] == "arathi" then BGStackHide() arathi:Show() end
	if BGS[BGItr] == "alterac" then BGStackHide() alterac:Show() end
end

function SubPartyBotAddAdvanced(self)
	SendChatMessage(CMD_PARTYBOT_ADD .. AddClass .. " " .. AddRole .. " " .. AddGender);
end

function SubPartyBotAdd(self, arg)
	SendChatMessage(CMD_PARTYBOT_ADD .. arg);
end

function Brackets()
	if UnitLevel("player") >= 10 and UnitLevel("player") <= 19 then return math.random(10,19) 
	elseif UnitLevel("player") >= 20 and UnitLevel("player") <= 29 then return math.random(20,29)
	elseif UnitLevel("player") >= 30 and UnitLevel("player") <= 39 then return math.random(30,39)
	elseif UnitLevel("player") >= 40 and UnitLevel("player") <= 49 then return math.random(40,49)
	elseif UnitLevel("player") >= 50 and UnitLevel("player") <= 59 then return math.random(50,59)
	elseif UnitLevel("player") == 60 then return 60
	else return math.random(10,19)
	end
end

function SubBattleBotAdd(self, arg1, arg2)
	RanBotLevel = Brackets()
	SendChatMessage(CMD_BATTLEBOT_ADD .. arg1 .. " " .. arg2 .. " " .. RanBotLevel);
end

function SubBattleGo(self, arg1)
	SendChatMessage(CMD_BATTLEGROUND_GO .. arg1);
end

function CloseFrame()
	PCPFrame:Hide();
end

function OpenFrame()
	DEFAULT_CHAT_FRAME:AddMessage("Loading PartyBot Control Panel...");
	DEFAULT_CHAT_FRAME:RegisterEvent('CHAT_MSG_SYSTEM')
	PCPFrame:Show();
end


SLASH_PCP1 = '/PCP'
function SlashCmdList.PCP(msg, editbox) -- 4.
    if (msg == "" or msg == "cp") then
        if (PCPFrame:IsVisible()) then
            PCPFrame:Hide()
        else
			PCPFrame:Show()
        end
    end
end

function ShowToggle()
	if (PCPFrame:IsVisible()) then
		PCPFrame:Hide()
	else
		PCPFrame:Show()
	end
end

function JoinWorld()
	id, name = GetChannelName(1)
	if (name ~= "World") then
		JoinChannelByName("World", nil, ChatFrame1:GetID(), 0)
	end
end