/*----------------------------------------------------------------------------
 * @copyright BFFT Gesellschaft für Fahrzeugtechnik mbH. All Rights reserved.
 * It is not allowed, whether to copy this document, nor to pass it even in
 * extracts to others, without the approval BFFT Gesellschaft für Fahrzeugtechnik mbH.
 * All Copyrights for this document are the exclusive property of
 * BFFT Gesellschaft für Fahrzeugtechnik mbH.
 *--------------------------------------------------------------------------*/
/**
 * @addtogroup TestFrame
 * @{
 * @file UT_ResetRAM.h
 */
/*---- switch against multiple include -------------------------------------*/
#ifndef UT_RESETRAM_H_
#define UT_RESETRAM_H_

#ifdef RESET_ACTIVE
/*---- include files -------------------------------------------------------*/
/* C and C++ libraries */
#include <stdint.h>

/* libraries and project files */

/*---- global defines ------------------------------------------------------*/
/*---- global type definitions ---------------------------------------------*/
/*---- global functions declaration ----------------------------------------*/
uint8_t UT_InitRamOfSUT(void);
void UT_SetBackup(void);

#endif /*RESET_ACTIVE*/

/*---- end of file ---------------------------------------------------------*/

#endif /* UT_RESETRAM_H_ */
/** @} */
