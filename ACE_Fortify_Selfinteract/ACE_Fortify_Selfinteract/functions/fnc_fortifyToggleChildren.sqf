params ["_target", "_player", "_boolArray"];
private _toggleChildActions = [];
{
    private _toggleAction = [
        format ["aceFortifyToggle%1", _x],
        format ["Allow fortification placement = %1", _x],
        format ["ace_Fortify_SelfInteract\icons\toggle%1.paa", _x],
        {
            params ["_target", "_player", "_bool"];
            missionNamespace setVariable ["ace_fortify_fortifyAllowed", _bool, true];
        },
        {true},
        {},
        _x
    ] call ace_interact_menu_fnc_createAction;
    _toggleChildActions pushBack [_toggleAction, [], _player];
} forEach _boolArray;

_toggleChildActions