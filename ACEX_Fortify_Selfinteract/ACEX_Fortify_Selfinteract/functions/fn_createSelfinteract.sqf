private _fortifyMainMenu = [
	"acexFortify",
	"ACEX Fortify",
	"ACEX_Fortify_SelfInteract\icons\hammer.paa",
	{},
	{!isMultiplayer || {is3DENMultiplayer} || {(call BIS_fnc_admin) > 0} || {!isNull (getAssignedCuratorLogic player)}}
] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _fortifyMainMenu] call ace_interact_menu_fnc_addActionToObject;

private _fortifyMainMenuActions = [];

private _fortifyToggleChildren = {
	params ["_target", "_player", "_boolArray"];
	private _toggleChildActions = [];
	{
		private _toggleAction = [
			format ["acexFortifyToggle%1", _x],
			format ["Allow fortification placement = %1", _x],
			format ["ACEX_Fortify_SelfInteract\icons\toggle%1.paa", _x],
			{
				params ["_target", "_player", "_bool"];
				missionNamespace setVariable ["acex_fortify_fortifyAllowed", _bool, true];
			},
			{true},
			{},
			_x
		] call ace_interact_menu_fnc_createAction;
		_toggleChildActions pushBack [_toggleAction, [], _player];
	} forEach _boolArray;

	_toggleChildActions
};

_fortifyMainMenuActions pushback ([
	"acexFortifyToggle",
	"ACEX Fortify ON/OFF",
	"ACEX_Fortify_SelfInteract\icons\powerToggle.paa",
	{},
	{true},
	_fortifyToggleChildren,
	[true, false]
] call ace_interact_menu_fnc_createAction);

private _fortifyBudgetChildren = {
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
};

private _budgetNumbers = parseSimpleArray SKT_fortify_CBA_budgetValues;
private _negativeBudgetNumbers = [_budgetNumbers, { _x * -1 }] call CBA_fnc_filter;

_fortifyMainMenuActions pushback ([
	"acexFortifyBudgetAdd",
	"+ Budget",
	"ACEX_Fortify_SelfInteract\icons\bank.paa",
	{},
	{true},
	_fortifyBudgetChildren,
	_budgetNumbers // TODO -- can this somehow get checked each frame so it can be updated live from the CBA settings menu?
] call ace_interact_menu_fnc_createAction);

_fortifyMainMenuActions pushback ([
	"acexFortifyBudgetMin",
	"- Budget",
	"ACEX_Fortify_SelfInteract\icons\bankNo.paa",
	{},
	{true},
	_fortifyBudgetChildren,
	_negativeBudgetNumbers
] call ace_interact_menu_fnc_createAction);

_fortifyMainMenuActions pushback ([
	"acexFortifyBudgetCheck",
	"Check Budget",
	"ACEX_Fortify_SelfInteract\icons\search.paa",
	{
		private _side = side player;
		private _sideBudget = [_side] call acex_fortify_fnc_getBudget;
		[format ["%1's budget is $%2",_side,_sideBudget]] call ace_common_fnc_displayTextStructured;
	},
	{true}
] call ace_interact_menu_fnc_createAction);

private _fortifyPresetChildren = {
	params ["_target", "_player", "_preset"];
	private _presetActions = [];
	{
		private _presetAction = [
			format ["Preset_%1", _x],
			format ["%1", _x],
			"ACEX_Fortify_SelfInteract\icons\selectedPreset.paa",
			{
				[side _player, (_this select 2)] call SKT_fortify_fnc_updatePreset
			},
			{true},
			{},
			_x
		] call ace_interact_menu_fnc_createAction;
		_presetActions pushBack [_presetAction, [], _player];
	} forEach _preset;

	_presetActions
};

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
	_fortifyPresetChildren,
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
	{[player, "ACE_Fortify"] remoteExec ["addItem", cursorTarget]},
	{true}
] call ace_interact_menu_fnc_createAction);

private _fortifyNotesHint = {
	private _myText = composeText
	[
		 "|- Selecting a preset will turn ON fortify if no preset has been selected yet",linebreak,linebreak,
		 "|- Placing the budget into negative will still allow players to remove placed fortifications",linebreak,linebreak,
		 "|- Players require a 'fortify tool' in their inventory to place fortifications!",linebreak,linebreak,
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
