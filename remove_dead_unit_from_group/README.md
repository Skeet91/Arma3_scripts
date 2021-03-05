# ACE action to remove dead unit from your group

## Notes

* Action will only show on dead units in the same group as the player

## Adding to mission:

* Add "remove_dead_unit_from_group.sqf" to your mission folder
* In your description.ext add this to the end of it:
```
class Extended_PostInit_EventHandlers {
    class skt_remove_dead {
        init = "call compile preprocessFileLineNumbers 'remove_dead_unit_from_group.sqf'";
    };
};
```
