From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER falg when HOVER event
 trigger
Date: Thu, 31 Mar 2016 11:17:30 -0700
Message-ID: <20160331181730.GI39098@dtor-ws>
References: <002801d18a28$2a12dfe0$7e389fa0$@emc.com.tw>
 <20160330023106.GA40436@dtor-ws>
 <014f01d18a69$6d761770$48624650$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33180 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbcCaSRd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2016 14:17:33 -0400
Content-Disposition: inline
In-Reply-To: <014f01d18a69$6d761770$48624650$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: DusonLin <dusonlin@emc.com.tw>
Cc: Linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Charles Mooney' <charliemooney@google.com>, 'jeff' <jeff.chuang@emc.com.tw>, 'Phoenix' <phoenix@emc.com.tw>

On Wed, Mar 30, 2016 at 05:49:12PM +0800, DusonLin wrote:
> Hello Dmitry,
>=20
> Please check my response below, thanks.
>=20
>=20
> -----Original Message-----
> From: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com]=20
> Sent: Wednesday, March 30, 2016 10:31 AM
> To: DusonLin
> Cc: Linux-kernel@vger.kernel.org; linux-input@vger.kernel.org; 'Charl=
es Mooney'; 'jeff'; 'Phoenix'
> Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER falg when HOVER ev=
ent trigger
>=20
> Hi Duson,
>=20
> On Wed, Mar 30, 2016 at 10:02:02AM +0800, DusonLin wrote:
> > Only ABS_DISTANCE is not enough for upper OS  to distiguish hover=20
> > event be triggered from object form faraway to and close touchpad=20
> > surface or from object prepare to leave the touchpad surface. We ad=
d=20
> > BNT_TOOL_FINGER to help it.
> >=20
> >                  Object_at_faraway   object_at_hover_area  object_t=
ouch_touchpad
> >       BTN_TOUCH         0                      0                   =
 1
> > BTN_TOOL_FINGER         0                      1                   =
 1
> >    ABS_DISTANCE         0                      1                   =
 0
> >=20
> > Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> > ---
> > drivers/input/mouse/elan_i2c_core.c |   14 +++++++++-----
> > 1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/elan_i2c_core.c=20
> > b/drivers/input/mouse/elan_i2c_core.c
> > index 2f58985..9392a8c 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -4,7 +4,7 @@
> >   * Copyright (c) 2013 ELAN Microelectronics Corp.
> >   *
> >   * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.c=
om.tw>
> > - * Version: 1.6.0
> > + * Version: 1.6.1
> >   *
> >   * Based on cyapa driver:
> >   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> > @@ -845,23 +845,27 @@ static void elan_report_absolute(struct=20
> > elan_tp_data *data, u8 *packet) {
> >       struct input_dev *input =3D data->input;
> >       u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
> > -       int i;
> > +      int i, valid_count =3D 0;
>=20
> This appears all whitespace-damaged.
> [duson] will do.
>=20
> >       u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
> >       u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
> >       bool contact_valid, hover_event;
> >=20
> > -       hover_event =3D hover_info & 0x40;
> > +      hover_event =3D (hover_info & 0x40);
>=20
> We do not need parentheses here.
> [duson] will do.
>=20
> >       for (i =3D 0; i < ETP_MAX_FINGERS; i++) {
> >               contact_valid =3D tp_info & (1U << (3 + i));
> >               elan_report_contact(data, i, contact_valid,=20
> > finger_data);
> >=20
> > -               if (contact_valid)
> > +              if (contact_valid) {
> >                       finger_data +=3D ETP_FINGER_DATA_LEN;
> > +                      valid_count++;
> > +              }
> >       }
> >=20
> >        input_report_key(input, BTN_LEFT, tp_info & 0x01);
> > +      input_report_key(input, BTN_TOOL_FINGER,
> > +                      ((hover_event !=3D 0) | (valid_count > 0)));
>=20
> You do not want to use "bitwise or" here.
>=20
> >       input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);
> > -       input_mt_report_pointer_emulation(input, true);
> > +      input_mt_report_pointer_emulation(input, false);
>=20
> I wonder if we should teach input_mt_report_pointer_emulation() to ha=
ndle hover properly.
> [duson] But, it looks like the hover is not standard function and not=
 all of touchpad support this function,=20
>        Even though, we still teach inpu_mt_report_pointer_emulation()=
 to handle this function?

Yes, something like this:

If device supports ABS_DISTANCE and does not support ABS_MT_DISTANCE an=
d
ABS_DISTANCE !=3D 0 is reported in current frame and there are no other
contacts then report BTN_TOOL_FINGER.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
