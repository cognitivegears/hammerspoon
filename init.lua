_G.hs = hs

-- One-time check at startup: unzip FnMate if not already unzipped
if not hs.fs.pathToAbsolute(hs.configdir .. "/Spoons/FnMate.spoon") then
    local zipPath = hs.configdir .. "/SpoonsRepository/Spoons/FnMate.spoon.zip"
    if hs.fs.pathToAbsolute(zipPath) then
        hs.alert.show("Unzipping FnMate spoon...")
        local unzipCmd = string.format("unzip -q -o %s/SpoonsRepository/Spoons/FnMate.spoon.zip -d %s/Spoons", hs.configdir, hs.configdir)
        print("Unzip command: " .. unzipCmd)
        local output = hs.execute(unzipCmd)
        if output then
            hs.alert.show("FnMate spoon unzipped successfully")
        else
            hs.alert.show("Failed to unzip FnMate spoon")
        end
    else
        print("FnMate spoon zip file not found. Skipping unzipping.")
    end
end

-- Initialize FnMate spoon if it exists
if hs.fs.pathToAbsolute(hs.configdir .. "/Spoons/FnMate.spoon") then
    hs.loadSpoon("FnMate")
else
    print("FnMate spoon not found; skipping hs.loadSpoon.")
end

-- define hyper key
local hyper = { "cmd", "alt", "ctrl", "shift" }
hs.hotkey.bind(hyper, "tab", function()
	local win = hs.window.focusedWindow()
	-- This is a Shortcut to quickly capture an idea with Obsidian key
	hs.shortcuts.run("Capture Idea")
	win:focus()
end)

hs.hotkey.bind(hyper, "`", function()
	local win = hs.window.focusedWindow()
	-- This is a Shortcut to make a daily log entry with Obsidian
	hs.shortcuts.run("Personal Log")
	win:focus()
end)

hs.hotkey.bind(hyper, "e", function()
	-- Launch email
	hs.application.launchOrFocus("Mail.app")
end)

hs.hotkey.bind(hyper, "b", nil, function()
	local app = hs.application.frontmostApplication()
	if app:title() == "Zen Browser" then
		-- If it's already running, bring up the bookmark bar
		-- Shorter delay to avoid repeat
		hs.eventtap.keyStroke({ "cmd" }, "b", 100000)
	else
		hs.application.launchOrFocus("Zen Browser.app")
	end
end)

hs.hotkey.bind(hyper, "y", function()
	-- Quick way to toggle the Hammerspoon console for debugging
	hs.toggleConsole()
end)

hs.hotkey.bind(hyper, "space", function()
	-- Launch my terminal
	local app = hs.application.frontmostApplication()
	if app:title() == "kitty" then
		-- If it's already running, start a new window
		-- Shorter delay to avoid repeat
		hs.eventtap.keyStroke({ "cmd" }, "n", 100000)
	else
		hs.application.launchOrFocus("Kitty.app")
	end
end)

hs.hotkey.bind(hyper, "c", function()
	-- Hotkey for visual studio code
	hs.application.launchOrFocus("Visual Studio Code.app")
end)

hs.hotkey.bind(hyper, "r", function()
	-- Good for debugging, reload the Hammerspoon configuration
	hs.reload()
end)

hs.hotkey.bind({ "cmd" }, "l", function()
	-- Lock my screen
	hs.caffeinate.lockScreen()
end)

hs.hotkey.bind(hyper, "v", function()
	-- This allows me to force paste my clipboard as plain text
	-- emulating keystrokes so the application doesn't know any different
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
