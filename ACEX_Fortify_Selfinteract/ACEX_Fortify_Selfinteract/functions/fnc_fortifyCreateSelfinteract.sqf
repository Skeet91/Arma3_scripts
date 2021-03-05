private _fortifyMainMenu = [
	"acexFortify",
	"ACEX Fortify",
	"ACEX_Fortify_SelfInteract\icons\hammer.paa",
	{},
	{!isMultiplayer || {is3DENMultiplayer} || {(call BIS_fnc_admin) > 0} || {!isNull (getAssignedCuratorLogic player)}}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _fortifyMainMenu] call ace_interact_menu_fnc_addActionToObject;



private _fortifyMainMenuActions = [];



_fortifyMainMenuActions pushback ([
	"acexFortifyToggle",
	"ACEX Fortify ON/OFF",
	"ACEX_Fortify_SelfInteract\icons\powerToggle.paa",
	{},
	{true},
	{call skt_fnc_fortifyToggleChildren},
	[true, false]
] call ace_interact_menu_fnc_createAction);



private _negativeBudgetValues = [SKT_fortify_budgetValues, { _x * -1 }] call CBA_fnc_filter;

_fortifyMainMenuActions pushback ([
	"acexFortifyBudgetAdd",
	"+ Budget",
	"ACEX_Fortify_SelfInteract\icons\bank.paa",
	{},
	{true},
	{call skt_fnc_fortifyBudgetChildren},
	SKT_fortify_budgetValues
] call ace_interact_menu_fnc_createAction);



_fortifyMainMenuActions pushback ([
	"acexFortifyBudgetMin",
	"- Budget",
	"ACEX_Fortify_SelfInteract\icons\bankNo.paa",
	{},
	{true},
	{call skt_fnc_fortifyBudgetChildren},
	_negativeBudgetValues
] call ace_interact_menu_fnc_createAction);



_fortifyMainMenuActions pushback ([
	"acexFortifyBudgetCheck",
	"Check Budget",
	"ACEX_Fortify_SelfInteract\icons\search.paa",
	{
		private _side = side player;
		private _sideBudget = [_side] call acex_fortify_fnc_getBudget;
		[format ["%1's budget is $%2",_side,_sideBudget]] call ace_common_fnc_displayTextStructured; //TODO make a child that splits out to each side
	},
	{true}
] call ace_interact_menu_fnc_createAction);



private _configsCustom = "true" configClasses (missionConfigFile >> "ACEX_Fortify_Presets");
private _classNamesCustom = _configsCustom apply {configName _x};

private _configsPremade = "true" configClasses (ConfigFile >> "ACEX_Fortify_Presets");
private _classNamesPremade = _configsPremade apply {configName _x};

private _combinedPresetsList = _classNamesCustom + _classNamesPremade;

_fortifyMainMenuActions pushback ([
	"acexFortifyPresetsMenu",
	"Presets",
	"ACEX_Fortify_SelfInteract\icons\list.paa",
	{},
	{true},
	{call skt_fnc_fortifyPresetChildren},
	_combinedPresetsList
] call ace_interact_menu_fnc_createAction);



_fortifyMainMenuActions pushback ([
	"acexFortifyGiveSelfTool",
	"Give Self x10 Fortify tools",
	"ACEX_Fortify_SelfInteract\icons\gift.paa",
	{for "_i" from 1 to 10 do {player addItem "ACE_Fortify"}},
	{true}
] call ace_interact_menu_fnc_createAction);



_fortifyMainMenuActions pushback ([
	"acexFortifyGiveTargetTool",
	"Give target x1 Fortify tool",
	"ACEX_Fortify_SelfInteract\icons\gift.paa",
	{[player, "ACE_Fortify"] remoteExec ["addItem", cursorTarget]}, //TODO turn this into all players in area around player
	{true}
] call ace_interact_menu_fnc_createAction);



private _fortifyNotesHint = {
	private _myText = composeText
	[
		 "|- Selecting a preset will turn ON fortify if no preset has been selected yet",linebreak,linebreak,
		 "|- Players require a 'fortify tool' in their inventory to place fortifications!",linebreak,linebreak,
		 "|- Placing the budget into negative will still allow players to remove placed fortifications",linebreak,linebreak,
		 "|- Removeing fortifications adds back to the budget of the side that placed the object"
	];

	[_myText, false, 10] call ace_common_fnc_displayText
};

_fortifyMainMenuActions pushback ([
	"acexFortifyNotes",
	"Notes",
	"ACEX_Fortify_SelfInteract\icons\report.paa",
	_fortifyNotesHint,
	{true}
] call ace_interact_menu_fnc_createAction);



{
	[player, 1, ["ACE_SelfActions", "acexFortify"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _fortifyMainMenuActions;
