From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 28 Sep 2015 10:29:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509281015220.1612-100000@iolanthe.rowland.org>
References: <1935189.6gJVPG4I9g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1935189.6gJVPG4I9g@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Mon, 28 Sep 2015, Rafael J. Wysocki wrote:

> > This suggests we forget about power/wakeup == "off" and introduce an 
> > "inhibit" attribute instead.
> 
> If we do that, can it still be regarded as a PM attribute?

Why not?  Consider this: Is there any reason to support inhibit when
CONFIG_PM is disabled?  I can't come up with any.

> And what about the corresponding callback?  Should that be a PM callback or
> a general one?

Well, if "inhibit" is a PM attribute then the callback should be a PM 
callback.  :-)

> > > Question is, though, what's the use case for turning off I/O when we don't
> > > go into runtime suspend.  After all, runtime suspend need not mean putting
> > > the device into any kind of low-power state and the "off" thing may very
> > > well be defined to mean that all input is discarded if the device is
> > > runtime-suspended and the device is not configured to do remote wakeup
> > > then.
> > 
> > Well, I suppose there might be a driver that supports inhibit but
> > doesn't support runtime PM, unlikely as that seems.  Or the driver
> > might support both but the user might leave power/control == "on" while
> > inhibiting the device.
> 
> That sounds like a general rather than PM-related mechanism then.

I don't follow your reasoning.

> I guess we need a real use case for that last thing or it will be rather
> difficult to convince Greg to accept the patch. :-)

The hard part is to come up with a design that Greg agrees with.  If 
the design is okay, there's no reason not to accept the patch.

One of the questions amounts to this: Do we want to allow situations
where input is inhibited but the user prevents the device from going
into runtime suspend by setting power/control = "on"?  If the answer is
Yes then "inhibit" should be a separate attribute.  Otherwise, we can 
just let "inhibit" be another setting in power/control.

Another question is: Do we want to make it easy for drivers to support
inhibit while still incrementing their PM usage counter every time the
device file is opened?  If we do then inhibit must be considered
separate from runtime suspend, because a device _can't_ go directly
into runtime suspend when the usage counter is > 1.  If we don't then 
we will most likely have to change the runtime-PM support in some 
drivers before they can implement inhibit.

Alan Stern

