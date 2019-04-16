From: Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH] xpad.c: Send necessary control transfer to certain Xbox
 controllers
Date: Tue, 16 Apr 2019 19:31:28 -0400
Message-ID: <d3a51004-8242-1983-03a3-1b7848546d7d@canonical.com>
References: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8uHkYsIYol5J88yK6ryzxH1EmTQES0bvJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: ramzeto@gmail.com, marcus.folkesson@gmail.com, flibitijibibo@gmail.com, aicommander@gmail.com, leosperling97@gmail.com, gottox@voidlinux.eu, frtherien@gmail.com, linux-kernel@vger.kernel.org, Mike Salvatore <mike.salvatore@canonical.com>, mike.s.salvatore@gmail.com
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8uHkYsIYol5J88yK6ryzxH1EmTQES0bvJ
Content-Type: multipart/mixed; boundary="ofXCy1rdBMWpxCcNJAZ41qZUjLLLyvSu0";
 protected-headers="v1"
From: Mike Salvatore <mike.salvatore@canonical.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: ramzeto@gmail.com, marcus.folkesson@gmail.com, flibitijibibo@gmail.com,
 aicommander@gmail.com, leosperling97@gmail.com, gottox@voidlinux.eu,
 frtherien@gmail.com, linux-kernel@vger.kernel.org,
 Mike Salvatore <mike.salvatore@canonical.com>, mike.s.salvatore@gmail.com
Message-ID: <d3a51004-8242-1983-03a3-1b7848546d7d@canonical.com>
Subject: Re: [PATCH] xpad.c: Send necessary control transfer to certain Xbox
 controllers
References: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
In-Reply-To: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>

--ofXCy1rdBMWpxCcNJAZ41qZUjLLLyvSu0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

All,

I took another look at this patch and realized it was missing a #include.=

I've added the appropriate #include to a new version of the patch.

Thanks,
Mike Salvatore



=46rom 6fbf80fa3d5bc39fa054350a663080e1380046f8 Mon Sep 17 00:00:00 2001
From: Mike Salvatore <mike.salvatore@canonical.com>
Date: Wed, 13 Mar 2019 22:11:37 -0400
Subject: [PATCH] Input: xpad - send control init message to certain Xbox
 controllers

The Xbox controller with idVendor =3D=3D 0x045e and idProduct =3D=3D 0x02=
8e
requires that a specific control transfer be sent from the host to the
device before the device will send data to the host.

This patch introduces an xboxone_control_packet struct and a mechanism
for sending control packets to devices that require them at
initialization.

Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
---
 drivers/input/joystick/xpad.c | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.=
c
index cfc8b94527b9..756df325bfa6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -81,6 +81,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/usb/ch9.h>
 #include <linux/usb/input.h>
 #include <linux/usb/quirks.h>
=20
@@ -460,6 +461,25 @@ struct xboxone_init_packet {
 		.len		=3D ARRAY_SIZE(_data),	\
 	}
