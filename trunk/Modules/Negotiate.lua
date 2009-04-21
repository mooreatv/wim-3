--[[
    Extends Modules by adding:
        Module:GuildMember_Online(name)
        Module:GuildMember_Offline(name)
        Module:Friend_Online(name)
        Module:Friend_Offline(name)
        Module:PartyMember_Online(name)
        Module:PartyMember_Offline(name)
        Module:RaidMember_Online(name)
        Module:RaidMember_Offline(name)
]]


-- imports
local WIM = WIM;
local _G = _G;
local pairs = pairs;
local string = string;
local table = table;
local time = time;
local tonumber = tonumber;

-- set namespace
setfenv(1, WIM);

local Module = CreateModule("Negotiate", true);

local maxVersion = version;
local alreadyAlerted = false;

db_defaults.rememberWho = false;
local WHO_LIST = {};

Module:RegisterEvent("FRIENDLIST_UPDATE");
Module:RegisterEvent("GUILD_ROSTER_UPDATE");
Module:RegisterEvent("PARTY_MEMBERS_CHANGED");


-- lessen broadcasts, target new users instead
 OnlineCache = {};
local function getCache(tag)
    if(not OnlineCache[tag]) then
        OnlineCache[tag] = {};
    end
    return OnlineCache[tag];
end

local function isCache(tag)
    if(OnlineCache[tag]) then
        local count = 0;
        for k, _ in pairs(OnlineCache[tag]) do
            count = count + 1;
        end
        return count > 0;
    else
        return false;
    end
end

local function tagToModuleName(tag)
    if(tag == "friends") then
        return "Friend";
    elseif(tag == "guild") then
        return "GuildMember";
    elseif(tag == "party") then
        return "PartyMember"
    elseif(tag == "raid") then
        return "RaidMember";
    else
        return "UNKNOWN_TAG"
    end
end

local function shouldNegotiate(tag, user, token)
    local cache = getCache(tag);
    if(cache[user]) then
        cache[user] = token;
        return false;
    else
        cache[user] = token;
        CallModuleFunction(tagToModuleName(tag).."_Online", user);
        return true;
    end
end

local function cleanCachebyToken(tag, token)
    local cache = getCache(tag);
    for k, t in pairs(cache) do
        if(t ~= token) then
            CallModuleFunction(tagToModuleName(tag).."_Offline", k);
            cache[k] = nil;
        end
    end
end


-- negotiate with target player/channel
local function Negotiate(ttype, target)
    SendData(ttype, target, "NEGOTIATE", version..":"..(beta and "1" or "0"));
end


