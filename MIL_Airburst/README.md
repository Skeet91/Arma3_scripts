Airburst HE

Original by: Millenwise (beno_83au)

Edits by: Skeet.

Use and abuse as required. Please just give credit for the original concept.

https://forums.bohemia.net/forums/topic/210503-release-airburst-he/

Millenwise (beno_83au):

- "I created this for VBS3 and converted it across (and fancied it up) for ArmA 3. It allows required ammunition types to be detonated for use as an airburst round.
This was converted primarily for the ADF Uncut Carl Gustav 84mm HE round, however it could conceivably be used for any explosive round."

Credits:

	- madpat3 for his German translation.
	- edits by Skeet.
	    - adjusted how script is initialized
		- changed add action to ACE action
		- added check for "canDoAirburst" variable so can be added or removed mid mission
		- Moved to inline fnc's in single sqf

Features:

	- GUI for quick input of range.
	- Engagement distances:
		- Range setting under 40m will have no affect (i.e. impact detonation).
		- Range setting between 40m and 70m will have a chance to fail to detonate.
	- Can be applied to only selected players (e.g. units who would be trained in the application of HE rounds for airburst).
	- Can account for numerous ammunition types (customisable).
	- Range setting will be "remembered" until a round is fired (pre-set a range into the next round).
	- More of a sacrifice on realism in favour of gameplay:
		- Range can be re-adjusted, including closer, without "breaking" the fuse.
		- AT gunner is the one making fuse adjustments.

To use:

	- Copy the folder MIL_Airburst to your mission folder.
	- Add these lines to your description.ext

```
    #include "MIL_Airburst\defines.hpp"	//(basic level of GUI defines, nothing flash, only use if needed)
    #include "MIL_Airburst\fuseSetting_dialog.hpp"
```

Add these lines to your init.sqf

```
if (isNil "MIL_AirBurstAmmo") then {
	MIL_AirburstAmmo = ["rhs_mag_maaws_HE","MRAWS_HE_F","RPG32_HE_F","RPG7_F"];
};

[] call compile preprocessFileLineNumbers "MIL_Airburst\airburst.sqf";
```
