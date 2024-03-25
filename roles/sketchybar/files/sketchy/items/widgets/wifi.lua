local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 2.0 seconds.
sbar.exec("killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 2.0")

local popup_width = 450

local wifi_up = sbar.add("item", "widgets.wifi1", {
  position = "right",
  padding_left = -5,
  width = 0,
  icon = {
    padding_right = 0,
    font = {
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = icons.wifi.upload,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.red,
    string = "??? Bps",
  },
  y_offset = 4,
})

local wifi_down = sbar.add("item", "widgets.wifi2", {
  position = "right",
  padding_left = -5,
  icon = {
    padding_right = 0,
    font = {
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = icons.wifi.download,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.blue,
    string = "??? Bps",
  },
  y_offset = -4,
})

local wifi = sbar.add("item", "widgets.wifi.padding", {
  position = "right",
  label = { drawing = false },
})

-- Background around the item
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
  wifi.name,
  wifi_up.name,
  wifi_down.name
}, {
  background = { color = colors.bg1 },
  popup = { align = "center", height = 30 }
})

local ssid = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    font = {
      style = settings.font.style_map["Bold"]
    },
    string = icons.wifi.router,
  },
  width = popup_width,
  align = "center",
  label = {
    font = {
      size = 15,
      style = settings.font.style_map["Bold"]
    },
    max_chars = 18,
    string = "????????????",
  },
  background = {
    height = 2,
    color = colors.grey,
    y_offset = -15
  }
})

local hostname = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Hostname:",
    width = popup_width / 2,
  },
  label = {
    max_chars = 20,
    string = "????????????",
    width = popup_width / 2,
    align = "right",
  }
})

local ip = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "IP:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  }
})

local router = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Router:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  },
})

local ipv6 = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "IPv6:",
    width = popup_width / 2,
  },
  label = {
    string = "????:????:????:????:????:????:????:????",
    width = popup_width / 2,
    align = "right",
  },
})

local router_ipv6 = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Router IPv6:",
    width = popup_width / 2,
  },
  label = {
    string = "????:????:????:????:????:????:????:????",
    width = popup_width / 2,
    align = "right",
  },
})


sbar.add("item", { position = "right", width = settings.group_paddings })

wifi_up:subscribe("network_update", function(env)
  local up_color = (env.upload == "000 Bps") and colors.grey or colors.red
  local down_color = (env.download == "000 Bps") and colors.grey or colors.blue
  wifi_up:set({
    icon = { color = up_color },
    label = {
      string = env.upload,
      color = up_color
    }
  })
  wifi_down:set({
    icon = { color = down_color },
    label = {
      string = env.download,
      color = down_color
    }
  })
end)

wifi:subscribe({"wifi_change", "system_woke"}, function(env)
  sbar.exec("ipconfig getifaddr en0", function(ip)
    local connected = not (ip == "")
    wifi:set({
      icon = {
        string = connected and icons.wifi.connected or icons.wifi.disconnected,
        color = connected and colors.white or colors.red,
      },
    })
  end)
end)

local function hide_details()
  wifi_bracket:set({ popup = { drawing = false } })
end

local function prefix_length_of_octet(x)
  local ret = ""

	while x~=1 and x~=0 do
		ret = tostring(x%2) .. ret
		x = math.modf(x/2)
	end

	ret = tostring(x) .. ret
	local _, count = ret:gsub("1", "")
  return count
end

local function toggle_details()
  local should_draw = wifi_bracket:query().popup.drawing == "off"
  if should_draw then
    wifi_bracket:set({ popup = { drawing = true }})
    sbar.exec("hostname -f", function(result)
      hostname:set({ label = result })
    end)
    sbar.exec("ipconfig getifaddr en0", function(address)
      sbar.exec("ipconfig getsummary en0 | awk '/subnet_mask/{print $3}'", function(mask)
        local octets = {mask:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
        local prefixLength = 0

        for _, octet in ipairs(octets) do
          prefixLength = prefixLength + prefix_length_of_octet(octet)
        end

        ip:set({ label = address .. "/" .. prefixLength})
      end)
    end)
    sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
      ssid:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
      router:set({ label = result })
    end)
    sbar.exec("ipconfig getv6packet en0 | awk '/IAADDR/{print $6}'", function(result)
      ipv6:set({ label = result })
    end)
    sbar.exec("ipconfig getra en0 | awk '/rdnss/{print $10}'", function(result)
      router_ipv6:set({ label = result })
    end)
  else
    hide_details()
  end
end

wifi_up:subscribe("mouse.clicked", toggle_details)
wifi_down:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec("echo \"" .. label .. "\" | pbcopy")
  sbar.set(env.NAME, { label = { string = icons.clipboard, align="center" } })
  sbar.delay(1, function()
    sbar.set(env.NAME, { label = { string = label, align = "right" } })
  end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
ipv6:subscribe("mouse.clicked", copy_label_to_clipboard)
router_ipv6:subscribe("mouse.clicked", copy_label_to_clipboard)
