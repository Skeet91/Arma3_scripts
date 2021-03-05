params ["_target", "_player", "_amount"];
private _budgetChildActions = [];
private _fortifyBudgetPic = "ACEX_Fortify_SelfInteract\icons\dollarPos.paa";
    if ((_amount select 0) < 0) then {
        _fortifyBudgetPic = "ACEX_Fortify_SelfInteract\icons\dollarNeg.paa"
    };
{
    private _budgetAction = [
        format ["changeAmount%1", _x],
        format ["$%1", _x],
        _fortifyBudgetPic,
        {
            [side _player, (_this select 2), true] call acex_fortify_fnc_updateBudget
        },
        {true},
        {},
        _x
    ] call ace_interact_menu_fnc_createAction;
    _budgetChildActions pushBack [_budgetAction, [], _player];
} forEach _amount;

_budgetChildActions