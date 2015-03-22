From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - fix max coordinates for v5 and v7 protocols
Date: Sun, 22 Mar 2015 13:33:09 +0100
Message-ID: <201503221333.10049@pali>
References: <20150322033656.GA35352@dtor-ws> <550E9DF1.60507@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4396320.NlDRGcEAPg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:33656 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbCVMdN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2015 08:33:13 -0400
In-Reply-To: <550E9DF1.60507@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Santiago Gala <sgala@apache.org>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-kernel@vger.kernel.org

--nextPart4396320.NlDRGcEAPg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 22 March 2015 11:48:17 Hans de Goede wrote:
> Hi,
>=20
> On 22-03-15 04:36, Dmitry Torokhov wrote:
> > Commit 3296f71cd2fde7a2ad52e66a27eae419f6328066 ("Input:
> > ALPS - consolidate setting protocol parameters")
> > inadvertently moved call to alps_dolphin_get_device_area()
> > from v5 to v7 protocol, causing both protocols report
> > incorrect maximum values for X and Y axes which resulted in
> > crash in Synaptics X driver.
> >=20
> > Reported-by: Santiago Gala <sgala@apache.org>
> > Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Fix looks good to me:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Regards,
>=20
> Hans
>=20

Looks good also for me...

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> > ---
> >=20
> >   drivers/input/mouse/alps.c | 11 ++++++-----
> >   1 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/alps.c
> > b/drivers/input/mouse/alps.c index 1bd15eb..33198b9 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -2281,10 +2281,12 @@ static int alps_set_protocol(struct
> > psmouse *psmouse,
> >=20
> >   		priv->set_abs_params =3D alps_set_abs_params_mt;
> >   		priv->nibble_commands =3D alps_v3_nibble_commands;
> >   		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> >=20
> > -		priv->x_max =3D 1360;
> > -		priv->y_max =3D 660;
> >=20
> >   		priv->x_bits =3D 23;
> >   		priv->y_bits =3D 12;
> >=20
> > +
> > +		if (alps_dolphin_get_device_area(psmouse, priv))
> > +			return -EIO;
> > +
> >=20
> >   		break;
> >   =09
> >   	case ALPS_PROTO_V6:
> > @@ -2303,9 +2305,8 @@ static int alps_set_protocol(struct
> > psmouse *psmouse,
> >=20
> >   		priv->set_abs_params =3D alps_set_abs_params_mt;
> >   		priv->nibble_commands =3D alps_v3_nibble_commands;
> >   		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> >=20
> > -
> > -		if (alps_dolphin_get_device_area(psmouse, priv))
> > -			return -EIO;
> > +		priv->x_max =3D 0xfff;
> > +		priv->y_max =3D 0x7ff;
> >=20
> >   		if (priv->fw_ver[1] !=3D 0xba)
> >   	=09
> >   			priv->flags |=3D ALPS_BUTTONPAD;


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4396320.NlDRGcEAPg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUOtoYACgkQi/DJPQPkQ1I1XACfWJp6fnT9nLyIfVJK9Yyyy+/+
S94AnR39h/mtfgo6WUk+ZJ/nU1iEvkp2
=DiHy
-----END PGP SIGNATURE-----

--nextPart4396320.NlDRGcEAPg--