=20
+struct xboxone_control_packet {
+	u16 idVendor;
+	u16 idProduct;
+	struct usb_ctrlrequest ctrlrequest;
+};
+
+#define XBOXONE_CONTROL_PKT(_vid, _pid, _reqtype, _req, _value, _index, =
_len)  \
+	{						\
+		.idVendor	=3D (_vid),		\
+		.idProduct	=3D (_pid),		\
+		.ctrlrequest    =3D {			\
+			.bRequestType	=3D (_reqtype),	\
+			.bRequest	=3D (_req),	\
+			.wValue		=3D (_value),	\
+			.wIndex		=3D (_index),	\
+			.wLength	=3D (_len),	\
+		},					\
+	}
+
=20
 /*
  * This packet is required for all Xbox One pads with 2015
@@ -537,6 +557,13 @@ static const struct xboxone_init_packet xboxone_init=
_packets[] =3D {
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumbleend_init),
 };
=20
+static const struct xboxone_control_packet xboxone_control_packets[] =3D=
 {
+	XBOXONE_CONTROL_PKT(0x045e, 0x028e,
+			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			USB_REQ_CLEAR_FEATURE,
+			USB_DEVICE_REMOTE_WAKEUP, 0, 0),
+};
+
 struct xpad_output_packet {
 	u8 data[XPAD_PKT_LEN];
 	u8 len;
@@ -1119,6 +1146,31 @@ static int xpad_init_output(struct usb_interface *=
intf, struct usb_xpad *xpad,
 	return error;
 }
=20
+static int xpad_init_control_msg(struct usb_xpad *xpad)
+{
+	struct usb_device *udev =3D xpad->udev;
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(xboxone_control_packets); i++) {
+		u16 idVendor =3D xboxone_control_packets[i].idVendor;
+		u16 idProduct =3D xboxone_control_packets[i].idProduct;
+
+		if (le16_to_cpu(udev->descriptor.idVendor) =3D=3D idVendor
+		    && le16_to_cpu(udev->descriptor.idProduct) =3D=3D idProduct) {
+			const struct usb_ctrlrequest *ctrlrequest =3D
+				&(xboxone_control_packets[i].ctrlrequest);
+
+			return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				ctrlrequest->bRequest,
+				ctrlrequest->bRequestType, ctrlrequest->wValue,
+				ctrlrequest->wIndex, NULL, ctrlrequest->wLength,
+				2 * HZ);
+		}
+	}
+
+	return 0;
+}
+
 static void xpad_stop_output(struct usb_xpad *xpad)
 {
 	if (xpad->xtype !=3D XTYPE_UNKNOWN) {
@@ -1839,6 +1891,11 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
 		if (error)
 			goto err_deinit_output;
 	}
+
+	error =3D xpad_init_control_msg(xpad);
+	if (error)
+		goto err_deinit_output;
+
 	return 0;
=20
 err_deinit_output:
--=20
2.17.1



On 3/23/19 12:46 PM, Mike Salvatore wrote:
> From 3051524e62d68b920019bcb50a713e736fcf4234 Mon Sep 17 00:00:00 2001
> From: Mike Salvatore <mike.salvatore@canonical.com>
> Date: Wed, 13 Mar 2019 22:11:37 -0400
> Subject: [PATCH] Input: xpad - send control init message to certain Xbo=
x
>  controllers
>=20
> The Xbox controller with idVendor =3D=3D 0x045e and idProduct =3D=3D 0x=
028e
> requires that a specific control transfer be sent from the host to the
> device before the device will send data to the host.
>=20
> This patch introduces an xboxone_control_packet struct and a mechanism
> for sending control packets to devices that require them at
> initialization.
>=20
> Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
> ---
>  drivers/input/joystick/xpad.c | 56 +++++++++++++++++++++++++++++++++++=

>  1 file changed, 56 insertions(+)
>=20
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
> index cfc8b94527b9..f45522b9ff1f 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -460,6 +460,25 @@ struct xboxone_init_packet {
>  		.len		=3D ARRAY_SIZE(_data),	\
>  	}
> =20
> +struct xboxone_control_packet {
> +	u16 idVendor;
> +	u16 idProduct;
> +	struct usb_ctrlrequest ctrlrequest;
> +};
> +
> +#define XBOXONE_CONTROL_PKT(_vid, _pid, _reqtype, _req, _value, _index=
, _len)  \
> +	{						\
> +		.idVendor	=3D (_vid),		\
> +		.idProduct	=3D (_pid),		\
> +		.ctrlrequest    =3D {			\
> +			.bRequestType	=3D (_reqtype),	\
> +			.bRequest	=3D (_req),	\
> +			.wValue		=3D (_value),	\
> +			.wIndex		=3D (_index),	\
> +			.wLength	=3D (_len),	\
> +		},					\
> +	}
> +
> =20
>  /*
>   * This packet is required for all Xbox One pads with 2015
> @@ -537,6 +556,13 @@ static const struct xboxone_init_packet xboxone_in=
it_packets[] =3D {
>  	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumbleend_init),
>  };
> =20
> +static const struct xboxone_control_packet xboxone_control_packets[] =3D=
 {
> +	XBOXONE_CONTROL_PKT(0x045e, 0x028e,
> +			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +			USB_REQ_CLEAR_FEATURE,
> +			USB_DEVICE_REMOTE_WAKEUP, 0, 0),
> +};
> +
>  struct xpad_output_packet {
>  	u8 data[XPAD_PKT_LEN];
>  	u8 len;
> @@ -1119,6 +1145,31 @@ static int xpad_init_output(struct usb_interface=
 *intf, struct usb_xpad *xpad,
>  	return error;
>  }
> =20
> +static int xpad_init_control_msg(struct usb_xpad *xpad)
> +{
> +	struct usb_device *udev =3D xpad->udev;
> +	size_t i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(xboxone_control_packets); i++) {
> +		u16 idVendor =3D xboxone_control_packets[i].idVendor;
> +		u16 idProduct =3D xboxone_control_packets[i].idProduct;
> +
> +		if (le16_to_cpu(udev->descriptor.idVendor) =3D=3D idVendor
> +		    && le16_to_cpu(udev->descriptor.idProduct) =3D=3D idProduct) {
> +			const struct usb_ctrlrequest *ctrlrequest =3D
> +				&(xboxone_control_packets[i].ctrlrequest);
> +
> +			return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> +				ctrlrequest->bRequest,
> +				ctrlrequest->bRequestType, ctrlrequest->wValue,
> +				ctrlrequest->wIndex, NULL, ctrlrequest->wLength,
> +				2 * HZ);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void xpad_stop_output(struct usb_xpad *xpad)
>  {
>  	if (xpad->xtype !=3D XTYPE_UNKNOWN) {
> @@ -1839,6 +1890,11 @@ static int xpad_probe(struct usb_interface *intf=
, const struct usb_device_id *id
>  		if (error)
>  			goto err_deinit_output;
>  	}
> +
> +	error =3D xpad_init_control_msg(xpad);
> +	if (error)
> +		goto err_deinit_output;
> +
>  	return 0;
> =20
>  err_deinit_output:
> -- 2.17.1


--ofXCy1rdBMWpxCcNJAZ41qZUjLLLyvSu0--

--8uHkYsIYol5J88yK6ryzxH1EmTQES0bvJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEwZbe96kJeWh2OITRdyg1Qz0oXX0FAly2ZdAACgkQdyg1Qz0o
XX24oQ/7BV3glS2hdqVnHzJb05CA0Mp6qHSdxakRAePkIkhjuwU5KaNCwcwDUyEx
Haj6AG+BpVQB67SQYs94AwN5bmtzSN1WszCiyYqmHzhOtem0MGevxy2Cu8Z6/Ezt
drmMOCVftwiFcmcKaxXCE+v5Sn7pbZ1U9anb15kG7FTirvzbLVZGa4i33N9XpkqV
CoyGuw6ZKpJf8akD223TxYkN2vgLP0OL+b/IYksYm/eHjebq7RvDX1vvhj+60N0m
kAkRjq33sORcE04DqHKE+a1ZFPDzOnl2DCe3kPlASPqeRe3iqEUojuIWpdQSxo2E
QbIGFdB+U3PI4gaQnBxQjxnODk5FaVc/s9cl7xWbmomXKuWke7RaPCUS4OL+Jzug
Lh3TbDKADW8ZkaH6Ni25w+DmCmOAxaZwPoyjNXyrug0qkBYiyFRArZPZfujNT3qB
7IrCPGaSxxhQBNcTb8uykc+wLlrW8XeJE4UN0WvpiejrJ4pNzEtXqLqjQKXsBKD8
/2/mQpl/vs6Grquhn8yRVntwABoDdhVpXlSYVrMxExiIOlaw+M8bKjTbK34ug/O1
QlBsDn9pqh5tZqA4Nepvs0yZQ1xzjTxvv6iuKugRxtda3pHLNO/huDDzlT5wbtO1
6NBBqqCo6hAbnKWF7IkwMu2WfOEJxxskdo0RdgWFYkNyV5kD7k4=
=26cY
-----END PGP SIGNATURE-----

--8uHkYsIYol5J88yK6ryzxH1EmTQES0bvJ--
