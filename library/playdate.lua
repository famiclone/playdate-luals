---@meta

---@enum playdate.Button
local Button = {
    kButtonA = "a",
    kButtonB = "b",
    kButtonUp = "up",
    kButtonDown = "down",
    kButtonLeft = "left",
    kButtonRight = "right",
}

---Version 2.4.1.
---
---Official reference: https://sdk.play.date
---@class _playdate
---@field public kButtonA     playdate.Button
---@field public kButtonB     playdate.Button
---@field public kButtonUp    playdate.Button
---@field public kButtonDown  playdate.Button
---@field public kButtonLeft  playdate.Button
---@field public kButtonRight playdate.Button
---@field public isSimulator boolean This variable—not a function, so don’t invoke with ()—it is set to 1 when running inside of the Simulator and is `nil` otherwise.
playdate = {}

---Returns two values, the current API version of the Playdate runtime and the minimum API version supported by the runtime.
---@return number curAPI, number minAPI
---@nodiscard
function playdate.apiVersion() end

---This table contains the values in the current game’s pdxinfo file, keyed by variable name. To retrieve the version number of the game, for example, you would use `playdate.metadata.version`.
---
---Changing values in this table at runtime has no effect.
---
---@type table<string, string>
playdate.metadata = {}

---Implement this callback and Playdate OS will call it once per frame. This is the place to put the main update-and-draw code for your game. Playdate will attempt to call this function by default 30 times per second; that value can be changed by calling `playdate.display.setRefreshRate()`.
---@see playdate.display.setRefreshRate
---@type fun()
function playdate.update() end

---Suspends callbacks to `playdate.update()` for the specified number of milliseconds.
---
---> **Note**
---> `playdate.wait()` is ideal for pausing game execution to, for example, show a message to the player. Because `.update()` will not be called, the screen will freeze during `.wait()`. Audio will continue to play. Animation during this wait period is possible, but you will need to explicitly call `playdate.display.flush()` once per frame.
---
---> **Warning**
---> While timers should pause during `playdate.wait()` (assuming `playdate.timer.updateTimers()` and `playdate.frameTimer.updateTimers()` are invoked during `playdate.update()`), animators will not pause during `playdate.wait()`. Be sure to account for this in your code.
---@param milliseconds integer
---@see playdate.update
function playdate.wait(milliseconds) end

---Stops per-frame callbacks to `playdate.update()`. Useful in conjunction with `playdate.display.flush()` if your program only does things in response to button presses.
function playdate.stop() end

---Resumes per-frame callbacks to `playdate.update()`
function playdate.start() end

---Called when the player chooses to exit the game via the System Menu or Menu button.
---@type fun()
playdate.gameWillTerminate = nil

---Called before the device goes to low-power sleep mode because of a low battery.
---
---> **Alert**
---> If your game saves its state, `playdate.gameWillTerminate()` and `playdate.deviceWillSleep()` are good opportunities to do it.
---
---@type fun()
playdate.deviceWillSleep = nil

---If your game is running on the Playdate when the device is locked, this function will be called. Implementing this function allows your game to take special action when the Playdate is locked, e.g., saving state.
---@type fun()
playdate.deviceWillLock = nil

---If your game is running on the Playdate when the device is unlocked, this function will be called.
---@type fun()
playdate.deviceDidUnlock = nil

---Called before the system pauses the game. (In the current version of Playdate OS, this only happens when the device’s Menu button is pushed.) Implementing these functions allows your game to take special action when it is paused, e.g., updating the menu image.
---@type fun()
playdate.gameWillPause = nil

---Called before the system resumes the game.
---@type fun()
playdate.gameWillResume = nil

---Returns true if `button` is currently being pressed.
---
---Button should be one of the constants:
---
---* `playdate.kButtonA`
---* `playdate.kButtonB`
---* `playdate.kButtonUp`
---* `playdate.kButtonDown`
---* `playdate.kButtonLeft`
---* `playdate.kButtonRight`
---
---Or one of the strings "a", "b", "up", "down", "left", "right".
---
---@param button playdate.Button
---@return boolean pressed
---@see playdate.buttonJustPressed
---@nodiscard
function playdate.buttonIsPressed(button) end

---Returns true for just one update cycle if button was pressed. `buttonJustPressed` will not return true again until the button is released and pressed again. This is useful for, say, a player "jump" action, so the jump action is taken only once and not on every single update.
---
---`button` should be one of the constants listed in `playdate.buttonIsPressed()`
---
---@param button playdate.Button
---@return boolean justPressed
---@see playdate.buttonIsPressed
---@nodiscard
function playdate.buttonJustPressed(button) end

---Returns a table holding booleans with the following keys:
---* `charging`: The battery is actively being charged
---* `USB`: There is a powered USB cable connected
---* `screws`: There is 5V being applied to the corner screws (via the dock, for example)
---
---@return { charging: boolean, USB: boolean, screws: boolean }
---@nodiscard
function playdate.getPowerStatus() end

