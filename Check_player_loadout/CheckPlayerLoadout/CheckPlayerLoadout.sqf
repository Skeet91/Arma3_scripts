skeet_fnc_checkLoadout = {
  params ["_target", "_player", "_params"];

  _color = assignedTeam _target;
  if (isNil "_color") then {_color = "MAIN"};
      switch (_color) do
      {
          case "MAIN": 	{_color = '#FFFFFF'};
          case "RED": 	{_color = '#FF0000'};
          case "BLUE": 	{_color = '#0000FF'};
          case "GREEN":	{_color = '#00FF00'};
          case "YELLOW": 	{_color = '#FFFF00'};
          default 		{_color = '#FFFFFF'};
      };
  _nameStr = format ["<t size='1' color='%4' align='left'>%1</t><t size='0.85' align='right'>Load: %2Lb - %3Kg</t><br/>",name _target,((round ((loadAbs _target * 0.1) * 100)) / 100),((round ((loadAbs _target * 0.1) * (1/2.2046) * 100)) / 100),_color];

  _color = assignedTeam (leader(group _target));
  if (isNil "_color") then {_color = "MAIN"};
      switch (_color) do
      {
          case "MAIN": 	{_color = '#FFFFFF'};
          case "RED": 	{_color = '#FF0000'};
          case "BLUE": 	{_color = '#0000FF'};
          case "GREEN": 	{_color = '#00FF00'};
          case "YELLOW": 	{_color = '#FFFF00'};
          default 		{_color = '#FFFFFF'};
      };
  _grpStr = format ["<t size='1' color='%3' align='left'>%1:</t><t size='0.85' align='right'>Lead: %2</t><br/>",groupID (group _target),name (leader (group _target)),_color];

  {
  	_color = assignedTeam _x;
      switch (_color) do
      {
          case "MAIN": 	{_color = '#FFFFFF'};
          case "RED": 	{_color = '#FF0000'};
          case "BLUE": 	{_color = '#0000FF'};
          case "GREEN": 	{_color = '#00FF00'};
          case "YELLOW": 	{_color = '#FFFF00'};
          default 		{_color = '#FFFFFF'};
      };
  	_grpStr = format ["%1<t color='%3' size='0.85' align='left'>%2</t><br/>",_grpStr,name _x,_color];
  } forEach ((units (group _target)) - [_target] - [leader (group _target)]);


  _gearStr = format ["<t size='1' color='#FF0000' underline='true' align='left'>Gear:</t><br/>"];
  {
  	_name = getText( configfile >> "CfgWeapons" >> _x  >> "displayName");
  	if (_x == (goggles _target))then
  	{
  		_name = getText( configfile >> "CfgGlasses" >> _x  >> "displayName");
  	};
  	if (_x == (backpack _target))then
  	{
  		_name = getText( configfile >> "CfgVehicles" >> _x  >> "displayName");
  	};
  	_gearStr = format ["%1<t color='#00FF33' size='0.84' align='left'>%2</t><br/>",_gearStr,_name];
  } forEach (([headgear _target] + [goggles _target] + [uniform _target] + [vest _target] + [backpack _target]) - [""]);


  _weapStr = format ["<t size='1' color='#FF0000' underline='true' align='left'>Weapons:</t><br/>"];
  {
  	if (count((_target weaponAccessories _x) - [""]) > 0) then
  	{
  		_accStr = format [""];
  		{
  			_accStr = format ["%1<t size='0.85' align='center'>%2</t><br/>",_accStr,(getText( configfile >> "CfgWeapons" >> _x  >> "displayName"))];
  		}forEach ((_target weaponAccessories _x) - [""]);
  		_weapStr = format ["%1<t color='#00FF33' size='0.9' align='left'>%2</t><br/>%3",_weapStr,(getText( configfile >> "CfgWeapons" >> _x  >> "displayName")),_accStr];
  	}
  	else
  	{
  		_weapStr = format ["%1<t color='#00FF33' size='0.9' align='left'>%2</t><br/>",_weapStr,(getText( configfile >> "CfgWeapons" >> _x  >> "displayName"))]
  	};
  } forEach (weapons _target);


  _uniqueArray = [];
  _compressedArray = [];
  {
  	if (!(_x in _uniqueArray)) then
  	{
  		_uniqueArray set [count _uniqueArray,_x];
  		_compressedArray set [count _compressedArray,[_x,1]];
  	}
  	else
  	{
  		_className = _x;
  		_i = 0;
  		{
  			if ((_x select 0) == _className) exitWith {_compressedArray set [_i,[_className,(_x select 1) + 1]];};
  			_i = _i + 1;
  		} forEach _compressedArray;
  	};
  } forEach (magazines _target + primaryWeaponMagazine _target + secondaryWeaponMagazine _target + handgunMagazine _target);

  _magStr = format ["<t size='1' color='#FF0000' underline='true' align='left'>Magazines:</t><br/>"];
  {
  	_magStr = format ["%1<t size='0.9' color='#00FF33' align='left'>%2</t><t align='right' size='0.9'>%3</t><br/>",_magStr,(getText( configfile >> "Cfgmagazines" >> _x select 0 >> "displayName")),(_x select 1)];
  } forEach _compressedArray;


  _uniqueArray = [];
  _compressedArray = [];
  {
  	if (!(_x in _uniqueArray)) then
  	{
  		_uniqueArray set [count _uniqueArray,_x];
  		_compressedArray set [count _compressedArray,[_x,1]];
  	}
  	else
  	{
  		_className = _x;
  		_i = 0;
  		{
  			if ((_x select 0) == _className) exitWith {_compressedArray set [_i,[_className,(_x select 1) + 1]];};
  			_i = _i + 1;
  		} forEach _compressedArray;
  	};
  } forEach (items _target + assignedItems _target - weapons _target);

  _itemStr = format ["<t size='1' color='#FF0000' underline='true' align='left'>Items:</t><br/>"];
  {
  	_itemStr = format ["%1<t size='0.9' color='#00FF33' align='left'>%2</t><t align='right' size='0.9'>%3</t><br/>",_itemStr,(getText( configfile >> "Cfgweapons" >> _x select 0 >> "displayName")),(_x select 1)];
  } forEach _compressedArray;


  _Str = _nameStr + "<br/>" + _grpStr + "<br/>" + _gearStr + "<br/>" + _weapStr + "<br/>" + _magStr + "<br/>" + _itemStr;

  hintSilent parseText _Str;
};

private _checkTargetsGear = [
		"checkTargetsGear",
		"Check Targets Gear",
		"",
		{call skeet_fnc_checkLoadout},
		{!isMultiplayer || {is3DENMultiplayer} || {(call BIS_fnc_admin) > 0} || {!isNull (getAssignedCuratorLogic player)}}
] call ace_interact_menu_fnc_createAction;
["CAManBase",0,["ACE_MainActions"],_checkTargetsGear,true] call ace_interact_menu_fnc_addActionToClass;
