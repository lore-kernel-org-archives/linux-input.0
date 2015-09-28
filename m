From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Mon, 28 Sep 2015 15:41:58 +0200
Message-ID: <1935189.6gJVPG4I9g@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509270958310.2226-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60303 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754543AbbI1NNk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 09:13:40 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509270958310.2226-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sunday, September 27, 2015 10:27:25 AM Alan Stern wrote:
> On Sun, 27 Sep 2015, Rafael J. Wysocki wrote:
> 
> > On Saturday, September 26, 2015 11:20:50 AM Alan Stern wrote:
> > > On Sat, 26 Sep 2015, Rafael J. Wysocki wrote:
> > > 
> > > > > > So something like:
> > > > > > 
> > > > > > 	echo on >/sys/.../power/control  (in case the device was
> > > > > > 			already in runtime suspend with wakeups enabled)
> > > > > > 	echo off >/sys/.../power/wakeup
> > > > > > 	echo auto >/sys/.../power/control
> 
> > > We still need some sort of "inhibit" callback for cases where the
> > > driver doesn't want to go into runtime suspend but does want to turn
> > > off all I/O.  Should this callback be triggered when the user writes
> > > "off" to power/wakeup, or when the user writes "inhibit" to
> > > power/control, or should there be a separate sysfs attribute?
> > 
> > My first thought is that if there is a separate attribute, then it only actually
> > makes sense for devices that generate input events, while the "off" thing may
> > be generally useful in principle (eg. it may indicate to disable PME for the
> > device to the PCI layer etc).
> 
> I'm not sure how much sense that distinction makes.  It seems to me the
> only time you want to ignore potential wakeup events is if you want to
> ignore _all_ input.  Which is basically what "inhibit" means.

The other case I had in mind is specific to the PCI layer and might be better
served by adding an "ignore PME" flag to PCI devices.

> This suggests we forget about power/wakeup == "off" and introduce an 
> "inhibit" attribute instead.

If we do that, can it still be regarded as a PM attribute?

And what about the corresponding callback?  Should that be a PM callback or
a general one?

> > OTOH, the additional "inhibit" attribute may only be exposed if the corresponding
> > callback is present, so I'm not really sure.
> 
> It could be a separate attribute, or it could be a new entry for
> power/control.  Come to think of it, a separate attribute might be
> better.  Otherwise we would lose track of whether runtime suspend was
> permitted (the "on" vs. "auto" distinction) when the device was
> inhibited.  I can imagine someone might want to forbid runtime suspend
> but still inhibit a device.
> 
> However, I agree that there's no point registering a separate attribute
> or accepting a write of "inhibit" to power/control if there's no
> corresponding callback.
> 
> > Question is, though, what's the use case for turning off I/O when we don't
> > go into runtime suspend.  After all, runtime suspend need not mean putting
> > the device into any kind of low-power state and the "off" thing may very
> > well be defined to mean that all input is discarded if the device is
> > runtime-suspended and the device is not configured to do remote wakeup
> > then.
> 
> Well, I suppose there might be a driver that supports inhibit but
> doesn't support runtime PM, unlikely as that seems.  Or the driver
> might support both but the user might leave power/control == "on" while
> inhibiting the device.

That sounds like a general rather than PM-related mechanism then.

I guess we need a real use case for that last thing or it will be rather
difficult to convince Greg to accept the patch. :-)

Thanks,
Rafael