---Simulator-only functionality.
playdate.simulator = {}

---
---Writes an image to a PNG file at the path specified. Only available on the Simulator.
---
---> **Note**:
---> path represents a path on your development computer, not the Playdate filesystem. It’s recommended you prefix your path with ~/ to ensure you are writing to a writeable directory, for example, ~/myImageFile.png. Please include the .png file extension in your path name. Any directories in your path must already exist on your development computer in order for the file to be written.
---
---@param image playdate.graphics.Image
---@param path string
function playdate.simulator.writeToFile(image, path) end

---Quits the Playdate Simulator app.
function playdate.simulator.exit() end

---Returns the contents of the URL `url` as a string.
---@param url string
---@return string contents
---@nodiscard
function playdate.simulator.getURL(url) end

---Clears the simulator console.
function playdate.clearConsole() end

---Sets the color of the `playdate.debugDraw()` overlay image. Values are in the range 0-1.
---@param r number
---@param g number
---@param b number
---@param a number
---@see playdate.debugDraw
function playdate.setDebugDrawColor(r, g, b, a) end

---Lets you act on keyboard keypresses when running in the Simulator ONLY. These can be useful for adding debugging functions that can be enabled via your keyboard.
---
---> **Note**:
---> It is possible test a game on Playdate hardware and trap computer keyboard keypresses if you are using the Simulator’s Control Device with Simulator option.
---
---`key` is a string containing the character pressed or released on the keyboard. Note that:
---
---* The key in question needs to have a textual representation or these functions will not be called. For instance, alphanumeric keys will call these functions; keyboard directional arrows will not.
---* If the keypress in question is already in use by the Simulator for another purpose (say, to control the d-pad or A/B buttons), these functions will not be called.
---* If key is an alphabetic character, the value will always be lowercase, even if the user deliberately typed an uppercase character.
---
---@type fun(key: string)
function playdate.keyPressed() end

---Lets you act on keyboard key releases when running in the Simulator ONLY. These can be useful for adding debugging functions that can be enabled via your keyboard.
---
---@type fun(key: string)
playdate.keyReleased = nil

---Called immediately after `playdate.update()`, any drawing performed during this callback is overlaid on the display in 50% transparent red (or another color selected with `playdate.setDebugDrawColor()`).
---
---White pixels are drawn in the debug draw color. Black pixels are transparent.
---
---@see playdate.update
---@see playdate.setDebugDrawColor
---@type fun()

---Highlight regions on the Simulator screen in a different color, to aid in debugging.
function playdate.debugDraw() end

---Calculates the current frames per second and draws that value at x, y.
---@param x number?
---@param y number?
function playdate.drawFPS(x, y) end

---Returns the measured, actual refresh rate in frames per second. This value may be different from the specified refresh rate (see playdate.display.getRefreshRate()) by a little or a lot depending upon how much calculation is being done per frame.
function playdate.getFPS() end

---Outputs the contents of a table to the console.
function playdate.printTable() end

---Your game can add up to three menu items to the System Menu. Three types of menu items are supported: normal action menu items, checkmark menu items, and options menu items.
playdate.menu = {}

---Use this to add your custom menu items.
---@return playdate.menu
function playdate.getSystemMenu() end

---When this menu item is selected, the OS will:
---1. Hide the System Menu.
---2. Invoke your callback function.
---3. Unpause your game and call `playdate.gameWillResume`.
--
---If the returned playdate.menu.item is nil, a second errorMessage return value will indicate the reason the operation failed.
--
---@param title string
---@param callback fun()
--->**Note**:
--->Playdate OS allows a maximum of three custom menu items to be added to the System Menu.
function playdate.menu:addMenuItem(title, callback) end

---Indicates whether or not the crank is folded into unit.
--->**Note**:
--->If your game requires the crank and `:isCrankDocked()` is true, you can use a crank alert to notify the user that the crank should be extended.
---@return boolean
function playdate.isCrankDocked() end

---Returns the absolute position of the crank (in degrees). Zero is pointing straight up parallel to the device.
---Turning the crank clockwise (when looking at the right edge of an upright device) increases the angle, up to a maximum value 359.9999.
---The value then resets back to zero as the crank continues its rotation.
---**Example**:
-->local crankPosition = playdate.getCrankPosition()
---@return number
function playdate.getCrankPosition() end

---Returns two values, change and acceleratedChange. change represents the angle change (in degrees) of the crank since the last time this function (or the `playdate.cranked()` callback) was called. Negative values are anti-clockwise. acceleratedChange is change multiplied by a value that increases as the crank moves faster, similar to the way mouse acceleration works.
---**Example**:
---```lua 
--local change, acceleratedChange = playdate.getCrankChange()
---```
---@return number change, number acceleratedChange
function playdate.getCrankChange() end

