/*
 * mdl_relay.c
 *
 *  Created on: 12 Feb 2024
 *  Developer: Abdelrahman Ahmed
 *  Main purpose: to implement the functions declared in the “mdl_relay.h”
 *  These functions are responsible for:
 * 		- Relay Initialization
 *		- Controlling relays
 *		- Monitoring Relays’ states
 *		- Detecting any errors in Relays operation


#include "mdl_relay.h"
#include <stdbool.h>
#include <stdint.h>
#include "mdl_di.h"
#include "mdl_do.h"
#include "mdl_clock.h"

//timeout values for error checking (in milliseconds)

#define Welded_Timeout 1000
#define Open_Timeout 1000


/* Initialize all relay control outputs to OFF*/
void Relay_init()
{
	DO_index_E i; // i= number of relays
	for(i=DO_index_00;i<DO_index_NUMBER;i++)
		DO_setOutputState(i,DO_state_OFF);
}

/*.....control function receive two variable index & state*/
void relay_ctrl(DO_index_E index,DO_state_E state)
{
	DO_setOutputState(index,state);  // Set the state of the specified relay control output
}

/* Get the state of the relay based on the feedback from a digital input*/
/*Function return relay open or close*/
RelayState Relay_getState(DI_index_E index)
{
	DI_state_E feedback=DI_getInputState(index);
	return (feedback== DO_state_ON) ? RELAY_Open : RELAY_Closed;//
}

/* Get the state of the relay Error*/

RelayError Relay_getError(DI_index_E index)
{
	RelayState state=Relay_getState(index); //Get the current state
	RelayError error=Relay_ERROR_UNKNOWN;   // Initialize error state
CLOCK_ticks_T start_time = CLOCK_getTicks(); // Record starting time for timeout

	/*if relay closed begin count time*/
	/*when timeout Welded & Open break before damage relay*/
	//Check for Welded condition at run time
	if (state==Relay_Closed)
	{
		while(CLOCK_getTicks()-start_time<Welded_Timeout)
		{
			if (Relay_getState(index)==RELAY_Open)
			{
				error=RELAY_ERROR_WELDED; //Detected welded condition
				break;
			}
		}
}
	else
	{
		/* Check for Constantly Open condition*/
		while(CLOCK_get_Ticks()-start_time<Open_Timeout)
		{
			if (Relay_getState(index)==RELAY_Closed)
			{
				error=RELAY_ERROR_CONSTANTLY_OPEN; //Detected Constantly Open condition
				break;
			}
		}
	}
}






