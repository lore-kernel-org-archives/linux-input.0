From: Michael Thayer <Michael.Thayer@Sun.COM>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Wed, 24 Feb 2010 12:46:29 +0100
Message-ID: <1267011989.2831.30.camel@michael-laptop>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
 <20100224100206.GA5598@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gmp-eb-inf-1.sun.com ([192.18.6.21]:41454 "EHLO
	gmp-eb-inf-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab0BXLrD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Feb 2010 06:47:03 -0500
In-reply-to: <20100224100206.GA5598@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Le mercredi 24 f=C3=A9vrier 2010 =C3=A0 02:02 -0800, Dmitry Torokhov a =
=C3=A9crit :
> On Tue, Feb 23, 2010 at 09:55:33PM +0100, Michael Thayer wrote:
> > I'm not sure, if we ended up doing a completely new device, how dif=
ferent it
> > would end up being.  Emulating a touchscreen or a tablet makes sens=
e for us as
> > these are both something known, which will work with existing syste=
ms without
> > too much tweaking
> > [snip]
> But the virtual mouse is not a touchscreen or a tablet, it behaves
> differently.
What would you suggest emulating that exists in the real world?  And mi=
ght a
tablet not be better than a touchscreen, given that it doesn't just hav=
e a
binary concept of "touch or not", but a pressure axis as well?  We coul=
d report
"pen on but zero pressure".  I take your point (below) about not relyin=
g on
behaviour that doesn't correspond to real devices like being able to se=
nd
position data without BTN_TOUCH being held down.

> > The two devices also make sense for us on the one hand because xf86=
-input-evdev
> > currently only understands absolute devices without mouse buttons
>=20
> Hmm, I scanned through it and I did not see anything specifically
> removing mouse buttons from absolute devices there... Is it still val=
id
> for the recent version of evdev driver?
Sorry, I have to correct myself there.  It assumes that an absolute dev=
ice with
a "BTN_TOUCH" and mouse buttons and no pen is a touchpad and not a touc=
hscreen.
=46unction "EvdevProbe()", search for "Found absolute touchpad".

> > (yes I know,
> > we could send them patches too if we had too, but we would rather n=
ot patch the
> > whole world :) ) and on the other because it makes it easy for us t=
o switch
> > between absolute and relative event reporting, which is a big plus.
>=20
> Why is this a big plus? Also, can't evdev handle devices reporting bo=
th
> relative and absolute events?
We sometimes want to switch to relative event reporting to e.g. let peo=
ple play
games which are controlled using the mouse.  Don't ask :)  I can check =
again,
but I think that xf86-input-evdev ignores relative axes if a device sup=
ports
absolute ones.  I do feel that having two devices from it's point of vi=
ew is
a safer bet here, rather than trying something fancier.

> You are relying on the fact that currently userspace components rely =
on
> drivers not sending coordinates data without touch; as soon as usersp=
ace
> (evdev) starts validating it and ignoring coordinate events without
> ABS_PRESSURE or BTN_TOUCH you'll be toast.
Point taken.  See above.

> > > I think it would be better if we had separate protocol module for=
 that.
> [snip]
> First, create a separate protocol handler (module similar to
> lifebook.c), allocate protocol number, something like PSMOUSE_VBPS, a=
nd
> plumb it into psmouse-base.c in the same fashion othe protocol handle=
rs
> do it.
Sure, I can copy lifebook.c and make the necessary modifications.  I wi=
ll wait
for your answers/comments on the above though (particularly the first b=
it)
before starting.

Thanks again.

Regards,

Michael
--=20
Sun Microsystems GmbH        Michael Thayer
Werkstrasse 24               VirtualBox engineer
71384 Weinstadt, Germany     mailto:michael.thayer@sun.com

Sitz der Gesellschaft:
Sun Microsystems GmbH, Sonnenallee 1, 85551 Kirchheim-Heimstetten
Amtsgericht Muenchen: HRB 161028
Geschaeftsfuehrer: Thomas Schroeder, Wolfgang Engels
Vorsitzender des Aufsichtsrates: Martin Haering

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
