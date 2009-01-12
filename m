From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Mon, 12 Jan 2009 09:07:14 +0000
Message-ID: <1231751234.23618.6.camel@petitemort>
References: <20090109121026.052643915@fluff.org.uk>
	 <20090111234903.ZZRA012@mailhub.coreip.homeip.net>
Reply-To: dsilvers@simtec.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:52458 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751556AbZALJHS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 04:07:18 -0500
In-Reply-To: <20090111234903.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, vince@simtec.co.uk

> > Index: linux.git/drivers/input/touchscreen/usbtouchscreen.c
> > +	/* Always service the USB devices irq not just when the input device is
> > +	 * open.
> > +	 */
> > +	int irq_always;
> > +
> Why is this needed?

Some devices (E.g. specifically this one) expect their interrupt
endpoints to always be serviced. In this case, the device has an
on-board watchdog and will reboot (disconnect and reconnecting to the
USB) if it is not serviced in a timely fashion.


> > +	case 0xC0: /* down */
> > +		dev->x = (pkt[1] & 0x7f) | ((pkt[2] & 0x07) << 7);
> > +		dev->y = (pkt[3] & 0x7f) | ((pkt[4] & 0x07) << 7);
> > +		dev->touch = 1;
> > +		dev->press = 1;
> Since the device does not report real pressure readings don't try to
> fake it, reporting touch is enough.

I believe that this is because some userland libraries, particularly
tslib, require the pressure reading in order to believe the device is
functioning usefully. Specifically, consider plugins/input-raw of
tslib's source package which uses pressure rather than touch.

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895


