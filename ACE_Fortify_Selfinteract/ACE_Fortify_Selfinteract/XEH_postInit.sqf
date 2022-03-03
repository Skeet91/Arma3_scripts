if (isServer) then {
    missionNamespace setVariable ["ace_fortify_Budget_west", 0, true];
    missionNamespace setVariable ["ace_fortify_Budget_east", 0, true];
    missionNamespace setVariable ["ace_fortify_Budget_guer", 0, true];
    missionNamespace setVariable ["ace_fortify_Budget_civ", 0, true];
};

SKT_fortify_budgetValues = [50,100,200,500,1000];

skt_fnc_fortifyCreateSelfinteract = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyCreateSelfinteract.sqf";
skt_fnc_fortifyToggleChildren = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyToggleChildren.sqf";
skt_fnc_fortifyBudgetChildren = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyBudgetChildren.sqf";
skt_fnc_fortifyPresetChildren = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyPresetChildren.sqf";
skt_fnc_fortifyUpdatePreset = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyUpdatePreset.sqf";
skt_fnc_fortifyBudgetCheckChildrenSideSelect = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyBudgetCheckChildrenSideSelect.sqf";
skt_fnc_fortifyPresetChildrenSideSelect = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyPresetChildrenSideSelect.sqf";
skt_fnc_fortifyBudgetChildrenSideSelect = compile preprocessFileLineNumbers "ace_fortify_Selfinteract\functions\fnc_fortifyBudgetChildrenSideSelect.sqf";

if (hasInterface) then {
    call skt_fnc_fortifyCreateSelfinteract;
};