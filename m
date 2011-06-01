From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Byte swapping u16 data in HID report
Date: Wed, 1 Jun 2011 12:58:32 +0200
Message-ID: <20110601125832.78d862ee.ospite@studenti.unina.it>
References: <80b32cfd7dc9e8afee2c4d9e21d1a7e3.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Jun_2011_12_58_32_+0200_2Y9UZNOKDCyNg2Zo"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:41609 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933403Ab1FAK7F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Jun 2011 06:59:05 -0400
In-Reply-To: <80b32cfd7dc9e8afee2c4d9e21d1a7e3.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Marcin Tolysz <tolysz@gmail.com>

--Signature=_Wed__1_Jun_2011_12_58_32_+0200_2Y9UZNOKDCyNg2Zo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jun 2011 01:32:15 -0400
simon@mungewell.org wrote:

> Hi,
> I'm looking into fixing the Sixaxis controller (hid-sony.c) so that the
> accelerometers and gyro data are reported via a joystick axis.
>=20
> I have patched the HID descriptor so that the values are seen, however
> they are reported high byte first (0x2FF -> 0x02, 0xFF) which appears to
> be contrary to the HID spec.
> --
> 5.8 Format of Multibyte Numeric Values
> Multibyte numeric values in reports are represented in little-endian
> format, with the least significant byte at the lowest address.
> --
>=20
> I'm working on the assumption that the data can be 'fixed' before it is
> parsed. Would intercepting 'hid_get_report()' be a good place and how can
> I locate the actual data bytes to do a 'bswap16()'.
>=20
> I'm thinking something like:
> --
> 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
> 		hdev->hid_get_report =3D sixaxis_hid_get_report;
> 	}
> --
>=20
> Any suggestions/comments?
> Simon.
>

Marcin Tolysz (added to CC), worked on the sixaxis descriptor before,
see http://permalink.gmane.org/gmane.linux.bluez.kernel/5184

Look in particular at the sony_raw_event() function.

I also like his approach of overriding HID descriptors with the
firmware framework in principle, even if its practical use still needs
some evaluation.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__1_Jun_2011_12_58_32_+0200_2Y9UZNOKDCyNg2Zo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3mG1gACgkQ5xr2akVTsAH7SgCdF3JifKtBOc7nTNIyipXdWMm0
ZscAoIwk7ILyd6uDG7fT5etsUWip4Sah
=1/e3
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Jun_2011_12_58_32_+0200_2Y9UZNOKDCyNg2Zo--
