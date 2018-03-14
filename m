From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Date: Wed, 14 Mar 2018 23:58:16 +0100
Message-ID: <20180314225816.634w64kggycj67ec@pali>
References: <20180312230915.26050-1-pali.rohar@gmail.com>
 <20180312231335.fnfxgenu22utr3z6@pali>
 <TYXPR01MB0719092EDE164BA6C576A1C7C7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="66ugg6jf3vaojm63"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TYXPR01MB0719092EDE164BA6C576A1C7C7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--66ugg6jf3vaojm63
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi! Thank you for information.

Your PS/2 Aux Port Control description seems to really matches. Just
there is reverse order of bits. Bit 0 in description is highest,
therefore matches BIT(7) macro.

Bit 6 in description (BIT(1) in code) describes SP Extended Mode which
alps.c enabled. And in that description is written:

"If 1 SP is extended packet format (driver must set SP raw mode and GP
absolute mode)."

Do you have any idea what "SP raw mode" is? How to set it? For me it
looks like it could be that extended mode of trackstick itself.

"GP absolute mode" I guess is GlidePoint absolute mode, therefore enable
6 byte absolute mode for touchpad.

And for Bit 7 (BIT(0)) is written:

This bit is used with the PS/2 Aux port to use the Pass-Thru mode ( see
appendix A ). Do you have some information about this appendix A?

On Wednesday 14 March 2018 10:21:43 Masaki Ota wrote:
> Hi, Pali,
>=20
> I just picked up the spec which relates with trackstic.
>=20
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]=20
> Sent: Tuesday, March 13, 2018 8:14 AM
> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.=
com>; Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization fo=
r v3 and v6 protocols
>=20
> Masaki, if you have access to the internal ALPS v3 / Rushmore documentati=
on, I would like to have a review of this patch or confirmation of those in=
formation :-)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--66ugg6jf3vaojm63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqmpAgAKCRCL8Mk9A+RD
UjwmAKCIxUQ7IDM0TLHJg8NQVwGQcMskTwCeJRtJUhh9kMeZDzwrQeq0ALRVYH4=
=37VS
-----END PGP SIGNATURE-----

--66ugg6jf3vaojm63--
