From: =?UTF-8?B?R8O2a8OnZW4gRXJhc2xhbg==?= <gokcen@pardus.org.tr>
Subject: Re: [PATCH] HID: Add support for Macbook Pro 8 keyboards and sort
 entries.
Date: Fri, 28 Oct 2011 08:13:30 +0300
Message-ID: <4EAA39FA.8040006@pardus.org.tr>
References: <20111022120426.GA2281@polaris.bitmath.org> <1319312346-2676-1-git-send-email-gokcen@pardus.org.tr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA75E7EEE4B2CBE095063FFF7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:34123 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1J1FNu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 01:13:50 -0400
In-Reply-To: <1319312346-2676-1-git-send-email-gokcen@pardus.org.tr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA75E7EEE4B2CBE095063FFF7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

G=C3=B6k=C3=A7en Eraslan wrote On 10/22/2011 10:39 PM:
> This patch adds keyboard support for Macbook Pro 8 models which has
> WELLSPRING5A model name and 0x0252, 0x0253 and 0x0254 USB IDs. Trackpad=

> support for those models are added to bcm5974 in
> c331eb580a0a7906c0cdb8dbae3cfe99e3c0e555.
>=20

Any feedback on that?

> Signed-off-by: G=C3=B6k=C3=A7en Eraslan <gokcen@pardus.org.tr>
> ---
>  drivers/hid/hid-apple.c |    6 ++++++
>  drivers/hid/hid-core.c  |    6 ++++++
>  drivers/hid/hid-ids.h   |    9 ++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 18b3bc6..4d8458e 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -493,6 +493,12 @@ static const struct hid_device_id apple_devices[] =
=3D {
>  		.driver_data =3D APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_JIS),
>  		.driver_data =3D APPLE_HAS_FN | APPLE_RDESC_JIS },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_ANSI),
> +		.driver_data =3D APPLE_HAS_FN },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_ISO),
> +		.driver_data =3D APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_JIS),
> +		.driver_data =3D APPLE_HAS_FN | APPLE_RDESC_JIS },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_W=
IRELESS_2009_ANSI),
>  		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_W=
IRELESS_2009_ISO),
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 242353d..9a3fcc5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1340,6 +1340,9 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_ANSI) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_ISO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_JIS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_ANSI) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_ISO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_JIS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_AN=
SI) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_IS=
O) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_JI=
S) },
> @@ -1892,6 +1895,9 @@ static const struct hid_device_id hid_mouse_ignor=
e_list[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_ANSI) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_ISO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
_JIS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_ANSI) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_ISO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5=
A_JIS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP=
_ONLY) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_=
ONLY) },
>  	{ }
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7d27d2b..2c281b6 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -100,6 +100,9 @@
>  #define USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI	0x0236
>  #define USB_DEVICE_ID_APPLE_WELLSPRING3_ISO	0x0237
>  #define USB_DEVICE_ID_APPLE_WELLSPRING3_JIS	0x0238
> +#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI  0x0239
> +#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO   0x023a
> +#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS   0x023b
>  #define USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI	0x023f
>  #define USB_DEVICE_ID_APPLE_WELLSPRING4_ISO	0x0240
>  #define USB_DEVICE_ID_APPLE_WELLSPRING4_JIS	0x0241
> @@ -112,9 +115,9 @@
>  #define USB_DEVICE_ID_APPLE_ALU_REVB_ANSI	0x024f
>  #define USB_DEVICE_ID_APPLE_ALU_REVB_ISO	0x0250
>  #define USB_DEVICE_ID_APPLE_ALU_REVB_JIS	0x0251
> -#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI  0x0239
> -#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO   0x023a
> -#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS   0x023b
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
>  #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
>  #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
>  #define USB_DEVICE_ID_APPLE_ATV_IRCONTROL	0x8241


--=20
G=C3=B6k=C3=A7en Eraslan


--------------enigA75E7EEE4B2CBE095063FFF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk6qOgEACgkQZ/1oBRJ7GWtGwACgktzXC8mZ6oF7dOWHu9RpAJrC
GaMAniOYn8gnE7ZFk31KnO7HY/TbwPnd
=l5cr
-----END PGP SIGNATURE-----

--------------enigA75E7EEE4B2CBE095063FFF7--
