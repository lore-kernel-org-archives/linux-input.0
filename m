From: Christophe Tordeux <christophe@tordeux.net>
Subject: Re: [PATCH 01/01] drivers:input:byd fix greedy detection of Sentelic
 FSP by the BYD touchpad driver
Date: Sat, 8 Oct 2016 09:51:38 +0800
Message-ID: <20161008015138.bhdh5kdrc25enat2@sherka.pkbd.org>
References: <20161007044148.ssgxygdvmiwjsb55@sherka.pkbd.org>
 <20161007233726.GB21386@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hehpyetnkgyfuhmv"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx496502.smtp-engine.com ([217.160.92.157]:35136 "EHLO
        mx496502.smtp-engine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932216AbcJHBv4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 21:51:56 -0400
Content-Disposition: inline
In-Reply-To: <20161007233726.GB21386@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org


--hehpyetnkgyfuhmv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Friday 07 October 2016 at 04:37:26PM, Dmitry Torokhov has written:
> Hi Christophe,
>=20
> On Fri, Oct 07, 2016 at 12:41:48PM +0800, Christophe Tordeux wrote:
> > From: Christophe TORDEUX <christophe@tordeux.net>
> >=20
> > With kernel v4.6 and later, the Sentelic touchpad STL3888_C0 and
> > probably other Sentelic FSP touchpads are detected as a BYD touchpad and
> > lose multitouch features.
> >=20
> > During the BYD handshake in the byd_detect function, the BYD driver
> > mistakenly interprets a standard PS/2 protocol status request answer
> > from the Sentelic touchpad as a successful handshake with a BYD
> > touchpad. This is clearly a bug of the BYD driver.
> >=20
> > Description of the patch: In byd_detect function, remove positive
> > detection result based on standard PS/2 protocol status request answer.
> > Replace it with positive detection based on handshake answers as they
> > can be inferred from the BYD touchpad datasheets found on BYD website.
> >=20
> > Signed-off-by: Christophe TORDEUX <christophe@tordeux.net>
>=20
> What devices was this tested on? Do you have both BYD and Sentelic
> devices?
>=20

I only have a Sentelic STL3888_C0 touchpad, I don't have any BYD=20
touchpad.

> I am really concerned about docs on BYD side as they seem to contradict
> each other... I wonder how accurate they are.
>=20

I agree, there's problems with each of their docs. I tried to infer the=20
handshake answers based on the big picture that seems to emerge when=20
reading all of them.

If ever that matters, I found out that my STL3888_C0 touchpad:
* answers E8/03/E8/03/E8/03/E8/03/E9 like standard PS/2 protocol
* answers E8/00/E8/00/E8/00/E8/00/E9 with 00/88/64

The latter does not look standard PS/2 so may be a kind of handshake=20
=66rom the Sentelic touchpad. And, in the BYD docs, part of the BYD=20
devices also call for 00 during the handshake, others call for 03.

Things which can be considered in addition or in parallel to my patch:

1) in psmouse-base.c, move the detection of Sentelic touchpads above the=20
detection of BYD touchpads. However based on the code comments could=20
have adverse effects I don't know about.

2) Exit the byd_detect function without detection based on=20
E8/00/E8/00/E8/00/E8/00/E9 being answered by 00/88/64. However while it=20
would certainly fix my issue with my particular touchpad, it still would
leaves the byd_detect function being dirty and greedy otherwise, so I=20
don't really like it.

3) take my patch, keep the 00 and 03 handshakes in sequence, add a=20
detection based on the first byte of data being 01 regardless of the=20
other bytes of data in the answer. It would probably fix the Sentelic=20
detection issue... unless the user is pressing the left button during=20
the BYD handshake. From the BYD docs "it is expected the get the value=20
of 01 in the first byte data (...) and the first byte data is the only=20
data needed to be checked". The issue with the docs is that this=20
statement is sometimes contradicted by the sketch of the handshake... My=20
patch is mostly based on the handshake sketches currently, but I could=20
add a detection based on the first byte being 01, with no other test.

Let me know what looks best for you, for me the third choice is probably=20
the most reasonable solution, either this or do it like in my initial=20
patch.  If you know someone who has the kernel sources and a BYD=20
touchpad, ask him to get the answer to E8/00/E8/00/E8/00/E8/00/E9 from=20
BYD touchpads.