---Returns the number of "ticks" — whose frequency is defined by the value of ticksPerRevolution — the crank has turned through since the last time this function was called. Tick boundaries are set at absolute positions along the crank’s rotation. Ticks can be positive or negative, depending upon the direction of rotation.

---For example, say you have a movie player and you want your movie to advance 6 frames for every one revolution of the crank. Calling playdate.getCrankTicks(6) during each update will give you a return value of 1 as the crank turns past each 60 degree increment. (Since we passed in a 6, each tick represents 360 ÷ 6 = 60 degrees.) So getCrankTicks(6) will return a 1 as the crank turns past the 0 degree absolute position, the 60 degree absolute position, and so on for the 120, 180, 240, and 300 degree positions. Otherwise, 0 will be returned. (-1 will be returned if the crank moves past one of these mentioned positions while going in a backward direction.)
---**Example**:
---```lua
--import "CoreLibs/crank"
--local ticksPerRevolution = 6
--
--function playdate.update()
--    local crankTicks = playdate.getCrankTicks(ticksPerRevolution)
--
--    if crankTicks == 1 then
--        print("Forward tick")
--    elseif crankTicks == -1 then
--        print("Backward tick")
--    end
--end
---```
---**Warning**:
--->You must import `CoreLibs/crank` to use `getCrankTicks()`.
---@param ticksPerRevolution number
---@return number crankTicks
function playdate.getCrankTicks(ticksPerRevolution) end

---Returns a single-line stack trace as a string.
---#### Example:
---main.lua:10 foo() < main.lua:18 (from C)
--->**Warning**
--->You must import `CoreLibs/utilities/where` to use this function.
function where() end

---@enum playdate.graphics.Color

---The `playdate.graphics` module contains functions related to displaying information on the device screen.
---
---## Conventions
---* The Playdate coordinate system has its origin point (0, 0) at the upper left. The x-axis increases to the right, and the y-axis increases downward.
---* (0, 0) represents the upper-left corner of the first pixel onscreen. The center of that pixel is (0.5, 0.5).
---* In the Playdate SDK, angle values should always be provided in degrees, and angle values returned will be in degrees. Not radians. (This is in contrast to Lua’s built-in math libraries, which use radians.)
---
---@class playdate.graphics
---@field public kColorClear playdate.graphics.Color
---@field public kColorBlack playdate.graphics.Color
---@field public kColorWhite playdate.graphics.Color
---@field public kColorXOR   playdate.graphics.Color
playdate.graphics = {}

---Pushes the current graphics state to the context stack and creates a new context.
---
---> **Alert**:
---> If you draw into an image context with color set to `playdate.graphics.kColorClear`, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image.
---
---> **Note**:
---> `playdate.graphics.lockFocus(image)` will reroute drawing into an image, without saving the overall graphics context. 
---
---#### Example: Using contexts to reset drawing modifiers
---```lua
---local gfx = playdate.graphics
---
---gfx.setLineWidth(1) -- Original line width
---gfx.setColor(gfx.kColorBlack) -- Original color
---
---gfx.pushContext() -- Creating a new graphics context
---gfx.setLineWidth(5) -- Setting the line width to 5
---gfx.setColor(gfx.kColorWhite) -- Setting the draw color to white
---gfx.drawCircleAtPoint(200, 120, 10) -- Only thing you're trying to modify
---gfx.popContext() -- All modifications done during the context get removed
---
----- Unaffected by modifiers and gets drawn with the original color/line width
---gfx.drawLine(0, 120, 400, 120)
---```
---
---@see playdate.graphics.lockFocus
function playdate.graphics.pushContext() end

