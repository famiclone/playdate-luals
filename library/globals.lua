---@meta

---@class kTextAlignment
---@field public left unknown
---@field public center unknown
---@field public right unknown
kTextAlignment = {}

---Represents a class.
---
---> **Alert**:
---> This class only exists to fill a hole in the API.
---> It is not part of the official Playdate API, and will likely never be.
---
---> **Warning**:
---> Only extend this class if you're making a class using the `class` function.
---
---@see class
---@class playdate.Class
---@field public super playdate.Class The parent of this class.
playdate.Class = {}

function playdate.Class:init(...) end

---Starts the creation of a class.
---`.extends()` must be called right after this function.
---
---> **Warning**:
---> You must import `CoreLibs/object` to use this function.
---> Only create classes through this function.
---> Extend `playdate.Class` or any other class
---> that extends that class after you're done to have all its methods.
---> For example, to make a new class:
---> ```lua
---> ---@class ClassName : playdate.Class
---> ClassName = {}
---> class("ClassName").extends()
---> ```
---> To make a class that extends something other than Object:
---> ```lua
---> ---@class ClassName : ParentClass
---> ClassName = {}
---> class("ClassName").extends(ParentClass)
---> ```
---
---@param className string
---@param properties table<string, any>?
---@param namespace table?
---@return playdate.ClassSpec classSpec
function class(className, properties, namespace) end

---Represents a class currently being made.
---
---> **Alert**:
---> This class only exists to fill a hole in the API.
---> It is not part of the official Playdate API, and will likely never be.
---
---> **Warning**:
---> Never extend this class. Only extend `playdate.Class` if you're making a class using `class`.
---
---@see playdate.Class
---@see class
---@class playdate.ClassSpec
playdate.ClassSpec = {}

---Specify the class to extend. Pass nothing to extend Object.
---@param parent? playdate.Class
function playdate.ClassSpec.extends(parent) end