/*
SM-ViewAngle-Fix

Copyright (C) 2016 Alvy Piper / 2020 sapphyrus

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#include <sourcemod>

public Plugin:myinfo = 
{ 
	name = "ViewAngle Fix", 
	author = "Alvy Piper / sapphyrus", 
	description = "Normalizes out of bounds viewangles", 
	version = "0.2", 
	url = "github.com/sapphyrus/" 
};

public Action OnPlayerRunCmd(int client, int& buttons, int& impulse, float vel[3], float angles[3], int& weapon, int& subtype, int& cmdnum, int& tickcount, int& seed, int mouse[2])
{
	if (!IsPlayerAlive(client)) {
		return Plugin_Continue;
	}

	// clamp pitch
	if (angles[0] > 89.0) {
		angles[0] = 89.0;
	} else if (angles[0] < -89.0) {
		angles[0] = -89.0;
	}

	// normalize yaw
	if (angles[1] > 180.0 || angles[1] < -180.0) {
		float flRevolutions = angles[1] / 360.0;

		if (flRevolutions < 0.0) {
			flRevolutions = -flRevolutions;
		}

		int iRevolutions = RoundToFloor(flRevolutions);

		if (angles[1] > 0.0) {
			angles[1] -= iRevolutions * 360.0;
		} else {
			angles[1] += iRevolutions * 360.0;
		}
	}

	// clamp roll
	if (angles[2] > 50.0) {
		angles[2] = 50.0;
	} else if (angles[2] < -50.0) {
		angles[2] = -50.0;
	}

	return Plugin_Changed;
}
