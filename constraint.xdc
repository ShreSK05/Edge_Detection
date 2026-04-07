############################################################
# CLOCK 100 MHz
############################################################

set_property PACKAGE_PIN E3 [get_ports clk100]
set_property IOSTANDARD LVCMOS33 [get_ports clk100]
create_clock -period 10.0 [get_ports clk100]


############################################################
# RESET BUTTON (BTNC)
############################################################

set_property PACKAGE_PIN C12 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


############################################################
# VGA HSYNC
############################################################

set_property PACKAGE_PIN B11 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]


############################################################
# VGA VSYNC
############################################################

set_property PACKAGE_PIN B12 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]


############################################################
# VGA RED
############################################################

set_property PACKAGE_PIN A3 [get_ports {red[0]}]
set_property PACKAGE_PIN B4 [get_ports {red[1]}]
set_property PACKAGE_PIN C5 [get_ports {red[2]}]
set_property PACKAGE_PIN A4 [get_ports {red[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {red[*]}]


############################################################
# VGA GREEN
############################################################

set_property PACKAGE_PIN C6 [get_ports {green[0]}]
set_property PACKAGE_PIN A5 [get_ports {green[1]}]
set_property PACKAGE_PIN B6 [get_ports {green[2]}]
set_property PACKAGE_PIN C7 [get_ports {green[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {green[*]}]


############################################################
# VGA BLUE
############################################################

set_property PACKAGE_PIN B7 [get_ports {blue[0]}]
set_property PACKAGE_PIN A6 [get_ports {blue[1]}]
set_property PACKAGE_PIN B8 [get_ports {blue[2]}]
set_property PACKAGE_PIN C9 [get_ports {blue[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {blue[*]}]