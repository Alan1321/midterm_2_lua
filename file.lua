local json = require( "json" )
local csv = require("csv")

function readFile(fileName, data_type)
    --fileName --> json.json/json1.json
    local defaultLocation = system.DocumentsDirectory
    local path = system.pathForFile( fileName, loc )
    local file, errorString = io.open( path, "r" )

    local contents = file:read( "*a" )
    local data
    if(data_type == "json") then
        local t = json.decode( contents )
        data = t
    else
        data = contents
        print(type(data))
    end
    io.close(file)
    return data
end

function writeFile(fileName, t, data_type)
    --fileName - Name of File, ex -- json2.json
    -- t - Table data which will be exported as .json
    local path2 = system.pathForFile( fileName, loc )
    local file2, errorString2 = io.open(path2, "w")
    if(data_type == "json") then
        file2:write( json.encode( t ) )
    else
        file2:write( t )
    end
    io.close(file2)
end

function printData(t, data_type)
    if(data_type == "json") then
        for k, v in pairs(t) do
            print(k, v)
            for i, j in pairs(v) do
                print(i,j)
            end
        end
    else
        print(t)
        print(type(t))
    end
end

function readCSV(fileName)
    local path = system.pathForFile(fileName)
    local f = csv.open(path,{separator = ",", header = false})
    -- for fields in f:lines() do
    --     for i, v in ipairs(fields) do print(i, v) end
    -- end
    return f
end

function getMaxMin(fileName)
    -- local maxMileage, minMileage;
    -- local maxWeight, minWeight;
    -- local maxDisp, minDisp;
    -- local path = system.pathForFile(fileName)
    -- local f = csv.open(path,{separator = ",", header = false})
    -- for fields in f:lines() do
    --     for i, v in ipairs(fields) do print(i, v) end
    -- end
end

function writeCSV(f, filename)
    local str = ""
    for fields in f:lines() do
        for i, v in ipairs(fields) do 
            if (i <= 3) then
                str = str .. v .. ","
            else
                str = str .. v
            end
        end
        str = str .. "\n"
    end
    writeFile(filename, str, "csv")
end

function printCSV(f)
    for fields in f:lines() do
        for i, v in ipairs(fields) do print(i, v) end
    end
end

return {
    readCSV = readCSV, 
    readFile = readFile, 
    writeFile = writeFile, 
    printData = printData,
    printCSV = printCSV,
    writeCSV = writeCSV,
    getMaxMin = getMaxMin
}