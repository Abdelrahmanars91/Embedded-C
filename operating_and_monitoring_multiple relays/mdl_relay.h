/*
 * mdl_relay.h
 *
 *  Created on: 12 Feb 2024
 *      Author: Abdelrahman
 */
#ifndef MDL_RELAY_H
#define MDL_RELAY_H
#ifndef MDL_RELAY_H
#define MDL_RELAY_H

#include <stdbool.h>
#include "mdl_di.h"
#include "mdl_do.h"
#include "mdl_clock.h"

typedef enum {
    RELAY_OFF,
    RELAY_ON,
    RELAY_ERROR_WELDED,
    RELAY_ERROR_CONSTANTLY_OPEN,
    RELAY_ERROR_UNKNOWN,
} RelayState;

typedef struct {
    DO_index_E controlIndex;
    DI_index_E feedbackIndex;
    RelayState state;
    CLOCK_ticks_T lastUpdateTime;
} Relay;

void Relay_init(Relay *relay, DO_index_E controlIndex, DI_index_E feedbackIndex);
void Relay_update(Relay *relay);
void Relay_setState(Relay *relay, RelayState state);
RelayState Relay_getState(Relay *relay);

#endif /* MDL_RELAY_H */
