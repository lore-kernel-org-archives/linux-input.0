From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [Linuxwacom-devel] [PATCH 2/2] HID: wacom: Add reporting of
 wheel for Intuos4 WL
Date: Fri, 09 Mar 2012 18:11:33 +0000
Message-ID: <1331316698.28974.13.camel@pldmachine>
References: <1331299252-23699-1-git-send-email-przemo@firszt.eu>
	 <1331299252-23699-2-git-send-email-przemo@firszt.eu>
	 <CANRwn3R5fFkujnsPhx++4PSQEwVNnWo_uXa9Zgb6m=SrJPtN0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:58972 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753568Ab2CISLm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Mar 2012 13:11:42 -0500
In-Reply-To: <CANRwn3R5fFkujnsPhx++4PSQEwVNnWo_uXa9Zgb6m=SrJPtN0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: jkosina@suse.cz, pinglinux@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

Dnia 2012-03-09, pi=C4=85 o godzinie 09:37 -0800, Jason Gerecke pisze:
> On Fri, Mar 9, 2012 at 5:20 AM, Przemo Firszt <przemo@firszt.eu> wrot=
e:
> > This patch adds reporting of ABS_WHEEL event. Raported walues are 0=
=2E.71
> > and are related to absolute location of the finger on the wheel.
> >
> > Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> > ---
> >  drivers/hid/hid-wacom.c |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> > index 5c25036..6f65514 100644
> > --- a/drivers/hid/hid-wacom.c
> > +++ b/drivers/hid/hid-wacom.c
> > @@ -36,6 +36,7 @@
> >  struct wacom_data {
> >        __u16 tool;
> >        __u16 butstate;
> > +       __u8 whlstate;
> >        __u8 features;
> >        __u32 id;
> >        __u32 serial;
> > @@ -322,6 +323,16 @@ static void wacom_i4_parse_button_report(struc=
t wacom_data *wdata,
> >                        struct input_dev *input, unsigned char *data=
)
> >  {
> >        __u16 new_butstate;
> > +       __u8 new_whlstate;
> > +       __u8 sync =3D 0;
> > +
> > +       new_whlstate =3D data[1] & 0x7f;
> > +       if (new_whlstate !=3D wdata->whlstate) {
> > +               wdata->whlstate =3D new_whlstate;
> > +               input_report_key(input, BTN_TOUCH, 1);
> > +               input_report_abs(input, ABS_WHEEL, new_whlstate);
> > +               sync =3D 1;
> > +       }
> >
> The highest bit of data[1] is a "touched" flag that you'll want to
> check to determine if the wheel is being used. If its unset, you'll
> want to reset ABS_WHEEL and BTN_TOUCH to zero here.
>=20
Thanks!
A new patch is on the way...
--=20
Przemo

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
