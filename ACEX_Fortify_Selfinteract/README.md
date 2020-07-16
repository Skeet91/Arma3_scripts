# ACEX fortify self interact menu
ACEX fortify settings in GM's ACE self interact menu by Skeet.

## Notes

* Runs on players with CBB GM checked or access to zeus.
* Adds an ACE self interact entry for GM's called "ACEX Fortify".
* The GM's side IN GAME (BLUFOR,OPFOR,INDFOR or CIVILIAN) determines what side the settings adjust. (meaning you can swap sides mid mission without changing slots)

## Adding to mission:

* Add the folder "ACEX_Fortify_Selfinteract" to your mission folder
* In your description.ext add this to the end of it:
```
class Extended_PreInit_EventHandlers {
    class ACEX_Fortify_Selfinteract {
        init = "call compile preprocessFileLineNumbers 'ACEX_Fortify_Selfinteract\cba_settings.sqf'";
    };
};

class CfgFunctions {
    #include "ACEX_Fortify_Selfinteract\cfgFunctions.hpp"
};

class ACEX_Fortify_Presets {
    #include "ACEX_Fortify_SelfInteract\skeetFortify.hpp"
};
```

* NOTE follow along with the examples in skeetFortify.hpp to create your own preset, following the format:
```
,{"CLASSNAME", COST}
```

#### Icons sourced from
##### https://google.github.io/material-design-icons/
