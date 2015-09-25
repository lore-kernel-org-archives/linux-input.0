From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Fri, 25 Sep 2015 22:15:28 +0200
Message-ID: <1825872.1pMPkfpiYH@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509251026290.1847-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509251026290.1847-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Friday, September 25, 2015 10:29:55 AM Alan Stern wrote:
> On Fri, 25 Sep 2015, Rafael J. Wysocki wrote:
> 
> > We are missing the "no remote wakeup" bit now (well, there is a PM QoS flag,
> > but it isn't very useful, so I'd prefer to replace it with a "no remote wakeup"
> > bit in struct dev_pm_info or something similar).
> > 
> > That is actually quite important, because (a) we can save energy but not
> > configuring the device to do remote wakeup in the first place and (b) that
> > may involve more than just the driver (for example, disabling PCI or ACPI
> > remote wakeup involves the bus type or similar).
> > 
> > So it looks like we need to be able to distinguish between "runtime suspend
> > with remote wakeup" and "runtime suspend without remote wakeup".
> > 
> > And if we do the latter, we may not even need the "inhibit" thing any more,
> > because suspended devices without that are not configured to do remote wakeup
> > cannot really signal anything in the majority of cases.
> 
> That works only for drivers that use autosuspend to go to low power in
> between events.  It doesn't work for drivers that remain at full power 
> as long as the device file is open.  That kind of driver does require 
> an "inhibit" interface.

Or an interface allowing user space to trigger pm_request_idle() for them.

So user space would change the "no remote wakeup" setting and then do the
"try to suspend now" thing.

Thanks,
Rafael
