From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 02/12] Input: synaptics - do not invert y if 0
Date: Wed, 6 Jul 2011 06:50:30 +0800
Message-ID: <CAGS+omA0=wperMBA+kXVtJW1HJg=1CuW+HnS5kN_cDCBSphT=A@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-3-git-send-email-djkurtz@chromium.org> <4E134D0C.7060500@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:10981 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1GEWuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 18:50:52 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p65Mop0O002463
	for <linux-input@vger.kernel.org>; Tue, 5 Jul 2011 15:50:51 -0700
Received: from gyd12 (gyd12.prod.google.com [10.243.49.204])
	by wpaz29.hot.corp.google.com with ESMTP id p65MooPI024606
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 5 Jul 2011 15:50:50 -0700
Received: by gyd12 with SMTP id 12so2922469gyd.20
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 15:50:50 -0700 (PDT)
In-Reply-To: <4E134D0C.7060500@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jul 6, 2011 at 1:42 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
>
> On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> >
> > Synaptics touchpads report increasing y from bottom to top.
> > This is inverted from normal userspace "top of screen is 0" coordin=
ates.
> > Thus, the kernel driver reports inverted y coordinates to userspace=
=2E
> >
> > In some cases, however, y =3D 0 is sent by the touchpad.
> > In these cases, the kernel driver should not invert, and just repor=
t 0.
>
> Under what cases is y sent as 0, and why do we want to report it as 0=
 to
> userspace?

I know of two such cases for the image sensor:
  (1) When all fingers, save the first finger are removed, an AGM
packet with (x=3D0, y=3D0, z=3D0) is sent.
  (2) When all fingers are removed, an SGM packet with (x=3D0, y=3D0, z=
=3D0) is sent.

After uploading this patch set, I played with the profile sensor
again, and I also saw it sometimes sends y=3D1 packets.  I don't know
what those are.

This is mostly useful for debugging the kernel driver.
When observing the raw position values, the special 0 (and 1?) cases
are more obvious when not inverted.
I think I am misleading in my commit message.  I don't believe these
are actually ever passed through to userspace.

>
> >
> > This patch also refactors the inversion into a macro, and moves it
> > into packet processing instead of during position reporting.
>
> It's getting really hard to read the bit transformations with a macro=
=2E
> I'd prefer an approach that splits the computation. Maybe:
>
> hw->y =3D bit_manipulations;
> hw->y =3D INVERT_Y(hw->y);
>
> (could use a temporary variable too)
>
> Or maybe define a static inline function that takes the hw state as a=
n arg:
>
> hw->y =3D bit_manipulations;
> fix_y(hw);
>
> I'd prefer this implementation if every scenario involved manipulatin=
g
> the y value of the hw state struct.

Ok.  This option sounds good to me.  Both the sgm & agm cases
manipulate the same struct.

>
> Also, it would be great if you could add your explanation of why Y is
> inverted as a comment above INVERT_Y (or whatever function/macro it
> eventually becomes).

Ok.  I agree a comment would help.

Thanks for the review!

-Dan

>
> Thanks!
>
> -- Chase
>
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> > =A0drivers/input/mouse/synaptics.c | =A0 16 +++++++++-------
> > =A01 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/=
synaptics.c
> > index e06e045..f6d0c04 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -44,6 +44,8 @@
> > =A0#define YMIN_NOMINAL 1408
> > =A0#define YMAX_NOMINAL 4448
> >
> > +#define INVERT_Y(y) (((y) !=3D 0) ? (YMAX_NOMINAL + YMIN_NOMINAL -=
 (y)) : 0)
> > +
> >
> > =A0/***************************************************************=
**************
> > =A0 * =A0 Stuff we need even when we do not want native Synaptics s=
upport
> > @@ -409,9 +411,9 @@ static int synaptics_parse_hw_state(const unsig=
ned char buf[],
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->x =3D (((buf[3] & 0x10) << 8) |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[1] & 0x0f) << =
8) |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[4]);
> > - =A0 =A0 =A0 =A0 =A0 =A0 hw->y =3D (((buf[3] & 0x20) << 7) |
> > + =A0 =A0 =A0 =A0 =A0 =A0 hw->y =3D INVERT_Y((((buf[3] & 0x20) << 7=
) |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[1] & 0xf0) << =
4) |
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[5]);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[5]));
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->z =3D buf[2];
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->w =3D (((buf[0] & 0x30) >> 2) |
> > @@ -421,7 +423,8 @@ static int synaptics_parse_hw_state(const unsig=
ned char buf[],
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0=
c) && hw->w =3D=3D 2) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Gesture packet: (x, =
y, z) at half resolution */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.x =3D (((buf[4=
] & 0x0f) << 8) | buf[1]) << 1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.y =3D (((buf[4] =
& 0xf0) << 4) | buf[2]) << 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.y =3D INVERT_Y((=
((buf[4] & 0xf0) << 4)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | buf[2]) << 1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.z =3D ((buf[3]=
 & 0x30) | (buf[5] & 0x0f)) << 1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > @@ -473,7 +476,7 @@ static int synaptics_parse_hw_state(const unsig=
ned char buf[],
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 } else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->x =3D (((buf[1] & 0x1f) << 8) | buf=
[2]);
> > - =A0 =A0 =A0 =A0 =A0 =A0 hw->y =3D (((buf[4] & 0x1f) << 8) | buf[5=
]);
> > + =A0 =A0 =A0 =A0 =A0 =A0 hw->y =3D INVERT_Y(((buf[4] & 0x1f) << 8)=
 | buf[5]);
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->z =3D (((buf[0] & 0x30) << 2) | (bu=
f[3] & 0x3F));
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->w =3D (((buf[1] & 0x80) >> 4) | ((b=
uf[0] & 0x04) >> 1));
> > @@ -491,8 +494,7 @@ static void set_slot(struct input_dev *dev, int=
 slot, bool active, int x, int y)
> > =A0 =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, active)=
;
> > =A0 =A0 =A0 if (active) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X=
, x);
> > - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0YMAX_N=
OMINAL + YMIN_NOMINAL - y);
> > + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, =
y);
> > =A0 =A0 =A0 }
> > =A0}
> >
> > @@ -584,7 +586,7 @@ static void synaptics_process_packet(struct psm=
ouse *psmouse)
> >
> > =A0 =A0 =A0 if (num_fingers > 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_X, hw.x);
> > - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_Y, YMAX_NOMINAL=
 + YMIN_NOMINAL - hw.y);
> > + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_Y, hw.y);
> > =A0 =A0 =A0 }
> > =A0 =A0 =A0 input_report_abs(dev, ABS_PRESSURE, hw.z);
> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
