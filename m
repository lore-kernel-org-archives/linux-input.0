From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 2/5] platform/x86: intel-vbtn: Support separate press/release events
Date: Fri, 10 Nov 2017 02:58:36 +0100
Message-ID: <1637751.MqEGyCB5Qi@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de> <20171110013417.GB9783@fury>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2629176.D3vXaZ9z9b";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171110013417.GB9783@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart2629176.D3vXaZ9z9b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 2:34:17 AM CET Darren Hart wrote:
> On Thu, Nov 09, 2017 at 11:44:33PM +0100, Stefan Br=FCns wrote:
> > Currently all key events use autorelease, but this forbids use as a
> > modifier key.
> >=20
> > As all event codes come in even/odd pairs, we can lookup the key type
> > (KE_KEY/KE_IGNORE) for the key up event corresponding to the currently
> > handled key down event. If the key up is ignored, we keep setting the
> > autorelease flag for the key down.
>=20
> What is the use-case for using these buttons as modifiers? I'm picturing =
one
> of these devices in tablet mode, with a physical Windows button. What oth=
er
> action does a user want to modify by holding the Windows button down? Or =
is
> there another scenario we're trying to support here?

Windows/KEY_LEFTMETA can be used as a modifier key, e.g. in combination wit=
h=20
the Volume Up/Down keys. On Windows, the default for Win + VolumeUp creates=
 a=20
screenshot.

You can also use this in combination with an onscreen keyboard. Pressing th=
e=20
hardware button with the hand holding the tablet and typing with the other=
=20
hand on the OSK is probably easier than hitting both keys on the OSK.

Additionally, the Volume Up/Down currently do not autorepeat, as the key is
autoreleased on the press event. The XPS 12 does issue distinct press/relea=
se=20
events, so this could be done properly. The same apparently holds for some=
=20
other convertibles, see the links in Patch 1/5.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2629176.D3vXaZ9z9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgUHzAAKCRBvf0o9jP6q
U/f8AJ9cavM7MbqNUsuGSK5BNh83ThmpAQCfezT+RVVwnqTHlmPobleeGTIBdZo=
=g7/J
-----END PGP SIGNATURE-----

--nextPart2629176.D3vXaZ9z9b--
