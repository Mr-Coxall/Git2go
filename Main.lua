-- Git2go

-- Use this function to perform your initial setup
function setup()
    print("Hello World!")
    theAssetList = assetList("Project")
    
    --icon = makeIcon("Git2go", "description")
    --saveImage( "Project:Icon", icon )
    print(readProjectPlist("Git2go"))
    
    for count = 1, #theAssetList do
        print (theAssetList[count])
    end
    
    
    -- Load high score
    -- Defaults to 0 if it doesnt exist
    print(readLocalData("highscore", 0))

    -- Save high score
 --saveLocalData("highscore", 5)
   -- print(readLocalData("highscore", 0))
    --saveLocalData("highscore", 0)
end

function readProjectFile(project, name, warn)
    local path = os.getenv("HOME") .. "/Documents/"
    local file = io.open(path .. project .. ".codea/" .. name,"r")
    if file then
        local plist = file:read("*all")
        file:close()
        return plist
    elseif warn then
        print("WARNING: unable to read " .. name)
    end
end

function readProjectPlist(project)
    return readProjectFile(project, "Info.plist", true)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)

    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    sprite("Project:scout")
    sprite("Project:sfx")
    
end


function makeIcon(name, description, col, ext)
    if ext then
        mfont = ext.font
        desctype = (tostring(ext.type)):upper()
        bgcol = ext.background
    end
    local size = 122
    local im = image(size, size)
    setContext(im)

    noSmooth()

    strokeWidth(1/ ContentScaleFactor)
    stroke(255, 255, 255, 255)
    fill(bgcol or color(255,255,255))
    local rmode = rectMode()
    rectMode(CORNER)
    rect(0, 0, size, size)

    --background(255)

    stroke(0)
    fill(col or color(127, 127, 127, 255))

    strokeWidth(1)

    local tmode = textMode()

    textMode(CORNER)

    font(mfont or "HelveticaNeue-Bold")
    fontSize(42 * size / 256)

    local tWrap = textWrapWidth()

    textWrapWidth(size - 10)

    local w, h = textSize(name)

    text(name, 5, size - 5 - h)

    if description then
        if description:find("LIBRARY") or desctype == "LIBRARY" then --Library File
            fill(0, 0, 255, 127)
        elseif description:find("TESTING") or desctype == "TESTING" then --Testing File
            fill(255, 128, 0, 127)
        elseif description:find("UTILITY") or desctype == "UTILITY" then --Utility Program
            fill(255, 0, 0, 127)
        elseif description:find("OBSOLETE") or desctype == "OBSOLETE" then --Utility Program
            fill(113, 31, 31, 127)
        elseif description:find("FORUM") or desctype == "FORUM" then --Utility Program
            fill(26, 151, 26, 127)
        elseif description:upper() ~= description then --General Description
            fill(0, 0, 0, 127)
        else
            fill(255, 0, 0, 127) --Specs
        end
        fontSize(32 * size / 256)
        text(description, 5, 5)
    end

    setContext()

    textWrapWidth(tWrap)

    textMode(tmode)

    rectMode(rmode)

    return im
end


