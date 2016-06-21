From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input/alps: Set DualPoint flag for 74 03 28 devices
Date: Mon, 20 Jun 2016 17:43:55 -0700
Message-ID: <20160621004355.GF22426@dtor-ws>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
 <1464436862-2649-5-git-send-email-ben@smart-cactus.org>
 <20160530091100.GP29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34366 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbcFUBkm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 21:40:42 -0400
Received: by mail-pa0-f66.google.com with SMTP id us13so146178pab.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2016 18:40:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160530091100.GP29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

On Mon, May 30, 2016 at 11:11:00AM +0200, Pali Roh=E1r wrote:
> On Saturday 28 May 2016 14:01:02 Ben Gamari wrote:
> > Here we introduce logic in alps_identify to set the ALPS_DUALPOINT =
flag
> > for touchpad hardware responding to E7 report with 73 03 28, as is =
found
> > in the Dell Latitude E7470.
> > ---
> >  drivers/input/mouse/alps.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.=
c
> > index 25d2cad..431bc26 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -2776,6 +2776,7 @@ static int alps_identify(struct psmouse *psmo=
use, struct alps_data *priv)
> >  	const struct alps_protocol_info *protocol;
> >  	unsigned char e6[4], e7[4], ec[4];
> >  	int error;
> > +	int flags =3D 0;
> > =20
> >  	/*
> >  	 * First try "E6 report".
> > @@ -2817,6 +2818,10 @@ static int alps_identify(struct psmouse *psm=
ouse, struct alps_data *priv)
> >  		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
> >  			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
> >  			protocol =3D &alps_v8_protocol_data;
> > +		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
> > +			   e7[2] =3D=3D 0x28 && ec[1] =3D=3D 0x01) {
> > +			protocol =3D &alps_v8_protocol_data;
> > +			flags |=3D ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE;
> >  		} else {
> >  			psmouse_dbg(psmouse,
> >  				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7,=
 ec);
> > @@ -2830,6 +2835,7 @@ static int alps_identify(struct psmouse *psmo=
use, struct alps_data *priv)
> >  		error =3D alps_set_protocol(psmouse, priv, protocol);
> >  		if (error)
> >  			return error;
> > +		priv->flags |=3D flags;
> >  	}
> > =20
> >  	return 0;
>=20
> I would rather see setting flags in alps_set_protocol function. Where=
 it
> is done for other protocols. But do not know if it is easily possible
> without rewriting lot of code...

Could probably key it off of prov->fw_ver[1] (which is ec[1]) in
alps_set_protocol() in V8 case.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
