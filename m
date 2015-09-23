From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 23 Sep 2015 10:55:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509231030270.1670-100000@iolanthe.rowland.org>
References: <1442977394.8607.8.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37734 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755071AbbIWOzx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 10:55:53 -0400
In-Reply-To: <1442977394.8607.8.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 23 Sep 2015, Oliver Neukum wrote:

> On Tue, 2015-09-22 at 11:22 -0400, Alan Stern wrote:
> > On Tue, 22 Sep 2015, Oliver Neukum wrote:
> >  
> > > Cancel, yes, going to low power is a consequence which needn't bother
> > > the power subsystem.
> > 
> > Going to low power needn't involve the power subsystem?  That sounds 
> > weird.
> 
> Think of it like rfkill. It makes sense to suspend an rfkilled device.
> It still is the job of the driver to report that its device is idle.

Reporting that the device is idle _does_ involve the power subsystem.  
But never mind...

> > So my next question is: _How_ can this help PM to do a better job?  
> > That is, what are the mechanisms?
> 
> "inhibit" -> driver stops input -> driver sets PM count to zero
> -> PM subsystem acts

Your third step here poses problems.  There is no runtime-PM API a 
driver or subsystem can use to set its usage counter to 0.  All it can 
do is increment or decrement the counter.

> To go from the first to the second step a callback is needed
> 
> > One you have already stated: Lack of spurious events will help prevent 
> > unwanted wakeups (or unwanted failures to go to sleep).
> 
> That too. We also save CPU cycles.
> 
> > But Dmitry made a stronger claim: Inhibiting an input device should 
> > allow the device to go to low power.  I would like to know how we can 
> > implement this cleanly.  The most straightforward approach is to use 
> > runtime PM, but it's not obvious how this can be made to work with the 
> > current API.
> 
> Yes, we can use the current API.
> The key is that you think of the mechanism as induced idleness,
> not forced suspend. We already have a perfectly working mechanism
> for suspending idle devices.

After thinking some more about this, here's what I've got.

Let's talk about input-only devices being in an "idle" state or a
"running" state:

	When the device is in the idle state, its driver does not 
	communicate with the device.  In particular, the driver does 
	not monitor for events or report them to the rest of the 
	kernel.  It is appropriate to put the device in runtime suspend
	with remote wakeup disabled.

	When the device is in the running state, its driver receives
	event reports from the device and propagates them forward.
	The subsystem/driver may choose to put the device in runtime
	suspend between events with remote wakeup enabled (like we do
	for USB keyboards if no LEDs are on) or it may choose to leave
	the device at full power the whole time.

The idea is that a device is in the idle state whenever the open file 
count is 0 _or_ it is "inhibited"; otherwise it is in the running 
state.

I tried to come up with a way to do some of this work in a central
core.  All I could think of was that the core should detect state
changes and inform the subsystem/driver when they occur.  Everything
else (starting and stopping I/O, adjusting the runtime-PM usage
counter) would have to be done by the subsystem/driver.

The problem is that a core generally isn't aware of when a file 
reference is opened or released.  Only the driver is.  Which means 
there's nothing that the core can do here; the driver and subsystem 
have to manage pretty much the whole thing.  A simple example:

open()
{
	mutex_lock(&dev->open_mutex);
	if (dev->open_count++ == 0 && !dev->inhibited) {
		pm_runtime_get_sync(dev);
		start_io(dev);
	}
	mutex_unlock(&dev->open_mutex);
}

release()
{
	mutex_lock(&dev->open_mutex);
	if (--dev->open_count == 0 && !dev->inhibited) {
		stop_io(dev);
		pm_runtime_put(dev);
	}
	mutex_unlock(&dev->open_mutex);
}

inhibit()
{
	mutex_lock(&dev->open_mutex);
	dev->inhibited = true;
	if (dev->open_count > 0) {
		stop_io(dev);
		pm_runtime_put(dev);
	}
	mutex_unlock(&dev->open_mutex);
}

uninhibit()
{
	mutex_lock(&dev->open_mutex);
	dev->inhibited = false;
	if (dev->open_count > 0) {
		pm_runtime_get_sync(dev);
		start_io(dev);
	}
	mutex_unlock(&dev->open_mutex);
}

This doesn't leave much room for the PM core or anything else.

Alan Stern

