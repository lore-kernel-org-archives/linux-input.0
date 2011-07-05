From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 02/12] Input: synaptics - do not invert y if 0
Date: Tue, 5 Jul 2011 12:29:51 +0800
Message-ID: <CAGS+omDXhiZz2i5eniu_eOCES1Eq_fKs4JVWU-+wz6ot7kyhSA@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-3-git-send-email-djkurtz@chromium.org> <20110704210838.GA23915@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110704210838.GA23915@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

Hi Henrik
Thanks for the review.

On Tue, Jul 5, 2011 at 5:08 AM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
>
> Hi Daniel,
>
> > Synaptics touchpads report increasing y from bottom to top.
> > This is inverted from normal userspace "top of screen is 0" coordin=
ates.
> > Thus, the kernel driver reports inverted y coordinates to userspace=
=2E
> >
> > In some cases, however, y =3D 0 is sent by the touchpad.
> > In these cases, the kernel driver should not invert, and just repor=
t 0.
> >
> > This patch also refactors the inversion into a macro, and moves it
> > into packet processing instead of during position reporting.
>
> The patch seems to invert the current output?

By 'current' do you mean referenced from the previous implementation?
Or referenced from the raw input.
It does indeed invert the raw input.
This is the same as the previous implementation did.
The difference is that it does not also invert the special 'y=3D0' into
an arbitrarily large value.
Is this your concern?
-Dan

>
> >
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
> > --
> > 1.7.3.1
> >
>
> Thanks,
> Henrik
