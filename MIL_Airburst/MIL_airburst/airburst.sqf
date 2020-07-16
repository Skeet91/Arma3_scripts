MIL_fnc_setBoxNumber = {
  disableSerialization;
  params ["_display"];
  if ((player getVariable ["FuseSetting","0"]) != "0") then {
    (_display displayCtrl 101) ctrlSetText (player getVariable ["FuseSetting","0"]);
  };
  ctrlSetFocus (_display displayCtrl 101);
};

MIL_fnc_fuseSetting_updater = {
  disableSerialization;
  private ["_display"];
  _display = uiNamespace getVariable "MIL_fuseSetting_HE";

  [_display] call MIL_fnc_setBoxNumber;

  MIL_displayEH_id = _display displayAddEventHandler ["KeyDown",{
  	private ["_key","_display","_fuse"];
  	_key = _this select 1;
  	_display = uiNamespace getVariable "MIL_fuseSetting_HE";
  	switch (_key) do {
  		case 1: {
  			//Escape
  			_display displayRemoveEventHandler ["KeyDown",MIL_displayEH_id];
  			closeDialog 0;
  		};
  		case 14: {
  			//Backspace
  			ctrlSetText [101,""];
  		};
  		case 28;//Enter
  		case 156: {
  			//Enter
  			_display displayRemoveEventHandler ["KeyDown",MIL_displayEH_id];
  			player setVariable ["FuseSetting",(ctrlText 101),false];

  			if ((parseNumber (ctrlText 101)) < 40) then {
  				hint "Fuse set: Impact.";
  				} else {
  				hint format["Fuse set: %1",(ctrlText 101) + "m."];
  			};

  			closeDialog 0;
  		};
  		case 211: {
    		//Delete
    		ctrlSetText [101,""];
  		};
  	};
  	true
  }];
};

MIL_fnc_airburst = {
  params ["_unit","_round","_fuse",["_randomFail",0]];

  _fuse = parseNumber (player getVariable ["FuseSetting","0"]);

  if ((_fuse >= 40) && (_fuse < 70) && ((random 1) > 0.85)) exitWith {
  	private ["_text"];
  	player setVariable ["FuseSetting","0",false];
  	sleep 1;
  	hint parseText "<t color='#ff0000'>Fuse failed</t>";
  };

  if (_fuse >= 40) then {
  	waitUntil {(_unit distance _round) >= _fuse};
  	_can = "Land_BakedBeans_F" createVehicle (getPos _round);
  	_can setPosATL (getPosATL _round);
  	sleep 0.1;
  	deleteVehicle _can;
  	hint "";
  };

  player setVariable ["FuseSetting","0",false];
};

private _airBurstACEaction = [
	"airBurst",
 	"HE Fuse Setting",
	"MIL_Airburst\MIL_Explosion.paa",
	{CreateDialog "MIL_fuseSetting_HE"},
	{(player getVariable ["canDoAirburst", false]) && {(currentMagazine _target) in MIL_AirburstAmmo}}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _airBurstACEaction] call ace_interact_menu_fnc_addActionToObject;

_index = player addEventHandler [
  "Fired",
    {
      if ((_this select 5) in MIL_AirburstAmmo) then
      {
        [_this select 0,_this select 6] spawn MIL_fnc_airburst;
      };
    }
];
