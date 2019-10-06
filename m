From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v3 1/4] HID: logitech: Add MX Mice over Bluetooth
Date: Sun, 06 Oct 2019 16:07:59 +0100
Message-ID: <c440435a1fb8a04a9fca83f17b7cc1ebb95bcc44.camel@archlinux.org>
References: <l7xYjnA9EGfZe03FsrFhnH2aMq8qS8plWhHVvOtY_l4ShZ1NV6HA6hn9aI-jAzbLYUGFCIQCIKkx9z42Uoj4-AZDwBfRcAecYIn-0ZA5upE=@protonmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4zPzoW7jzVovkqYvJJGf"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <l7xYjnA9EGfZe03FsrFhnH2aMq8qS8plWhHVvOtY_l4ShZ1NV6HA6hn9aI-jAzbLYUGFCIQCIKkx9z42Uoj4-AZDwBfRcAecYIn-0ZA5upE=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-4zPzoW7jzVovkqYvJJGf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-10-06 at 01:04 +0000, Mazin Rezk wrote:
> This patch adds support for several MX mice over Bluetooth. The device ID=
s
> have been copied from the libratbag device database and their features
> have been based on their DJ device counterparts.
>=20
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 0179f7ed77e5..85fd0c17cc2f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3773,6 +3773,24 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
>  	{ /* MX5500 keyboard over Bluetooth */
>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>  	  .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> +	{ /* MX Anywhere 2 mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ /* MX Anywhere 2S mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ /* MX Master mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ /* MX Master 2S mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> +	  .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>  	{}
>  };
>=20
> --
> 2.23.0

I think you should only add the mice you tested. We are not sure if
this devices actually do work properly with the current stack. I will
try to test some devices after Tuesday.

Filipe La=C3=ADns

--=-4zPzoW7jzVovkqYvJJGf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl2aA0UACgkQ+JPGdIFq
qV2tShAAmhubw9I/kSIhhapRmz2G0cNdy0pa2TS5Aai1RQulADup1aIHEAQpH+dW
WxeNSeNkuB0pFgGIw+weOmuvvV5H2M+J+K+dWxdfuM08lJmmXSIbJBXSkDy0FZLd
8Ausxvwg+RHVPmVhQg7h6pe3FpLEKEpM0T/D8cvyUGJmbbCNgBtz12sltY4XKyo/
tOJ0g0TU4STocg722fFYaQCh2MeBQzCj5qIMITM84Q7Wv7GUSIbVHmYfBHbC7EvY
wyJEkX2y12HQeJOsUVYPMArmzVX0xqe/v72V8m0lpNH55KUYzzy5HFqqzKzEq1v0
FTCJHdIZRoDIKz4rd85175v2hEnsdEju9dD0UmfGPbasvaMQb6qxYRMMlve7G+tg
bzblD6UgD7sU7jsmFdj/Cnu5gxQqZqT6GfENLtK7IFy6fFURtR5qxnGUZuxh6j3m
o8CyPDjp2dwt+k6jpOUmFXinMw0oqpUD0g1pJ3jkVy8XEiMRIsrMt141B+osmJYT
ZOHpRSARTh1WkTBxi7mfFNh9TOYxur+6llGIdReKYtfLTQyN73Ae+FQexjsf8beQ
4xB4/9C8e3tBV5ApxcHhDrt5EqOW84gMD54tDL93GeGsAVlLDTB6jvrrTIlW+GKk
A2I1ZQwChJYunDEIO8eXxqBePp2qPZSwu2SkUGIhLugDN8byS6s=
=QMFT
-----END PGP SIGNATURE-----

--=-4zPzoW7jzVovkqYvJJGf--
