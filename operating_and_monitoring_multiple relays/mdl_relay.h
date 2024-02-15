/*
 * mdl_relay.h
 *
 *  Created on: 12 Feb 2024
 *  Developer: Abdelrahman Ahmed
 *  Main purpose: To declare the interface or API for the relay module
 */

#ifndef MDL_RELAY_H
#define MDL_RELAY_H

#include <stdbool.h>
#include "mdl_di.h"
#include "mdl_do.h"
#include "mdl_clock.h"

// Enumeration representing the state of the relay
typedef enum {
	RELAY_Open,
	RELAY_Closed,
} RelayState;

//Enumeration for relay errors
typedef enum {
	RELAY_ERROR_WELDED,				// Relay is open (not closed)
	RELAY_ERROR_CONSTANTLY_OPEN,			// Relay is closed
	RELAY_ERROR_UNKNOWN, 				// Unknown error
} RelayError;

/* Functions Prototypes */
void Relay_init();					// Initialize relay
void relay_ctrl(DO_index_E index,DO_state_E state);// Control relay
RelayState Relay_getState(DI_index_E index); 	// Get relay state
RelayError Relay_getError(DI_index_E index); 	// Get relay error

#endif /* MDL_RELAY_H */