---Pushes the current graphics state to the context stack and creates a new context, applying the drawing functions to the image instead of the screen buffer.
---
---> **Alert**:
---> If you draw into an image context with color set to `playdate.graphics.kColorClear`, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image.
---
---> **Note**:
---> `playdate.graphics.lockFocus(image)` will reroute drawing into an image, without saving the overall graphics context. 
---
---#### Example: Using contexts to draw something to an image
---```lua
----- You can copy and paste this example directly as your main.lua file to see it in action
---import "CoreLibs/graphics"
---
----- In this example, we'll be drawing a smiley face to an image, which saves our
----- drawing, makes it easier to draw, and helps improve performance since we don't
----- have to redraw each element separately each time
---local gfx = playdate.graphics
---
---local smileWidth, smileHeight = 36, 36
---local smileImage = gfx.image.new(smileWidth, smileHeight)
----- Pushing our new image to the graphics context, so everything
----- drawn will be drawn directly to the image
---gfx.pushContext(smileImage)
---    -- => Indentation not required, but helps organize things!
---    gfx.setColor(gfx.kColorWhite)
---    -- Coordinates are based on the image being drawn into
---    -- (e.g. (x=0, y=0) refers to the top left of the image)
---    gfx.fillCircleInRect(0, 0, smileWidth, smileHeight)
---    gfx.setColor(gfx.kColorBlack)
---    -- Drawing the eyes
---    gfx.fillCircleAtPoint(11, 13, 3)
---    gfx.fillCircleAtPoint(25, 13, 3)
---    -- Drawing the mouth
---    gfx.setLineWidth(3)
---    gfx.drawArc(smileWidth/2, smileHeight/2, 11, 115, 245)
---    -- Drawing the outline
---    gfx.setLineWidth(2)
---    gfx.setStrokeLocation(gfx.kStrokeInside)
---    gfx.drawCircleInRect(0, 0, smileWidth, smileHeight)
----- Popping context to stop drawing to image
---gfx.popContext()
---
---function playdate.update()
---    -- Draw smile in the center of the screen
---    local screenWidth, screenHeight = playdate.display.getSize()
---    smileImage:drawAnchored(screenWidth/2, screenHeight/2, 0.5, 0.5)
---end
---
----- Works really well with sprites! Just set the sprite image to your new image
---local smileSprite = gfx.sprite.new(smileImage)
---smileSprite:add()
---```
---
---@param image playdate.graphics.Image
---@see playdate.graphics.Image
function playdate.graphics.pushContext(image) end

---Pops a graphics context off the context stack and restores its state.
function playdate.graphics.popContext() end

---Draws the rect at (`x`, `y`) of the given `width` and `height`.
---@param x number
---@param y number
---@param width number
---@param height number
function playdate.graphics.fillRect(x, y, width, height) end

---Draws the filled rectangle `r`.
---@param r playdate.geometry.Rect
---@see playdate.geometry.Rect
function playdate.graphics.fillRect(r) end

---Sets and gets the current drawing color for primitives.
---
---`color` should be one of the constants:
---* `playdate.graphics.kColorBlack`
---* `playdate.graphics.kColorWhite`
---* `playdate.graphics.kColorClear`
---* `playdate.graphics.kColorXOR`
---
---This color applies to drawing primitive shapes such as lines and rectangles, not bitmap images.
---
---> **Alert**:
---> `setColor()` and `setPattern()` / `setDitherPattern()` are mutually exclusive. Setting a color will overwrite a pattern, and vice versa. 
---@param color playdate.graphics.Color
function playdate.graphics.setColor(color) end

---@enum playdate.graphics.image.DitherType

---@enum playdate.graphics.image.FlipState

---PNG and GIF images in the source folder are compiled into a Playdate-specific format by pdc, and can be loaded into Lua with `playdate.graphics.image.new(path)`. Playdate images are 1 bit per pixel, with an optional alpha channel.
---@class playdate.graphics.image
---@field public kDitherTypeFloydSteinberg playdate.graphics.image.DitherType
---@field public kDitherTypeBurkes         playdate.graphics.image.DitherType
---@field public kDitherTypeAtkinson       playdate.graphics.image.DitherType
---@field public kImageUnflipped           playdate.graphics.image.FlipState
---@field public kImageFlippedX            playdate.graphics.image.FlipState
---@field public kImageFlippedY            playdate.graphics.image.FlipState
---@field public kImageFlippedXY           playdate.graphics.image.FlipState
playdate.graphics.image = {}

---PNG and GIF images in the source folder are compiled into a Playdate-specific format by pdc, and can be loaded into Lua with `playdate.graphics.image.new(path)`. Playdate images are 1 bit per pixel, with an optional alpha channel.
---@class playdate.graphics.Image
local Image = {} 

---Draws the image with its upper-left corner at location (`x`, `y`)
---@param x number
---@param y number
---@param flip playdate.graphics.image.FlipState?
---@param sourceRect playdate.geometry.Rect?
function Image:draw(x, y, flip, sourceRect) end

---Draws the image with its upper-left corner at location `p`.
---@param p playdate.geometry.Point
---@param flip playdate.graphics.image.FlipState?
---@param sourceRect playdate.geometry.Rect?
function Image:draw(p, flip, sourceRect) end

---@class playdate.graphics.Tilemap
local Tilemap = {}

