From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Tue, 26 Jan 2010 01:52:17 -0800
Message-ID: <20100126095217.GC3480@core.coreip.homeip.net>
References: <1262977099.2050.75.camel@climbing-alby>
 <BD79186B4FD85F4B8E60E381CAEE190902089738@mi8nycmail19.Mi8.com>
 <1263664125.4350.18.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61020 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0AZJwX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2010 04:52:23 -0500
Content-Disposition: inline
In-Reply-To: <1263664125.4350.18.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel-infradead <linux-arm-kernel@lists.infradead.org>, Sascha linux-arm <s.hauer@pengutronix.de>

Hi Alberto,

On Sat, Jan 16, 2010 at 06:48:45PM +0100, Alberto Panizzo wrote:
> Version 2 for this driver proposal.
> --------------------------------------------------------------------------------
> The MXC family of Application Processors is shipped with a Keypad Port 
> supported now by this driver.
> 
> The peripheral can control up to an 8x8 matrix key pad where all the scanning 
> procedure is done via software.
> 
> The hardware provide two interrupts: one for a key pressed (KDI) and one for 
> all key releases (KRI). There is also a simple circuit for glitch reduction 
> (said for synchronization) made by two series of 3 D-latches clocked by the 
> keypad-clock that stabilize the interrupts sources.
> KDI and KRI are fired only if the respective conditions are maintained for at 
> last 4 keypad-clock cycle.
> 
> Those simple synchronization circuits are used also for multiple key pressures: 
> between a KDI and a KRI the driver reset the sync circuit and re-enable the KDI
> interrupt so after 3 keypad-clock cycle another KDI is fired making possible to
> repeat the matrix scan operation.
> 

Nicely looking driver, thank you.

> This algorithm is done via a threaded management of the keypad interrupt source
> and delayed by a proper (and longer) debounce interval controlled by the 
> platform initialization.

This I am not so sure about - the core of the matrix scan routine does
not sleep so I wonder if starting a separate thread is not too wasteful
in this case - you can easily do whan you want with a timer, no?

> +
> +	/*
> +	 * Search for rows and cols enabled
> +	 */
> +	keymap_data = (struct matrix_keymap_data *) pdata->keymap_data;

Why do you need to cast away constness instead of declaring keymap_data
as const pointer?

-- 
Dmitry
