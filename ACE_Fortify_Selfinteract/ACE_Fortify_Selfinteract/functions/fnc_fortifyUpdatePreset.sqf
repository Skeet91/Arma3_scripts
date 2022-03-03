params ["_side","_preset"];

private _selectedPreset = [_preset] call ace_fortify_fnc_getPlaceableSet;
private _sideBudget = [_side] call ace_fortify_fnc_getBudget;
["ace_fortify_registerObjects", [_side,_sideBudget,_selectedPreset]] call CBA_fnc_serverEvent;
[format ["%1 preset selected for %2",_preset, _side]] call ace_common_fnc_displayTextStructured;
