From: Rosie Hall <roswest@cisco.com>
Subject: Re: USB vulnerabilities
Date: Fri, 29 Jul 2016 20:48:01 -0400
Message-ID: <2fd29934-03ac-b67c-a644-07aebbfe8aff@cisco.com>
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
 <20160728174848.GA16852@dtor-ws>
 <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SHWuMRUXSuTSEHtm2JMI2cCvmWIHGJD8l"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:50586 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbcG3Arb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jul 2016 20:47:31 -0400
In-Reply-To: <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>, abagde1@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SHWuMRUXSuTSEHtm2JMI2cCvmWIHGJD8l
Content-Type: multipart/mixed; boundary="d0f6p8aAmHkBUB5FdFrnKoJdTgFn52xTh"
From: Rosie Hall <roswest@cisco.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>,
 abagde1@gmail.com
Message-ID: <2fd29934-03ac-b67c-a644-07aebbfe8aff@cisco.com>
Subject: Re: USB vulnerabilities
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
 <20160728174848.GA16852@dtor-ws>
 <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
In-Reply-To: <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>

--d0f6p8aAmHkBUB5FdFrnKoJdTgFn52xTh
Content-Type: multipart/mixed;
 boundary="------------5405C1D589DA1E066805A306"

This is a multi-part message in MIME format.
--------------5405C1D589DA1E066805A306
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dmitry,

Attached are the patches Anirudh created.  Also, I have added him to the
thread if you have any questions or comments for him.

Rosie

On Thu Jul 28 2016 16:58:27 GMT-0400 (EDT), roswest wrote:
> Dmitry,
>=20
> Tomorrow is his last day, but he is going to try to accomplish that.
>=20
> Rosie
>=20
> On Thu Jul 28 2016 13:48:48 GMT-0400 (EDT), Dmitry Torokhov wrote:
>> Hi Rosie,
>>
>> On Thu, Jul 28, 2016 at 12:23:09PM -0400, roswest wrote:
>>>
>>> Dmitry,
>>>
>>> Hi, I am an engineer at Cisco Systems, and this summer we tasked some=

>>> interns with performing USB fuzzing. One of the interns, Anirudh Bagd=
e,
>>> was able to crash the USB stack due to an error in the iforce module =
and
>>> discovered a buffer over-read in the usbtouchscreen module.  Please s=
ee
>>> the attachment for details.
>>
>> Thank you for the report. Any chance Anirudh could provide patches to
>> fix these issues as well?
>>
>> Thanks!
>>
>=20

--------------5405C1D589DA1E066805A306
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="iforce-usb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="iforce-usb.patch"

--- a/drivers/input/joystick/iforce/iforce-usb.c	2016-07-29 15:02:47.6026=
30504 -0400
+++ b/drivers/input/joystick/iforce/iforce-usb.c	2016-07-29 15:02:32.9468=
12336 -0400
@@ -135,12 +135,23 @@
 {
 	struct usb_device *dev =3D interface_to_usbdev(intf);
 	struct usb_host_interface *interface;
-	struct usb_endpoint_descriptor *epirq, *epout;
+	struct usb_endpoint_descriptor *epirq =3D NULL, *epout =3D NULL;
 	struct iforce *iforce;
-	int err =3D -ENOMEM;
+	int i, err =3D -ENOMEM;
=20
 	interface =3D intf->cur_altsetting;
=20
+	for (i =3D 0; i < interface->desc.bNumEndpoints; i++) {
+		if (!epirq &&
+		    usb_endpoint_dir_in(&interface->endpoint[i].desc))
+			epirq =3D &interface->endpoint[i].desc;
+		if (!epout &&
+		    usb_endpoint_dir_out(&interface->endpoint[i].desc))
+			epout =3D &interface->endpoint[i].desc;
+	}
+	if (!epirq || !epout)
+		return -ENODEV;
+
 	epirq =3D &interface->endpoint[0].desc;
 	epout =3D &interface->endpoint[1].desc;
=20

--------------5405C1D589DA1E066805A306
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="usbtouchscreen.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="usbtouchscreen.patch"

--- a/drivers/input/touchscreen/usbtouchscreen.c	2016-07-29 17:33:31.4304=
29835 -0400
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2016-07-29 17:31:57.7955=
91496 -0400
@@ -85,7 +85,8 @@
 	 */
 	bool irq_always;
=20
-	void (*process_pkt) (struct usbtouch_usb *usbtouch, unsigned char *pkt,=
 int len);
+	void (*process_pkt) (struct usbtouch_usb *usbtouch, unsigned char *pkt,=

+			     unsigned int len);
=20
 	/*
 	 * used to get the packet len. possible return values:
@@ -95,7 +96,8 @@
 	 */
 	int  (*get_pkt_len) (unsigned char *pkt, int len);
=20
-	int  (*read_data)   (struct usbtouch_usb *usbtouch, unsigned char *pkt)=
;
+	int  (*read_data)   (struct usbtouch_usb *usbtouch, unsigned char *pkt,=

+			     unsigned int len);
 	int  (*alloc)       (struct usbtouch_usb *usbtouch);
 	int  (*init)        (struct usbtouch_usb *usbtouch);
 	void (*exit)	    (struct usbtouch_usb *usbtouch);
@@ -275,7 +277,8 @@
 	return ret;
 }
