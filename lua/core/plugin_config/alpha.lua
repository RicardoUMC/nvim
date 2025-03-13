local alpha = require("alpha")

local theta = require("alpha.themes.theta")
theta.header.val = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
}

local dashboard = require("alpha.themes.dashboard")
theta.buttons.val = {
	{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
	{ type = "padding", val = 1 },
	dashboard.button("e", "  New file", "<cmd>ene<CR>"),
	dashboard.button("SPC SPC", "󰊄  Recently opened files"),
	dashboard.button("SPC p f", "󰈞  Find file"),
	dashboard.button("SPC p s", "󰈬  Find word"),
	dashboard.button("SPC s l", "  Open last session", "<cmd>cd stdpath('Local')<CR>"),
	dashboard.button("u", "  Update plugins", "<cmd>Pckr sync<CR>"),
	dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
}

alpha.setup(theta.config)
