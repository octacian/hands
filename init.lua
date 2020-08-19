-- hands/init.lua
hands = {}

-- [api] register hand
function hands.register_hand(handstring, def)
  if not handstring then return minetest.log("[hands] missing handstring") end

  minetest.register_item(handstring, {
    type = "none",
    wield_image = def.wield_image or "hands_hand.png",
    wield_scale = def.wield_scale or {x=1,y=1,z=2.5},
    tool_capabilities = def.tool_capabilities or {
  		full_punch_interval = 0.9,
  		max_drop_level = 0,
  		groupcaps = {
  			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
  			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
  			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
  		},
  		damage_groups = {fleshy=1},
  	}
  })
end

-- [priv] sethand
minetest.register_privilege("sethand", "Player can set their own hand.")

-- [command] set hand
minetest.register_chatcommand("sethand", {
  privs = { sethand = true },
  params = "<new_hand> | itemstring",
  description = "Change player's hand.",
  func = function(name, param)
    local player = minetest.get_player_by_name(name)

    -- if not param, return to default hand
    if not param or param == "" then
      player:get_inventory():set_size("hand", 0)
      return true, "Set to default hand"
    end

    player:get_inventory():set_size("hand", 1)
    player:get_inventory():set_stack("hand", 1, param)
    return true, "Set hand to "..param
  end,
})

dofile(minetest.get_modpath("hands").."/hands.lua") -- load hands
