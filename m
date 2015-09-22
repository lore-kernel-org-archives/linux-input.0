From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 22 Sep 2015 10:15:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509221013470.1742-100000@iolanthe.rowland.org>
References: <1442923519.6240.6.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442923519.6240.6.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-input@vger.kernel.org

On Tue, 22 Sep 2015, Oliver Neukum wrote:

> Indeed. We can handle output to suspended devices by waking them.
> I don't see why this case is different. We are talking about input
> only.
> 
> > The runtime-PM "usage" value for these devices is a little tricky to 
> > calculate.  It should be nonzero if there are any open files _and_ the 
> > device isn't "inhibited".  I don't know the best way to represent that 
> > kind of condition in the runtime PM framework.
> 
> Does that make sense in the generic framework at all? I still
> think that drivers should cease IO for input in such cases.
> That should involve a common callback, but no counter.

I'm not sure I understand what you're saying.  Are you suggesting that
this "inhibit" mechanism should involve a new callback different from
the existing runtime-PM callbacks?  And when this new callback is
invoked, drivers should cancel existing input requests (these devices
are input-only) and go to low power?

This would create a parallel runtime-PM mechanism which is independent
of the existing one.  Is that really a good idea?

Alan Stern
