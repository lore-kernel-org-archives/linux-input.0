From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Thu, 25 Feb 2010 02:17:05 -0800
Message-ID: <20100225101705.GF10823@core.coreip.homeip.net>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
 <20100224100206.GA5598@core.coreip.homeip.net>
 <1267011989.2831.30.camel@michael-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:48033 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab0BYKRM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Feb 2010 05:17:12 -0500
Content-Disposition: inline
In-Reply-To: <1267011989.2831.30.camel@michael-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Thayer <Michael.Thayer@Sun.COM>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 24, 2010 at 12:46:29PM +0100, Michael Thayer wrote:
> Le mercredi 24 f=E9vrier 2010 =E0 02:02 -0800, Dmitry Torokhov a =E9c=
rit :
> > On Tue, Feb 23, 2010 at 09:55:33PM +0100, Michael Thayer wrote:
> > > I'm not sure, if we ended up doing a completely new device, how d=
ifferent it
> > > would end up being.  Emulating a touchscreen or a tablet makes se=
nse for us as
> > > these are both something known, which will work with existing sys=
tems without
> > > too much tweaking
> > > [snip]
> > But the virtual mouse is not a touchscreen or a tablet, it behaves
> > differently.
> What would you suggest emulating that exists in the real world?

There are not many real devices that have teh same characteristics as
virtual mouse generating absolute coordinates. Umm, the closest would b=
e
a wacom tablet when used with its own mouse.

>  And might a
> tablet not be better than a touchscreen, given that it doesn't just h=
ave a
> binary concept of "touch or not", but a pressure axis as well?  We co=
uld report
> "pen on but zero pressure".

No, tablet still has the property that movement ceases when you remove
object touching the device from proximity. In your case you will be
always sending coordinates and expect userspace react to them regardles=
s
of button/tool/etc state.

>  I take your point (below) about not relying on
> behaviour that doesn't correspond to real devices like being able to =
send
> position data without BTN_TOUCH being held down.

I think the cleaniest would be to send ABS_X/ABS_Y nad buttons. Xen doe=
s
this so I'd expect evdev being able to handle it.

>=20
> > > The two devices also make sense for us on the one hand because xf=
86-input-evdev
> > > currently only understands absolute devices without mouse buttons
> >=20
> > Hmm, I scanned through it and I did not see anything specifically
> > removing mouse buttons from absolute devices there... Is it still v=
alid
> > for the recent version of evdev driver?
> Sorry, I have to correct myself there.  It assumes that an absolute d=
evice with
> a "BTN_TOUCH" and mouse buttons and no pen is a touchpad and not a to=
uchscreen.
> Function "EvdevProbe()", search for "Found absolute touchpad".

And if you remove BTN_TOUCH (which does not make sense in your case)
then it won't be saying that.

>=20
> > > (yes I know,
> > > we could send them patches too if we had too, but we would rather=
 not patch the
> > > whole world :) ) and on the other because it makes it easy for us=
 to switch
> > > between absolute and relative event reporting, which is a big plu=
s.
> >=20
> > Why is this a big plus? Also, can't evdev handle devices reporting =
both
> > relative and absolute events?
> We sometimes want to switch to relative event reporting to e.g. let p=
eople play
> games which are controlled using the mouse.  Don't ask :)  I can chec=
k again,
> but I think that xf86-input-evdev ignores relative axes if a device s=
upports
> absolute ones.

I don't think so, could you please re-test it?

> I do feel that having two devices from it's point of view is
> a safer bet here, rather than trying something fancier.
>=20
> > You are relying on the fact that currently userspace components rel=
y on
> > drivers not sending coordinates data without touch; as soon as user=
space
> > (evdev) starts validating it and ignoring coordinate events without
> > ABS_PRESSURE or BTN_TOUCH you'll be toast.
> Point taken.  See above.
>=20
> > > > I think it would be better if we had separate protocol module f=
or that.
> > [snip]
> > First, create a separate protocol handler (module similar to
> > lifebook.c), allocate protocol number, something like PSMOUSE_VBPS,=
 and
> > plumb it into psmouse-base.c in the same fashion othe protocol hand=
lers
> > do it.
> Sure, I can copy lifebook.c and make the necessary modifications.  I =
will wait
> for your answers/comments on the above though (particularly the first=
 bit)
> before starting.
>=20
> Thanks again.
>=20
> Regards,
>=20
> Michael
> --=20
> Sun Microsystems GmbH        Michael Thayer
> Werkstrasse 24               VirtualBox engineer
> 71384 Weinstadt, Germany     mailto:michael.thayer@sun.com
>=20
> Sitz der Gesellschaft:
> Sun Microsystems GmbH, Sonnenallee 1, 85551 Kirchheim-Heimstetten
> Amtsgericht Muenchen: HRB 161028
> Geschaeftsfuehrer: Thomas Schroeder, Wolfgang Engels
> Vorsitzender des Aufsichtsrates: Martin Haering
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
