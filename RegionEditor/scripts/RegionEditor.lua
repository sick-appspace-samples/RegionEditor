--Start of Global Scope---------------------------------------------------------

-- Creating viewer instance
local viewer = View.create()
viewer:setID('viewer2D')

-- Creating background image
local img = Image.create(1000, 1000, 'UINT8')
img:multiplyAddConstantInplace(1, 150)

-- Creating rectangle
local pt1 = Point.create(500, 250)
local rectangle = Shape.createRectangle(pt1, 400, 200)

-- Creating Decoration
local shapeDeco = View.ShapeDecoration.create()
shapeDeco:setFillColor(0, 127, 195, 50)
shapeDeco:setLineWidth(3)

-- Creating explicit iconic IDs
local imageID = 'BackgroundImage'
local rectangleID = 'Rectangle'

-- Variable for store the currently installed editor
local installedEditorIconic

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

-- Entrypoint for the function and event scope
local function main()
  viewer:clear()
  -- Adding image to viewer with the defined ID
  viewer:addImage(img, nil, imageID)
  -- Adding shape with the defined ID relative to the image coordinate system
  viewer:addShape(rectangle, shapeDeco, rectangleID, imageID)
  viewer:present()
end
Script.register('Engine.OnStarted', main)
-- serve API in global scope

-- Is called when the installed editor detects changes of the iconic in the viewer
--@handleOnChange(iconicid:string,iconic:object)
local function handleOnChange(iconicid, iconic)
  -- Checking if selected iconic is the added rectangle
  if iconicid == rectangleID and 'RECTANGLE' == iconic:getType() then
    -- Updating rectangle in script with the one defined in the viewer
    rectangle = iconic
    local center,
      width,
      height,
      rotation = rectangle:getRectangleParameters()
    print(
      'Updated Rectangle -> Center: ' ..
        center:getX() ..
          '/' ..
            center:getY() ..
              ' - Dimensions: ' ..
                width .. ' x ' .. height .. ' - Rotation: ' .. rotation
    )
  end
end
View.register(viewer, 'OnChange', handleOnChange)

-- Is called when the viewer detects a pointer action and raises the "OnPointer" event
--@handleOnPointer(iconicid:string,pointeractiontype:enum,pointertype:enum)
local function handleOnPointer(iconicid, pointeractiontype, pointertype)
  if pointertype == 'PRIMARY' and pointeractiontype == 'CLICKED' then
    if installedEditorIconic == iconicid then
      -- Nothing to do, editor is already installed on selected ID
      return
    end
    -- Deinstalling editor if it is installed on another iconic than the currently selected
    if installedEditorIconic and installedEditorIconic ~= iconicid then
      print(
        'Clicked on iconic with ID: ' ..
          iconicid .. '  -> Uninstalling editor on ' .. installedEditorIconic
      )
      viewer:uninstallEditor(installedEditorIconic)
      installedEditorIconic = nil
    end
    -- Installing editor on the rectangle if selected in the viewer
    if iconicid == rectangleID then
      print(
        'Clicked on iconic with ID: ' ..
          iconicid .. '  -> Installing editor on ' .. iconicid
      )
      viewer:installEditor(iconicid)
      installedEditorIconic = iconicid
    elseif iconicid ~= '' then
      print('Clicked on iconic with ID: ' .. iconicid)
    else
      print('Clicked on undefined')
    end
    viewer:present()
  end
end
View.register(viewer, 'OnPointer', handleOnPointer)

--@updateView():
local function updateView()
  viewer:clear()
  -- Adding image to viewer with the defined ID
  viewer:addImage(img, nil, imageID)
  -- Adding shape with the defined ID relative to the image coordinate system
  viewer:addShape(rectangle, shapeDeco, rectangleID, imageID)
  if installedEditorIconic then
    viewer:installEditor(installedEditorIconic)
  end
  viewer:present()
end
Script.serveFunction('RegionEditor.updateView', updateView)

--End of Function and Event Scope--------------------------------------------------
