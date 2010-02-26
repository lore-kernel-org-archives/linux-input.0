From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Route kbd leds through the generic leds layer (3rd version)
Date: Fri, 26 Feb 2010 11:35:05 +0100
Message-ID: <20100226103505.GB3992@const.homenet.telecomitalia.it>
References: <20100224012010.GA4062@const> <20100225013840.GA5519@const.homenet.telecomitalia.it> <20100225102056.GG10823@core.coreip.homeip.net> <20100225214403.GB9378@const.homenet.telecomitalia.it> <20100226035448.GA16797@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from toccata.ens-lyon.fr ([140.77.166.68]:37457 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933334Ab0BZKfK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2010 05:35:10 -0500
Content-Disposition: inline
In-Reply-To: <20100226035448.GA16797@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, mgarski@post.pl, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Richard Purdie <rpurdie@rpsys.net>

Dmitry Torokhov, le Thu 25 Feb 2010 19:54:48 -0800, a =C3=A9crit :
> Right now on .33, if you write LED event to one event device while
> legacy keyboard driver is inactive (in raw mode) then that write will
> only affect that particular event device, not the rest of them. Your
> patch changes that.

Errr, I don't think so.  My patch just puts a trigger layer between
keyboard and the loop over devices that keyboard used to do.  When the
legacy keyboard driver is inactive, it doesn't trigger anything any
more, and my patch becomes actually inactive, and other sources of LED
events can send them to various input event devices independently.  I'v=
e
just tried it with Xorg (telling it to use only one keyboard) and it
works.

> Whether LED state should be shared between all input devices or shoul=
d
> be kept separate is a matter of policy and we try to keep policy in
> userspace.

Sure.

> >  On the contrary,
> > it fixes the problem of proper caps lock with led feedback.
>=20
> I am unaware of such issue, any pointers?

In the very changelog of my patch :) #7063
And also please see the thread =E2=80=9Cmake CapsLock work as expected =
even
for non-ASCII=E2=80=9D on lkml.

> > Being able to assign only some of the devices to the linux console
> > would indeed probably be good, but to me it's just a refinement. Us=
ers
> > a priori assume all keyboards get their leds updated, so my patch
> > makes sense.  And it won't prevent a further patch that, in additio=
n
> > to input::<led> leds, adds per-device leds, which the user could us=
e
> > instead of input::<led>.
>=20
> I think that if we want to go LED route we shoudl start with adding l=
ed
> devices to individual keyboard drivers first

Mmm, thinking again, I think my patch could be rather easily converted
into creating led instances for each device, with proper trigger
defaults.  Something like input-devicename::numlock? (devicename::numlo=
ck
might get conflicts with non-input devices I guess?)

That being said, usermode tools which want to set up the modifiers and
connect the input LEDs to them need an easy and proper way to do so.
Having central input::numlock and such still seems a good thing.

> and then convert legacy
> keyboard to use trigger instead of talking to input devices directly.

This part is already done by my patch.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