function Module:FRIENDLIST_UPDATE()
    local token = _G.GetTime();
    for i=1, _G.GetNumFriends() do 
        local name, level, class, area, connected, status, note = _G.GetFriendInfo(i);
        if(connected and shouldNegotiate("friends", name, token)) then
            Negotiate("WHISPER", name); --[set place holder for quick lookup
        end
    end
    cleanCachebyToken("friends", token);
end

function Module:GUILD_ROSTER_UPDATE()
    if(isCache("guild")) then
        --negotiate with new only
        local token = _G.GetTime();
        for i=1, _G.GetNumGuildMembers() do 
	    local name, _, _, _, _, _, _, _, online, _, _ = _G.GetGuildRosterInfo(i);
	    if(name and online and shouldNegotiate("guild", name, token)) then
		Negotiate("WHISPER", name);
	    end
	end
        cleanCachebyToken("guild", token);
    else
        --build cache
        local token = _G.GetTime();
        for i=1, _G.GetNumGuildMembers() do 
	    local name, _, _, _, _, _, _, _, online, _, _ = _G.GetGuildRosterInfo(i);
	    if(name and online and shouldNegotiate("guild", name, token)) then
		-- do nothing, we're broadcasting...
	    end
	end
        Negotiate("GUILD");
    end
end

function Module:PARTY_MEMBERS_CHANGED()
    if(_G.GetNumRaidMembers() > 0) then
        if(isCache("raid")) then
            --negotiate with new only
            local token = _G.GetTime();
            for i=1, 40 do
                local unit = "raid"..i;
                local name, online = _G.UnitName(unit), _G.UnitIsConnected(unit);
                if(name and online and shouldNegotiate("raid", name, token)) then
                    Negotiate("WHISPER", name);
                end
            end
            cleanCachebyToken("raid", token);
        else
            -- build cache
            local token = _G.GetTime();
            for i=1, 40 do
                local unit = "raid"..i;
                local name, online = _G.UnitName(unit), _G.UnitIsConnected(unit);
                if(name and online and shouldNegotiate("raid", name, token)) then
                    -- do nothing, we're broadcasting...
                end
            end
            Negotiate("RAID");
            cleanCachebyToken("raid", token);
        end
    else
        if(isCache("party")) then
            --negotiate with new only
            local token = _G.GetTime();
            for i=1, 5 do
                local unit = "party"..i;
                local name, online = _G.UnitName(unit), _G.UnitIsConnected(unit);
                if(name and online and shouldNegotiate("party", name, token)) then
                    Negotiate("WHISPER", name);
                end
            end
            cleanCachebyToken("party", token);
        else
            -- build cache
            local token = _G.GetTime();
            for i=1, 5 do
                local unit = "party"..i;
                local name, online = _G.UnitName(unit), _G.UnitIsConnected(unit);
                if(name and online and shouldNegotiate("party", name, token)) then
                    -- do nothing, we're broadcasting...
                end
            end
            Negotiate("PARTY");
            cleanCachebyToken("party", token);
        end
    end
end

function Module:OnWindowCreated(win)
    if(win.type == "whisper") then
        Negotiate("WHISPER", win.theUser);
    end
end

RegisterAddonMessageHandler("NEGOTIATE", function(from, data)
        local v, isBeta = string.match(data, "^(.+):(%d)");
        local diff = CompareVersion(v);
        if(diff > 0) then
            if(not alreadyAlerted and tonumber(isBeta) == 0) then
                -- there is a newer version
                alreadyAlerted = true;
                DisplayTutorial(L["WIM Update Available!"], _G.format(L["There is a newer version of WIM available for download. You can download it at %s."], "|cff69ccf0WIMAddon.com|r"))
            end
        elseif(diff < 0) then
            -- user has an older version, let him know.
            Negotiate("WHISPER", from);
        end
        if(db.rememberWho) then
            WHO_LIST[from] = v..(tonumber(isBeta)==1 and " BETA" or "");
        end
    end);
    
    
function WhoList(arg)
    if(string.lower(arg) == "on") then
        db.rememberWho = true;
        _G.ReloadUI();
        return;
    elseif(string.lower(arg) == "off") then
        db.rememberWho = false;
        _G.ReloadUI();
        return;
    end
    if(not db.rememberWho) then
        _G.DEFAULT_CHAT_FRAME:AddMessage("WIM is not set to remember user encounters.");
        _G.DEFAULT_CHAT_FRAME:AddMessage("usage: /wim who on      /wim who off");
        return;
    end
    local count = 0;
    for user, v in pairs(WHO_LIST) do
        _G.DEFAULT_CHAT_FRAME:AddMessage("|Hplayer:"..user.."|h"..user.."|h   "..v);
        count = count + 1;
    end
    _G.DEFAULT_CHAT_FRAME:AddMessage("Total found using WIM: "..count);
end


--[[ DEBUGGING
function Module:GuildMember_Online(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Guild Online: "..name);
end
function Module:GuildMember_Offline(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Guild Offiline: "..name);
end
function Module:Friend_Online(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Friend Online: "..name);
end
function Module:Friend_Offline(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Friend Offiline: "..name);
end
function Module:PartyMember_Online(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Party Online: "..name);
end
function Module:PartyMember_Offline(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Party Offline: "..name);
end
function Module:RaidMember_Online(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Raid Online: "..name);
end
function Module:RaidMember_Offline(name)
    _G.DEFAULT_CHAT_FRAME:AddMessage("Raid Offline: "..name);
end
]]