#pragma newdecls required
#pragma semicolon 1

#include <sourcemod>

public Plugin myinfo =
{
	name = "block thirdperson zoom script",
	author = "koen",
	description = "",
	version = "",
	url = "https://github.com/notkoen"
};

public void OnGameFrame()
{
	for (int i = 1; i <= MaxClients; i++)
	{
		ClientCommand(i, "cam_idealdist 150");
	}
}