> Thanks.
>=20
> >=20
> > ---
> > Resubmitting this patch because I got no feedback on my first=20
> > submission.
> > Fixes kernel bug 175421 which is impacting multiple users.
> >=20
> > ---
> >  drivers/input/mouse/byd.c | 76=20
> >  ++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 62 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> > index b27aa63..b5acca0 100644
> > --- a/drivers/input/mouse/byd.c
> > +++ b/drivers/input/mouse/byd.c
> > @@ -35,6 +35,18 @@
> >   * BYD pad constants
> >   */
> > =20
> > +/* Handshake answer of BTP6034 */
> > +#define BYD_MODEL_BTP6034	0x00E801
> > +/* Handshake answer of BTP6740 */
> > +#define BYD_MODEL_BTP6740	0x001155
> > +/* Handshake answers of BTP8644, BTP10463 and BTP11484 */
> > +#define BYD_MODEL_BTP8644	0x011155
> > +
> > +/* Handshake SETRES byte of BTP6034 and BTP6740 */
> > +#define BYD_SHAKE_BYTE_A	0x00
> > +/* Handshake SETRES byte of BTP8644, BTP10463 and BTP11484 */
> > +#define BYD_SHAKE_BYTE_B	0x03
> > +
> >  /*
> >   * True device resolution is unknown, however experiments show the
> >   * resolution is about 111 units/mm.
> > @@ -434,23 +446,59 @@ static void byd_disconnect(struct psmouse *psmous=
e)
> >  	}
> >  }
> > =20
> > +u32 byd_try_model(u32 model)
> > +{
> > +	size_t i;
> > +
> > +	u32 byd_model[] =3D {
> > +		BYD_MODEL_BTP6034,
> > +		BYD_MODEL_BTP6740,
> > +		BYD_MODEL_BTP8644
> > +	};
> > +
> > +	for (i=3D0; i < ARRAY_SIZE(byd_model); i++) {
> > +		if (model =3D=3D  byd_model[i])
> > +			return model;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int byd_detect(struct psmouse *psmouse, bool set_properties)
> >  {
> >  	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> > -	u8 param[4] =3D {0x03, 0x00, 0x00, 0x00};
> > -
> > -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > -		return -1;
> > -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > -		return -1;
> > -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > -		return -1;
> > -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > -		return -1;
> > -	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> > -		return -1;
> > -
> > -	if (param[1] !=3D 0x03 || param[2] !=3D 0x64)
> > +	size_t i;
> > +
> > +	u8 byd_shbyte[] =3D {
> > +		BYD_SHAKE_BYTE_A,
> > +		BYD_SHAKE_BYTE_B
> > +	};
> > +
> > +	bool detect =3D false;
> > +	for (i=3D0; i < ARRAY_SIZE(byd_shbyte); i++) {
> > +		u32 model;
> > +		u8 param[4] =3D {byd_shbyte[i], 0x00, 0x00, 0x00};
> > +
> > +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > +			return -1;
> > +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > +			return -1;
> > +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > +			return -1;
> > +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
> > +			return -1;
> > +		if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> > +			return -1;
> > +
> > +		model =3D param[2];
> > +		model +=3D param[1] << 8;
> > +		model +=3D param[0] << 16;
> > +		model =3D byd_try_model(model);
> > +		if (model)
> > +			detect =3D true;
> > +	}
> > +
> > +	if (!detect)
> >  		return -ENODEV;
> > =20
> >  	psmouse_dbg(psmouse, "BYD touchpad detected\n");
>=20
>=20
>=20
> --=20
> Dmitry
>=20

--=20
Christophe TORDEUX
4403, Building 3, Arcadia Court
South side of Liuwei Rd. West
Hedong District
Tianjin, 300350
P.R. China
mob: +86 186 1403 3192
http://christophe.tordeux.net

--hehpyetnkgyfuhmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJX+FEoAAoJEE/hdwZK2Yyt0bgH/jtpz5agM0/oBOt4Q4Fou52M
ClTKHJi0RHxDc/UC4ejfS4iMdr/KVLVWbqApfz8oUbQHphEvrha0CDT+r4Q6SqJ4
GI826Q4g9va3LTFNztGFnGsl76N1DXG1yWQpyIZW99rSNu0Zt2W484oWPIhIrzSw
jBAKIKOEeFoD/V8gwh3jYxWjbaSaw/U+/Dgctjy9dT9yVnwWX5w2rSnrpRugXwrP
S6qXWaa4ZZfVVJmw4pje1Y/tGc6t4kgdbqFF8Z/9v6r/rxT8M1Ii5lAG35ZUNKTf
gtdQd+HUi/a2x19g18msHk7MT+9SJk/wGZF6t7PNhKIopNsVC75TfWoLZc5tilk=
=kHWl
-----END PGP SIGNATURE-----

--hehpyetnkgyfuhmv--
