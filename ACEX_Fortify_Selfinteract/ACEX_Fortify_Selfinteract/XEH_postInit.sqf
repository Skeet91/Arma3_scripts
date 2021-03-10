if (isServer) then {
    missionNamespace setVariable ["acex_fortify_Budget_west", 0, true];
    missionNamespace setVariable ["acex_fortify_Budget_east", 0, true];
    missionNamespace setVariable ["acex_fortify_Budget_guer", 0, true];
    missionNamespace setVariable ["acex_fortify_Budget_civ", 0, true];
};

SKT_fortify_budgetValues = [50,100,200,500,1000];

skt_fnc_fortifyCreateSelfinteract = compile preprocessFileLineNumbers "ACEX_Fortify_Selfinteract\functions\fnc_fortifyCreateSelfinteract.sqf";
skt_fnc_fortifyToggleChildren = compile preprocessFileLineNumbers "ACEX_Fortify_Selfinteract\functions\fnc_fortifyToggleChildren.sqf";
skt_fnc_fortifyBudgetChildren = compile preprocessFileLineNumbers "ACEX_Fortify_Selfinteract\functions\fnc_fortifyBudgetChildren.sqf";
skt_fnc_fortifyPresetChildren = compile preprocessFileLineNumbers "ACEX_Fortify_Selfinteract\functions\fnc_fortifyPresetChildren.sqf";
skt_fnc_fortifyUpdatePreset = compile preprocessFileLineNumbers "ACEX_Fortify_Selfinteract\functions\fnc_fortifyUpdatePreset.sqf";

if (hasInterface) then {
    call skt_fnc_fortifyCreateSelfinteract;
};