params ["_target", "_player", "_amount"];
private _actions = [];
{
    private _action = [
        format ["Side_%1", _x],
        format ["%1", _x],
        "",
        {
            params ["_target", "_player", "_amountArray"];
            [_amountArray select 0, _amountArray select 1, true] call acex_fortify_fnc_updateBudget
        },
        {true},
        {},
        [_x, _amount]
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _player];
} forEach [west, east, independent, civilian];

_actions