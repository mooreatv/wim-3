WIM = { -- WIM's core object.
    addonTocName = "WIM_Rewrite",
    version = "3.0.0",
    revision = "$Revision:$",
    beta = true
}; 
local WIM = WIM;

WIM.debug = true; -- turn debugging on and off.
WIM.constants = {}; -- constants such as class colors will be stored here. (includes female class names).
WIM.modules = {}; -- module table. consists of all registerd WIM modules/plugins/skins. (treated the same).
WIM.windows = {active = {whisper = {}, chat = {}, w2w = {}}}; -- table of WIM windows.
WIM.libs = {}; -- table of loaded library references.

-- default options. live data is found in WIM.db
-- modules may insert fields into this table to
-- respect their option contributions.
WIM.db_defaults = {
    enabled = true,
    showToolTips = true,
    modules = {},
}

-- WIM.env is an evironmental reference for the current instance of WIM.
-- Information is stored here such as .realm and .character.
-- View table dump for more available information.
WIM.env = {};

-- default lists - This will store lists such as friends, guildies, raid members etc.
WIM.lists = {};

-- list of all the events registered from attached modules.
local Events = {};


-- create a frame to moderate events and frame updates.
    local workerFrame = CreateFrame("Frame", "WIM_workerFrame");
    workerFrame:SetScript("OnEvent", function(self, event, ...) WIM:EventHandler(event, ...); end);
    
    -- some events we always want to listen to so data is ready upon WIM being enabled.
    workerFrame:RegisterEvent("VARIABLES_LOADED");
    workerFrame:RegisterEvent("ADDON_LOADED");
    workerFrame:RegisterEvent("GUILD_ROSTER_UPDATE");
    workerFrame:RegisterEvent("FRIENDLIST_UPDATE");
    

-- called when WIM is first loaded into memory but after variables are loaded.
local function initialize()
    --load cached information from the WIM_Cache saved variable.
	WIM.env.cache[WIM.env.realm] = WIM.env.cache[WIM.env.realm] or {};
        WIM.env.cache[WIM.env.realm][WIM.env.character] = WIM.env.cache[WIM.env.realm][WIM.env.character] or {};
	WIM.lists.friends = WIM.env.cache[WIM.env.realm][WIM.env.character].friendList;
	WIM.lists.guild = WIM.env.cache[WIM.env.realm][WIM.env.character].guildList;
        
        if(type(WIM.lists.friends) ~= "table") then WIM.lists.friends = {}; end
        if(type(WIM.lists.guild) ~= "table") then WIM.lists.guild = {}; end
        
        --querie guild roster
        if( IsInGuild() ) then
            GuildRoster();
        end
    
    WIM.libs.WhoLib = AceLibrary and AceLibrary('WhoLib-1.0');
    WIM.libs.Astrolabe = DongleStub("Astrolabe-0.4");
    
    WIM.isInitialized = true;
    
    WIM:RegisterPrematureSkins();
    
    --enableModules
    local moduleName, tData;
    for moduleName, tData in pairs(WIM.modules) do
        WIM.modules[moduleName].db = WIM.db;
        if(WIM.modules[moduleName].canDisable ~= false) then
            local modDB = WIM.db.modules[moduleName];
            if(modDB) then
                if(modDB.enabled == nil) then
                    modDB.enabled = WIM.modules[moduleName].enableByDefault;
                end
                WIM:EnableModule(moduleName, modDB.enabled);
            else
                if(WIM.modules[moduleName].enableByDefault) then
                    WIM:EnableModule(moduleName, true);
                end
            end
        end
    end
    
    WIM:dPrint("WIM initialized...");
end

-- called when WIM is enabled.
-- WIM will not be enabled until WIM is initialized event is fired.
local function onEnable()
    WIM.db.enabled = true;
    
    local tEvent;
    for tEvent, _ in pairs(Events) do
        workerFrame:RegisterEvent(tEvent);
    end
    
    local module = WIM.modules[moduleName];
    if(module) then
        module.enabled = enabled;
        if(type(module.OnEnableWIM) == "function") then
            module:OnEnableWIM();
        end
    end
    
    WIM_isEnabled = true;
    WIM:dPrint("WIM is now enabled.");
