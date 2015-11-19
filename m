From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Thu, 19 Nov 2015 16:04:06 +0100
Message-ID: <564DE4E6.1030505@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g69Pj5CFjl5eAD79FAjiW4DCqPP8QEbTX"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55456 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbbKSPJz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 10:09:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input Mailing List <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g69Pj5CFjl5eAD79FAjiW4DCqPP8QEbTX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/15 16:00, Andrew Shadura wrote:
> PenMount 6000 USB resistive touchscreen controller reports it has three=

> buttons, while in reality it doesn't have any and doesn't support activ=
e
> styli, and only generates touch events.
>=20
> In penmount_input_mapping(), map only the first button (with code 0),
> ignore the rest.
>=20
> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>

Any updates on this patch?

--=20
Cheers,
  Andrew


--g69Pj5CFjl5eAD79FAjiW4DCqPP8QEbTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWTeTmAAoJEEFnG7NKhJOBOuAQAKKeA70F0NB4cGqKQMm9+8fu
BztK63nMz452vzGK1gnM2m8M04M0RuYuu3XN/VJjoqPZU14w1yN4KNl2Ktoj8wCh
TrO1Mh2lq77RQf6RTUSL5LklyrBZC6PaGlukQEna9ipY6hwTXDRkIh6JFVRsOnzD
+VVTo4Zc5anXRjGRsUtPIWNZck4OjQGfIdHE/bNoUOYVPZgJrbWe2A1RCCvAaRkr
btPIsBle0GcA4LDKUIHqEcCDNuhlhjzMbaf5m1g7jItkFKGHj0jsJH0ZdNeFOgUI
wC4myAhC6rIgboheC0ZzBR6k6W4C6CtfkxS6vRGuE63mgYdEV5l9cjLj8MqULtk+
jjMhnFBHtnnvi2YRCNOf9SiCDr2mGzM/kmIciI4YEKTdQZnDLwXwDyUzM6CSWIdY
ZZfL0f2gRUOdiuTQBRipPUBXIiyzqprj07q3gFDjSv8tsWz17I8t0jFbH69zZlBm
Pkg6XVBSrCuojC+6AmITni/E0mL47fCRVL89gW5/bBRGPZ4cU2Onz3YK4aOUAKUX
sr6OUNB4CLp0h4AnBRe16CRRTJTptE2t+3xaywhSJC08JFUuF0oohQKurEc37Rex
37/VYkFlg0ZYeV/92DuSEFlxzfrE+13u6iK4DQ+uqXdSt96sVibf9DKEVSxTDKS0
D+GskvIffycgddjb4R2h
=ACXn
-----END PGP SIGNATURE-----

--g69Pj5CFjl5eAD79FAjiW4DCqPP8QEbTX--
