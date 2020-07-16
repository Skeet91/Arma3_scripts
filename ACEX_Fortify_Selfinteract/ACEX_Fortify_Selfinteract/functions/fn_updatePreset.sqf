params ['_side','_preset'];

private _selectedPreset = [_preset] call acex_fortify_fnc_getPlaceableSet;
private _sideBudget = [_side] call acex_fortify_fnc_getBudget;
["acex_fortify_registerObjects", [_side,_sideBudget,_selectedPreset]] call CBA_fnc_serverEvent;
[format ["%1 preset selected!",_preset]] call ace_common_fnc_displayTextStructured;
