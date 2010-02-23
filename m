From: Michael Thayer <Michael.Thayer@Sun.COM>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Tue, 23 Feb 2010 21:55:33 +0100
Message-ID: <1266958533.3602.128.camel@michael-laptop>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gmp-eb-inf-1.sun.com ([192.18.6.21]:45270 "EHLO
	gmp-eb-inf-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab0BWUzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 15:55:54 -0500
In-reply-to: <20100223175852.GA11301@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Dmitry,

Thanks for your comments!

Le mardi 23 f=C3=A9vrier 2010 =C3=A0 09:58 -0800, Dmitry Torokhov a =C3=
=A9crit :
> On Tue, Feb 23, 2010 at 12:13:35PM +0100, Michael Thayer wrote:
> > This patch adds support for VirtualBox touchscreen emulation to the=
 Lifebook
> >  input driver.
[snip]
> I am wondering if it is a good idea to piggy-back on Lifebook. The
> devices are sufficiently different with Lifebook really having 2
> separate devices (touchscreen and either regular external mouse or a
> touchpad) and VirtualBox having asingle device that looks like a poin=
ter
> (not a touchscreen since pointer moves constantly, not while "touchin=
g")
> with absolute coordinates reporting.
I'm not sure, if we ended up doing a completely new device, how differe=
nt it
would end up being.  Emulating a touchscreen or a tablet makes sense fo=
r us as
these are both something known, which will work with existing systems w=
ithout
too much tweaking (I could imagine us adding Solaris support at a later=
 point,
and it would be nice to see "little" OSes picking up support independen=
tly).

The two devices also make sense for us on the one hand because xf86-inp=
ut-evdev
currently only understands absolute devices without mouse buttons (yes =
I know,
we could send them patches too if we had too, but we would rather not p=
atch the
whole world :) ) and on the other because it makes it easy for us to sw=
itch
between absolute and relative event reporting, which is a big plus.  Of=
 course,
as you point out, we have the unused touch bit, but the device works ni=
cely
sending co-ordinates without "touching", and having at least nominal to=
uch
functionality is rather a prerequisite for emulating a touch screen.

> I think it would be better if we had separate protocol module for tha=
t.
> [snip]
Separate module as in separate driver, or changes to the actual (PS/2 e=
xtension)
protocol?  If the second, then what did you have in mind?  One protocol=
 change
I could think of, other than the thing with the buttons, would be a mag=
ic knock
rather than DMI matching, as that would let others piggy-back on us.  N=
ot a big
advantage for us of course, but it might be one for you.

> This issue should be fixed in the recent kernels.
Ah, I failed to see that (I was working against the Ubuntu Lucid kernel
after checking that there were no more recent changes to lifebook.c).
Is the fix in psmouse-base.c?

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
