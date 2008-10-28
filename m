From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3] Input: appletouch - driver refactoring
Date: Tue, 28 Oct 2008 08:23:54 +0100
Message-ID: <1225178634.3796.56.camel@johannes.berg>
References: <1223542147.6130.14.camel@galileo>
	 <20081011032120.GB22499@anvil.corenet.prv>
	 <1223822468.9733.1.camel@galileo> <1223822674.9733.5.camel@galileo>
	 <1223823289.10176.9.camel@johannes.berg> <1223827257.11389.1.camel@galileo>
	 <1223827421.11389.5.camel@galileo> <1223891135.24954.1.camel@johannes.berg>
	 <20081028030355.GA2898@anvil.corenet.prv>
	 (sfid-20081028_040402_139480_41C02D8C)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Up3CMr93xD7mQtpI+8cM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:57913 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJ1HYA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2008 03:24:00 -0400
In-Reply-To: <20081028030355.GA2898@anvil.corenet.prv> (sfid-20081028_040402_139480_41C02D8C)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stelian Pop <stelian@popies.net>, linux-input@vger.kernel.org


--=-Up3CMr93xD7mQtpI+8cM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-10-27 at 23:03 -0400, Dmitry Torokhov wrote:

> > > +static struct atp_info geyser1_info =3D {
> > > +	.xsensors	=3D 16,		/* will be set to 26 on 17" */
> >=20
> > those static variables ;)
> >=20
> > Considering these devices aren't available outside of apple laptops and
> > those always come with exactly one, I don't think it's much of a
> > problem.
> >=20
>=20
> How about if we do this:
>=20
> Input: appletouch - small fixup to Stelians patch

looks good to me, thanks!

johannes

--=-Up3CMr93xD7mQtpI+8cM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJBr4GAAoJEKVg1VMiehFYQHoP+wY/7s4pgCb/LBqHbZ9F3cKo
OWt1DTPzfO2FL8CJW2i3ZFEC2ga5cFz5coSgOEx97jns5Bs+2BZyxsDzRPbOBBbK
WHHIuzjlFmRrPBgiq32EWglS3sWYcL2YiJ1CI2c5gDBNaX6HcNWQ+qntVlczUQ2E
e13U/hrUL0zXIWbt4iFFvjmhHPuDVcxy2OFIy0DsqP8G8evEY07NJDjBjb8l8WwL
B2yWi9qFApWlCRWMf1HhW6e0S9kHobmvC6OQVS1X4PLbzd3e/7QvrD07ZAwltypq
zoer1+Yug8cR3i/leM3/cEcmCD+TpZ+m/M0gajajlpBhZ0IgN8DlFdsjK4HA/R5Z
vkBVqs4HrNbPlUe0PanIE0ByC+T1hegAW4UaR+lLlgAJC/2ELiSa2W/3OBZcQ4Hz
rv1GRLXMSXp8QF84RHx1UF0sOP5y64tBrGKVVpthqsBUDxLNET7T2hOz1/ixe3zP
Q/HSIfyU75R8Nc5MbBIWhQg0mPDGCGktDsLNU2kF6+/Z8bI9HgqMavexbgleX+UL
uWSjzWyXRqtpacU70cUZSYTSAKClQIiKdtredoaKkK7HkvkO08Kz3bkv5+JNZZ13
vncYvCApCvJ4EIXNSYhWxk8OptxE7zZedCvIFtPkpyrZKifL4U/zbcAbKF8EhDOY
HB2xFU538a8fbDYkMljc
=cjCX
-----END PGP SIGNATURE-----

--=-Up3CMr93xD7mQtpI+8cM--

