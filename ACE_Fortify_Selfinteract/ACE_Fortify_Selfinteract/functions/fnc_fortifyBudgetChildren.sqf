params ["_target", "_player", "_amount"];
private _budgetChildActions = [];
private _fortifyBudgetPic = "ACE_Fortify_SelfInteract\icons\dollarPos.paa";
    if ((_amount select 0) < 0) then {
        _fortifyBudgetPic = "ACE_Fortify_SelfInteract\icons\dollarNeg.paa"
    };
{
    private _budgetAction = [
        format ["changeAmount%1", _x],
        format ["$%1", _x],
        _fortifyBudgetPic,
        {
            params ["_target", "_player", "_amount"];
            [side _player, _amount, true] call ace_fortify_fnc_updateBudget
        },
        {true},
        {call skt_fnc_fortifyBudgetChildrenSideSelect},
        _x
    ] call ace_interact_menu_fnc_createAction;
    _budgetChildActions pushBack [_budgetAction, [], _player];
} forEach _amount;

_budgetChildActions