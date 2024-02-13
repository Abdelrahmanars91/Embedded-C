/*
 * mdl_relay.c
 *
 *  Created on: 12 Feb 2024
 *      Author: Abdelrahman
 */


#include "mdl_relay.h"

void RELAY_initialize(Relay *relay, RelayConfig config) {
relay->config = config;
relay->state = RELAY_CLOSED;
relay->lastControlTime = CLOCK_getTicks();
}

void RELAY_executeTask(Relay *relay) {
// Check if it's time to monitor and handle errors
CLOCK_ticks_T currentTime = CLOCK_getTicks();
if (currentTime - relay->lastControlTime >= RELAY_MONITOR_INTERVAL_MS) {
DI_state_E feedbackState = DI_getInputState(relay->config.feedbackInput);

// Check for errors
if (relay->state == RELAY_OPEN && feedbackState == DI_state_ON) {
relay->state = RELAY_ERROR_CONST_OPEN;
} else if (relay->state == RELAY_CLOSED && feedbackState == DI_state_OFF) {
relay->state = RELAY_ERROR_WELDED;
} else {
relay->state = RELAY_ERROR_NONE;
}

relay->lastControlTime = currentTime;
}
}

void RELAY_destroy(Relay *relay) {
// Cleanup code
}

void RELAY_control(Relay *relay, RelayControl control) {
// Control the relay based on the given command
switch (control) {
case RELAY_CONTROL_OPEN:
DO_setOutputState(relay->config.controlOutput, DO_state_ON);
relay->state = RELAY_OPEN;
break;
case RELAY_CONTROL_CLOSE:
DO_setOutputState(relay->config.controlOutput, DO_state_OFF);
relay->state = RELAY_CLOSED;
break;
default:
// Handle unknown control command
break;
}
}

RelayState RELAY_getStatus(Relay *relay) {
return relay->state;
}

RelayState RELAY_getError(Relay *relay) {
return (relay->state == RELAY_ERROR_NONE) ? RELAY_ERROR_NONE : relay->state;
}
