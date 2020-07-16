if (isNil "MIL_AirBurstAmmo") then {
	MIL_AirburstAmmo = ["rhs_mag_maaws_HE","MRAWS_HE_F","RPG32_HE_F","RPG7_F"];
};

[] call compile preprocessFileLineNumbers "MIL_Airburst\airburst.sqf";
