From: Orivej Desh <orivej@gmx.fr>
Subject: Re: Missing axis on Gembird JPD-DUALFORCE2 since Linux 3.18
Date: Mon, 10 Aug 2015 22:28:55 +0000
Message-ID: <20150810222855.7e08c16e@orivej.orivej.org>
References: <20150810082642.3a0880ab@orivej.orivej.org>
	<CAN+gG=EmtKjR2bw1c=LedYv24PPaPVijW-HqsyxA0mF6F4+FrQ@mail.gmail.com>
	<20150810213608.356908e5@orivej.orivej.org>
	<CAN+gG=FkyGdYQwBFYfRFGuTC5xPpieoq7gDeQwFs5B1A8ZOhqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:55201 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929AbbHJW3F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 18:29:05 -0400
In-Reply-To: <CAN+gG=FkyGdYQwBFYfRFGuTC5xPpieoq7gDeQwFs5B1A8ZOhqA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

* Benjamin Tissoires
> Thanks for the logs.
>=20
> So, yes, it appears that your joypad as a weird report descriptor.
> It declares 2 Z axis, no Ry and one Rz.
>
> The first Z axis seems somewhat correlated to X, but does not seem to
> add any actual value but noise.

That's right.

> If I understand correctly your problem, I can submit a patch which
> will mute the Z axis, and provide proper Rx,Ry so you won't have to
> deal with that in userspace.
> Will this be OK with you?

I would appreciate it if you do this, and learn to do it myself!  Yet I
think that Z axis is better removed than muted; it serves no purpose an=
d
would only confuse other users of this device (if any) when tools
present them with 7 axes to configure.

> On Mon, Aug 10, 2015 at 5:36 PM, Orivej Desh <orivej@gmx.fr> wrote:
> > * Benjamin Tissoires
> >> Thanks for the bisect. Could you please run a hid-recorder from
> >> http://bentiss.github.io/hid-replay-docs/ and record a few events =
from
> >> your joypad? Depending on the output, we will be able to tell you
> >> where this should be fixed (but I strongly suspect that the kernel
> >> should be fixed).
> >
> > See attached idle.hid, with what appears to be noise on the Z axis =
when
> > the joypad is idle, and XYRxRy.hid with my approximation to the seq=
uence
> > of physical X Y Rx Ry zero-negative-positive-zero swings.
>=20
> >> On Mon, Aug 10, 2015 at 4:26 AM, Orivej Desh <orivej@gmx.fr> wrote=
:
> >> > I have one of those gamepads, and since Linux 3.18 the kernel hi=
des one
> >> > of its axes.
> >> >
> >> > In Linux 3.17 jstest reports it as
> >> >
> >> >      Joystick (PC Game Controller       ) has 7 axes (X, Y, Z, R=
x, Rz, Hat0X, Hat0Y)
> >> >
> >> > and in Linux 3.18 as
> >> >
> >> >      Joystick (PC Game Controller       ) has 6 axes (X, Y, Z, R=
z, Hat0X, Hat0Y)
> >> >
> >> > It has 6 physical axes (X, Y, Rx, Ry, Hat0X, Hat0Y), but Ry is r=
eported
> >> > as Rz, and Z emits noise (which had to be silenced with jscal).
> >> >
> >> > I bisected disappearing axis to the following commit [1], but if=
 I
> >> > understand correctly, it is the device that is wrong by misrepor=
ting
> >> > some property of Rx.
> >> >
> >> > I can remap Rz to Ry in userspace with ioctl(fd, JSIOCSAXMAP, ..=
=2E),
> >> > though I never had to.  Can I likewise restore Rx in userspace (=
and also
> >> > delete Z)?  If not, or if this device justifies a quirk, how sho=
uld it
> >> > be added?
> >> >
> >> > usb-devices report: [2].
> >> >
> >> > [1]
> >> > commit 79346d620e9de87912de73337f6df8b7f9a46888
> >> > Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >> > Date:   Mon Aug 25 13:07:10 2014 -0400
> >> >
> >> >     HID: input: force generic axis to be mapped to their user sp=
ace axis
> >> >
> >> >     Atmel 840B digitizer presents a stylus interface which repor=
ts twice
> >> >     the X coordinate and then twice the Y coordinate. In its cur=
rent
> >> >     implementation, hid-input assign the first X to X, then the =
second to Y,
> >> >     then the first Y to Z, then the second one to RX.
> >> >
> >> >     This is wrong, and X should always be mapped to X, no matter=
 what.
> >> >     A solution consists in forcing X, Y, Z, RX, RY, RZ to be map=
ped to their
> >> >     correct user space counter part.
> >> >
> >> >     Reported-by: =C3=89ric Brunet <Eric.Brunet@lps.ens.fr>
> >> >     Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat=
=2Ecom>
> >> >     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> >> >
> >> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> >> > index 2619f7f..2df7fdd 100644
> >> > --- a/drivers/hid/hid-input.c
> >> > +++ b/drivers/hid/hid-input.c
> >> > @@ -599,6 +599,12 @@ static void hidinput_configure_usage(struct=
 hid_input *hidinput, struct hid_fiel
> >> >                 /* These usage IDs map directly to the usage cod=
es. */
> >> >                 case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
> >> >                 case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
> >> > +                       if (field->flags & HID_MAIN_ITEM_RELATIV=
E)
> >> > +                               map_rel(usage->hid & 0xf);
> >> > +                       else
> >> > +                               map_abs_clear(usage->hid & 0xf);
> >> > +                       break;
> >> > +
> >> >                 case HID_GD_SLIDER: case HID_GD_DIAL: case HID_G=
D_WHEEL:
> >> >                         if (field->flags & HID_MAIN_ITEM_RELATIV=
E)
> >> >                                 map_rel(usage->hid & 0xf);
> >> >
> >> > [2]
> >> > T:  Bus=3D09 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Sp=
d=3D1.5 MxCh=3D 0
> >> > D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cf=
gs=3D  1
> >> > P:  Vendor=3D11ff ProdID=3D3331 Rev=3D01.07
> >> > S:  Product=3DPC Game Controller
> >> > C:  #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
> >> > I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D03(HID  ) Sub=3D00 Prot=3D=
00 Driver=3Dusbhid
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
