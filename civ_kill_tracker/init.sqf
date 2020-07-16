if (isServer) then {

	SKT_civKillers = [[], 0] call CBA_fnc_hashCreate;
	SKT_civKillsTotal = 0;
	SKT_killerList = [];
	publicVariable "SKT_killerList";

	SKT_buildKillers = {
		SKT_killerList = [];
		[SKT_civKillers, { SKT_killerList pushBack format ["%1: %2", _key, _value] }] call CBA_fnc_hashEachPair;
		SKT_killerList = SKT_killerList joinString "<br/>";
		SKT_killerList = format ["%1<br/>Total civ kills: %2", SKT_killerList, SKT_civKillsTotal];
		publicVariable "SKT_killerList";
	};

	addMissionEventHandler ["EntityKilled", {
		params["_killed", "_killer"];
		if (side group _killed == civilian) then {

			SKT_civKillsTotal = SKT_civKillsTotal + 1;

			_kills = [SKT_civKillers, name _killer] call CBA_fnc_hashGet;
			_killsAdd = _kills + 1;

			[SKT_civKillers, name _killer, _killsAdd] call CBA_fnc_hashSet;

			call SKT_buildKillers;
			};
		}
	];
};




if (hasInterface) then {

	private _mainAction = [
		"SKT_civKillTrackerHint",
		"List Collateral Damage",
		"",
		{
			params ["_target", "_player", "_params"];

			[["Civ killers", 1.5, [1, 1, 0, 1]], [format ["%1", SKT_killerList]], true] call CBA_fnc_notify;
		},
		{true},
		{},
		{},
		{[0,0,0]},
		2,
		[false, false, false, true, false]
	] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions", "CBB_Framework"], _mainAction] call ace_interact_menu_fnc_addActionToObject;
};