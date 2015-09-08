From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 08 Sep 2015 09:35:44 +0200
Message-ID: <1441697744.26994.21.camel@suse.com>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
	 <8981266.1iKleIVcUj@vostro.rjw.lan>
	 <1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2015-09-08 at 01:10 +0000, Tirdea, Irina wrote:

> However, in the scenario I mentioned this is exactly what is happening.
> When turning off the screen of a mobile device, the user space

Would you explain why user space doesn't simply stop using those
devices, which in turn will make them idle? There are obvious cases
like keyboards or SCSI hosts where the kernel controls stuff, but could
you state where you expect this to be most useful?
Or why devices cannot be closed, e.g. you need to be sure settings
be not lost or is it something else?

> is the one that suspends the devices that are not needed in order to save power
> (like touchscreens). Each such driver export an enable/disable attribute
> that calls the same code as resume/suspend (e.g. touchscreen drivers ads7846,
> ad7877 and most Android drivers not merged upstream). This adds more
> complexity to every driver by adding one more logical power state.
> It would be good to have a common interface instead of doing this in
> every 

Now these are two distinct questions.

1. a common interface
2. a capability implemented in common code

It is important to keep that apart. I suppose if we want this at all
#1 is a given. #2 however may be impossible in a generic manner

> I might have not used "forced" in the proper way here. What I mean by it is that
> the device can be runtime suspended while ignoring the runtime usage count.

That is highly problematic. You'd need to audit the locking in every
driver. Right now elevating the count means that suspend()/resume()
cannot race with user space, as in the case of the system suspending
user space is frozen.

> In this implementation, user space is only allowed to change the states
> bottom-up in the sysfs hierarchy (it cannot force suspend a device if it
> has children that have not been suspended by user space).

That is obviously not enough. Take the worst case: we are flashing some
firmware. Or far more harmless: a key is has been pressed on a keyboard

> Would it work if this would be a capability that individual drivers need
> to declare?

For some drivers. But it needs support in the driver. Right now we can
make a device idle by calling close(). In fact we can benefit for
example in mice from this. But it needs support in the drivers.

> In the previous discussion thread , there were a couple of options
> mentioned, but none seemed to reach a consensus. You mentioned
> adding a "more aggressive runtime PM mode" [1]. I'm not sure how

That would have to be done on a per driver base.

> this would work except for adding a sysfs attribute that would trigger
> a runtime suspend while ignoring usage count. Would that be a
> better direction?

No. If we want this at all, we need a new callback to notify drivers
that user space is temporarily uninterested in a device. And the reverse
of course.
The power model is good. We must not assume that devices can be
suspended at will. If we do this at all, we ought to see it as giving
strong hints to drivers when a device can be considered idle.

	Regards
		Oliver


