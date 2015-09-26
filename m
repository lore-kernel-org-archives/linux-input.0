From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Sat, 26 Sep 2015 11:20:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509261110470.4211-100000@netrider.rowland.org>
References: <1645828.psusZpgl4n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:50980 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751457AbbIZPUv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Sep 2015 11:20:51 -0400
In-Reply-To: <1645828.psusZpgl4n@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat, 26 Sep 2015, Rafael J. Wysocki wrote:

> > > So something like:
> > > 
> > > 	echo on >/sys/.../power/control  (in case the device was
> > > 			already in runtime suspend with wakeups enabled)
> > > 	echo off >/sys/.../power/wakeup
> > > 	echo auto >/sys/.../power/control

Cases where the driver wants to avoid runtime suspend (while the device
is active) because of bad wakeup support in the hardware can be handled
easily enough.  The runtime-idle or runtime-suspend callback routine
can check whether wakeup == off; if it isn't then the callback should
return -EBUSY.  Thus the driver can prevent runtime suspend without any
need to increment the usage counter.

> > That, or there may be an additional value, say "aggressive", to write to the
> > control file in which case it becomes just
> > 
> > echo aggressive >/sys/.../power/control
> 
> That said I suppose that the "off" value for the "wakeup" file might also be
> useful in some other cases, so it likely is a better approach.

We still need some sort of "inhibit" callback for cases where the
driver doesn't want to go into runtime suspend but does want to turn
off all I/O.  Should this callback be triggered when the user writes
"off" to power/wakeup, or when the user writes "inhibit" to
power/control, or should there be a separate sysfs attribute?

Alan Stern

