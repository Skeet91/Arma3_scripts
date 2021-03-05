/**
Author: Skeet.

Remove dead unit from players group via ACE action on dead unit.

**/

skt_removeUnitFromGroup = true;

_statement = {
    [_target] joinSilent grpNull;
};

_condition = {
    (skt_removeUnitFromGroup) && {!alive _target} && {leader _target isEqualTo leader player}
};

_action = [
    "skt_removeUnitFromGroup_action",
    "Remove unit from your group",
    "",
    _statement,
    _condition
] call ace_interact_menu_fnc_createAction;

["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;