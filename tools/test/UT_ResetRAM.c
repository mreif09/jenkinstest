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
 * Functions for resetting the RAM for tests.
 *
 * @file UT_ResetRAM.c
 */
#ifdef RESET_ACTIVE
/*---- include files -------------------------------------------------------*/
/* related header */

/* C and C++ libraries */
#include <stdlib.h>
#include <string.h>

/* libraries and project files */
#include "UT_ResetRAM.h"

/* only if supported by makefile */

/*---- internal defines ----------------------------------------------------*/
/*---- internal type definitions -------------------------------------------*/
/*---- internal forward declaration ----------------------------------------*/
#ifdef GCOV_ACTIVE
void __gcov_flush(void); /* check in gcc sources gcc/gcov-io.h for the prototype */
#endif

/* linker symbols for RAM reset */
extern char _libdata_start__;
extern char _libdata_end__;
extern char _libbss_start__;
extern char _libbss_end__;

/* size of SUT RAM */
#define LIBDATA_SIZE (&_libdata_end__-&_libdata_start__)
#define LIBBSS_SIZE (&_libbss_end__-&_libbss_start__)

/* pointer on dynamic backup memory */
static uint8_t* pu8_BackupMemory = NULL;

/*---- implementation ------------------------------------------------------*/

/* backup of lib data */
void UT_SetBackup()
{
    /* set dynamic backup memory */
    pu8_BackupMemory = calloc(LIBDATA_SIZE, sizeof(uint8_t));

    /* Copy of lib data to backup: Target, Source, Length */
    memcpy(pu8_BackupMemory, &_libdata_start__, LIBDATA_SIZE);
}

/* API to GetBackup for Initialization of RAM */
uint8_t UT_InitRamOfSUT(void)
{
    uint8_t u8_Returnvalue = 1;

    /* Only if SetBackup was called successfully */
    if(NULL != pu8_BackupMemory)
    {
#ifdef GCOV_ACTIVE
        /* save gcov data before reseting the ram */
        __gcov_flush();
#endif

        /* Copy backup to lib data: Target, Source, Length */
        // TODO check why lms does not work
        // memcpy(&_libdata_start__, &_libdata_lma__, LIBDATA_SIZE);
        memcpy(&_libdata_start__, pu8_BackupMemory, LIBDATA_SIZE);
        memset(&_libbss_start__, 0, LIBBSS_SIZE);

        u8_Returnvalue = 0;
    }

    return u8_Returnvalue;
}

#endif /* RESET_ACTIVE */

/*---- end of file ---------------------------------------------------------*/
/** @} */
