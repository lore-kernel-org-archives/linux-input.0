From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 22 Sep 2015 11:22:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509221116430.1742-100000@iolanthe.rowland.org>
References: <1442932301.6240.11.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1442932301.6240.11.camel@suse.de>
Sender: linux-pm-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 22 Sep 2015, Oliver Neukum wrote:

> > I'm not sure I understand what you're saying.  Are you suggesting that
> > this "inhibit" mechanism should involve a new callback different from
> 
> Yes, there is no necessary relation to power management. If you put
> your phone into your pocket, you will want to inhibit the touchscreen
> even if that doesn't save power.
> 
> > the existing runtime-PM callbacks?  And when this new callback is
> > invoked, drivers should cancel existing input requests (these devices
> > are input-only) and go to low power?
> 
> Cancel, yes, going to low power is a consequence which needn't bother
> the power subsystem.

Going to low power needn't involve the power subsystem?  That sounds 
weird.

>  You need a callback. If there are spurious
> events, the current heuristics will keep devices awake.
> You must discard them anyway, as they are spurious. There's no point
> in transporting over the bus at all. We can cease IO for input.
> 
> > This would create a parallel runtime-PM mechanism which is independent
> > of the existing one.  Is that really a good idea?
> 
> It isn't strictly PM. It helps PM to do a better job, but
> conceptually it is independent.

So my next question is: _How_ can this help PM to do a better job?  
That is, what are the mechanisms?

One you have already stated: Lack of spurious events will help prevent 
unwanted wakeups (or unwanted failures to go to sleep).

But Dmitry made a stronger claim: Inhibiting an input device should 
allow the device to go to low power.  I would like to know how we can 
implement this cleanly.  The most straightforward approach is to use 
runtime PM, but it's not obvious how this can be made to work with the 
current API.

Alan Stern

