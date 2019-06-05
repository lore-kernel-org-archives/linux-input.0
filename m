From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v2 0/4] Read battery voltage from G403 and G900 mice
Date: Wed, 05 Jun 2019 23:24:18 +0100
Message-ID: <0d998fe0ff4473be2a9341c1f5ddf55957d18ad8.camel@archlinux.org>
References: <20190605194533.18717-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-b2wSQK5XfwPnbBz+78jy"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605194533.18717-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Vanzella <pedro@pedrovanzella.com>, linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-b2wSQK5XfwPnbBz+78jy
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

Hello,

Why using quirks? 0x1001 is a feature, it should be discoverable in
IFeatureSet (0x0001). I don't understand the need to hardcode the
supported devices, HID++ exists specifically to prevent that.

Wasn't this what you started in your previous patch? Why move away from
it?

Thank you,
Filipe La=C3=ADns
3DCE 51D6 0930 EBA4 7858 BA41 46F6 33CB B0EB 4BF2

--=-b2wSQK5XfwPnbBz+78jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAlz4QQkACgkQ+JPGdIFq
qV2ohA//ZGUDKIds/DIp+6rdJeuW7H8UQ2th2gXAir3NclnfH+CaDpjpmxJs5Noi
VHXI0ML8sakz8e0uOMbl6cY+0oxZyn6F754fb0FAY301ZhZz/L09SzzuPZI9eyNC
Wpb+UWuf5K1trq5pmfJbE9Pw49s6K4i0G/rtut1R3lDF+QTxz1f0wohipKApk/Om
IRMbWBli2hEI+FbXFtH8vdKrLYT884gbp/EooVBY8T3mJDIhxzQdFG7OpIAFYMJk
QB5Aprw9nraCLHDnYOIxbmLvFU+yMKJFJxi43mHLR7FocVD3+uroxlIiRVYANHVs
+Q43YdZfLgO6hXkAYVsCWtSXS1XgeZDaXiCFA+CZIqq+XkTBtXE3X2rE6Dg3nCgI
TJdnQFZvCWLTtNaBHQSAE2iS38o24W+x7Go5Uj9UMIfDIoxoZigoCUQbk+VbaVxe
WuprtmdZVhPPo2JzlhwWjMWOgzNeeMgceQnc8DHQyQGDAIPlJ4iX+23MFFAcRG1I
48rX3ssO20e4H9+MDgxCFV6f27/yCAf/qSOXP5cgWFRt9LyeKzvr0aAEC4urx1Iq
Kqrf6WLcypVJNpEBeP70J7ZEsJUkT75b4tYWzyRGnwA/1LhtMIunAFK7IexASkZk
qzN9etW89nWgZb/XKLcJQ9Y3l8/4cCONbj6l7tVyIpzzKi94i04=
=M0oI
-----END PGP SIGNATURE-----

--=-b2wSQK5XfwPnbBz+78jy--
