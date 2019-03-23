From: Mike Salvatore <mike.salvatore@canonical.com>
Subject: [PATCH] xpad.c: Send necessary control transfer to certain Xbox
 controllers
Date: Sat, 23 Mar 2019 12:46:38 -0400
Message-ID: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: ramzeto@gmail.com, marcus.folkesson@gmail.com, flibitijibibo@gmail.com, aicommander@gmail.com, leosperling97@gmail.com, gottox@voidlinux.eu, frtherien@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl
Content-Type: multipart/mixed; boundary="06aaZUYQ70Bok69xtlnJ5I91mu9k25xx3";
 protected-headers="v1"
From: Mike Salvatore <mike.salvatore@canonical.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: ramzeto@gmail.com, marcus.folkesson@gmail.com, flibitijibibo@gmail.com,
 aicommander@gmail.com, leosperling97@gmail.com, gottox@voidlinux.eu,
 frtherien@gmail.com, linux-kernel@vger.kernel.org
Message-ID: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
Subject: [PATCH] xpad.c: Send necessary control transfer to certain Xbox
 controllers

--06aaZUYQ70Bok69xtlnJ5I91mu9k25xx3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I recently purchased an Xbox controller with USB ID 045e:028e. When I plu=
gged
the device in, it was recognized as a joystick but button presses were no=
t
recognized. Using evtest, I confirmed that the device was not sending any=

information to the host when I pressed its buttons.

After doing some research, I found that this particular device requires t=
hat the
host send a control transfer before the device will begin sending any dat=
a to
the host. Below is a patch that introduces a mechanism into xpad.c for se=
nding
control transfers to specific Xbox controllers at initialization.

After applying this patch to the xpad module, the Xbox controller is prop=
erly
initialized when plugged in and functions as expected. Other Xbox control=
lers
may also require control transfers at initialization, but I don't know wh=
ich (if
any).

Regards,
Mike Salvatore


=46rom 3051524e62d68b920019bcb50a713e736fcf4234 Mon Sep 17 00:00:00 2001
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
 drivers/input/joystick/xpad.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.=
c
index cfc8b94527b9..f45522b9ff1f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -460,6 +460,25 @@ struct xboxone_init_packet {
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
@@ -537,6 +556,13 @@ static const struct xboxone_init_packet xboxone_init=
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
@@ -1119,6 +1145,31 @@ static int xpad_init_output(struct usb_interface *=
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
@@ -1839,6 +1890,11 @@ static int xpad_probe(struct usb_interface *intf, =
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



--06aaZUYQ70Bok69xtlnJ5I91mu9k25xx3--

--rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEwZbe96kJeWh2OITRdyg1Qz0oXX0FAlyWYvUACgkQdyg1Qz0o
XX3mPw//UMR3Te0qEjP/PkyWowSYuM09YSgnsIN54mQ4/tkMH7I5tG9xSjYczZu7
CPGBbwHYm7CbrTq0mFGuPURzwAx7lYG9ImAPS8GZstwL6jJ+Xkptws+ZRtQwStYr
aAzh7X4u0s9YXKAYMKuIsiZmipAr9hUz5eUW6fImE0Gf5UZ5AhoaJXVmWoj+Es5r
ULQ2PlrouTtrL75DGAKgJsOZKlqOCPmWq6mCsLXG3ZzXEnlh0vQV6q+E24aMXEWl
fBUXp/Kvv+WiNIGiJqBWQVRxdLKaDjWQ3i/wVtch3r6mBWLl5uLc2+JsLJWVXbfU
Lt93e8CtFwv2cpOtHoTDUG2j+XXn58uKrX3UQ+ZlzyC/AUccjkU7Vf3QOOvK5mdS
XiIAIK+EWVcwLK3DOu4+X6H9lmcdgjexgV1qiwhfO9A/c/+VuuSbsiebOHfV0zS8
Hmxm7Cdm9VP01xyM+9rqnb5uRlDGiBvfiiBE6DVXmIp9ROk5XU7dBM5XqSZAYSc5
PUt1N2VqzL7LixYcs2UlMOr2ruE3JfLctHJ7QJPGsbQDzKngRaw7GWLPc6Q2PRza
kSnAUp3WwsJMUO6BgzqOOmuXICm+dFqd1OO/LWBgPH4UENvQ7Dov9/d86nJGt7vB
uasxrVBre5d7uKLNE5WAhd6WFBZVv1Yt98fgLZQdgBLKMUbehEU=
=9403
-----END PGP SIGNATURE-----

--rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl--
