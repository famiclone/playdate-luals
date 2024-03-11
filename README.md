# Playdate Lua API Definitions

This is an addon for LuaLS that helps with autocompletion for Playdate's Lua API.

> **Warning**
> Currently, this addon is handwritten, so there might be errors in the implementation
> of certain features. Inside Playdate also doesn't explain some of its contents, such
> as the `class` function, which means that only approximations to the behavior of said
> elements are able to be supplied.
>
> The addon is still in development and there are no stable releases yet, so annotations
> and other things will change at any time. It's not totally good for use yet, so PRs
> would be appreciated.

![showcase video](assets/showcase.webm)

## Installation

Currently this addon is not available in the Lua Addon Manager, so manual
installation is required. To install manually, clone this repository under
your addons folder. Then add the location of the `library/` subfolder to
your workspace settings, inside the `Lua.workspace.library` field, and add
all the settings in the [config.json](config.json) file:

```json
{
    "Lua.workspace.library": [
        "/path/to/playdate/library",
    ],

    "Lua.runtime.special": {
        "import": "require"
    },

    "Lua.runtime.nonstandardSymbol": [
        "+=", "-=", "*=", "/=", "//=", "%=",
        "<<=", ">>=", "&=", "|=", "^="
    ],

    "Lua.runtime.version": "Lua 5.4",

    "Lua.runtime.builtin": {
        "basic": "default",
        "io": "disable",
        "os": "disable"
    }
}
```

## Currently implemented

- Table extensions
- Main callbacks
- Some graphics objects and functions
- Some global variables and `class`
- Some display functions
- Some timing objects and functions

### Disclaimer

This addon is not affiliated with or endorsed by Panic. Playdate, sdk.play.date and the Playdate console are copyright of Panic.