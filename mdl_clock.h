/*
 * mdl_clock.h
 *
 *  Created on: 12 Feb 2024
 *      Author: Abdelrahman
 */

typedef uint32_t CLOCK_ticks_T;
…
/*********************************************************************************************************
 * @brief Retrieve elapsed miliseconds from power-up. Assume there will be no overflow.
 *********************************************************************************************************
 * @param [in] Nothing.
 * @return Number of Ɵcks elapsed.
 ********************************************************************************************************/
CLOCK_ticks_T CLOCK_getTicks();
