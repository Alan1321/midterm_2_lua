------------------------------------------
widget = require( "widget" )
local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

composer.gotoScene("scene1")
----------------------------------------------
-- local json = require( "json" )
-- local csv = require("csv")
-- local file = require("file")

-- local data = file.readCSV("csv1.csv")
-- file.writeCSV(data, "csv2.csv")
-- local data = readFile("json1.json", "json")
-- writeFile("json2.json", data, "json")
-- printData(data, "csv")
