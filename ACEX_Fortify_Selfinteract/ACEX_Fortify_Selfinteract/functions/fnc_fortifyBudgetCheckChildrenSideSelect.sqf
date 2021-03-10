params ["_target", "_player", "_side"];
private _actions = [];
{
    private _action = [
        format ["Side_%1", _x],
        format ["%1", _x],
        "",
        {
            params ["_target", "_player", "_side"];
            private _sideBudget = [_side] call acex_fortify_fnc_getBudget;
            [format ["%1's budget is $%2",_side,_sideBudget]] call ace_common_fnc_displayTextStructured;
        },
        {true},
        {},
        _x
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _player];
} forEach _side;

_actions