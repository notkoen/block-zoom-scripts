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
		QueryClientConVar(i, "cam_idealdist", CheckForShit);
	}
}

public void CheckForShit(QueryCookie cookie, int client, ConVarQueryResult res, const char[] cvar, const char[] value, int admin)
{
	int dist = StringToInt(value);
	if (dist != 150)
	{
		ClientCommand(client, "cam_idealdist 150");
	}
}