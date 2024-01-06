//stuff for building respawn menus

#include "RespawnCommandCommon.as"

//class for getting everything needed for swapping to a class at a building

shared class PlayerClass
{
	string name;
	string iconFilename;
	string iconName;
	string configFilename;
	string description;
};
int P_Archers;
int P_Builders;
int P_Knights;
int builder_max = 2;
int archer_max = 2;
const f32 CLASS_BUTTON_SIZE = 2;

//adding a class to a blobs list of classes

void addPlayerClass(CBlob@ this, string name, string iconName, string configFilename, string description)
{
	if (!this.exists("playerclasses"))
	{
		PlayerClass[] classes;
		this.set("playerclasses", classes);
	}

	PlayerClass p;
	p.name = name;
	p.iconName = iconName;
	p.configFilename = configFilename;
	p.description = description;
	this.push("playerclasses", p);
}

//helper for building menus of classes

void addClassesToMenu(CBlob@ this, CGridMenu@ menu, u16 callerID)
{
	P_Archers = 0;
	P_Builders = 0;
	P_Knights = 0;
	for (u32 i = 0; i < getPlayersCount(); i++)
	{
		if (getPlayer(i).getScoreboardFrame() == 2 && getLocalPlayer().getTeamNum() == getPlayer(i).getTeamNum()) {P_Archers++;}
		if (getPlayer(i).getScoreboardFrame() == 1 && getLocalPlayer().getTeamNum() == getPlayer(i).getTeamNum()) {P_Builders++;}
		if (getPlayer(i).getScoreboardFrame() == 3 && getLocalPlayer().getTeamNum() == getPlayer(i).getTeamNum()) {P_Knights++;}
	}
	PlayerClass[]@ classes;
//	for(uint i = 0 ; i < classes.length; i++)
	if (this.get("playerclasses", @classes))
	{
		for (uint i = 0 ; i < classes.length; i++)
		{
			PlayerClass @pclass = classes[i];
			CBitStream params;
			write_classchange(params, callerID, pclass.configFilename);
			CGridButton@ button = menu.AddButton(pclass.iconName, getTranslatedString(pclass.name), SpawnCmd::changeClass, Vec2f(CLASS_BUTTON_SIZE, CLASS_BUTTON_SIZE), params);
			CRules@ rules = getRules();

			// Limiting classes stuff
			if(pclass.configFilename == "archer")
			{
				if (P_Archers < archer_max)
				{
					button.SetHoverText( "    " + P_Archers + " / " + archer_max + "\n");
				}
				else if (P_Archers >= archer_max)
				{
					if (g_locale == "ru")
					{
						button.SetHoverText( "    " + "Всего " + P_Archers + " / " + archer_max + "\n");
					}
					else
					{
						button.SetHoverText( "    " + "Total " + P_Archers + " / " + archer_max + "\n");
					}
				}
			}
			else if (pclass.configFilename == "builder")
			{
				if (P_Builders < builder_max && !rules.isWarmup())
				{
					button.SetHoverText( "    " + P_Builders + " / " + builder_max + "\n");
				}
				else if (P_Builders >= builder_max && !rules.isWarmup())
				{
					if (g_locale == "ru")
					{
						button.SetHoverText( "    " + "Всего " + P_Builders + " / " + builder_max + "\n");
					}
					else
					{
						button.SetHoverText( "    " + "Total " + P_Builders + " / " + builder_max + "\n");
					}
				}
			}
//			button.SetHoverText( pclass.description + "\n");
		}
	}
}

PlayerClass@ getDefaultClass(CBlob@ this)
{
	PlayerClass[]@ classes;

	if (this.get("playerclasses", @classes))
	{
		return classes[0];
	}
	else
	{
		return null;
	}
}
