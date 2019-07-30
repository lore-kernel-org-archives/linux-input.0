From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH] hid-logitech-dj: add other Lightspeed receiver
Date: Tue, 30 Jul 2019 12:08:04 +0100
Message-ID: <1ffa6265ec30bc0e2d720def221dc046cc17520b.camel@archlinux.org>
References: <20190718140358.9058-1-lains@archlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dRUS50kxUdxY1qNpVTUb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718140358.9058-1-lains@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Cc: nlopezcasad@logitech.com, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-dRUS50kxUdxY1qNpVTUb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 15:03 +0100, Filipe La=C3=ADns wrote:
> This receiver seems to only be used in the G305.
>=20
> Signed-off-by: Filipe La=C3=ADns <lains@archlinux.org>
> ---
>  drivers/hid/hid-ids.h         | 1 +
>  drivers/hid/hid-logitech-dj.c | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 884356feb016..e5d0fd85e61d 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -770,6 +770,7 @@
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED	0xc539
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
> +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_2	0xc53f
>  #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
>  #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
>  #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-
> logitech-dj.c
> index d5b47ec1510c..0139912c3f69 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1836,6 +1836,10 @@ static const struct hid_device_id
> logi_dj_receivers[] =3D {
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>  		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED),
>  	 .driver_data =3D recvr_type_gaming_hidpp},
> +	{ /* Logitech lightspeed receiver (0xc53f) */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_2),
> +	 .driver_data =3D recvr_type_gaming_hidpp},
>  	{ /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_MX3000_RECEIVER),
>  	 .driver_data =3D recvr_type_27mhz},

Please don't merge this as it introduces a regression. I will send a new re=
vision.

Filipe La=C3=ADns
3DCE 51D6 0930 EBA4 7858 BA41 46F6 33CB B0EB 4BF2

--=-dRUS50kxUdxY1qNpVTUb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl1AJQoACgkQ+JPGdIFq
qV3x8Q//ekkTDb7koCBceey+dLahDlF6CWC7CGKzt2wbhp55PkmpX+9E/PXnY5eD
R8wh07Dwdmxk0rqG3t33Q/nZAt1HJRQ5UBP/cb0alWiVj3gWIteLsA4R0+tcMAko
NQJ90SMMOYpco823IwH2zwAGLtRaJUQB7scefAxMjZidYyCa8PBkaYi80QsY5Swc
V+0J4t9nknieMlKIZc70yzU34+r7I901Poi/GefnEHhAEGLQw93pGmq9EK64JcEV
pKISOpS7z2UgBOTkKl6Fq6dri+0adKAgSBPWj65cmx39iBhuBkaKekbRF7jVxq4l
SgzF/3oqkVAba7IQ4eONrUyXBnBzHkHXJDP6MkVhb0bQz+ar1/6iSIwaBLbi9SIO
arDIc1iTg0y9Wo/C1xRHfMzGpTbVAXWVVA/qJEAhVb87Q0gfpxcK8I3J6iVZ6ys4
qA6YaPp8oi/5XADDP7k3OsXn3rAKHj48XhGiU0vOO7bWzW0NpcgmjVRvFxLIWy1f
p8W5kxZAGjIatI3AkobmGN3BNqcMIoUx44jKcIZd6xfxC79weGYBuBHIOYLR9nnd
oMpoWulrDryL2g3I72ZliupieQcZ+mSY7qLH3TV842w6CTvuev5lFV90UiBvDS4X
zuymPsXHnV/QZI3ueKqPbEjsR7mSL5TNSH0AfjxpnnLpqYagPdY=
=dDRO
-----END PGP SIGNATURE-----

--=-dRUS50kxUdxY1qNpVTUb--
