From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v2 0/4] Read battery voltage from G403 and G900 mice
Date: Mon, 19 Aug 2019 14:44:21 +0100
Message-ID: <ccad5760aef282d86abc4ba88c1fa484ad62108e.camel@archlinux.org>
References: <20190605194533.18717-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nsL2SEBp2H9r4FLuninh"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605194533.18717-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Vanzella <pedro@pedrovanzella.com>, linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-nsL2SEBp2H9r4FLuninh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-05 at 15:45 -0400, Pedro Vanzella wrote:
> The gaming line of Logitech devices doesn't use the old hidpp20
> feature
> for battery level reporting. Instead, they report the current voltage
> of the battery, in millivolts.
>=20
> This patch set handles this case by adding a quirk to the devices we
> know
> to have this new feature, in both wired and wireless mode.
>=20
> This version of the patch set is better split, as well as adding the
> quirk to make sure we don't needlessly probe every device connected.
>=20
> Pedro Vanzella (4):
>   HID: hid-logitech-hidpp: add quirk to handle battery voltage
>   HID: hid-logitech-hidpp: add function to query battery voltage
>   HID: hid-logitech-hidpp: report battery voltage to the power supply
>   HID: hid-logitech-hidpp: subscribe to battery voltage events
>=20
>  drivers/hid/hid-logitech-hidpp.c | 150
> ++++++++++++++++++++++++++++++-
>  1 file changed, 147 insertions(+), 3 deletions(-)
>=20

This is OK. However since we now have a feature discovery routine I
think the code should use that instead of quirks. I will send a patch
making this change.

You can have my
Reviewed-by: Filipe La=C3=ADns <lains@archlinux.org>

Thank you,
Filipe La=C3=ADns

--=-nsL2SEBp2H9r4FLuninh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl1ap7AACgkQ+JPGdIFq
qV3/hQ/9HqVd9/NubPX0RxXJ2Gh64enjTTHj2LFfbre7ylLBz3D3Ir5/1SLgr1dh
uyXmUKD4gn6HeVYRLz0nYUzskuITwZ4VXjcOr2hfg3poht6MDl9AMFw+gQJt6mXs
y4glX/4VjIODfP7LaO3pT28R+2S7iuAozdsrn3uacToexWA4p6AG1CnbTOCzcOYo
e6hosSgvyrmWsiCqVyLMHhAuW29Sr5TEeCLghxZS3dWi2CF+eo/KOGG2zveB0CER
iw9SLWwMnNy8hKS9aJUc6IuWyePrTekTm6xdMtzRz5SgA6rSpMObG144WVjs075Z
tLufPaBGakp+d4/7+4grHC6YPsGnYrms+tE5xbRmc5udeYc7doc8J5WsyR3V7A4B
7NOmzAS/uLL10Uv10oErvNk3eRK8YOMW7Auol9O7ohk4C/1TDvNcG3wHSDroDPUi
i+8QYR8sm7C42XZDT/rq50kZrYrCbXD4QiNp4Tp28qFIvavR9nH8Z4Dvcr6GOtdS
Ksl6im8Qj8LwyXJFSlim/KFO91RugujrAyai6B1yLvkB2mPHFiWLG26cGOjFcCGy
RUEKGoSUqGKjy7QoJeBb+ltPvyA/ltn/oJAWU4N7IEGgHYBL2oc/DDkD8eEof5L+
/qpngOcEWKMfx3ooVy2NWY9QoFHWWEaIeS9Ibh/JAWiEoaLex3s=
=QENM
-----END PGP SIGNATURE-----

--=-nsL2SEBp2H9r4FLuninh--
