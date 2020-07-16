class MIL_fuseSetting_HE
{
    idd = 10846;
    movingenable = true;
	  onLoad = "uiNamespace setVariable ['MIL_fuseSetting_HE',_this select 0];[] call MIL_fnc_fuseSetting_updater;";

    class Controls
    {
		class 84mmHE_Picture: RscPicture
		{
			idc = 100;
			text = "MIL_airburst\MIL_84mmHE.paa";
			x = 0.1 * safezoneW + safezoneX;	//0.299479
			y = 0.104154 * safezoneH + safezoneY;
			w = 0.8 * safezoneW;
			h = 0.8 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class Range_Heading: RscStructuredText
		{
			idc = -1;
			text = "<t size='1.3' color='#000000' align='center' shadow='1'>RANGE (m):</t>"; //--- ToDo: Localize;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.175 * safezoneH + safezoneY;	//0.159133
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			colorActive[] = {-1,-1,-1,0};
		};
		class Range_Box: RscEdit
		{
			idc = 101;
			text = ""; //--- ToDo: Localize;
			x = 0.471354 * safezoneW + safezoneX;
			y = 0.203116 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,0,0,1};
			tooltip = Enter range (metres - e.g. 150, minimum 40), 0 = impact detonation. Airburst may fail from 40m to 70m.; //--- ToDo: Localize;
			sizeEx = 2 * GUI_GRID_H;
		};
		class Button_Confirm: RscButton
		{
			idc = 102;
			text = CONFIRM?; //--- ToDo: Localize;
			x = 0.4599995 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = Set range (can still be changed again).; //--- ToDo: Localize;
			action = "(uiNamespace getVariable 'MIL_fuseSetting_HE') displayRemoveEventHandler ['KeyDown',MIL_displayEH_id]; player setVariable ['FuseSetting',(ctrlText 101),false]; if ((parseNumber (ctrlText 101)) < 40) then {hint 'Fuse set: Impact.';} else {hint format['Fuse set: %1',(ctrlText 101) + 'm.'];}; closeDialog 0;";
		};
		class Button_Exit: RscButton
		{
			idc = 1701;
			text = CANCEL; //--- ToDo: Localize;
			x = 0.47249965 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.055 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = Exit without adjusting fuse setting.; //--- ToDo: Localize;
			onButtonClick = "(uiNamespace getVariable 'MIL_fuseSetting_HE') displayRemoveEventHandler ['KeyDown',MIL_displayEH_id]; closeDialog 0;";
		};
	};
};