end

-- called when WIM is disabled.
local function onDisable()
    WIM.db.enabled = false;
    
    local tEvent;
    for tEvent, _ in pairs(Events) do
        workerFrame:UnregisterEvent(tEvent);
    end
    
    local module = WIM.modules[moduleName];
    if(module) then
        module.enabled = enabled;
        if(type(module.OnDisableWIM) == "function") then
            module:OnDisableWIM();
        end
    end
    
    WIM_isEnabled = false;
    WIM:dPrint("WIM is now disabled.");
end


function WIM:SetEnabled(enabled)
    if( enabled ) then
        onEnable();
    else
        onDisable();
    end
end

-- events are passed to modules. Events do not need to be
-- unregistered. A disabled module will not receive events.
local function RegisterEvent(event)
    Events[event] = true;
    if( WIM.db and WIM.db.enabled ) then
        workerFrame:RegisterEvent(event);
    end
end

-- create a new WIM module. Will return module object.
function WIM:CreateModule(moduleName, enableByDefault)
    if(type(moduleName) == "string") then
        WIM.modules[moduleName] = {
            title = moduleName,
            enabled = false,
            enableByDefault = enableByDefault or false,
            canDisable = true,
            resources = {
                lists = WIM.lists,
                windows = WIM.windows,
                env = WIM.env,
                constants = WIM.constants,
                libs = WIM.libs,
            },
            db = WIM.db,
            db_defaults = WIM.db_defaults,
            RegisterEvent = function(self, event) RegisterEvent(event); end,
            Enable = function() WIM:EnableModule(moduleName, true) end,
            Disable = function() WIM:EnableModule(moduleName, false) end,
            dPrint = function(self, t) WIM:dPrint(t); end,
            hasWidget = false,
            RegisterWidget = function(widgetName, createFunction) WIM:RegisterWidget(widgetName, createFunction, moduleName); end
        }
        return WIM.modules[moduleName];
    else
        return nil;
    end
end

function WIM:EnableModule(moduleName, enabled)
    local module = WIM.modules[moduleName];
    if(module) then
        if(module.canDisable == false and enabled == false) then
            WIM:dPrint("Module '"..moduleName.."' can not be disabled!");
            return;
        end
        if(enabled) then
            module.enabled = enabled;
            if(enabled and type(module.OnEnable) == "function") then
                module:OnEnable();
            elseif(not enabled and type(module.OnDisable) == "function") then
                module:OnDisable();
            end
            WIM:dPrint("Module '"..moduleName.."' Enabled");
        else
            if(module.hasWidget) then
                WIM:dPrint("Module '"..moduleName.."' will be disabled after restart.");
            else
                module.enabled = enabled;
                if(enabled and type(module.OnEnable) == "function") then
                    module:OnEnable();
                elseif(not enabled and type(module.OnDisable) == "function") then
                    module:OnDisable();
                end
                WIM:dPrint("Module '"..moduleName.."' Disabled");
            end
        end
        if(WIM.db) then
            WIM.db.modules[moduleName] = WIM.db.modules[moduleName] or {};
            WIM.db.modules[moduleName].enabled = enabled;
        end
    end
end

function WIM:CallModuleFunction(funName, ...)
    -- notify all enabled modules.
    local module, tData, fun;
    for module, tData in pairs(WIM.modules) do
        fun = tData[funName];
        if(type(fun) == "function" and tData.enabled) then
            fun(tData, ...);
        end
    end
end
--------------------------------------
--          Event Handlers          --
--------------------------------------

