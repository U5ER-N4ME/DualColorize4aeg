--[[

Licence by WTFPL

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.

]]

-- 照葫芦画瓢，出什么BUG都不意外
-- copy & paste, BUG contributor

local tr = aegisub.gettext -- idk the meaning, just copy...

-- just simply modified. see: https://aegi.vmoe.info/docs/3.2/Automation/Lua/Registration/
script_name = tr"Dual Colorize"
script_description = tr"Dual colorize subtitles"
script_author = "U5ER-N4ME"
script_version = "0.1"

-- use aegisub.unicode. see: https://aegi.vmoe.info/docs/3.2/Automation/Lua/Modules/unicode/
unicode = require 'aegisub.unicode'

--[[
	function
	@name: dual_colarizes
	@note: copied & modified from macro-1-edgeblur.lua
]]
function dual_colorize(subtitles, selected_lines, active_line)

	for z, i in ipairs(selected_lines) do
		-- idk why, just copy & modify till works
		local l = subtitles[i]
		local m = subtitles[i]
		m.text = ""

		--[[
		for j = 1, string.len(l.text), 6 do
			m.text = m.text .. "{\\c&HFFCC66&}" .. string.sub(l.text, j, j+2)
			m.text = m.text .. "{\\c&H0000FF&}" .. string.sub(l.text, j+3, j+5)
		end -- end for
		]] -- abandoned

		local flag = 0 -- mark for colors

		for char in unicode.chars(l.text) do -- aegisub.unicode, for each character
			-- if bg required, add \\4cH954F4D
			if flag == 0 then
				m.text = m.text .. "{\\c&HD6C7F3&}" .. char -- pink
				flag = 1
			else
				m.text = m.text .. "{\\c&HFBE0D3&}" .. char -- blue
				flag = 0
			end -- end if
		end -- end for
		subtitles[i] = m -- return to subtitles
	end -- end for
	aegisub.set_undo_point(script_name) -- allow undo (I guess...)
end -- end func

-- reg macro to aegisub
aegisub.register_macro(script_name, script_description, dual_colorize)