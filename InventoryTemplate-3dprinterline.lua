SCREEN_TITLE = "3D Printer Line 1"
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- each item name -> item mass entry in unit_mass_table must have 
-- corresponding item name -> container in unit_container_map
unit_mass_table = {basic_injector = 20.30,
				uncommon_injector = 20.50,
				advanced_injector = 20.45,
				carbon_fiber = 1.5,
				basic_fixation = 1.12,
				uncommon_fixation = 1.16,
				advanced_fixation = 1.21,
}
unit_container_map = { basic_injector = basic_injector_container,
    				uncommon_injector = uncommon_injector_container,
    				advanced_injector = advanced_injector_container,
    				carbon_fiber = carbon_fiber_container,
    				basic_fixation = basic_fixation_container,
    				uncommon_fixation = uncommon_fixation_container,
    				advanced_fixation = advanced_fixation_container 
				}

stock_table = {}
local stock_value = 0
for item, unit_mass in pairs(unit_mass_table) do
    stock_value = unit_container_map[item].getItemsMass() / unit_mass_table[item]
    stock_table[item] = stock_value
end

local html_preamble = [[
<div class="bootstrap">
<h1 style="
	font-size: 6em;
">TACO CORP INVENTORY</h1>
<h1 style="
	font-size: 4em;
">]]..SCREEN_TITLE..[[</h1>
<table 
style="
	margin-top: 5px;
	margin-left: auto;
	margin-right: auto;
	width: 80%;
	font-size: 4em;
">
	</br>
	<tr style="
		width: 100%;
		margin-bottom: 30px;
		background-color: green;
		color: white;
	">
		<th>Item</th>
		<th>Qty</th>
	]]

local html_table = ""
for name, stock in pairs(stock_table) do
     html_table = html_table .. [[
	<tr>
		<th>]]..name..[[</th>
		<th>]]..math.floor(stock)..[[</th>
	</tr>]]
end

local html_conclusion = [[
</table>
</div>
]]
local html = ""
html = html_preamble .. html_table .. html_conclusion
screen1.setHTML(html)   