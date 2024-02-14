/*
 * mdl_relay.c
 *
 *  Created on: 12 Feb 2024
 *      Author: Abdelrahman
 */


#include "mdl_relay.h"
#include <stdbool.h>
#include <stdint.h>
#include "mdl_di.h"
#include "mdl_do.h"
#include "mdl_clock.h"
#include "mdl_relay.h"

#define RELAY_DEBOUNCE_TIME_MS 10

void Relay_init(Relay *relay, DO_index_E controlIndex, DI_index_E feedbackIndex) {
    relay->controlIndex = controlIndex;
    relay->feedbackIndex = feedbackIndex;
    relay->state = RELAY_OFF;
    relay->lastUpdateTime = CLOCK_getTicks();
}

void Relay_update(Relay *relay) {
    // Check feedback and update state
    DI_state_E feedbackState = DI_getInputState(relay->feedbackIndex);

    switch (relay->state) {
        case RELAY_OFF:
        case RELAY_ON:
            if (feedbackState == DI_state_ON) {
                Relay_setState(relay, RELAY_ERROR_WELDED);
            }
            break;

        case RELAY_ERROR_WELDED:
            if (feedbackState == DI_state_OFF) {
                Relay_setState(relay, RELAY_OFF);
            }
            break;

        default:
            break;
    }
}

void Relay_setState(Relay *relay, RelayState state) {
    relay->state = state;
    relay->lastUpdateTime = CLOCK_getTicks();

    // Set control output based on state
    switch (state) {
        case RELAY_OFF:
            DO_setOutputState(relay->controlIndex, DO_state_OFF);
            break;

        case RELAY_ON:
            DO_setOutputState(relay->controlIndex, DO_state_ON);
            break;

        case RELAY_ERROR_WELDED:
            // Additional handling for error state if needed
            break;

        default:
            break;
    }
}

RelayState Relay_getState(Relay *relay) {
    return relay->state;
}
