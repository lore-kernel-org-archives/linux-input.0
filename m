From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Findind input event device path with libudev
Date: Wed, 16 Nov 2011 20:12:15 +0100
Message-ID: <20111116201215.1b6f708f9510de5362d20660@studenti.unina.it>
References: <4EC3A656.7050800@edigma.com>
	<4EC3CC38.9080304@edigma.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__16_Nov_2011_20_12_16_+0100_9a54M6nCBA2pO+U8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:43440 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab1KPTMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 14:12:25 -0500
In-Reply-To: <4EC3CC38.9080304@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

--Signature=_Wed__16_Nov_2011_20_12_16_+0100_9a54M6nCBA2pO+U8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Nov 2011 14:44:08 +0000
Nuno Santos <nsantos@edigma.com> wrote:

> Hi,
>=20
> After digging a little bit around this i found that my problem is with=20
> this function:
>=20
> dev =3D udev_device=20
> *udev_device_get_parent_with_subsystem_devtype(dev,"usb","usb_device");
>=20
> dev is always null. He can't find me the usb device for my input device.=
=20
> Maybe i'm not specifiying subsystem and dev type correctly.
>=20
> If I make several calls to udev_device_get_parent I can get to the=20
> correct device.
>=20
> Does anyone knows what should be the correct subsystem and dev type pair=
=20
> to find the parent usb device for an input device?
>=20

You can find out the most specific subsystem and devtype yourself using:

	udevadm monitor

and then plugging the device in.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__16_Nov_2011_20_12_16_+0100_9a54M6nCBA2pO+U8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7ECxAACgkQ5xr2akVTsAHzzQCfdk1rFAKHvCFMsQXOB9aqfIfB
mVEAniiPni6qctUE2ZaAuvTVay86BC41
=UM5D
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Nov_2011_20_12_16_+0100_9a54M6nCBA2pO+U8--
