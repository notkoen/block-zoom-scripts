#pragma newdecls required
#pragma semicolon 1

#include <sourcemod>

ConVar g_cvRate;
float g_flRefreshRate;
Handle g_hCheckTimer;

public Plugin myinfo =
{
	name = "block thirdperson zoom script",
	author = "koen",
	description = "",
	version = "",
	url = "https://github.com/notkoen"
};

public void OnPluginStart()
{
	g_cvRate = CreateConVar("sm_tp_check_rate", "0.1", "Set cam_idealdist checking rate", _, true, 0.1);
	g_flRefreshRate = g_cvRate.FloatValue;
	HookConVarChange(g_cvRate, TimerUpdated);
	AutoExecConfig(true);
}

public void TimerUpdated(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	g_flRefreshRate = StringToFloat(newValue);
	delete g_hCheckTimer;
	g_hCheckTimer = CreateTimer(g_flRefreshRate, CheckForSusCams, _, TIMER_REPEAT);
}

public void OnConfigsExecuted()
{
	g_hCheckTimer = CreateTimer(g_flRefreshRate, CheckForSusCams, _, TIMER_REPEAT);
}

public void OnMapEnd()
{
	delete g_hCheckTimer;
}

public Action CheckForSusCams(Handle timer)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		QueryClientConVar(i, "cam_idealdist", CheckForShit);
	}
	return Plugin_Continue;
}

public void CheckForShit(QueryCookie cookie, int client, ConVarQueryResult res, const char[] cvar, const char[] value, int admin)
{
	int dist = StringToInt(value);
	if (dist != 150)
	{
		ClientCommand(client, "cam_idealdist 150");
	}
}