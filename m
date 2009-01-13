From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Tue, 13 Jan 2009 09:29:18 +0000
Message-ID: <1231838958.30531.3.camel@petitemort>
References: <20090109121026.052643915@fluff.org.uk>
	 <20090111234903.ZZRA012@mailhub.coreip.homeip.net>
	 <1231751234.23618.6.camel@petitemort>
	 <20090112212907.ZZRA012@mailhub.coreip.homeip.net>
Reply-To: dsilvers@simtec.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:46572 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755533AbZAMJ3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 04:29:23 -0500
In-Reply-To: <20090112212907.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, vince@simtec.co.uk

On Mon, 2009-01-12 at 21:33 -0800, Dmitry Torokhov wrote:
> > > > +	/* Always service the USB devices irq not just when the input device is
> > > > +	 * open.
> > > > +	 */
> > > > +	int irq_always;
> > > Why is this needed?
> > Some devices (E.g. specifically this one) expect their interrupt
> > endpoints to always be serviced. In this case, the device has an
> > on-board watchdog and will reboot (disconnect and reconnecting to the
> > USB) if it is not serviced in a timely fashion.
> So what happens if driver was unloaded or there was no driver loaded at
> all? Is this device constantly connecting and reconnecting?

As I understand it; yes. (Some bits of hardware really are hideous
things) Indeed if the driver fails to load quickly enough, the device
might disconnect/reconnect before the driver can get hold of it.

> > > > +		dev->touch = 1;
> > > > +		dev->press = 1;
> > > Since the device does not report real pressure readings don't try to
> > > fake it, reporting touch is enough.
> > I believe that this is because some userland libraries, particularly
> > tslib, require the pressure reading in order to believe the device is
> > functioning usefully. Specifically, consider plugins/input-raw of
> > tslib's source package which uses pressure rather than touch.
> Yes, I am aware of TSLIB case and I am telling everyone who submits
> touchscreen drivers that they need to fix it. The policy is that
> kernel should not generate fake events but present as accurate state
> of hardware as possible.

Unfortunately it's often harder to get people to change their userland
than their kernel. It seems a pity to make the driver less useful during
any longer-term effort to fix TSLIB. If acceptance of this patch is
predicated on removing that then I guess we'll have to discuss it
amongst ourselves and try and work out what we'd rather do. Is removing
the fake pressure report a requirement or a would-like?

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895


