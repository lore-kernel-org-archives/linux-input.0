From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fix BTN_TOUCH reporting in
 input_mt_report_pointer_emulation for hovering finger
Date: Wed, 15 Oct 2014 11:05:01 -0700
Message-ID: <20141015180501.GC8625@dtor-ws>
References: <1412861506-21732-1-git-send-email-cywang@chromium.org>
 <CAM2ehZa2OUH14_hQ5nbmzGfXGaRrd5bN43wBnriuL_zJUjv2MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:49953 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaJOSFL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 14:05:11 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so17800298igi.17
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2014 11:05:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAM2ehZa2OUH14_hQ5nbmzGfXGaRrd5bN43wBnriuL_zJUjv2MA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chung-Yih Wang =?utf-8?B?KOeOi+W0h+aHvyk=?= <cywang@chromium.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Chung-Yih,

On Wed, Oct 15, 2014 at 07:02:31PM +0800, Chung-Yih Wang (=E7=8E=8B=E5=B4=
=87=E6=87=BF) wrote:
> any comment for this patch?
>=20
> On Thu, Oct 9, 2014 at 9:31 PM, Chung-yih Wang <cywang@chromium.org> =
wrote:
> >   From the definition of BTN_TOUCH, BTN_TOOL_<name> and BTN_TOUCH c=
odes are
> > orthogonal. BTN_TOUCH should be zero if there is no physical contac=
t, e.g.
> > hovering finger, happened on device. The patch uses touch_count and=
 finger_count
> > to get the final reporting code for BTN_TOUCH and BTN_TOOL_<name>,
> > respectively. In addition, as there are some hard-coded pressure th=
resholds
> > defined in touch device's driver classes, 'touch_threshold' is intr=
oduced into
> > struct input_dev in order to tell if a finger is considered as a to=
uch one in
> > input_mt_report_pointer_emulation().
> >
> > ---
> >  drivers/input/input-mt.c | 15 ++++++++++-----
> >  include/linux/input.h    |  2 ++
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> > index fbe29fc..47e41d6 100644
> > --- a/drivers/input/input-mt.c
> > +++ b/drivers/input/input-mt.c
> > @@ -192,18 +192,21 @@ void input_mt_report_pointer_emulation(struct=
 input_dev *dev, bool use_count)
> >  {
> >         struct input_mt *mt =3D dev->mt;
> >         struct input_mt_slot *oldest;
> > -       int oldid, count, i;
> > +       int oldid, i;
> > +       int touch_count, finger_count;
> >
> >         if (!mt)
> >                 return;
> >
> >         oldest =3D NULL;
> >         oldid =3D mt->trkid;
> > -       count =3D 0;
> > +       touch_count =3D 0;
> > +       finger_count =3D 0;
> >
> >         for (i =3D 0; i < mt->num_slots; ++i) {
> >                 struct input_mt_slot *ps =3D &mt->slots[i];
> >                 int id =3D input_mt_get_value(ps, ABS_MT_TRACKING_I=
D);
> > +               int pressure =3D input_mt_get_value(ps, ABS_MT_PRES=
SURE);
> >
> >                 if (id < 0)
> >                         continue;
> > @@ -211,12 +214,14 @@ void input_mt_report_pointer_emulation(struct=
 input_dev *dev, bool use_count)
> >                         oldest =3D ps;
> >                         oldid =3D id;
> >                 }
> > -               count++;
> > +               finger_count++;
> > +               if (pressure > dev->touch_threshold)
> > +                       touch_count++;
> >         }
> >
> > -       input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
> > +       input_event(dev, EV_KEY, BTN_TOUCH, touch_count > 0);
> >         if (use_count)
> > -               input_mt_report_finger_count(dev, count);
> > +               input_mt_report_finger_count(dev, finger_count);
> >
> >         if (oldest) {
> >                 int x =3D input_mt_get_value(oldest, ABS_MT_POSITIO=
N_X);
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 82ce323..5b2739d 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -187,6 +187,8 @@ struct input_dev {
> >         struct input_value *vals;
> >
> >         bool devres_managed;
> > +
> > +       unsigned int touch_threshold;

I'd rather not use the pressure threshold, but gate it on distance,
since touch threshold would be user preference. This way we are not
changing existing behavior where registered touches are reported in the
finger count, only true hovering contacts will be excluded.

Henrik, Benjamin?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
