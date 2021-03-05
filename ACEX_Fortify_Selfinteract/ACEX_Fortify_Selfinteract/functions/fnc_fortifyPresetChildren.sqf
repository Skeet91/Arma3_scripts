params ["_target", "_player", "_preset"];
private _presetActions = [];
{
    private _presetAction = [
        format ["Preset_%1", _x],
        format ["%1", _x],
        "ACEX_Fortify_SelfInteract\icons\selectedPreset.paa",
        {
            [side _player, (_this select 2)] call skt_fnc_fortifyUpdatePreset
        },
        {true},
        {},
        _x
    ] call ace_interact_menu_fnc_createAction;
    _presetActions pushBack [_presetAction, [], _player];
} forEach _preset;

_presetActions