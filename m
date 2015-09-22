From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 22 Sep 2015 16:31:41 +0200
Message-ID: <1442932301.6240.11.camel@suse.de>
References: <Pine.LNX.4.44L0.1509221013470.1742-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509221013470.1742-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 2015-09-22 at 10:15 -0400, Alan Stern wrote:
> On Tue, 22 Sep 2015, Oliver Neukum wrote:
> 
> > Indeed. We can handle output to suspended devices by waking them.
> > I don't see why this case is different. We are talking about input
> > only.
> > 
> > > The runtime-PM "usage" value for these devices is a little tricky to 
> > > calculate.  It should be nonzero if there are any open files _and_ the 
> > > device isn't "inhibited".  I don't know the best way to represent that 
> > > kind of condition in the runtime PM framework.
> > 
> > Does that make sense in the generic framework at all? I still
> > think that drivers should cease IO for input in such cases.
> > That should involve a common callback, but no counter.
> 
> I'm not sure I understand what you're saying.  Are you suggesting that
> this "inhibit" mechanism should involve a new callback different from

Yes, there is no necessary relation to power management. If you put
your phone into your pocket, you will want to inhibit the touchscreen
even if that doesn't save power.

> the existing runtime-PM callbacks?  And when this new callback is
> invoked, drivers should cancel existing input requests (these devices
> are input-only) and go to low power?

Cancel, yes, going to low power is a consequence which needn't bother
the power subsystem. You need a callback. If there are spurious
events, the current heuristics will keep devices awake.
You must discard them anyway, as they are spurious. There's no point
in transporting over the bus at all. We can cease IO for input.

> This would create a parallel runtime-PM mechanism which is independent
> of the existing one.  Is that really a good idea?

It isn't strictly PM. It helps PM to do a better job, but
conceptually it is independent.

	Regards
		Oliver



