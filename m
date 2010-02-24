From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Wed, 24 Feb 2010 02:02:06 -0800
Message-ID: <20100224100206.GA5598@core.coreip.homeip.net>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:45897 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0BXKCN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Feb 2010 05:02:13 -0500
Content-Disposition: inline
In-Reply-To: <1266958533.3602.128.camel@michael-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Thayer <Michael.Thayer@Sun.COM>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 23, 2010 at 09:55:33PM +0100, Michael Thayer wrote:
> Hello Dmitry,
>=20
> Thanks for your comments!
>=20
> Le mardi 23 f=E9vrier 2010 =E0 09:58 -0800, Dmitry Torokhov a =E9crit=
 :
> > On Tue, Feb 23, 2010 at 12:13:35PM +0100, Michael Thayer wrote:
> > > This patch adds support for VirtualBox touchscreen emulation to t=
he Lifebook
> > >  input driver.
> [snip]
> > I am wondering if it is a good idea to piggy-back on Lifebook. The
> > devices are sufficiently different with Lifebook really having 2
> > separate devices (touchscreen and either regular external mouse or =
a
> > touchpad) and VirtualBox having asingle device that looks like a po=
inter
> > (not a touchscreen since pointer moves constantly, not while "touch=
ing")
> > with absolute coordinates reporting.
> I'm not sure, if we ended up doing a completely new device, how diffe=
rent it
> would end up being.  Emulating a touchscreen or a tablet makes sense =
for us as
> these are both something known, which will work with existing systems=
 without
> too much tweaking (I could imagine us adding Solaris support at a lat=
er point,
> and it would be nice to see "little" OSes picking up support independ=
ently).

But the virtual mouse is not a touchscreen or a tablet, it behaves
differently.

>=20
> The two devices also make sense for us on the one hand because xf86-i=
nput-evdev
> currently only understands absolute devices without mouse buttons

Hmm, I scanned through it and I did not see anything specifically
removing mouse buttons from absolute devices there... Is it still valid
for the recent version of evdev driver?

> (yes I know,
> we could send them patches too if we had too, but we would rather not=
 patch the
> whole world :) ) and on the other because it makes it easy for us to =
switch
> between absolute and relative event reporting, which is a big plus.

Why is this a big plus? Also, can't evdev handle devices reporting both
relative and absolute events?

>  Of course,
> as you point out, we have the unused touch bit, but the device works =
nicely
> sending co-ordinates without "touching", and having at least nominal =
touch
> functionality is rather a prerequisite for emulating a touch screen.

You are relying on the fact that currently userspace components rely on
drivers not sending coordinates data without touch; as soon as userspac=
e
(evdev) starts validating it and ignoring coordinate events without
ABS_PRESSURE or BTN_TOUCH you'll be toast.

>=20
> > I think it would be better if we had separate protocol module for t=
hat.
> > [snip]
> Separate module as in separate driver, or changes to the actual (PS/2=
 extension)
> protocol?  If the second, then what did you have in mind?

=46irst, create a separate protocol handler (module similar to
lifebook.c), allocate protocol number, something like PSMOUSE_VBPS, and
plumb it into psmouse-base.c in the same fashion othe protocol handlers
do it.

>  One protocol change
> I could think of, other than the thing with the buttons, would be a m=
agic knock
> rather than DMI matching, as that would let others piggy-back on us. =
 Not a big
> advantage for us of course, but it might be one for you.

I'd rather you stick with DMI, piggybackers can simply add their DMI
strings. The reason I do not want to have magic knock is that it may
disturb real hardware probing which is already quite fragile.

>=20
> > This issue should be fixed in the recent kernels.
> Ah, I failed to see that (I was working against the Ubuntu Lucid kern=
el
> after checking that there were no more recent changes to lifebook.c).
> Is the fix in psmouse-base.c?
>=20

Among others.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
