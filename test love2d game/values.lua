function getspritevalues(n)
  if string.sub(n,1,10) == "text_text_" then
    return {sprite = n,name = n,color = getspritevalues(string.sub(n,6,string.len(n))).color,rotate =  nil,args = nil,type = 0}
  end
  return betterObjectValues[n] or {sprite = n,name = n, color = {1,1}, rotate = nil, args = nil, nope = true}
end
objectValues = {
  {
    name = "baaba",
    sprite = "baaba",
    color = {1,2},
    rotate = 6
  },
  {
    name = "text_baaba",
    sprite = "text_baaba",
    color = {4,4},
    type = 0
  },
  {
    name = "stone",
    sprite = "stone",
    color = {1,3}
  },
  {
    name = "text_stone",
    sprite = "text_stone",
    color = {1,3},
    type = 0
  },
  {
    name = "tile",
    sprite = "tile",
    color = {7,4},
  },
  {
    name = "text_tile",
    sprite = "text_tile",
    color = {7,4},
    type = 0
  },
  {
    name = "text_you",
    sprite = "text_you",
    color = {4,4},
    type = 2
  },
  {
    name = "text_is",
    sprite = "text_is",
    color = {1,2},
    type = 1,
    args = {0, 2}
  },
  {
    name = "text_meta",
    sprite = "text_meta",
    color = {4,4},
    type = 2
  },
  {
    name = "text_text",
    sprite = "text_text",
    color = {4,4},
    type = 0
  },
  {
    name = "text_open",
    sprite = "text_open",
    color = {3,1},
    type = 2
  },
  {
    name = "text_push",
    sprite = "text_push",
    color = {2,3},
    type = 2
  },
  {
    name = "text_all",
    sprite = "text_all",
    color = {1,2},
    type = 0
  },
  {
    name = "text_weak",
    sprite = "text_weak",
    color = {5,3},
    type = 2
  },
  {
    name = "text_move",
    sprite = "text_move",
    color = {5,1},
    type = 2
  },
  {
    name = "text_red",
    sprite = "text_red",
    color = {1,1},
    type = 2
  },
  {
    name = "text_stop",
    sprite = "text_stop",
    color = {6,1},
    type = 2
  },
  {
    name = "text_this",
    sprite = "text_this",
    color = {1,2},
    type = 0
  },
  {
    name = "text_shut",
    sprite = "text_shut",
    color = {1,1},
    type = 2
  },
  {
    name = "keeke",
    sprite = "keeke",
    color = {2,1},
    rotate = 6
  },
  {
    name = "flag",
    sprite = "flag",
    color = {3,1},
    rotate = 4
  },
  {
    name = "wall",
    sprite = "wall",
    color = {7,5},
    rotate = 5
  },
  {
    name = "text_keeke",
    sprite = "text_keeke",
    color = {2,1},
    type = 0
  },
  {
    name = "text_flag",
    sprite = "text_flag",
    color = {3,1},
    type = 0
  },
  {
    name = "text_wall",
    sprite = "text_wall",
    color = {7,5},
    type = 0
  },
  {
    name = "text_sink",
    sprite = "text_sink",
    color = {6,3},
    type = 2
  },
  {
    name = "text_whater",
    sprite = "text_whater",
    color = {6,1},
    type = 0
  },
  {
    name = "whater",
    sprite = "whater",
    color = {6,1},
    rotate = 5
  },
  {
    name = "text_lavaaa",
    sprite = "text_lavaaa",
    color = {2,1},
    type = 0
  },
  {
    name = "lavaaa",
    sprite = "lavaaa",
    color = {2,1},
    rotate = 5
  },
  {
    name = "text_hot",
    sprite = "text_hot",
    color = {2,1},
    type = 2
  },
  {
    name = "text_melt",
    sprite = "text_melt",
    color = {6,1},
    type = 2
  },
  {
    name = "text_fofofo",
    sprite = "text_fofofo",
    color = {5,1},
    type = 0
  },
  {
    name = "fofofo",
    sprite = "fofofo",
    color = {5,1},
    rotate = 6
  },
  {
    name = "text_key",
    sprite = "text_key",
    color = {3,1},
    type = 0
  },
  {
    name = "key",
    sprite = "key",
    color = {3,1},
    rotate = 4
  },
  {
    name = "text_door",
    sprite = "text_door",
    color = {1,1},
    type = 0
  },
  {
    name = "door",
    sprite = "door",
    color = {1,1}
  },
  {
    name = "text_group",
    sprite = "text_group",
    color = {5,1},
    type = 0
  },
  {
    name = "clock",
    sprite = "clock",
    color = {7,4}
  },
  {
    name = "text_clock",
    sprite = "text_clock",
    color = {7,4},
    type = 0
  },
  {
    name = "text_have",
    sprite = "text_have",
    color = {1,2},
    type = 1
  },
  {
    name = "text_win",
    sprite = "text_win",
    color = {3,1},
    type = 2
  },
  {
    name = "text_defeat",
    sprite = "text_defeat",
    color = {3,4},
    type = 2
  },
  {
    name = "text_clipboard",
    sprite = "text_clipboard",
    color = {1,2},
    type = 0
  },
  {
    name = "text_orange",
    sprite = "text_orange",
    color = {2,1},
    type = 2
  },
  {
    name = "skull",
    sprite = "skull",
    color = {3,4},
    rotate = 4
  },
  {
    name = "text_skull",
    sprite = "text_skull",
    color = {3,4},
    type = 0
  },
  {
    name = "text_level",
    sprite = "text_level",
    color = {4,4},
    type = 0
  },
  {
    name = "level",
    sprite = "level",
    color = {1,2}
  },
  {
    name = "text_a",
    sprite = "text_a",
    color = {1,2},
    type = 5
  },
  {
    name = "text_b",
    sprite = "text_b",
    color = {1,2},
    type = 5
  },
  {
    name = "text_tele",
    sprite = "text_tele",
    color = {6,5},
    type = 2
  },
  {
    name = "text_ice",
    sprite = "text_ice",
    color = {6,5},
    type = 0
  },
  {
    name = "ice",
    sprite = "ice",
    color = {6,5}
  },
  {
    name = "text_what",
    sprite = "text_what",
    color = {2,1},
    type = 2
  },
  {
    name = "pumpkin",
    sprite = "pumpkin",
    color = {2,1}
  },
  {
    name = "text_pumpkin",
    sprite = "text_pumpkin",
    color = {2,1},
    type = 0
  },
  {
    name = "text_n'",
    sprite = "text_N'",
    color = {1,2},
    type = 4
  },
  {
    name = "text_dl",
    sprite = "text_dl",
    color = {1,2},
    type = 14
  },
  {
    name = "text_icon",
    sprite = "text_icon",
    color = {1,1},
    type = 0
  },

  {
    name = "text_lonely",
    sprite = "text_lonely",
    color = {1,1},
    type = 3
  },
  {
    name = "text_jelly",
    sprite = "text_jelly",
    color = {6,5},
    type = 0
  },
  {
    name = "jelly",
    sprite = "jelly",
    color = {6,5}
  },
  {
    name = "text_often",
    sprite = "text_often",
    color = {4,1},
    type = 3
  },
  {
    name = "text_seldom",
    sprite = "text_seldom",
    color = {6,1},
    type = 3
  },
  {
    name = "text_powered",
    sprite = "text_powered",
    color = {3,1},
    type = 3
  },
  {
    name = "text_power",
    sprite = "text_power",
    color = {3,1},
    type = 2
  },
  {
    name = "text_on",
    sprite = "text_on",
    color = {1,2},
    type = 7
  },
  {
    name = "box",
    sprite = "box",
    color = {2,3}
  },
  {
    name = "text_box",
    sprite = "text_box",
    color = {2,3},
    type = 0
  },
  {
    name = "circle",
    sprite = "circle",
    color = {3,1}
  },
  {
    name = "text_circle",
    sprite = "text_circle",
    color = {3,1},
    type = 0
  },
  {
    name = "triangle",
    sprite = "triangle",
    color = {6,3}
  },
  {
    name = "text_triangle",
    sprite = "text_triangle",
    color = {6,3},
    type = 0
  },
  {
    name = "square",
    sprite = "square",
    color = {4,4}
  },
  {
    name = "text_square",
    sprite = "text_sqaure",
    color = {4,4},
    type = 0
  },
  {
    name = "text_fear",
    sprite = "text_fear",
    color = {1,1},
    type = 1
  },
  {
    name = "text_grass",
    sprite = "text_grass",
    color = {5,5},
    type = 0
  },
  {
    name = "grass",
    sprite = "grass",
    color = {5,5}
  },
  {
    name = "text_grubble",
    sprite = "text_grubble",
    color = {4,5},
    type = 0
  },
  {
    name = "grubble",
    sprite = "grubble",
    color = {4,5},
    rotate = 5
  },
  {
    name = "text_rubble",
    sprite = "text_rubble",
    color = {2,5},
    type = 0
  },
  {
    name = "rubble",
    sprite = "rubble",
    color = {2,5}
  },
  {
    name = "text_scribble",
    sprite = "text_scribble",
    color = {1,2},
    type = 0
  },
  {
    name = "scribble",
    sprite = "scribble",
    color = {1,2}
  },
  {
    name = "text_hex",
    sprite = "text_hex",
    color = {2,3},
    type = 0
  },
  {
    name = "hex",
    sprite = "hex",
    color = {2,3}
  },
  {
    name = "text_pentagon",
    sprite = "text_pentagon",
    color = {1,2},
    type = 0
  },
  {
    name = "pentagon",
    sprite = "pentagon",
    color = {1,2}
  },
  {
    name = "text_i",
    sprite = "text_i",
    color = {1,2},
    type = 5
  },
  {
    name = "text_s",
    sprite = "text_s",
    color = {1,2},
    type = 5
  },
  {
    name = "text_float",
    sprite = "text_float",
    color = {6,5},
    type = 2
  },
  {
    name = "text_cake",
    sprite = "text_cake",
    color = {6,4},
    type = 0
  },
  {
    name = "cake",
    sprite = "cake",
    color = {6,4}
  },
  {
    name = "text_the m",
    sprite = "text_the m",
    color = {6,5},
    type = 0
  },
  {
    name = "the m",
    sprite = "the m",
    color = {6,5},
    rotate = 6
  },
  {
    name = "jijiji",
    sprite = "jijiji",
    color = {1,1},
    rotate = 6
  },
  {
    name = "text_jijiji",
    sprite = "text_jijiji",
    color = {1,1},
    type = 0
  },
  {
    name = "text_no",
    sprite = "text_no",
    color = {1,1},
    type = 3
  },
  {
    name = "text_small",
    sprite = "text_small",
    color = {7,1},
    type = 2
  },
  {
    name = "text_brick",
    sprite = "text_brick",
    color = {2,5},
    type = 0
  },
  {
    name = "brick",
    sprite = "brick",
    color = {2,5}
  },
  {
    name = "text_bubble",
    sprite = "text_bubble",
    color = {6,5},
    type = 0
  },
  {
    name = "bubble",
    sprite = "bubble",
    color = {6,5}
  },
  {
    name = "text_robot",
    sprite = "text_robot",
    color = {1,4},
    type = 0
  },
  {
    name = "robot",
    sprite = "robot",
    color = {1,4},
    rotate = 6
  },
  {
    name = "text_hedge",
    sprite = "text_hedge",
    color = {5,1},
    type = 0
  },
  {
    name = "hedge",
    sprite = "hedge",
    color = {5,1},
    rotate = 5
  },
  {
    name = "text_pillar",
    sprite = "text_pillar",
    color = {1,3},
    type = 0
  },
  {
    name = "pillar",
    sprite = "pillar",
    color = {1,3},
  },
  {
    name = "text_love",
    sprite = "text_love",
    color = {5,4},
    type = 0
  },
  {
    name = "love",
    sprite = "love",
    color = {5,4},
  },
  {
    name = "text_star",
    sprite = "text_star",
    color = {3,1},
    type = 0
  },
  {
    name = "star",
    sprite = "star",
    color = {3,1},
  },
  {
    name = "text_algae",
    sprite = "text_algae",
    color = {5,1},
    type = 0
  },
  {
    name = "algae",
    sprite = "algae",
    color = {5,1},
  },
  {
    name = "text_flower",
    sprite = "text_flower",
    color = {6,3},
    type = 0
  },
  {
    name = "flower",
    sprite = "flower",
    color = {6,3},
  },
  {
    name = "text_crab",
    sprite = "text_crab",
    color = {1,1},
    type = 0
  },
  {
    name = "crab",
    sprite = "crab",
    color = {1,1},
    rotate = 4
  },
  {
    name = "text_block",
    sprite = "text_block",
    color = {2,1},
    type = 0
  },
  {
    name = "block",
    sprite = "block",
    color = {2,1}
  },
  {
    name = "text_pa",
    sprite = "text_pa",
    color = {4,4},
    type = 0
  },
  {
    name = "pa",
    sprite = "pa",
    color = {4,4},
    rotate = 4
  },
  {
    name = "text_baadbad",
    sprite = "text_baadbad",
    color = {7,1},
    type = 0
  },
  {
    name = "baadbad",
    sprite = "baadbad",
    color = {7,1},
    rotate = 6
  },
  {
    name = "text_bolt",
    sprite = "text_bolt",
    color = {3,1},
    type = 0
  },
  {
    name = "bolt",
    sprite = "bolt",
    color = {3,1},
    rotate = 4
  },
  {
    name = "text_statue",
    sprite = "text_statue",
    color = {1,3},
    type = 0
  },
  {
    name = "statue",
    sprite = "statue",
    color = {1,4},
    rotate = 4
  },
  {
    name = "text_ghost",
    sprite = "text_ghost",
    color = {5,4},
    type = 0
  },
  {
    name = "ghost",
    sprite = "ghost",
    color = {5,4},
    rotate = 4
  },
  {
    name = "text_cog",
    sprite = "text_cog",
    color = {1,4},
    type = 0
  },
  {
    name = "cog",
    sprite = "cog",
    color = {1,4}
  },
  {
    name = "text_pipe",
    sprite = "text_pipe",
    color = {1,4},
    type = 0
  },
  {
    name = "pipe",
    sprite = "pipe",
    color = {1,4}
  },
  {
    name = "text_foliage",
    sprite = "text_foliage",
    color = {2,1},
    type = 0
  },
  {
    name = "foliage",
    sprite = "foliage",
    color = {2,5}
  },
  {
    name = "text_fruit",
    sprite = "text_fruit",
    color = {1,1},
    type = 0
  },
  {
    name = "fruit",
    sprite = "fruit",
    color = {1,1}
  },
  {
    name = "text_husk",
    sprite = "text_husk",
    color = {2,5},
    type = 0
  },
  {
    name = "husk",
    sprite = "husk",
    color = {2,5}
  },
  {
    name = "text_leaf",
    sprite = "text_leaf",
    color = {3,1},
    type = 0
  },
  {
    name = "leaf",
    sprite = "leaf",
    color = {3,1}
  },
  {
    name = "text_reed",
    sprite = "text_reed",
    color = {2,3},
    type = 0
  },
  {
    name = "reed",
    sprite = "reed",
    color = {2,3}
  },
  {
    name = "text_stump",
    sprite = "text_stump",
    color = {2,5},
    type = 0
  },
  {
    name = "stump",
    sprite = "stump",
    color = {2,5}
  },
  {
    name = "text_tree",
    sprite = "text_tree",
    color = {5,1},
    type = 0
  },
  {
    name = "tree",
    sprite = "tree",
    color = {5,1}
  },
  {
    name = "text_goal",
    sprite = "text_goal",
    color = {1,2},
    type = 0
  },
  {
    name = "goal",
    sprite = "goal",
    color = {1,2}
  },
  {
    name = "text_target",
    sprite = "text_target",
    color = {1,2},
    type = 0
  },
  {
    name = "target",
    sprite = "target",
    color = {1,2}
  },
  {
    name = "text_place",
    sprite = "text_place",
    color = {5,1},
    type = 2
  },
  {
    name = "text_placed",
    sprite = "text_placed",
    color = {2,1},
    type = 2
  },
  {
    name = "text_active",
    sprite = "text_active",
    color = {5,1},
    type = 3
  },
  {
    name = "text_button",
    sprite = "text_button",
    color = {1,1},
    type = 0
  },
  {
    name = "button",
    sprite = "button",
    color = {1,1}
  },
  --[[
  {
    name = "text_possess",
    sprite = "text_possess",
    color = {6,4},
    type = 2
  },]]
  {
    name = "text_fungus",
    sprite = "text_fungus",
    color = {2,3},
    type = 0
  },
  {
    name = "fungus",
    sprite = "fungus",
    color = {2,3}
  },
  {
    name = "text_belt",
    sprite = "text_belt",
    color = {6,3},
    type = 0
  },
  {
    name = "belt",
    sprite = "belt",
    color = {6,3},
    rotate = 4
  },
  {
    name = "text_bug",
    sprite = "text_bug",
    color = {2,3},
    type = 0
  },
  {
    name = "bug",
    sprite = "bug",
    color = {2,3},
    rotate = 6
  },
  {
    name = "text_moon",
    sprite = "text_moon",
    color = {3,1},
    type = 0
  },
  {
    name = "moon",
    sprite = "moon",
    color = {3,1}
  },
  {
    name = "text_dust",
    sprite = "text_dust",
    color = {2,3},
    type = 0
  },
  {
    name = "dust",
    sprite = "dust",
    color = {2,3}
  },
  {
    name = "text_rocket",
    sprite = "text_rocket",
    color = {1,3},
    type = 0
  },
  {
    name = "rocket",
    sprite = "rocket",
    color = {1,3},
    rotate = 4
  },
  {
    name = "text_cloud",
    sprite = "text_cloud",
    color = {6,5},
    type = 0
  },
  {
    name = "cloud",
    sprite = "cloud",
    color = {6,5},
  },
  {
    name = "text_rose",
    sprite = "text_rose",
    color = {1,1},
    type = 0
  },
  {
    name = "rose",
    sprite = "rose",
    color = {1,1},
  },
  {
    name = "text_fence",
    sprite = "text_fence",
    color = {2,3},
    type = 0
  },
  {
    name = "fence",
    sprite = "fence",
    color = {2,3},
  },
  {
    name = "text_cliff",
    sprite = "text_cliff",
    color = {2,4},
    type = 0
  },
  {
    name = "cliff",
    sprite = "cliff",
    color = {2,4},
    rotate = 5
  },
  {
    name = "text_sun",
    sprite = "text_sun",
    color = {3,1},
    type = 0
  },
  {
    name = "sun",
    sprite = "sun",
    color = {3,1},
  },
  {
    name = "text_bird",
    sprite = "text_bird",
    color = {2,1},
    type = 0
  },
  {
    name = "bird",
    sprite = "bird",
    color = {2,1},
    rotate = 6
  },
  {
    name = "text_bat",
    sprite = "text_bat",
    color = {7,1},
    type = 0
  },
  {
    name = "bat",
    sprite = "bat",
    color = {7,1},
    rotate = 4
  },
  {
    name = "text_up",
    sprite = "text_up",
    color = {6,5},
    type = 2
  },
  {
    name = "text_yellow",
    sprite = "text_yellow",
    color = {3,1},
    type = 2
  },
  {
    name = "text_gellow",
    sprite = "text_gellow",
    color = {3,2},
    type = 2
  },
  {
    name = "text_green",
    sprite = "text_green",
    color = {5,1},
    type = 2
  },
  {
    name = "text_blue",
    sprite = "text_blue",
    color = {6,1},
    type = 2
  },
  {
    name = "text_purple",
    sprite = "text_purple",
    color = {7,1},
    type = 2
  },
  {
    name = "text_burn",
    sprite = "text_burn",
    color = {2, 1},
    type = 2
  },
  {
    name = "text_only",
    sprite = "text_only",
    color = {1, 3},
    type = 2
  },
  {
    name = "text_moon",
    sprite = "text_moon",
    color = {3,1},
    type = 0
  },
  {
    name = "moon",
    sprite = "moon",
    color = {3,1},
  },
  {
    name = "text_bog",
    sprite = "text_bog",
    color = {5,1},
    type = 0
  },
  {
    name = "bog",
    sprite = "whater",
    color = {5,1},
    rotate = 5
  },
  {
    name = "text_stump",
    sprite = "text_stump",
    color = {2,4},
    type = 0
  },
  {
    name = "stump",
    sprite = "stump",
    color = {2,5}
  },
  {
    name = "text_sj7ll",
    sprite = "text_sj7ll",
    color = {4,4},
    type = 0
  },
  {
    name = "sj7ll",
    sprite = "whater",
    color = {4,4}
  },
  {
    name = "text_make",
    sprite = "text_make",
    color = {5,1},
    type = 1,
  },
  {
    name = "text_write",
    sprite = "text_write",
    color = {1,2},
    type = 1,
    args = {0, 2}
  },
  {
    name = "text_pants",
    sprite = "text_pants",
    color = {6,3},
    type = 0
  },
  {
    name = "pants",
    sprite = "pants",
    color = {6,3},
  },
  {
    name = "text_unmeta",
    sprite = "text_unmeta",
    color = {7,1},
    type = 2
  },
  {
    name = "text_hop",
    sprite = "text_hop",
    color = {6,1},
    type = 2
  },
  {
    name = "bee",
    sprite = "bee",
    color = {3,1},
    rotate = 6
  },
  {
    name = "text_bee",
    sprite = "text_bee",
    color = {3,1},
    type = 0
  },
  {
    name = "shirt",
    sprite = "shirt",
    color = {3,3},
  },
  {
    name = "text_shirt",
    sprite = "text_shirt",
    color = {3,3},
    type = 0
  },
  {
    name = "text_arrow",
    sprite = "text_arrow",
    color = {5,1},
    type = 0
  },
  {
    name = "arrow",
    sprite = "arrow",
    color = {5,1},
    rotate = 4
  },
  {
    name = "text_sleep",
    sprite = "text_sleep",
    color = {6,5},
    type = 2
  },
  {
    name = "text_you2",
    sprite = "text_you2",
    color = {4,4},
    type = 2
  },
  {
    name = "blossom",
    sprite = "blossom",
    color = {1,2},
  },
  {
    name = "text_blossom",
    sprite = "text_blossom",
    color = {1,2},
    type = 0
  },
  {
    name = "calendar",
    sprite = "calendar",
    color = {1,2},
  },
  {
    name = "text_calendar",
    sprite = "text_calendar",
    color = {1,2},
    type = 0
  },
  {
    name = "card",
    sprite = "card",
    color = {1,2},
    rotate = 4
  },
  {
    name = "text_card",
    sprite = "text_card",
    color = {1,2},
    type = 0
  },
  {
    name = "jar",
    sprite = "jar",
    color = {1,2}
  },
  {
    name = "text_jar",
    sprite = "text_jar",
    color = {1,2},
    type = 0
  },
  {
    name = "satelite",
    sprite = "satelite",
    color = {6,5},
    rotate = 4
  },
  {
    name = "text_satelite",
    sprite = "text_satelite",
    color = {6,5},
    type = 0
  },
  {
    name = "planet",
    sprite = "planet",
    color = {4,2},
    rotate = 4
  },
  {
    name = "text_planet",
    sprite = "text_planet",
    color = {4,2},
    type = 0
  },
  {
    name = "text_collect",
    sprite = "text_collect",
    color = {4,4},
    type = 2
  },
  {
    name = "text_select",
    sprite = "text_select",
    color = {3,1},
    type = 2
  },
  {
    name = "pixel",
    sprite = "pixel",
    color = {1,2}
  },
  {
    name = "text_pixel",
    sprite = "text_pixel",
    color = {1,2},
    type = 0
  },
  {
    name = "arc",
    sprite = "arc",
    color = {1,2}
  },
  {
    name = "text_arc",
    sprite = "text_arc",
    color = {1,2},
    type = 0
  },
  {
    name = "dot",
    sprite = "dot",
    color = {1,2}
  },
  {
    name = "text_dot",
    sprite = "text_dot",
    color = {1,2},
    type = 0
  },
  {
    name = "gburble",
    sprite = "gburble",
    color = {4,2}
  },
  {
    name = "text_gburble",
    sprite = "text_gburble",
    color = {4,2},
    type = 0
  },
  {
    name = "guy",
    sprite = "guy",
    color = {1,2},
    rotate = 6
  },
  {
    name = "text_guy",
    sprite = "text_guy",
    color = {1,2},
    type = 0
  },
  {
    name = "ite",
    sprite = "ite",
    color = {7,1},
    rotate = 6
  },
  {
    name = "text_ite",
    sprite = "text_ite",
    color = {7,1},
    type = 0
  },
  {
    name = "lever",
    sprite = "lever",
    color = {1,3},
    rotate = 4
  },
  {
    name = "text_lever",
    sprite = "text_lever",
    color = {1,3},
    type = 0
  },
  {
    name = "line",
    sprite = "line",
    color = {1,2},
    rotate = 5
  },
  {
    name = "text_line",
    sprite = "text_line",
    color = {1,2},
    type = 0
  },
  {
    name = "text_auto",
    sprite = "text_auto",
    color = {4,4},
    type = 2
  },
  {
    name = "text_still",
    sprite = "text_still",
    color = {1,1},
    type = 2
  },
  {
    name = "text_fall",
    sprite = "text_fall",
    color = {2,3},
    type = 2
  },
  {
    name = "wug",
    sprite = "wug",
    color = {4,4},
    rotate = 6
  },
  {
    name = "text_wug",
    sprite = "text_wug",
    color = {4,4},
    type = 0
  },
  {
    name = "text_near",
    sprite = "text_near",
    color = {1,2},
    type = 7
  },
  {
    name = "text_above",
    sprite = "text_above",
    color = {6,5},
    type = 7
  },
  {
    name = "text_below",
    sprite = "text_below",
    color = {6,5},
    type = 7
  },
  {
    name = "fiiiiire",
    sprite = "fiiiiire",
    color = {2,1}
  },
  {
    name = "text_fiiiiire",
    sprite = "text_fiiiiire",
    color = {2,1},
    type = 0
  },
  {
    name = "fish",
    sprite = "fish",
    color = {6,1},
    rotate = 4
  },
  {
    name = "text_fish",
    sprite = "text_fish",
    color = {6,1},
    type = 0
  },
  {
    name = "bell",
    sprite = "bell",
    color = {3,1}
  },
  {
    name = "text_bell",
    sprite = "text_bell",
    color = {3,1},
    type = 0
  },
  {
    name = "orb",
    sprite = "orb",
    color = {4,4}
  },
  {
    name = "text_orb",
    sprite = "text_orb",
    color = {4,4},
    type = 0
  },
  {
    name = "fan",
    sprite = "fan",
    color = {5,3}
  },
  {
    name = "text_fan",
    sprite = "text_fan",
    color = {5,3},
    type = 0
  },
  {
    name = "gem",
    sprite = "gem",
    color = {6,4}
  },
  {
    name = "text_gem",
    sprite = "text_gem",
    color = {6,4},
    type = 0
  },
  {
    name = "bucket",
    sprite = "bucket",
    color = {1,1}
  },
  {
    name = "text_bucket",
    sprite = "text_bucket",
    color = {1,1},
    type = 0
  },
  {
    name = "turtle",
    sprite = "turtle",
    color = {4,5},
    rotate = 6
  },
  {
    name = "text_turtle",
    sprite = "text_turtle",
    color = {4,5},
    type = 0
  },
  {
    name = "lim",
    sprite = "lim",
    color = {6,1},
    rotate = 6
  },
  {
    name = "text_lim",
    sprite = "text_lim",
    color = {6,1},
    type = 0
  },
  {
    name = "bananas",
    sprite = "bananas",
    color = {3,1}
  },
  {
    name = "text_bananas",
    sprite = "text_bananas",
    color = {3,1},
    type = 0
  },
  {
    name = "text_eat",
    sprite = "text_eat",
    color = {1,1},
    type = 1
  },
  {
    name = "text_y",
    sprite = "text_y",
    color = {1,2},
    type = 5
  },
  {
    name = "text_o",
    sprite = "text_o",
    color = {1,2},
    type = 5
  },
  {
    name = "text_u",
    sprite = "text_u",
    color = {1,2},
    type = 5
  },
  {
    name = "text_old",
    sprite = "text_old",
    color = {7,5},
    type = 2
  },
  {
    name = "text_cursor",
    sprite = "text_cursor",
    color = {3,1},
    type = 0
  },
  {
    name = "cursor",
    sprite = "cursor",
    color = {6,4}
  },
  {
    name = "text_pull",
    sprite = "text_pull",
    color = {2,3},
    type = 2
  },
  {
    name = "all",
    sprite = "all",
    color = {1,2},
    rotate = 4
  },
  {
    name = "text",
    sprite = "text",
    color = {4,4}
  },
  {
    name = "icon",
    sprite = "icon",
    color = {1,1}
  },
  {
    name = "group",
    sprite = "group",
    color = {5,1},
    rotate = 4
  },
  {
    name = "clipboard",
    sprite = "clipboard",
    color = {1,2}
  },
  {
    name = "this",
    sprite = "this",
    color = {1,2}
  },
  {
    name = "text_monster",
    sprite = "text_monster",
    color = {3,1},
    type = 0
  },
  {
    name = "monster",
    sprite = "monster",
    color = {3,1},
    rotate = 4
  },
  {
    name = "text_monitor",
    sprite = "text_monitor",
    color = {1,3},
    type = 0
  },
  {
    name = "monitor",
    sprite = "monitor",
    color = {1,3}
  },
  {
    name = "text_question",
    sprite = "text_question",
    color = {1,2},
    type = 0
  },
  {
    name = "question",
    sprite = "question",
    color = {1,2}
  },
  {
    name = "text_question",
    sprite = "text_question",
    color = {1,2},
    type = 0
  },
  {
    name = "question",
    sprite = "question",
    color = {1,2}
  },
  {
    name = "text_but",
    sprite = "text_but",
    color = {1,2},
    type = 7
  },
  {
    name = "text_correct",
    sprite = "text_correct",
    color = {4,1},
    type = 0
  },
  {
    name = "correct",
    sprite = "correct",
    color = {4,1}
  },
  {
    name = "text_horse",
    sprite = "text_horse",
    color = {2,4},
    type = 0
  },
  {
    name = "horse",
    sprite = "horse",
    color = {2,4},
    rotate = 6
  },
  {
    name = "text_battery",
    sprite = "text_battery",
    color = {5,1},
    type = 0
  },
  {
    name = "battery",
    sprite = "battery",
    color = {5,1}
  },
  {
    name = "text_staple",
    sprite = "text_staple",
    color = {1,3},
    type = 0
  },
  {
    name = "staple",
    sprite = "staple",
    color = {1,3}
  },
  {
    name = "text_mountain",
    sprite = "text_mountain",
    color = {6,5},
    type = 0
  },
  {
    name = "mountain",
    sprite = "mountain",
    color = {6,5}
  },
  {
    name = "text_textof",
    sprite = "text_textof",
    color = {4,4},
    type = 9
  },
  {
    name = "text_uncopy",
    sprite = "text_uncopy",
    color = {7,1},
    type = 2
  },
  {
    name = "text_incorrect",
    sprite = "text_incorrect",
    color = {1,1},
    type = 0
  },
  {
    name = "incorrect",
    sprite = "incorrect",
    color = {1,1}
  },
  {
    name = "text_heavy",
    sprite = "text_heavy",
    color = {7,4},
    type = 2
  },
  {
    name = "text_oneway",
    sprite = "text_oneway",
    color = {5,1},
    type = 2
  },
  {
    name = "text_reset",
    sprite = "text_reset",
    color = {6,5},
    type = 2
  },
  {
    name = "text_set",
    sprite = "text_set",
    color = {6,5},
    type = 2
  },
  {
    name = "text_shift",
    sprite = "text_shift",
    color = {6,1},
    type = 2
  },
  --[[
  {
    name = "text_word",
    sprite = "text_word",
    color = {1,2},
    type = 2
  },]]
  {
    name = "text_link",
    sprite = "text_link",
    color = {4,1},
    type = 2
  },
  {
    name = "text_big",
    sprite = "text_big",
    color = {3,1},
    type = 2
  },
  {
    name = "text_random",
    sprite = "text_random",
    color = {4,2},
    type = 2
  },
  {
    name = "text_axe",
    sprite = "text_axe",
    color = {6,1},
    type = 0
  },
  {
    name = "axe",
    sprite = "axe",
    color = {6,1}
  },
  {
    name = "text_pick",
    sprite = "text_pick",
    color = {6,1},
    type = 0
  },
  {
    name = "pick",
    sprite = "pick",
    color = {6,1}
  },
  {
    name = "text_sword",
    sprite = "text_sword",
    color = {6,1},
    type = 0
  },
  {
    name = "mathdotsinxword",
    sprite = "mathdotsinxword",
    color = {6,1}
  },
  {
    name = "text_mathdotsinxword",
    sprite = "text_mathdotsinxword",
    type = 0,
    color = {6,1}
  },
  {
    name = "sword",
    sprite = "sword",
    color = {6,1}
  },
  {
    name = "text_57",
    sprite = "text_57",
    color = {3,3},
    type = 0
  },
  {
    name = "57",
    sprite = "57 copy",
    color = {3,3}
  },
  {
    name = "text_57",
    sprite = "text_57",
    color = {3,3},
    type = 0
  },
  {
    name = "log",
    sprite = "log",
    color = {2,4}
  },
  {
    name = "text_log",
    sprite = "text_log",
    color = {2,4},
    type = 0
  },
  {
    name = "text_starts",
    sprite = "text_starts",
    color = {1,2},
    type = 7,
    args = {5,0, 1, 2, 3, 4 ,6.7,7,'57yw ruwr '}
  },
  {
    name = "text_contains",
    sprite = "text_contains",
    color = {1,2},
    type = 7,
    args = {5,0, 1, 2, 3, 4 ,6.7,7,'57yw ruwr '}
  },
  {
    name = "text_ends",
    sprite = "text_ends",
    color = {1,2},
    type = 7,
    args = {5,0, 1, 2, 3, 4 ,6.7,7,'57yw ruwr '}
  },
  {
    name = "text_without",
    sprite = "text_without",
    color = {1,2},
    type = 7,
  },
  {
    name = "text_feeling",
    sprite = "text_feeling",
    color = {1,2},
    type = 7,
    args = {2}
  },
  {
    name = "text_path",
    sprite = "text_path",
    color = {2,3},
    type = 2,
  },
  {
    name = "text_right",
    sprite = "text_right",
    color = {6,5},
    type = 2,
  },
  {
    name = "text_left",
    sprite = "text_left",
    color = {6,5},
    type = 2,
  },
  {
    name = "text_down",
    sprite = "text_down",
    color = {6,5},
    type = 2,
  },
  {
    name = "text_hand",
    sprite = "text_hand",
    color = {6,5},
    type = 0
  },
  {
    name = "hand",
    sprite = "hand",
    color = {6,5},
    rotate = 4
  },
  {
    name = "text_eye",
    sprite = "text_eye",
    color = {6,5},
    type = 0
  },
  {
    name = "eye",
    sprite = "eye",
    color = {6,5},
    rotate = 4
  },
  {
    name = "text_sqrt9",
    sprite = "text_sqrt9",
    color = {7,3},
    type = 0
  },
  {
    name = "sqrt9",
    sprite = "sqrt9",
    color = {7,3},
    type = 5
  },
  {
    name = "text_file",
    sprite = "text_file",
    color = {1,2},
    type = 0
  },
  {
    name = "file",
    sprite = "file",
    color = {1,2} --why was this 7,3 !??!>?>!>
  },
  {
    name = "text_ba",
    sprite = "text_ba",
    type = 5,
    color = {4,4}
  },
  {
    name = "text_chair",
    sprite = "text_chair",
    type = 0,
    color = {2,3}
  },
  {
    name = "chair",
    sprite = "chair",
    color = {2,3}
  },
  {
    name = "text_3dollars",
    sprite = "text_3dollars",
    type = 0,
    color = {5,1}
  },
  {
    name = "3dollars",
    sprite = "3dollars",
    color = {5,1}
  },
  {
    name = "text_ring",
    sprite = "text_ring",
    type = 0,
    color = {3,1}
  },
  {
    name = "ring",
    sprite = "ring",
    color = {3,1}
  },
  {
    name = "text_pink",
    sprite = "text_pink",
    type = 2,
    color = {4,4}
  },
  {
    name = "lemon",
    sprite = "lemon",
    color = {2,1}
  },
  {
    name = "text_lemon",
    sprite = "text_lemon",
    color = {2,1},
    type = 0
  },
  {
    name = "prize",
    sprite = "prize",
    color = {1,1}
  },
  {
    name = "text_prize",
    sprite = "text_prize",
    color = {1,1},
    type = 0
  },
  {
    name = "car",
    sprite = "car",
    color = {1,1},
    rotate = 4
  },
  {
    name = "text_car",
    sprite = "text_car",
    color = {1,1},
    type = 0
  },
  {
    name = "text_poof",
    sprite = "text_poof",
    color = {1,2},
    type = 2
  },
  {
    name = "jsdhgous",
    sprite = "jsdhgous",
    color = {2,1},
    rotate = -999
  },
  {
    name = "text_jsdhgous",
    sprite = "text_jsdhgous",
    color = {2,1},
    type = 0
  },
  {
    name = "text_hide",
    sprite = "text_hide",
    color = {6,3},
    type = 2
  },
  {
    name = "seastar",
    sprite = "seastar",
    color = {2,1},
  },
  {
    name = "text_seastar",
    sprite = "text_seastar",
    color = {2,1},
    type = 0
  },
  {
    name = "lock",
    sprite = "lock",
    color = {1,4},
  },
  {
    name = "text_lock",
    sprite = "text_lock",
    color = {1,4},
    type = 0
  },
  {
    name = "abba",
    sprite = "abba",
    color = {1,2},
    rotate = 6
  },
  {
    name = "text_abba",
    sprite = "text_abba",
    color = {1,2},
    type = 0
  },
  {
    name = "cucucu",
    sprite = "cucucu",
    color = {1,2},
    rotate = 6
  },
  {
    name = "text_cucucu",
    sprite = "text_cucucu",
    color = {1,2},
    type = 0
  },
  {
    name = "wheel",
    sprite = "wheel",
    color = {1,1}
  },
  {
    name = "text_wheel",
    sprite = "text_wheel",
    color = {1,1},
    type = 0
  },
  {
    name = "choose",
    sprite = "choose",
    color = {1,2}
  },
  {
    name = "text_choose",
    sprite = "text_choose",
    color = {1,2},
    type = 0
  },
  {
    name = "text_the",
    sprite = "text_the",
    color = {1,2},
    type = 3
  },
  {
    name = "text_yes",
    sprite = "text_yes",
    color = {4,1},
    type = 3
  },
  {
    name = "text_none",
    sprite = "text_none",
    color = {1,2},
    type = -5
  },
  {
    name = "stack",
    sprite = "stack",
    color = {1,2}
  },
  {
    name = "text_stack",
    sprite = "text_stack",
    color = {1,2},
    type = 0
  },
  {
    name = "text_particle",
    sprite = "text_particle",
    color = {3,1},
    type = 0
  },
  {
    name = "particle",
    sprite = "particle",
    color = {3,1}
  },
  {
    name = "text_facing",
    sprite = "text_facing",
    color = {1,2},
    type = 7
  },
}

local bonusletters = {"c","d","e","f","g","h","j","k","l","m","n","p","r","t","v","w","x","z","upsilon","0","1","2","3","4","5","6","7","8","9","ch","dollars"}
for i, j in ipairs(bonusletters) do
  table.insert(objectValues, {
    name = "text_" .. j,
    sprite = "text_" .. j,
    color = {1,2},
    type = 5
  })
end

betterObjectValues = {}
for i,j in ipairs(objectValues)do
 betterObjectValues[j.name] = j
end
alias = {}
alias["wupsilong"] = "wug"
alias["sqrt9dollars"] = "3dollars"
alias["water"] = "whater"
alias["walter"] = "whater"
alias["hrrkrkrkrwpfrbrbrbrlablblblblblblblwhitooap"] = "poof"
alias["aaaaaaajjjjjjjjj"] = "poof"

letterreplacements = {}
letterreplacements["sqrt9"] = "3"
letterreplacements["question"] = "?"
