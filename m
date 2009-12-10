From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Fri, 11 Dec 2009 09:21:43 +1000
Message-ID: <20091210232143.GC13607@barra.bne.redhat.com>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr>
 <20091209231516.GF10138@core.coreip.homeip.net>
 <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr>
 <20091210182844.GC23717@core.coreip.homeip.net>
 <4B214BCA.5080403@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:42676 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZLJXjg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 18:39:36 -0500
Content-Disposition: inline
In-Reply-To: <4B214BCA.5080403@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, Benjamin Tissoires <tissoire@cena.fr>

On Thu, Dec 10, 2009 at 02:28:10PM -0500, Rafi Rubin wrote:
> >> Actually, Rafi Rubin and I have started to discuss the idea of splitting 
> >> this into two input nodes: a pure multitouch device and a pure single 
> >> touch emulation. I'd like to have feedback on this idea too, even if I 
> >> have no time to work on it yet.
> > 
> > If you create 2 devices basically supplying the same data then it will
> > be harder for consumers to select between them and drivers. I.e. if
> > single device transmits entire state then it is easy to write hotplug
> > policy for say X server (using udev/hal) such as:
> > 
> > 	- this box always uses evdev for everything, or
> > 	- devices with nultitouch capabilities use new multitouch
> > 	  X driver, the rest use evdev.
> > 
> > This will be harder if there were 2 "copies" of multitouch devices
> > because we'd have to be able to recognize "siblings" and ignore one or
> > the other.
> > 
> > Does this make sense?
> 
> At the moment, the evdev and wacom drivers (the only two that I've used
> for a digitizer), require specifying which device to use.  I
> also have the memory (and I might just be miss-remembering) that the
> synaptics driver finds an event dev on its own.  So as far as I see it a
> single driver should be smart enough to select the device that it prefers.

synaptics does a simple 
for device in /dev/input/eventX
        open device
        if device is a synaptics device
                woohoo, found it

if not found
        write angry letter to editor


That used to be common for those configured in the xorg.conf but these days
HAL (udev, in the future) will provide the device file anyway.
the same approach could be used for any driver, the problem with it is that
you'd put the policy of which devices are ok to use into the driver and
there are overlapping ranges (evdev can deal with most touchpads and tablets
for example).

> If we're worried about a discovery tool identifying both devs and
> assigning appropriate drivers to each, could we not just export names that
> indicate they are in fact the same device and let the tools select which
> to prefer?  It should be trivial for such tools
> to select sanely.
> 
> 
> That being said, I did at some point have a touchpad that was configured
> such that I got events from both mice and an event dev, and it was really
> annoying.

by default, synaptics grabs the event device so you don't get the same
event twice. evdev doesn't to avoid things like rfkill and the mac mouse
button emulation breaking.
we've tried hard to DTRT in most configurations but there are some corner
cases where the only exit is fixing the user's configuration.
e.g. if you set up evdev on the event device and synaptics on
/dev/input/mice, then you can still get duplicate events.

> > If there is a concern about too many unused events reaching userspace -
> > then we need to implement subscription model in evdev where consumer can
> > specify list of events it is interested in and have input core deliver
> > only those. I'll take patches ;)
> 
> While that sounds tempting, it also could introduce a bit of a hazard.
> Programmer A masks out events he doesn't need, then programmer B starts
> coding up support for more features and is confounded by the lack of
> response, and yet a hexdump of the dev indicates the events are streaming.

from most input driver's POV it's easier to just ignore events that can't be
handled by the driver than to mask them out. Having them masked out can make
some debugging paths harder. it also ensures that the drivers are more
robust at dealing with unexpected events.
So I don't really have a need for this feature in X, though I can see how
others may find it useful.

Cheers,
  Peter
