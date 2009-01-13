From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Mon, 12 Jan 2009 21:33:23 -0800
Message-ID: <20090112212907.ZZRA012@mailhub.coreip.homeip.net>
References: <20090109121026.052643915@fluff.org.uk> <20090111234903.ZZRA012@mailhub.coreip.homeip.net> <1231751234.23618.6.camel@petitemort>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:53128 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZAMFeD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 00:34:03 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3573997yxm.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2009 21:34:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1231751234.23618.6.camel@petitemort>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Silverstone <dsilvers@simtec.co.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, vince@simtec.co.uk

Hi Daniel,

On Mon, Jan 12, 2009 at 09:07:14AM +0000, Daniel Silverstone wrote:
> > > Index: linux.git/drivers/input/touchscreen/usbtouchscreen.c
> > > +	/* Always service the USB devices irq not just when the input device is
> > > +	 * open.
> > > +	 */
> > > +	int irq_always;
> > > +
> > Why is this needed?
> 
> Some devices (E.g. specifically this one) expect their interrupt
> endpoints to always be serviced. In this case, the device has an
> on-board watchdog and will reboot (disconnect and reconnecting to the
> USB) if it is not serviced in a timely fashion.
> 

So what happens if driver was unloaded or there was no driver loaded at
all? Is this device constantly connecting and reconnecting?

> 
> > > +	case 0xC0: /* down */
> > > +		dev->x = (pkt[1] & 0x7f) | ((pkt[2] & 0x07) << 7);
> > > +		dev->y = (pkt[3] & 0x7f) | ((pkt[4] & 0x07) << 7);
> > > +		dev->touch = 1;
> > > +		dev->press = 1;
> > Since the device does not report real pressure readings don't try to
> > fake it, reporting touch is enough.
> 
> I believe that this is because some userland libraries, particularly
> tslib, require the pressure reading in order to believe the device is
> functioning usefully. Specifically, consider plugins/input-raw of
> tslib's source package which uses pressure rather than touch.
> 

Yes, I am aware of TSLIB case and I am telling everyone who submits
touchscreen drivers that they need to fix it. The policy is that
kernel should not generate fake events but present as accurate state
of hardware as possible.

-- 
Dmitry