---Creates a new blank image of the given width and height. The image can be drawn on using `playdate.graphics.pushContext()` or `playdate.graphics.lockFocus()`. The optional bgcolor argument is one of the color constants as used in playdate.graphics.setColor()`, defaulting to `kColorClear`.
---@param width number
---@param height number
---@param bgColor playdate.graphics.Color?
---@return playdate.graphics.Image
---@see playdate.graphics.setColor
---@nodiscard
function playdate.graphics.image.new(width, height, bgColor) end

---Returns a `playdate.graphics.image` object from the data at `path`. If there is no file at `path`, the function returns nil and a second value describing the error.
---@param path string
---@return playdate.graphics.Image? image, string error
---@nodiscard
function playdate.graphics.image.new(path) end

---Sets the pattern used for drawing to a dithered pattern. If the current drawing color is white, the pattern is white pixels on a transparent background and (due to a bug) the alpha value is inverted: 1.0 is transparent and 0 is opaque. Otherwise, the pattern is black pixels on a transparent background and alpha 0 is transparent while 1.0 is opaque.
---
---The optional ditherType argument is a dither type as used in playdate.graphics.image:blurredImage(), and should be an ordered dither type; i.e., line, screen, or Bayer.
---
---> **Alert**:
---> The error-diffusing dither types Floyd-Steinberg (`kDitherTypeFloydSteinberg`), Burkes (`kDitherTypeBurkes`), and Atkinson (`kDitherTypeAtkinson`) are allowed but produce very unpredictable results here. 
---
---@param alpha number
---@param ditherType playdate.graphics.image.DitherType?
function playdate.graphics.setDitherPattern(alpha, ditherType) end

---`lockFocus()` routes all drawing to the given playdate.graphics.image. playdate.graphics.unlockFocus() returns drawing to the frame buffer.
---
---> **Alert**:
---> If you draw into an image with color set to `playdate.graphics.kColorClear`, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image.
---
---> **Note**:
---> `playdate.graphics.pushContext(image)` will also allow offscreen drawing into an image, with the additional benefit of being able to save and restore the graphics state. 
---
---#### Example: Drawing into multiple images with `lockFocus`
---```lua
----- If you're drawing into multiple different images, using lockFocus might be easier (and
----- slightly faster performance-wise) than having to repeatedly call pushContext/popContext
---
---local tinyCircle = gfx.image.new(10, 10)
---local smallCircle = gfx.image.new(20, 20)
---local mediumCircle = gfx.image.new(30, 30)
---local largeCircle = gfx.image.new(40, 40)
---
---gfx.lockFocus(tinyCircle) -- draw into tinyCircle image
----- Drawing coordinates are relative to the image, so (0, 0) is the top left of the image
---gfx.fillCircleInRect(0, 0, tinyCircle:getSize())
---gfx.lockFocus(smallCircle) -- draw into smallCircle image
---gfx.fillCircleInRect(0, 0, smallCircle:getSize())
---gfx.lockFocus(mediumCircle) -- draw into mediumCircle image
---gfx.fillCircleInRect(0, 0, mediumCircle:getSize())
---gfx.lockFocus(largeCircle) -- draw into largeCircle image
---gfx.fillCircleInRect(0, 0, largeCircle:getSize())
---gfx.unlockFocus() -- unlock focus to bring drawing back to frame buffer
---```
---
---@param image playdate.graphics.Image
function playdate.graphics.lockFocus(image) end

---Reroutes drawing to the frame buffer.
---
---#### Example: Drawing into multiple images with `lockFocus`
---```lua
----- If you're drawing into multiple different images, using lockFocus might be easier (and
----- slightly faster performance-wise) than having to repeatedly call pushContext/popContext
---
---local tinyCircle = gfx.image.new(10, 10)
---local smallCircle = gfx.image.new(20, 20)
---local mediumCircle = gfx.image.new(30, 30)
---local largeCircle = gfx.image.new(40, 40)
---
---gfx.lockFocus(tinyCircle) -- draw into tinyCircle image
----- Drawing coordinates are relative to the image, so (0, 0) is the top left of the image
---gfx.fillCircleInRect(0, 0, tinyCircle:getSize())
---gfx.lockFocus(smallCircle) -- draw into smallCircle image
---gfx.fillCircleInRect(0, 0, smallCircle:getSize())
---gfx.lockFocus(mediumCircle) -- draw into mediumCircle image
---gfx.fillCircleInRect(0, 0, mediumCircle:getSize())
---gfx.lockFocus(largeCircle) -- draw into largeCircle image
---gfx.fillCircleInRect(0, 0, largeCircle:getSize())
---gfx.unlockFocus() -- unlock focus to bring drawing back to frame buffer
---```
function playdate.graphics.unlockFocus() end

---Sprites are graphic objects that can be used to represent moving entities in your games, like the player, or the enemies that chase after your player. Sprites animate efficiently, and offer collision detection and a host of other built-in functionality. (If you want to create an environment for your sprites to move around in, consider using tilemaps or drawing a background image.)
---To have access to all the sprite functionality described below, be sure to import "CoreLibs/sprites" at the top of your source file.
---
---The simplest way to create a sprite is using sprite.new(image):
---
---#### Creating a standalone sprite
---```lua
---import "CoreLibs/sprites"
---
---local image = playdate.graphics.image.new("coin")
---local sprite = playdate.graphics.sprite.new(image)
---sprite:moveTo(100, 100)
---sprite:add()
---```
---
---If you want to use an object-oriented approach, you can also subclass sprites and create instance of those subclasses.
---
---#### Creating a sprite subclass
---```lua
---import "CoreLibs/sprites"
---
---class('MySprite').extends(playdate.graphics.sprite)
---
---local sprite = MySprite()
---local image = playdate.graphics.image.new("coin")
---sprite:setImage(image)
---sprite:moveTo(100, 100)
---sprite:add()
---```
---
---Or with a custom initializer:
---
---#### Creating a sprite subclass with a custom initializer
---```lua
---import "CoreLibs/sprites"
---
---class('MySprite').extends(playdate.graphics.sprite)
---
---local image = playdate.graphics.image.new("coin")
---
---function MySprite:init(x, y)
---MySprite.super.init(self) -- this is critical
---    self:setImage(image)
---    self:moveTo(x, y)
---end
---
---local sprite = MySprite(100, 100)
---sprite:add()
---```
---
---@see playdate.graphics.image
---@see class
---@class _playdate.graphics.sprite : playdate.Class
playdate.graphics.sprite = {}

---Sprites are graphic objects that can be used to represent moving entities in your games, like the player, or the enemies that chase after your player. Sprites animate efficiently, and offer collision detection and a host of other built-in functionality. (If you want to create an environment for your sprites to move around in, consider using tilemaps or drawing a background image.)
---To have access to all the sprite functionality described below, be sure to import "CoreLibs/sprites" at the top of your source file.
---
---The simplest way to create a sprite is using sprite.new(image):
---
---### Creating a standalone sprite
---```lua
---import "CoreLibs/sprites"
---
---local image = playdate.graphics.image.new("coin")
---local sprite = playdate.graphics.sprite.new(image)
---sprite:moveTo(100, 100)
---sprite:add()
---```
---
---If you want to use an object-oriented approach, you can also subclass sprites and create instance of those subclasses.
---
---#### Creating a sprite subclass
---```lua
---import "CoreLibs/sprites"
---
---class('MySprite').extends(playdate.graphics.sprite)
---
---local sprite = MySprite()
---local image = playdate.graphics.image.new("coin")
---sprite:setImage(image)
---sprite:moveTo(100, 100)
---sprite:add()
---```
---
---Or with a custom initializer:
---
---#### Creating a sprite subclass with a custom initializer
---```lua
---import "CoreLibs/sprites"
---
---class('MySprite').extends(playdate.graphics.sprite)
---
---local image = playdate.graphics.image.new("coin")
---
---function MySprite:init(x, y)
---MySprite.super.init(self) -- this is critical
---    self:setImage(image)
---    self:moveTo(x, y)
---end
---
---local sprite = MySprite(100, 100)
---sprite:add()
---```
---
---@see playdate.graphics.image
---@see class
---@class playdate.graphics.Sprite
local Sprite = {}

---This class method (note the "." syntax rather than ":") returns a new sprite object.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@return playdate.graphics.Sprite
---@nodiscard
function playdate.graphics.sprite.new() end

---This class method (note the "." syntax rather than ":") returns a new sprite object from a previously loaded image.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@param image playdate.graphics.Image
---@return playdate.graphics.Sprite sprite
---@nodiscard
function playdate.graphics.sprite.new(image) end

---This class method (note the "." syntax rather than ":") returns a new sprite object from a previously loaded tilemap.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@param tilemap playdate.graphics.Tilemap
---@return playdate.graphics.Sprite sprite
---@nodiscard
function playdate.graphics.sprite.new(tilemap) end

--- This class method (note the "." syntax rather than ":") calls the `update()` function on every sprite in the global sprite list and redraws all of the dirty rects.
---
---> **Alert**:
---> You will generally want to call playdate.graphics.sprite.update() once in your playdate.update() method, to ensure that your sprites are updated and drawn during every frame. Failure to do so may mean your sprites will not appear onscreen.
---
---> **Warning**:
---> Be careful not confuse sprite.update() with sprite:update(): the former updates all sprites; the latter updates just the sprite being invoked.
---
function playdate.graphics.sprite.update() end

---> **Alert**:
---> You must import CoreLibs/sprites to use this function.
---
---A convenience function for drawing a background image behind your sprites.
---
---`drawCallback` is a routine you specify that implements your background drawing. The callback should be a function taking the arguments `x, y, width, height`, where `x`, `y`, `width`, `height` specify the region (in screen coordinates, not world coordinates) of the background region that needs to be updated.
---
---> **Info**:
---> Some implementation details: `setBackgroundDrawingCallback()` creates a screen-sized sprite with a z-index set to the lowest possible value so it will draw behind other sprites, and adds the sprite to the display list so that it is drawn in the current scene. The background sprite ignores the `drawOffset`, and will not be automatically redrawn when the draw offset changes; use `playdate.graphics.sprite.redrawBackground()` if necessary in this case. `drawCallback` will be called from the newly-created background sprite’s `playdate.graphics.sprite:draw()` callback function and is where you should do your background drawing. This function returns the newly created `playdate.graphics.sprite`.
---@see playdate.graphics.sprite.redrawBackground
---
---For additional background, here is the implementation of `setBackgroundDrawingCallback()` in the Playdate SDK. (This does not reflect how you should use `setBackgroundDrawingCallback()` in your game. For an example of game usage, see [A Basic Playdate Game in Lua](https://sdk.play.date/#basic-playdate-game).)
---```lua
---function playdate.graphics.sprite.setBackgroundDrawingCallback(drawCallback)
---    local bgsprite = gfx.sprite.new()
---    bgsprite:setSize(playdate.display.getSize())
---    bgsprite:setCenter(0, 0)
---    bgsprite:moveTo(0, 0)
---    bgsprite:setZIndex(-32768)
---    bgsprite:setIgnoresDrawOffset(true)
---    bgsprite:setUpdatesEnabled(false)
---    bgsprite.draw = function(s, x, y, w, h)
---            drawCallback(x, y, w, h)
---    end
---    bgsprite:add()
---    return bgsprite
---end
---```
---@param drawCallback fun(x: number, y: number, width: number, height: number)
---@return playdate.graphics.Sprite bgsprite # The background sprite itself.
function playdate.graphics.sprite.setBackgroundDrawingCallback(drawCallback) end

---> **Alert**: You must import CoreLibs/sprites to use this function.
---
---Marks the background sprite dirty, forcing the drawing callback to be run when playdate.graphics.sprite.update() is called.
---
function playdate.graphics.sprite.redrawBackground() end

---Called by `playdate.graphics.sprite.update()` (note the syntactic difference between the period and the colon) before sprites are drawn. Implementing `:update()` gives you the opportunity to perform some code upon every frame.
---> **Note**:
---> The update method will only be called on sprites that have had `add()` called on them, and have their updates enabled.
---
---> **Warning**
---> Be careful not confuse sprite:update() with sprite.update(): the latter updates all sprites; the former updates just the sprite being invoked.
---
function Sprite:update() end

---Adds the given sprite to the display list, so that it is drawn in the current scene.
function Sprite:add() end

---Sets the sprite’s drawing center as a fraction (ranging from 0.0 to 1.0) of the height and width. Default is 0.5, 0.5 (the center of the sprite). This means that when you call `:moveTo(x, y)`, the center of your sprite will be positioned at x, y. If you want x and y to represent the upper left corner of your sprite, specify the center as 0, 0.
---@param x number The x percentage of the center.
---@param y number The y percentage of the center.
function Sprite:setCenter(x, y) end

---`setBounds()` positions and sizes the sprite, used for drawing and for calculating dirty rects. upper-left-x and upper-left-y are relative to the overall display coordinate system.
---(If an image is attached to the sprite, the size will be defined by that image, and not by the width and height parameters passed in to `setBounds()`.)
---> **Note**:
---> In `setBounds()`, x and y always correspond to the upper left corner of the sprite, regardless of how a sprite’s center is defined. This makes it different from sprite:moveTo(), where x and y honor the sprite’s defined center (by default, at a point 50% along the sprite’s width and height.) 
---@param upperLeftX number
---@param upperLeftY number
---@param width number
---@param height number
function Sprite:setBounds(upperLeftX, upperLeftY, width, height) end

---Moves the sprite and resets the bounds based on the image dimensions and center.
---@param x number
---@param y number
function Sprite:moveTo(x, y) end

---Moves the sprite by `x`, `y` pixels relative to its current position.
---@param x number
---@param y number
function Sprite:moveBy(x, y) end

---If the sprite doesn’t have an image, the sprite’s draw function is called as needed to update the display. The rect passed in is the current dirty rect being updated by the display list. The rect coordinates passed in are relative to the sprite itself (i.e. x = 0, y = 0 refers to the top left corner of the sprite). Note that the callback is only called when the sprite is on screen and has a size specified via `sprite:setSize()` or `sprite:setBounds()`.
---
---#### Example: Overriding the sprite draw method
---```lua
----- You can copy and paste this example directly as your main.lua file to see it in action
---import "CoreLibs/graphics"
---import "CoreLibs/sprites"
---
---local mySprite = playdate.graphics.sprite.new()
---mySprite:moveTo(200, 120)
----- You MUST set a size first for anything to show up (either directly or by setting an image)
---mySprite:setSize(30, 30)
---mySprite:add()
---
----- The x, y, width, and height arguments refer to the dirty rect being updated, NOT the sprite dimensions
---function mySprite:draw(x, y, width, height)
---    -- Custom draw methods gives you more flexibility over what's drawn, but with the added benefits of sprites
---
---    -- Here we're just modulating the circle radius over time
---    local spriteWidth, spriteHeight = self:getSize()
---    if not self.radius or self.radius > spriteWidth then
---        self.radius = 0
---    end
---    self.radius += 1
---
---    -- Drawing coordinates are relative to the sprite (e.g. (0, 0) is the top left of the sprite)
---    playdate.graphics.fillCircleAtPoint(spriteWidth / 2, spriteHeight / 2, self.radius)
---end
---
---function playdate.update()
---    -- Your custom draw method gets called here, but only if the sprite is dirty
---    playdate.graphics.sprite.update()
---
---    -- You might need to manually mark it dirty
---    mySprite:markDirty()
---end
---```
---@param x number
---@param y number
---@param width number
---@param height number
function Sprite:draw(x, y, width, height) end

---Marks the rect defined by the sprite’s current bounds as needing a redraw.
function Sprite:markDirty() end

---Clears the entire display, setting the color to either the given color argument, or the current background color set in setBackgroundColor(color) if no argument is given.
---@param color playdate.graphics.Color?
---@see playdate.graphics.setBackgroundColor
function playdate.graphics.clear(color) end

---Draw a single pixel in the current color at (x, y).
---@param x number
---@param y number
function playdate.graphics.drawPixel(x, y) end

---Draws the rect r or the rect with origin (x, y) with a size of (w, h). Line width is specified by `setLineWidth()`. Stroke location is specified by `setStrokeLocation()`.
---@param x number
---@param y number
---@param w number
---@param h number
---> Equivalent to playdate->graphics->drawRect() in the C API.
function playdate.graphics.drawRect(x, y, w, h) end

---Draws a line from `(x1, y1)` to `(x2, y2)`, or draws the `playdate.geometry.lineSegment` ls.
---Line width is specified by `setLineWidth()`. End cap style is specified by `setLineCapStyle()`.
-->Equivalent to `playdate->graphics->drawLine()` in the C API.
function playdate.graphics.drawLine(x1, y1, x2, y2) end

---@param width number
function playdate.graphics.setLineWidth(width) end

---Flips the bitmap. See playdate.graphics.image:draw() for valid flip values.
---If true is passed for the optional flipCollideRect argument, the sprite’s collideRect will be flipped as well.
---Calling setImage() will reset the sprite to its default, non-flipped orientation. So, if you call both setImage() and setImageFlip(), call setImage() first.
function playdate.graphics.sprite:setImageFlip(number) end

---There are two kinds of image tables: *matrix* and *sequential*.
---1. **Matrix** image tables are great as sources of imagery for tilemap. They are loaded from a single file in your game’s source folder with the suffix -table-<w>-<h> before the file extension. The compiler splits the image into separate bitmaps of dimension w by h pixels that are accessible via imagetable:getImage(x,y).
---2. **Sequential** image tables are useful as a way to load up sequential frames of animation. They are loaded from a sequence of files in your game’s source folder at compile time from filenames with the suffix -table-<sequenceNumber> before the file extension. Individual images in the sequence are accessible via imagetable:getImage(n). The images employed by a sequential image table are not required to be the same size, unlike the images used in a matrix image table.
playdate.graphics.imagetable = {}

---Returns a `playdate.graphics.imagetable` object from the data at path. If there is no file at path, the function returns nil and a second value describing the error. If the file at path is an animated GIF, successive frames of the GIF will be loaded as consecutive bitmaps in the imagetable. Any timing data in the animated GIF will be ignored.
---**Warning**:
--->To load a matrix image table defined in `frames-table-16-16.png`, you call `playdate.graphics.imagetable.new("frames")`.
--->To load a sequential image table defined with the files `frames-table-1.png`, `frames-table-2.png`, etc., you call `playdate.graphics.imagetable.new("frames")`.
---@param path string
---@return playdate.graphics.imagetable? imagetable | nil, string error
function playdate.graphics.imagetable.new(path) end

---Returns the n-th `playdate.graphics.image` in the table (ordering left-to-right, top-to-bottom). The first image is at index 1. If .n_ or (x,y) is out of bounds, the function returns nil. See also `imagetable[n]`.
---Returns the image in cell `(x,y)` in the original bitmap. The first image is at index 1. If n or `(x,y)` is out of bounds, the function returns `nil`. See also imagetable[n].
---@param n number?
---@param x number?
---@param y number?
---@return playdate.graphics.Image? image
---@see playdate.graphics.Image
function playdate.graphics.imagetable:getImage(x, y, n) end

---Animation
---**Warning**:
--->You must import CoreLibs/animation to use these functions.
playdate.graphics.animation = {}

---Helps keep track of animation frames, especially for frames in an `playdate.graphics.imagetable`.
---@see playdate.timer
---@see playdate.frameTimer
playdate.graphics.animation.loop = {}
