From: "Andrew Victor" <avictor.za@gmail.com>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL Touchscreen
Date: Sat, 26 Apr 2008 00:16:51 +0200
Message-ID: <cd73a99e0804251516xf9dab81q173bcdc919ebabc8@mail.gmail.com>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
	 <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
	 <20080425211041.GC28497@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.249]:51967 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756792AbYDYWQv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 18:16:51 -0400
Received: by rv-out-0506.google.com with SMTP id k29so2196245rvb.1
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 15:16:51 -0700 (PDT)
In-Reply-To: <20080425211041.GC28497@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Waters <justin.waters@timesys.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, dmitry.torokhov@gmail.com

hi Justin,

>  > +     regbuf = (0x01 & 0x3) |                         /* TSAMOD       */
>  > +             ((0x0 & 0x1) << 5) |                    /* SLEEP        */
>
>  (0 & 1) << 5 ?  How about using a #define for bit 5 and simply
>  omitting it?
>
>  > +             ((0x1 & 0x1) << 6) |                    /* PENDET       */
>
>  And a #define for bit 6 as well?


Maybe this header file will be useful to you...


/*
 * include/asm-arm/arch-at91/at91_tsc.h
 *
 * Touch Screen ADC Controller (TSC)
 * Based on AT91SAM9RL64 preliminary draft datasheet.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 */

#ifndef AT91_TSC_H
#define AT91_TSC_H

#define AT91_TSADCC_CR		0x00	/* Control register */
#define		AT91_TSADCC_SWRST	(1 << 0)	/* Software Reset*/
#define		AT91_TSADCC_START	(1 << 1)	/* Start conversion */

#define AT91_TSADCC_MR		0x04	/* Mode register */
#define		AT91_TSADCC_TSAMOD	(3    <<  0)	/* ADC mode */
#define		AT91_TSADCC_LOWRES	(1    <<  4)	/* Resolution selection */
#define		AT91_TSADCC_SLEEP	(1    <<  5)	/* Sleep mode */
#define		AT91_TSADCC_PENDET	(1    <<  6)	/* Pen Detect selection */
#define		AT91_TSADCC_PRESCAL	(0x3f <<  8)	/* Prescalar Rate Selection */
#define		AT91_TSADCC_STARTUP	(0x7f << 16)	/* Start Up time */
#define		AT91_TSADCC_SHTIM	(0xf  << 24)	/* Sample & Hold time */
#define		AT91_TSADCC_PENDBC	(0xf  << 28)	/* Pen Detect debouncing time */

#define AT91_TSADCC_TRGR	0x08	/* Trigger register */
#define		AT91_TSADCC_TRGMOD	(7      << 0)	/* Trigger mode */
#define			AT91_TSADCC_TRGMOD_NONE		(0 << 0)
#define			AT91_TSADCC_TRGMOD_EXT_RISING	(1 << 0)
#define			AT91_TSADCC_TRGMOD_EXT_FALLING	(2 << 0)
#define			AT91_TSADCC_TRGMOD_EXT_ANY	(3 << 0)
#define			AT91_TSADCC_TRGMOD_PENDET	(4 << 0)
#define			AT91_TSADCC_TRGMOD_PERIOD	(5 << 0)
#define			AT91_TSADCC_TRGMOD_CONTINUOUS	(6 << 0)
#define		AT91_TSADCC_TRGPER	(0xffff << 16)	/* Trigger period */

#define AT91_TSADCC_TSR		0x0C	/* Touch Screen register */
#define		AT91_TSADCC_TSFREQ	(0xf <<  0)	/* TS Frequency in Interleaved mode */
#define		AT91_TSADCC_TSSHTIM	(0xf << 24)	/* Sample & Hold time */

#define AT91_TSADCC_CHER	0x10	/* Channel Enable register */
#define AT91_TSADCC_CHDR	0x14	/* Channel Disable register */
#define AT91_TSADCC_CHSR	0x18	/* Channel Status register */
#define		AT91_TSADCC_CH(n)	(1 << (n))	/* Channel number */

#define AT91_TSADCC_SR		0x1C	/* Status register */
#define		AT91_TSADCC_EOC(n)	(1 << ((n)+0))	/* End of conversion for channel N */
#define		AT91_TSADCC_OVRE(n)	(1 << ((n)+8))	/* Overrun error for channel N */
#define		AT91_TSADCC_DRDY	(1 << 16)	/* Data Ready */
#define		AT91_TSADCC_GOVRE	(1 << 17)	/* General Overrun Error */
#define		AT91_TSADCC_ENDRX	(1 << 18)	/* End of RX Buffer */
#define		AT91_TSADCC_RXBUFF	(1 << 19)	/* TX Buffer full */
#define		AT91_TSADCC_PENCNT	(1 << 20)	/* Pen contact */
#define		AT91_TSADCC_NOCNT	(1 << 21)	/* No contact */

#define AT91_TSADCC_LCDR	0x20	/* Last Converted Data register */
#define		AT91_TSADCC_DATA	(0x3ff << 0)	/* Channel data */

#define AT91_TSADCC_IER		0x24	/* Interrupt Enable register */
#define AT91_TSADCC_IDR		0x28	/* Interrupt Disable register */
#define AT91_TSADCC_IMR		0x2C	/* Interrupt Mask register */
#define AT91_TSADCC_CDR0	0x30	/* Channel Data 0 */
#define AT91_TSADCC_CDR1	0x34	/* Channel Data 1 */
#define AT91_TSADCC_CDR2	0x38	/* Channel Data 2 */
#define AT91_TSADCC_CDR3	0x3C	/* Channel Data 3 */
#define AT91_TSADCC_CDR4	0x40	/* Channel Data 4 */
#define AT91_TSADCC_CDR5	0x44	/* Channel Data 5 */

#endif



Regards,
  Andrew Victor