local function honorChatFrameEventFilter(event, msg)
    local chatFilters = ChatFrame_GetMessageEventFilters(event);
    if chatFilters then 
	local filter, newmsg = false;
        for _, filterFunc in next, chatFilters do
            filter, newmsg = filterFunc(msg);
            if filter then 
		return true; 
	    end 
	end 
    end 
    return false;
end


-- This is WIM's core event controler.
function WIM:EventHandler(event, ...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
    -- before we do any filtering, make sure that we are not speaking to a GM.
    -- no matter what, we want to see these.
    if(not (event == "CHAT_MSG_WHISPER" and agr6 ~= "GM")) then
        -- first we will filter out
        if(honorChatFrameEventFilter(event, arg1 or "")) then
            -- ChatFrame's event filters said to block this message.
            return;
        end
        -- other filtering will take place in individual event handlers within modules.
    end

    -- Core WIM Event Handlers.
    WIM:dPrint("Event '"..event.."' received.");
    -- the following line is for debugging only.
    --WIM:dPrint("Args:"..(arg1 or "")..","..(arg2 or "")..","..(arg3 or "")..","..(arg4 or "")..","..(arg5 or "")..","..(arg6 or "")..","..(arg7 or "")..","..(arg8 or "")..","..(arg9 or "")..","..(arg10 or "")..","..(arg11 or ""));
    local fun = WIM[event];
    if(type(fun) == "function") then
        WIM:dPrint("  +-- WIM:"..event);
        fun(WIM, ...);
    end
    
    -- Module Event Handlers
    local module, tData;
    for module, tData in pairs(WIM.modules) do
        fun = tData[event];
        if(type(fun) == "function" and tData.enabled) then
            WIM:dPrint("  +-- "..module..":"..event);
            fun(WIM.modules[module], ...);
        end
    end
end

function WIM:VARIABLES_LOADED()
    WIM3_Data = WIM3_Data or {};
    WIM.db = WIM3_Data;
    WIM3_Cache = WIM3_Cache or {};
    WIM.env.cache = WIM3_Cache;
    
    -- load some environment data.
    WIM.env.realm = GetCVar("realmName");
    WIM.env.character = UnitName("player");
    
    
    -- inherrit any new default options which wheren't shown in previous releases.
    WIM.copyTable(WIM.db_defaults, WIM.db);
    WIM.lists.gm = {};
    
    initialize();
    WIM:SetEnabled(WIM.db.enabled);
end

function WIM:FRIENDLIST_UPDATE()
    WIM.env.cache[WIM.env.realm][WIM.env.character].friendList = {};
	for i=1, GetNumFriends() do 
		local name, junk = GetFriendInfo(i);
		if(name) then
			WIM.env.cache[WIM.env.realm][WIM.env.character].friendList[name] = "1"; --[set place holder for quick lookup
		end
	end
    WIM.lists.friends = WIM.env.cache[WIM.env.realm][WIM.env.character].friendList;
    WIM:dPrint("Friends list updated...");
end

function WIM:GUILD_ROSTER_UPDATE()
	WIM.env.cache[WIM.env.realm][WIM.env.character].guildList = {};
	if(IsInGuild()) then
		for i=1, GetNumGuildMembers(true) do 
			local name, junk = GetGuildRosterInfo(i);
			if(name) then
				WIM.env.cache[WIM.env.realm][WIM.env.character].guildList[name] = "1"; --[set place holder for quick lookup
			end
		end
	end
	WIM.lists.guild = WIM.env.cache[WIM.env.realm][WIM.env.character].guildList;
        WIM:dPrint("Guild list updated...");
end

function WIM:IsGM(name)
    if(name == nil or name == "") then
		return false;
	end
	if(string.len(name) < 4) then return false; end
	if(string.sub(name, 1, 4) == "<GM>") then
		local tmp = string.gsub(name, "<GM> ", "");
		WIM.lists.gm[tmp] = 1;
		return true;
	else
		if(WIM.lists.gm[user]) then
			return true;
		else
			return false;
		end
	end
end
