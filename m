From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope chip.
Date: Wed, 16 Mar 2011 22:07:31 +0100
Message-ID: <201103162207.32030.rjw@sisk.pl>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk> <20110315125846.34b6af32@lxorguk.ukuu.org.uk> <20110316063024.GE14604@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39759 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab1CPVHZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 17:07:25 -0400
In-Reply-To: <20110316063024.GE14604@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-input@vger.kernel.org

On Wednesday, March 16, 2011, Dmitry Torokhov wrote:
> On Tue, Mar 15, 2011 at 12:58:46PM +0000, Alan Cox wrote:
> > > I'd be more happy if it was just an input device. If non-wired interrupt
> > > is a common case then we should probably add polled input device mode,
> > 
> > I can't really answer how common it is or would be - its a generic chip
> > that is used on all sorts of equipment
> > 
> > > but we certainly should not register completely non-functional input
> > > device as the driver does now.
> > 
> > Agreed
> > 
> > > We also have a way of retrieving current (or rather most recent)
> > > coordinates via EVIOCGABS so I am not sure why we want the sysfs way of
> > > retrieving coordinates as well.
> > 
> > The sysfs way comes about because the devices are very very power
> > oriented, waking up and polling regularly burns power, hence also the
> > power control side. Opening an input device would power it up for the
> > duration it was open and the polling would cause a lot of wakeups burning
> > power.
> > 
> > Doing open/EVIOCGABS/close to avoid that aspect of the input layer
> > won't ensure you get current data that I can see - because an IRQ may not
> > have occurred between the open and the EVIOCGABS so any data may be very
> > stale or non-existent.
> 
> I would be perfectly fine with a driver that does refresh it's state in
> dev->open() if we expect that data might be stale. We normally do not do
> that because old data is normally not interesting for touchpads, mice or
> keyboards and we not always have option of querying current hardware
> state.
> 
> > 
> > The polled case looks trivial to sort but for an IRQ driver driver it
> > looks like you would need a new "get co-ordinates right now" optional
> > method tht EVIOCGABS would use if available ?
> > 
> > > Regarding power mode - I really believe that this should be done on the
> > > driver core level instead of implementing "manual off" in every single
> > > driver out there.
> > 
> > Definitely - not sure what plans Rafael has there ?
> >
> 
> Last time we discussed this we were talking about sysfs entry at the
> driver core level allowing userspace to "expire" idle timer and force
> runtime PM action. Rafael, did I remember that right?

Well, I'm not exactly sure what the question is about. :-)

There's the family of pm_*_autosuspend() routines in the runtime PM
framework (recently introduced by Alan Stern) that allow you to use delay
timers and deal with them automatically (as described in
Documentation/power/runtime_pm.txt, Section 9).

Is that what you mean?

Rafael

