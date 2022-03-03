params ["_target", "_player", "_preset"];
private _actions = [];
{
    private _action = [
        format ["Side_%1", _x],
        format ["%1", _x],
        "",
        {
            params ["_target", "_player", "_presetArray"];
            [_presetArray select 0, _presetArray select 1] call skt_fnc_fortifyUpdatePreset;
        },
        {true},
        {},
        [_x, _preset]
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _player];
} forEach [west, east, independent, civilian];

_actions