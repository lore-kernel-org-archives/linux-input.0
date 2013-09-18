From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH] add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pixelsense)
Date: Wed, 18 Sep 2013 09:29:14 +0200
Message-ID: <5239564A.80207@butterbrot.org>
References: <1378934763-17938-1-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fxID7vKt6jLklFt7GRMj0lKJmkMjliefp"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:54761 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab3IRH3X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 03:29:23 -0400
In-Reply-To: <1378934763-17938-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@gmail.com, rydberg@euromail.se, dmitry.torokhov@gmail.com, dh.herrmann@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fxID7vKt6jLklFt7GRMj0lKJmkMjliefp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,

just curious: did anybody already have a chance to test this? JFYI, I
used a stock Ubuntu 12.04 32 bit on an external USB disk for
development. If you change the boot order in the SUR40's BIOS, there is
no need to modify anything on the pre-installed copy of Windows 7.

Best regards, Florian

On 11.09.2013 23:26, Florian Echtler wrote:
> This patch adds support for the built-in multitouch sensor in the Samsu=
ng
> SUR40 touchscreen device, also known as Microsoft Surface 2.0 or Micros=
oft
> Pixelsense. Support for raw video output from the sensor as well as the=
=20
> accelerometer will be added in a later patch.
>=20
> Signed-off-by: Florian Echtler <floe@butterbrot.org>
> ---
[...]

--=20
SENT FROM MY DEC VT50 TERMINAL


--fxID7vKt6jLklFt7GRMj0lKJmkMjliefp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlI5VkoACgkQ7CzyshGvatjeywCfXQZGbL91DN1gX/VTZ6jNEOXK
MTYAn1H4394rmLtvpBP6wHvVM9HwH383
=e4gJ
-----END PGP SIGNATURE-----

--fxID7vKt6jLklFt7GRMj0lKJmkMjliefp--
