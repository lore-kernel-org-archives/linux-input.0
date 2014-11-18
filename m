From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 001/001] hid-sony.c: add sysfs provisioning
Date: Tue, 18 Nov 2014 23:30:23 +0100
Message-ID: <20141118233023.4368facdc75a090b9017e53e@ao2.it>
References: <20141116181846.GA31516@abrij.org>
	<20141117133518.ee306b3b35a0e0566a255b14@ao2.it>
	<546A4EF7.903@gmail.com>
	<20141118000005.GA32256@abrij.org>
	<546ABB51.4010905@gmail.com>
	<20141118142629.GA343@abrij.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:3070 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852AbaKRWae (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 17:30:34 -0500
In-Reply-To: <20141118142629.GA343@abrij.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bri <bri@abrij.org>
Cc: Frank Praznik <frank.praznik@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, open@abrij.org, HID CORE LAYER <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>

On Tue, 18 Nov 2014 09:26:29 -0500
bri <bri@abrij.org> wrote:

> On Mon, Nov 17, 2014 at 10:21:53PM -0500, Frank Praznik wrote:
> > Hi Brian,
> > 
> > On 11/17/2014 19:00, bri wrote:
> > >
> > >>Yeah, the device ID in the driver is only for tracking devices internally
> > >>and setting sane default LED values.  It has no meaning outside of the
> > >>module.  Like Antonio said, if you want the system number for a controller
> > >>you are better off just getting it from the joystick device.
> > >Would you be amenable to a patch that removes the IDA entirely and just sets
> > >the LEDs to all solid-on?  Since the LEDs are available through sysfs,
> > >udev rule could probably be made to set the LEDs in the absence of bluez
> > >or a higher level controller manager, and then it becomes the distro's
> > >responsibility.
> > >
> > 
> > What would be the benefit of doing this?  Nothing is stopping higher level
> > services from setting the LEDs right now.  The driver just sets sane
> > defaults for systems that don't have anything else to set the 'real' values.
> > Other controllers like Wiimotes and Xbox gamepads do the same thing.  It
> > doesn't get in the way of services like BlueZ setting them once
> > initialization is complete.
> > 
> > Leaving it completely up to the distro just means that there will be
> > situations where there is nothing to set the default values which makes for
> > a bad user experience.
> 
> It would eliminate 50 to 100 lines of code just for that tiny purpose,
> which userspace can and probably should take care of, given the disparity
> with the eventual values.  I'm honestly a bit confused of the criteria in use
> here, as I thought it was mostly deciding between the usefulness of features
> versus maintainability.  In my mind if I weight a master_bdaddr sysfs file
> and the code to support it versus this feature, I don't see where this one
> wins out.
>

I don't find the IDA code and the default LED state super useful
either, and the functionality over USB is limited, but the actual point
is that, in general, removing stuff is a bigger deal than refusing to
add new optional features: people may rely on, or expect the behavior
of, the code that is _already_ there.

The IDA code was added in the first place because Frank found it
useful, and being him the de-facto maintainer of the driver (he
had worked on it for quite a while before he added the IDA code) he has
a stronger voice in the decisions.

If you ask me, wrt. usefulness and necessity the two functionality
are more or less on the same level but the code which is already there
will more likely stay in.

> But whatever.  I made this for my own use, and offered it up, and if the
> community does not want it I am free to keep using what I made, so I'm happy
> either way.
> 

I'll comment on that in the other mail when you talk about the shell
solution.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
