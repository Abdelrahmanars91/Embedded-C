/*
 * mdl_relay.h
 *
 *  Created on: 12 Feb 2024
 *      Author: Abdelrahman
 */
#ifndef MDL_RELAY_H
#define MDL_RELAY_H

#include "mdl_di.h"
#include "mdl_do.h"
#include "mdl_clock.h"

typedef enum {
RELAY_OPEN,
RELAY_CLOSED,
RELAY_ERROR_WELDED,
RELAY_ERROR_CONST_OPEN,
RELAY_ERROR_NONE
} RelayState;

typedef enum {
RELAY_CONTROL_OPEN,
RELAY_CONTROL_CLOSE
} RelayControl;

typedef struct {
DO_index_E controlOutput;
DI_index_E feedbackInput;
} RelayConfig;

typedef struct {
RelayState state;
RelayConfig config;
CLOCK_􏰀cks_T lastControlTime;
} Relay;

void RELAY_initialize(Relay *relay, RelayConfig config);
void RELAY_executeTask(Relay *relay);
void RELAY_destroy(Relay *relay);
void RELAY_control(Relay *relay, RelayControl control);
RelayState RELAY_getStatus(Relay *relay);
RelayState RELAY_getError(Relay *relay);

#endif // MDL_RELAY_H
