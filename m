From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Sun, 27 Sep 2015 15:41:23 +0200
Message-ID: <1493729.nvxxQyxdme@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509261110470.4211-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509261110470.4211-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Saturday, September 26, 2015 11:20:50 AM Alan Stern wrote:
> On Sat, 26 Sep 2015, Rafael J. Wysocki wrote:
> 
> > > > So something like:
> > > > 
> > > > 	echo on >/sys/.../power/control  (in case the device was
> > > > 			already in runtime suspend with wakeups enabled)
> > > > 	echo off >/sys/.../power/wakeup
> > > > 	echo auto >/sys/.../power/control
> 
> Cases where the driver wants to avoid runtime suspend (while the device
> is active) because of bad wakeup support in the hardware can be handled
> easily enough.  The runtime-idle or runtime-suspend callback routine
> can check whether wakeup == off; if it isn't then the callback should
> return -EBUSY.  Thus the driver can prevent runtime suspend without any
> need to increment the usage counter.

Right.

> > > That, or there may be an additional value, say "aggressive", to write to the
> > > control file in which case it becomes just
> > > 
> > > echo aggressive >/sys/.../power/control
> > 
> > That said I suppose that the "off" value for the "wakeup" file might also be
> > useful in some other cases, so it likely is a better approach.
> 
> We still need some sort of "inhibit" callback for cases where the
> driver doesn't want to go into runtime suspend but does want to turn
> off all I/O.  Should this callback be triggered when the user writes
> "off" to power/wakeup, or when the user writes "inhibit" to
> power/control, or should there be a separate sysfs attribute?

My first thought is that if there is a separate attribute, then it only actually
makes sense for devices that generate input events, while the "off" thing may
be generally useful in principle (eg. it may indicate to disable PME for the
device to the PCI layer etc).

OTOH, the additional "inhibit" attribute may only be exposed if the corresponding
callback is present, so I'm not really sure.

Question is, though, what's the use case for turning off I/O when we don't
go into runtime suspend.  After all, runtime suspend need not mean putting
the device into any kind of low-power state and the "off" thing may very
well be defined to mean that all input is discarded if the device is
runtime-suspended and the device is not configured to do remote wakeup
then.

Thanks,
Rafael
