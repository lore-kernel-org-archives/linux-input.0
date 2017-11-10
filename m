From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 5/5] platform/x86: intel-vbtn: support panel front button
Date: Fri, 10 Nov 2017 01:21:51 +0100
Message-ID: <1625791.nSucaqoEJ0@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <7c072721-1bd8-4921-b759-70bafb2ec894@rwthex-w2-a.rwth-ad.de> <1510270833.2624.52.camel@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8258186.OfJ9pR5HK6";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1510270833.2624.52.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart8258186.OfJ9pR5HK6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 12:40:33 AM CET Bastien Nocera wrote:
> On Thu, 2017-11-09 at 23:44 +0100, Stefan Br=FCns wrote:
> > The Lenovo Helix 2 and Dell XPS 12 (9Q33) have an extra button on the
> > front showing a 'Windows' logo, both reporting event codes 0xC2/0xC3
> > on press/release. On the Dell, both press/release are distinct events
> > while on the Helix 2 both events are generated on release.
> >=20
> > Tested on XPS 12, for info on the Helix 2 see:
> > https://www.spinics.net/lists/ibm-acpi-devel/msg03982.html
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
>=20
> Same problem as mentioned in patch 3. Pretty sure you need to set the
> Windows key release to KEY_IGNORE.
>=20
> Or better, teach the intel-vbtn driver which buttons should be
> autoreleased, and which ones should send key presses and key releases
> separately. This would allow handling long presses in the upper layers.

=46irst, I explicitly mentioned on the XPS 12, press/release are distinct=20
events. Care to read?

Second, if you read patch 2/5, you see support for press/release vs=20
autorelease.

Regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart8258186.OfJ9pR5HK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgTxHwAKCRBvf0o9jP6q
U94yAKCBZk/i9cy59xOiPaW154ywTiX5AQCgh/lOQ+1KZz4RKzwz3h317lty0Og=
=/pd+
-----END PGP SIGNATURE-----

--nextPart8258186.OfJ9pR5HK6--
