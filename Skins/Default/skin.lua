-- Custom Skin handlers (In this situation, this must be declared before the skin table. If loaded after, it would not have a chance to load and an error would be thrown.)
local function formatDetails(window, guild, level, race, class)
    if(guild ~= "") then
	guild = "<"..guild.."> ";
    end
    return "|cffffffff"..guild..level.." "..race.." "..class.."|r";
end


--Default window skin
local WIM_ClassicSkin = {
    title = "WIM Classic",
    version = "1.0.0",
    author = "Pazza <Bronzebeard>",
    website = "http://www.wimaddon.com",
    message_window = {
        texture = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\message_window",
        min_width = 256,
        min_height = 128,
        backdrop = {
            top_left = {
                width = 64,
                height = 64,
                offset = {0, 0},
                texture_coord = {0, 0, 0, .25, .25, 0, .25, .25}
            },
            top_right = {
                width = 64,
                height = 64,
                offset = {0, 0},
                texture_coord = {.75, 0, .75, .25, 1, 0, 1, .25}
            },
            bottom_left = {
                width = 64,
                height = 64,
                offset = {0, 0},
                texture_coord = {0, .75, 0, 1, .25, .75, .25, 1}
            },
            bottom_right = {
                width = 64,
                height = 64,
                offset = {0, 0},
                texture_coord = {.75, .75, .75, 1, 1, .75, 1, 1}
            },
            top = {
                tile = false,
                texture_coord = {.25, 0, .25, .25, .75, 0, .75, .25}
            },
            bottom = {
                tile = false,
                texture_coord = {.25, .75, .25, 1, .75, .75, .75, 1}
            },
            left = {
                tile = false,
                texture_coord = {0, .25, 0, .75, .25, .25, .25, .75}
            },
            right = {
                tile = false,
                texture_coord = {.75, .25, .75, .75, 1, .25, 1, .75}
            },
            background = {
                tile = false,
                texture_coord = {.25, .25, .25, .75, .75, .25, .75, .75}
            }
        },
        widgets = {
            class_icon = {
                texture = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\class_icons",
                width = 64,
                height = 64,
                points = {
                    {"TOPLEFT", "window", "TOPLEFT", -10, 12}
                },
                is_round = true,
                blank = {.5, .5, .5, .75, .75, .5, .75, .75},
                druid = {0, 0, 0, .25, .25, 0, .25, .25},
                hunter = {.25, 0, .25, .25, .5, 0, .5, .25},
                mage = {.5, 0, .5, .25, .75, 0, .75, .25},
                paladin = {.75, 0, .75, .25, 1, 0, 1, .25},
                priest = {0, .25, 0, .5, .25, .25, .25, .5},
                rogue = {.25, .25, .25, .5, .5, .25, .5, .5},
                shaman = {.5, .25, .5, .5, .75, .25, .75, .5},
                warlock = {.75, .25, .75, .5, 1, .25, 1, .5},
                warrior = {0, .5, 0, .75, .25, .5, .25, .75},
                deathknight = {.75, .5, .75, .75, 1, .5, 1, .75},
                gm = {.25, .5, .25, .75, .5, .5, .5, .75}
            },
            from = {
                points = {
                    {"TOPLEFT", "window", "TOPLEFT", 50, -8}
                },
                font = "GameFontNormalLarge",
                font_color = "ffffff",
                font_height = 16,
                font_flags = "",
                use_class_color = true
            },
            char_info = {
                format = formatDetails,
                points = {
                    {"TOP", "window", "TOP", 0, -30}
                },
                font = "GameFontNormal",
                font_color = "ffffff"
            },
            close = {
                state_hide = {
                    NormalTexture = "Interface\\Minimap\\UI-Minimap-MinimizeButtonDown-Up",
                    PushedTexture = "Interface\\Minimap\\UI-Panel-MinimizeButtonDown-Down",
                    HighlightTexture = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight",
                    HighlightAlphaMode = "ADD"
                },
                state_close = {
                    NormalTexture = "Interface\\Buttons\\UI-Panel-MinimizeButton-Up",
                    PushedTexture = "Interface\\Buttons\\UI-Panel-MinimizeButton-Down",
                    HighlightTexture = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight",
                    HighlightAlphaMode = "ADD"
                },
                width = 32,
                height = 32,
                points = {
                    {"TOPRIGHT", "window", "TOPRIGHT", 4, 1}
                }
            },
            history = {
                NormalTexture = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up",
                PushedTexture = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up",
                HighlightTexture = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up",
                HighlightAlphaMode = "ADD",
                rect = {
                    size = {
                        x = 19,
                        y = 19
                    },
                    anchor = "TOPRIGHT",
                    offset = {
                        x = -28,
                        y = -6
                    }
                }
            },
            w2w = {
                NormalTexture = "Interface\\AddOns\\WIM_Rewrite\\Images\\w2w.tga",
                PushedTexture = "Interface\\AddOns\\WIM_Rewrite\\Images\\w2w.tga",
                HighlightTexture = "Interface\\AddOns\\WIM_Rewrite\\Images\\w2w.tga",
                HighlightAlphaMode = "ADD",
                rect = {
                    size = {
                        x = 32,
                        y = 32
                    },
                    anchor = "TOPLEFT",
                    offset = {
                        x = -16,
                        y = 4
                    }
                }
            },
            chatting = {
                NormalTexture = "Interface\\GossipFrame\\PetitionGossipIcon",
                PushedTexture = "Interface\\GossipFrame\\PetitionGossipIcon",
                rect = {
                    size = {
                        x = 16,
                        y = 16
                    },
                    anchor = "TOPLEFT",
                    offset = {
                        x = 40,
                        y = -28
                    }
                }
            },
            scroll_up = {
                NormalTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up",
                PushedTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down",
                HighlightTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight",
                DisabledTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled",
                HighlightAlphaMode = "ADD",
                width = 32,
                height = 32,
                points = {
                    {"TOPRIGHT", "window", "TOPRIGHT", -4, -39}
                }
            },
            scroll_down = {
                NormalTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up",
                PushedTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down",
                HighlightTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight",
                DisabledTexture = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled",
                HighlightAlphaMode = "ADD",
                width = 32,
                height = 32,
                points = {
                    {"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -4, 24}
                }
            },
            chat_display = {
                points = {
                    {"TOPLEFT", "window", "TOPLEFT", 24, -46},
                    {"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -38, 39}
                },
                font = "ChatFontNormal"
            },
            msg_box = {
                font = "ChatFontNormal",
                font_height = 14,
                font_color = {1,1,1},
                points = {
                    {"TOPLEFT", "window", "BOTTOMLEFT", 24, 30},
                    {"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -10, 4}
                },
            },
            resize = {
                NormalTexture = "Interface\\AddOns\\"..WIM.addonTocName.."\\Skins\\Default\\resize",
                width = 25,
                height = 25,
                points = {
                    {"BOTTOMRIGHT", "window", "BOTTOMRIGHT", 5, -5}
                }
            },
            shortcuts = {
                verticle = true,
                inverted = false,
                button_size = 28,
                buffer = 132,
                rect = {
                    anchor = "TOPRIGHT",
                    offset = {
                        x = -30,
                        y = -95
                    }
                }
            }
        },
    },
    tab_strip = {
        textures = {
            tab = {
                NormalTexture = "Interface\\AddOns\\WIM_Rewrite\\Skins\\Default\\tab_normal",
                PushedTexture = "Interface\\AddOns\\WIM_Rewrite\\Skins\\Default\\tab_selected",
                HighlightTexture = "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight",
                HighlightAlphaMode = "ADD"
            },
            prev = {
                NormalTexture = "Interface\\MoneyFrame\\Arrow-Left-Up",
                PushedTexture = "Interface\\MoneyFrame\\Arrow-Left-Down",
                DisabledTexture = "Interface\\MoneyFrame\\Arrow-Left-Disabled",
                HighlightTexture = "Interface\\AddOns\\"..WIM.addonTocName.."\\Skins\\Default\\TabArrowLeft",
                HighlightAlphaMode = "ADD",
                height = 20,
                width = 20,
            },
            next = {
                NormalTexture = "Interface\\MoneyFrame\\Arrow-Right-Up",
                PushedTexture = "Interface\\MoneyFrame\\Arrow-Right-Down",
                DisabledTexture = "Interface\\MoneyFrame\\Arrow-Right-Disabled",
                HighlightTexture = "Interface\\AddOns\\"..WIM.addonTocName.."\\Skins\\Default\\TabArrowRight",
                HighlightAlphaMode = "ADD",
                height = 20,
                width = 20,
            },
        },
        height = 32,
        points = {
            {"BOTTOMLEFT", "window", "TOPLEFT", 38, -4},
            {"BOTTOMRIGHT", "window", "TOPRIGHT", -20, -4}
        },
        text = {
            offsets = {0, 0},
            font = "ChatFontNormal",
            font_color = {1, 1, 1},
            font_height = 12,
            font_flags = ""
        },
        vertical = false,
    },
    emoticons = {
        width = 0,
        height = 0,
        offset = {0, 0},
        definitions = {
            [":)"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\smile.tga",
            [":-)"] = ":)",
            [":("] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\sad.tga",
            [":-("] = ":(",
            ["{beer}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\beer.tga",
            ["{drink}"] = "{beer}",
            [":D"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\biggrin.tga",
            [":-D"] = ":D",
            ["=D"] = ":D",
            ["=-D"] = ":D",
            [":]"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\blush.tga",
            [":-]"] = ":]",
            ["(u)"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\brokenheart.tga",
            ["</3"] = "(u)",
            ["{broken}"] = "(u)",
            ["{brokenheart}"] = "{broken}",
            ["':."] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\brow.tga",
            ["{brow}"] = "':.",
            ["':-."] = "':.",
            ["{coffee}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\coffee.tga",
            ["8)"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\cool.tga",
            ["8-)"] = "8)",
            [":'("] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\cry.tga",
            [":'-("] = ":'(",
            ["{ouch}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\doh.tga",
            [">:."] = "{ouch}",
            [">:-."] = "{ouch}",
            ["{dull}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\dull.tga",
            [":p"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\dumb.tga",
            [":P"] = ":p",
            [":-p"] = ":p",
            [":P"] = ":p",
            [":-P"] = ":p",
            [";p"] = ":p",
            [";P"] = ":p",
            [";-p"] = ":p",
            [";-P"] = ":p",
            ["O.o"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\speechless.tga",
            ["0.o"] = "O.o",
            ["o.O"] = "O.o",
            ["o.0"] = "O.o",
            [">:("] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\envy.tga",
            [">:-("] = ">:(",
            ["{flip}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\finger.tga",
            ["{finger}"] = "{flip}",
            ["nlm"] = "{flip}",
            ["{rose}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\flower.tga",
            ["{flower}"] = "{rose}",
            ["<-@"] = "{rose}",
            ["8|"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\glass.tga",
            ["8-|"] = "8|",
            ["{hi}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\hihi.tga",
            [":*"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\kiss.tga",
            [":-*"] = ":*",
            ["{kiss}"] = ":*",
            ["{martini}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\martini.tga",
            ["{mmm}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\mmm.tga",
            ["{butt}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\mooning.tga",
            ["{no}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\no.tga",
            ["O.O"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\ohh.tga",
            ["0.0"] = "O.O",
            ["=-o"] = "O.O",
            [":("] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\sad.tga",
            [":-("] = ":(",
            [":$"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\sealed.tga",
            [":-$"] = ":$",
            ["{smoke}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\smoke.tga",
            ["o_o"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\speechless.tga",
            ["0_o"] = "o_o",
            ["O_o"] = "o_o",
            ["O_O"] = "o_o",
            ["0_0"] = "o_o",
            ["{tired}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\tired.tga",
            ["{wasntme}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\wasntme.tga",
            ["{yes}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\yes.tga",
            ["{rock}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\rock.tga",
            ["lml"] = "{rock}",
            ["{drunk}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\drunk.tga",
            ["{ninja}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\ninja.tga",
            ["{angry}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\angry.tga",
            [">:o"] = "{angry}",
            [">:-o"] = "{angry}",
            [">:O"] = "{angry}",
            [">:-O"] = "{angry}",
            ["{heart}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\heart.tga",
            ["<3"] = "{heart}",
            ["{wink}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\wink.tga",
            [";)"] = "{wink}",
            [";-)"] = "{wink}",
            ["{eat}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\eat.tga",
            ["{pizza}"] = "{eat}",
            ["{drunk}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\drunk.tga",
            ["{devil}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\devil.tga",
            ["{callme}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\callme.tga",
            ["{boom}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\boom.tga",
            ["{explode}"] = "{boom}",
            ["{money}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\money.tga",
            ["$"] = "{money}",
            ["{evil}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\evil.tga",
            ["{flex}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\flex.tga",
            ["{strong}"] = "{flex}",
            ["{phone}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\phone.tga",
            ["{cell}"] = "{phone}",
            ["{puke}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\puke.tga",
            ["{barf}"] = "{puke}",
            ["{wait}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\wait.tga",
            ["{rain}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\rain.tga",
            ["{badday}"] = "{rain}",
            ["{zipper}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\zipper.tga",
            ["{zipped}"] = "{zipper}",
            ["{zip}"] = "{zipper}",
            ["{hi}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\hi.tga",
            ["{tired}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\tired.tga",
            ["{nervous}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\nervous.tga",
            ["{scared}"] = "{nervous}",
            ["{smoke}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\smoke.tga",
            ["{cig}"] = "{smoke}",
            ["{angel}"] = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\Emoticons\\angel.tga",
            ["O:)"] = "{angel}",
        }
    }
};

local WIM_ClassicSkin_Blue = {
    title = "WIM Classic - Blue",
    author = WIM_ClassicSkin.author,
    version = WIM_ClassicSkin.version,
    message_window = {
        texture = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\message_window_blue"
    }
};

local WIM_ClassicSkin_Green = {
    title = "WIM Classic - Green",
    author = WIM_ClassicSkin.author,
    version = WIM_ClassicSkin.version,
    message_window = {
        texture = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\message_window_green"
    }
};

local WIM_ClassicSkin_Red = {
    title = "WIM Classic - Red",
    author = WIM_ClassicSkin.author,
    version = WIM_ClassicSkin.version,
    message_window = {
        texture = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\message_window_red"
    }
};

local WIM_ClassicSkin_Yellow = {
    title = "WIM Classic - Yellow",
    author = WIM_ClassicSkin.author,
    version = WIM_ClassicSkin.version,
    message_window = {
        texture = "Interface\\AddOns\\WIM_Rewrite\\skins\\default\\message_window_yellow"
    }
};
----------------------------------------------------------
--                  Register Skin                       --
----------------------------------------------------------

WIM.RegisterSkin(WIM_ClassicSkin);
WIM.RegisterSkin(WIM_ClassicSkin_Blue);
WIM.RegisterSkin(WIM_ClassicSkin_Green);
WIM.RegisterSkin(WIM_ClassicSkin_Red);
WIM.RegisterSkin(WIM_ClassicSkin_Yellow);