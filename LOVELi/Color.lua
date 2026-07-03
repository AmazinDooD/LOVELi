-- MIT License
-- 
-- Copyright (c) 2025 mtanksl
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell		
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

LOVELi.Color = {}
LOVELi.Color.__index = LOVELi.Color
function LOVELi.Color:new(red, green, blue, alpha) -- LOVELi.Color LOVELi.Color:new(float red = 0, float green = 0, float blue = 0, float alpha = 1)
	local o = { 
		red = red or 0, 
		green = green or 0, 
		blue = blue or 0, 
		alpha = alpha or 1
	}	
	setmetatable(o, self)
	return o
end
function LOVELi.Color:getred()
	return self.red
end
function LOVELi.Color:getgreen()
	return self.green
end
function LOVELi.Color:getblue()
	return self.blue
end
function LOVELi.Color:getalpha()
	return self.alpha
end
function LOVELi.Color:getrgba()
	return self.red, self.green, self.blue, self.alpha
end	
function LOVELi.Color:type()
	return "Color"
end
function LOVELi.Color.parse(value) -- static
	local red
	local green
	local blue
	local alpha
	if type(value) == "number" then
		red = (math.floor(value / 16777216) % 256) / 255
		green = (math.floor(value / 65536) % 256) / 255
		blue = (math.floor(value / 256) % 256) / 255 
		alpha = (value % 256) / 255
	elseif type(value) == "string" then
		if value:sub(0,1) == "#" then
			-- If the string has length 9, then it has an alpha component ("#rrggbbaa") as opposed to it having 7 length ("#rrggbb") 
			local has_alpha = (#value == 9)
			red, green, blue =
				tonumber(value:sub(2, 3), 16),
				tonumber(value:sub(4, 5), 16),
				tonumber(value:sub(6, 7), 16)

			if has_alpha then
				alpha = tonumber(value:sub(8, 9), 16)
			else
				alpha = 1
			end
		else
			-- Colour name parsing
			local colors = {
				red = {1,0,0},
				green = {0,1,0},
				blue = {0,0,1},
				cyan = {0,1,1},
				magenta = {1,0,1},
				yellow = {1,1,0},
				grey = {0.5,0.5,0.5},
				gray = {0.5,0.5,0.5},
				white = {1,1,1},
				black = {0,0,0},
				-- Some extra colours :)
				cobaltblue = {0,0.3,0.7},
				purple = {0.3,0,0.7},
				orange = {0.7,0.3,0},
				pink = {0.7,0,0.3},
				mint = {0,0.7,0.3},
				lime = {0.3,0.7,0},
			}

			-- Check if colour is in the above table
			local rgba_table = colors[value] or {}

			if next(rgba_table) ~= nil then
				rgba_table[4] = rgba_table[4] or 1

				red, green, blue, alpha = unpack(rgba_table)
			else
				-- If colour isn't valid, default to black
				red, green, blue, alpha = 0,0,0,1
			end
				
	elseif type(value) == "table" then
		red = value.red
		green = value.green
		blue = value.blue
		alpha = value.alpha	
	end
	return LOVELi.Color:new(red, green, blue, alpha)
end
