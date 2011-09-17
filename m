From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Sat, 17 Sep 2011 13:21:14 +0200
Message-ID: <20110917112114.GA3015@polaris.bitmath.org>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
 <20110913080911.GA4986@polaris.bitmath.org>
 <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
 <20110914071524.GA3422@polaris.bitmath.org>
 <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
 <20110916105036.GA4455@polaris.bitmath.org>
 <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:39369 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab1IQLR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Sep 2011 07:17:29 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id BADE0EA782
	for <linux-input@vger.kernel.org>; Sat, 17 Sep 2011 13:17:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

Hi Jason,

> >> Take Wacom's Intuos and Graphire series for example, those tablets
> >> support both styli and mice. For styli, the default is absolute mode;
> >> while for mice, it is relative. So, only valid property the tablet can
> >> tell the user-land is: I am a tablet, i.e., not a touchscreen. Clients
> >> have to check the tool types to set the default mode to relative
> >> (BTN_TOOL_MOUSE/LENS) or absolute (BTN_TOOL_PEN/AIRBRUSH/RUBBER...).
> >
> > And those modes can be determined using the available axes. However,
> > when all axes are the same, a statement like "I am a tablet" does not
> > exist. In that case, distinguishing between touchscreen, touchpad and
> > tablet becomes a question of interpreting the properties. Such a
> > distinction cannot be achieved using a single bit of information, and
> > that was never the intention.
> >
> It is certainly true that you cannot separate out the different cases
> with a single bit. The more properties and hints we can expose to
> userspace the better. However, at the device level, there's only so
> much information we *can* expose. We know if its a direct input device
> or not. We don't know if its relative or absolute, since that depends
> on the tool in use at any given moment.

It seems the various arguments we have seen in this thread are all
logical and well founded, but they originate in different assumptions
about the semantics of POINTER and DIRECT. Such a debate does
obviously not satisfy everyone.

The original intention of the properties are these:

POINTER - The device needs a visual guide in order to be useful. In
most cirumstances, this is equivalent to not having a screen directly
beneath the surface.

DIRECT - The input device is to be used as if it was overlaying a
sreen. It could be separate from the screen, but the expected behavior
should be the same.

>From these definitions, it follows that a device could well be both
POINTER and DIRECT. For instance, a multitouch tablet designed to
replace the keyboard would fall into this category.

Now, people may have different opinions about the semantics as
presented above. Bike sheds tend to have that effect. Nevertheless,
this is how it was intended.

> To be honest, I'm not sure why we need to further disambiguate
> touchpads and tablets (though I'd be interested in finding out). From
> what I can tell, the difference between a touchpad and a tablet is in
> the tools they use; identical tools (i.e. BTN_TOOL_FINGER) should have
> identical absoluteness. The absoluteness of tool would depends on what
> it is (BTN_TOOL_FINGER is relative, BTN_TOOL_PEN is absolute) and if
> the underlying device is a direct input device (if it is, all tools
> are absolute) -- not on some arbitrarily distinction between
> "touchpad" and "tablet".

Your patch is already merged, and for pen devices, the distinction may
well be made as you describe. In other words, setting DIRECT for a pen
device is not strictly necessary. I wanted it in there to make clear
that in general, POINTER and DIRECT are not to be considered mutually
exclusive. Perhaps the discussion will continue when the first
"multi-touch tablet" appears, but hopefully not. ;-)

Cheers,
Henrik
