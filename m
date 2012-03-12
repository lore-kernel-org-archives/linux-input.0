From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: wacom: Reset stylus buttons - Intuos4 WL
Date: Mon, 12 Mar 2012 15:52:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203121552300.18356@pobox.suse.cz>
References: <1331299252-23699-1-git-send-email-przemo@firszt.eu> <CANRwn3T0osghgP4i_e0xK8FkvKv1gXMwnumggv0pkxrDqPqKDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab2CLOwo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 10:52:44 -0400
In-Reply-To: <CANRwn3T0osghgP4i_e0xK8FkvKv1gXMwnumggv0pkxrDqPqKDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Przemo Firszt <przemo@firszt.eu>, pinglinux@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

On Fri, 9 Mar 2012, Jason Gerecke wrote:

> > Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> > ---
> > =C2=A0drivers/hid/hid-wacom.c | =C2=A0 =C2=A02 ++
> > =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> > index 2a440a6..5c25036 100644
> > --- a/drivers/hid/hid-wacom.c
> > +++ b/drivers/hid/hid-wacom.c
> > @@ -352,6 +352,8 @@ static void wacom_i4_parse_pen_report(struct wa=
com_data *wdata,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x80: /* Out of proximity report */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report=
_key(input, BTN_TOUCH, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report=
_abs(input, ABS_PRESSURE, 0);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(input, BTN_STYLUS, 0);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(input, BTN_STYLUS2, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report=
_key(input, wdata->tool, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report=
_abs(input, ABS_MISC, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_event(=
input, EV_MSC, MSC_SERIAL, wdata->serial);
> > --
> > 1.7.6.4
>=20
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
