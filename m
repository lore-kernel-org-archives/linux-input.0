From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 00:33:07 +0200
Message-ID: <201010120033.07695.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010111140040.2339-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36393 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672Ab0JKWdp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 18:33:45 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010111140040.2339-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Monday, October 11, 2010, you wrote:
> On Mon, 11 Oct 2010, Rafael J. Wysocki wrote:
> 
> > On Sunday, October 10, 2010, Alan Stern wrote:
> > > On Sun, 10 Oct 2010, Dmitry Torokhov wrote:
> > ... 
> > > > > 
> > > > > It's up to userspace to make sure that the display's usage count goes
> > > > > to 0 at the proper time, i.e., when the button is pressed.  Contrary to
> > > > > what you wrote above, we _do_ have an interface for this at the PM core
> > > > > level: power/control.
> > 
> > I think that power/control is not sufficient, because drivers may generally not
> > have enough information to make a decision to suspend the device.  What you're
> > saying basically means that for every driver there should be an interface for
> > user space to tell it when the device is not used (and therefore may be
> > suspended), which is pretty much what I'm saying.  The difference seems to be
> > that I think it's better to put this interface into /sys/devices/.../power/,
> > while your opinion seems to be that the interface should be driver-specific.
> 
> This has to depend on how the device is going to be used.  Will there
> be multiple user processes, each using it independently?  In that case
> a single attribute value won't work; some sort of counter will be
> needed.  Will all access funnel through a single process?  Then a
> single attribute value will work, and that attribute might as well be
> power/control.
> 
> I'm not fully convinced that we are yet in a good position to do
> anything along these lines.  A driver can generally tell when it is
> being used easily enough: If there are I/O calls then it is in use.  
> Of course there are exceptions, like a display screen that is in use
> when the user is looking at it, not when the display is being updated.
>
> To the extent that drivers can tell what's going on just by monitoring
> their own activities, we don't need a new interface.  For anything
> beyond that, it seems likely that the situation will vary considerably
> from one device to another.  At this point we don't have enough
> experience to specify a single approach that will work everywhere.
> 
> Especially since I haven't seen any scenarios so far that can't be
> solved using the existing interfaces under power/.

The question is not whether they can be solved _somehow_, but whether it is
_sufficiently_ _convenient_ to solve them using the existing interfaces.

It seems to me that for some devices it might be more convenient to have
an "execute pm_runtime_idle() for this device right now" sysfs trigger
(and analogously for resume).

Anyway, please note that the scenario in which the driver detects inactivity
and suspends the device in response is not the only one possible.  The other
one is that the driver is told to suspend the device and then blocks apps
wanting to access it until resumed.  Right now we have interfaces for the
former, but not for the latter.

> > > I don't like the idea of having an "off" setting in power/control.  
> > > What happens if the user turns a disk drive controller "off" and the 
> > > system needs to read or write something on that disk drive?
> > 
> > That's why I said about a new flag that will only be set by drivers
> > _knowing_ that they can suspend "on demand".
> 
> For such drivers, the only question is "Does userspace want me to
> suspend now?"  This question can be answered by
> power/autosuspend_delay_ms or by power/control.

Not necessarily.

> Why is a new flag needed?

For the second scenario above to be possible.

Thanks,
Rafael