=20
-static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt,
+			 unsigned int len)
 {
 	int tmp =3D (pkt[0] << 8) | pkt[1];
 	dev->x  =3D (pkt[2] << 8) | pkt[3];
@@ -343,7 +346,8 @@
 	return ret;
 }
=20
-static int egalax_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
)
+static int egalax_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
,
+			    unsigned int len)
 {
 	if ((pkt[0] & EGALAX_PKT_TYPE_MASK) !=3D EGALAX_PKT_TYPE_REPT)
 		return 0;
@@ -387,7 +391,8 @@
 #define ETOUCH_PKT_TYPE_REPT2		0xB0
 #define ETOUCH_PKT_TYPE_DIAG		0x0A
=20
-static int etouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
)
+static int etouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
,
+			    unsigned int len)
 {
 	if ((pkt[0] & ETOUCH_PKT_TYPE_MASK) !=3D ETOUCH_PKT_TYPE_REPT &&
 		(pkt[0] & ETOUCH_PKT_TYPE_MASK) !=3D ETOUCH_PKT_TYPE_REPT2)
@@ -422,7 +427,8 @@
  * PanJit Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_PANJIT
-static int panjit_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
)
+static int panjit_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
,
+			    unsigned int len)
 {
 	dev->x =3D ((pkt[2] & 0x0F) << 8) | pkt[1];
 	dev->y =3D ((pkt[4] & 0x0F) << 8) | pkt[3];
@@ -442,7 +448,8 @@
 #define MTOUCHUSB_RESET                 7
 #define MTOUCHUSB_REQ_CTRLLR_ID         10
=20
-static int mtouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
)
+static int mtouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
,
+			    unsigned int len)
 {
 	if (hwcalib_xy) {
 		dev->x =3D (pkt[4] << 8) | pkt[3];
@@ -501,7 +508,8 @@
  * ITM Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_ITM
-static int itm_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+static int itm_read_data(struct usbtouch_usb *dev, unsigned char *pkt,
+			 unsigned int len)
 {
 	int touch;
 	/*
@@ -538,7 +546,8 @@
 #ifndef MULTI_PACKET
 #define MULTI_PACKET
 #endif
-static int eturbo_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
)
+static int eturbo_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
,
+			    unsigned int len)
 {
 	unsigned int shift;
=20
@@ -569,7 +578,8 @@
  * Gunze part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_GUNZE
-static int gunze_read_data(struct usbtouch_usb *dev, unsigned char *pkt)=

+static int gunze_read_data(struct usbtouch_usb *dev, unsigned char *pkt,=

+			   unsigned int len)
 {
 	if (!(pkt[0] & 0x80) || ((pkt[1] | pkt[2] | pkt[3]) & 0x80))
 		return 0;
@@ -655,7 +665,8 @@
 }
=20
=20
-static int dmc_tsc10_read_data(struct usbtouch_usb *dev, unsigned char *=
pkt)
+static int dmc_tsc10_read_data(struct usbtouch_usb *dev, unsigned char *=
pkt,
+			       unsigned int len)
 {
 	dev->x =3D ((pkt[2] & 0x03) << 8) | pkt[1];
 	dev->y =3D ((pkt[4] & 0x03) << 8) | pkt[3];
@@ -670,7 +681,8 @@
  * IRTOUCH Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_IRTOUCH
-static int irtouch_read_data(struct usbtouch_usb *dev, unsigned char *pk=
t)
+static int irtouch_read_data(struct usbtouch_usb *dev, unsigned char *pk=
t,
+			     unsigned int len)
 {
 	dev->x =3D (pkt[3] << 8) | pkt[2];
 	dev->y =3D (pkt[5] << 8) | pkt[4];
@@ -684,7 +696,8 @@
  * ET&T TC5UH/TC4UM part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_ETT_TC45USB
-static int tc45usb_read_data(struct usbtouch_usb *dev, unsigned char *pk=
t)
+static int tc45usb_read_data(struct usbtouch_usb *dev, unsigned char *pk=
t,
+			     unsigned int len)
 {
 	dev->x =3D ((pkt[2] & 0x0F) << 8) | pkt[1];
 	dev->y =3D ((pkt[4] & 0x0F) << 8) | pkt[3];
@@ -710,7 +723,8 @@
 	return 0;
 }
=20
-static int idealtek_read_data(struct usbtouch_usb *dev, unsigned char *p=
kt)
+static int idealtek_read_data(struct usbtouch_usb *dev, unsigned char *p=
kt,
+			      unsigned int len)
 {
 	switch (pkt[0] & 0x98) {
 	case 0x88:
@@ -737,7 +751,8 @@
  * General Touch Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH
-static int general_touch_read_data(struct usbtouch_usb *dev, unsigned ch=
ar *pkt)
+static int general_touch_read_data(struct usbtouch_usb *dev, unsigned ch=
ar *pkt,
+				   unsigned int len)
 {
 	dev->x =3D (pkt[2] << 8) | pkt[1];
 	dev->y =3D (pkt[4] << 8) | pkt[3];
@@ -752,7 +767,8 @@
  * GoTop Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_GOTOP
-static int gotop_read_data(struct usbtouch_usb *dev, unsigned char *pkt)=

+static int gotop_read_data(struct usbtouch_usb *dev, unsigned char *pkt,=

+			   unsigned int len)
 {
 	dev->x =3D ((pkt[1] & 0x38) << 4) | pkt[2];
 	dev->y =3D ((pkt[1] & 0x07) << 7) | pkt[3];
@@ -766,7 +782,8 @@
  * JASTEC Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_JASTEC
-static int jastec_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
)
+static int jastec_read_data(struct usbtouch_usb *dev, unsigned char *pkt=
,
+			    unsigned int len)
 {
 	dev->x =3D ((pkt[0] & 0x3f) << 6) | (pkt[2] & 0x3f);
 	dev->y =3D ((pkt[1] & 0x3f) << 6) | (pkt[3] & 0x3f);
@@ -780,7 +797,8 @@
  * Zytronic Part
  */
 #ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
-static int zytronic_read_data(struct usbtouch_usb *dev, unsigned char *p=
kt)
+static int zytronic_read_data(struct usbtouch_usb *dev, unsigned char *p=
kt,
+			      unsigned int len)
 {
 	struct usb_interface *intf =3D dev->interface;
=20
@@ -964,7 +982,8 @@
 	kfree(priv);
 }
=20
-static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char =
*pkt)
+static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char =
*pkt,
+			   unsigned int len)
 {
 	struct nexio_touch_packet *packet =3D (void *) pkt;
 	struct nexio_priv *priv =3D usbtouch->priv;
@@ -977,6 +996,11 @@
 	if ((pkt[0] & 0xe0) !=3D 0xe0)
 		return 0;
=20
+	if (data_len > len)
+		data_len =3D len;
+	if (x_len + y_len > data_len)
+		return 0;
+
 	if (data_len > 0xff)
 		data_len -=3D 0x100;
 	if (x_len > 0xff)
@@ -1055,7 +1079,8 @@
=20
 #ifdef CONFIG_TOUCHSCREEN_USB_ELO
=20
-static int elo_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+static int elo_read_data(struct usbtouch_usb *dev, unsigned char *pkt,
+			 unsigned int len)
 {
 	dev->x =3D (pkt[3] << 8) | pkt[2];
 	dev->y =3D (pkt[5] << 8) | pkt[4];
@@ -1072,7 +1097,7 @@
  */
 #ifdef MULTI_PACKET
 static void usbtouch_process_multi(struct usbtouch_usb *usbtouch,
-				   unsigned char *pkt, int len);
+				   unsigned char *pkt, unsigned int len);
 #endif
=20
 static struct usbtouch_device_info usbtouch_dev_info[] =3D {
@@ -1303,11 +1328,11 @@
  * Generic Part
  */
 static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
-                                 unsigned char *pkt, int len)
+                                 unsigned char *pkt, unsigned int len)
 {
 	struct usbtouch_device_info *type =3D usbtouch->type;
=20
-	if (!type->read_data(usbtouch, pkt))
+	if (!type->read_data(usbtouch, pkt, len))
 			return;
=20
 	input_report_key(usbtouch->input, BTN_TOUCH, usbtouch->touch);
@@ -1327,7 +1352,7 @@
=20
 #ifdef MULTI_PACKET
 static void usbtouch_process_multi(struct usbtouch_usb *usbtouch,
-                                   unsigned char *pkt, int len)
+                                   unsigned char *pkt, unsigned int len)=

 {
 	unsigned char *buffer;
 	int pkt_len, pos, buf_len, tmp;

--------------5405C1D589DA1E066805A306--

--d0f6p8aAmHkBUB5FdFrnKoJdTgFn52xTh--

--SHWuMRUXSuTSEHtm2JMI2cCvmWIHGJD8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAleb+UUACgkQBAXm4T8ynGsr9gCgw+Yzt3iPKIBTS6XkCri3X2DZ
2EcAoJWXvFDcE0gw4vcWlXQoHJ3bBQFR
=9pVo
-----END PGP SIGNATURE-----

--SHWuMRUXSuTSEHtm2JMI2cCvmWIHGJD8l--
