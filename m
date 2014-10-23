From: Jarrad Whitaker <jarrad.whitaker@gmail.com>
Subject: Microsoft Surface Pro 3 Type Cover keyboard
Date: Fri, 24 Oct 2014 02:57:13 +1100
Message-ID: <54492559.8000205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060601010904040801080608"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59486 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbaJWP5T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 11:57:19 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so1290557pad.25
        for <linux-input@vger.kernel.org>; Thu, 23 Oct 2014 08:57:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

This is a multi-part message in MIME format.
--------------060601010904040801080608
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The keyboard on the Surface Pro 3 type cover does not function without
some patching, similar to what was apparently required for the SP2
type/touch covers.

A working patch against 3.16 attached, it's an amalgamation of "some
dude posted this on the ubuntu/arch forums and it seems to work" so
I'm making no claims that it's kernel-quality! Just trying to give a
better indication of what needs to be added. My C is rudimentary and
my knowledge of the kernel limited to 'fakeroot debian/rules
updateconfigs', sorry. :)
Happy to test any improved version, but note I only have a type, not a
touch cover.

Patch source is
http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/, which
in turn sources a Russian site.

c.f. https://bugzilla.kernel.org/show_bug.cgi?id=86641

Jarrad
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSSVZAAoJED3oB8CFhvqeL2oP/3aaFFjCMaVKyJKB7Xi5DgLq
WuHLnKUVVVcriW+ZP6AoCdowNEDqlmtrW0Ytvr0wbPGNOutPpWrrNKn9/LDXblt/
26CLTM3M44hnyST3QbyfCNOhKKncPBMdqz0jwcsJnElSRWVjSmiQ4LoHcBkrnUTV
TwoURkA75TzRKqcy5v9FHHAezGXLmqiSym8/F9RBO2ELi2s8bRuL/a8BLo3HQjSS
HPCoCiZ0wlrTImT/w1DW1EpPNXkQ1EjhHZdnz9DrGlr0ha9LtstrFeM15TXWBLME
/hqn7wFehwuxIZccMg1ZiDidf2tMPNnvPOnng/PiJDa7pOlzSn9OAMggLm//yk4m
oyyvzr75onZa4m61Ay2Llhs+2NLAywke+04FXJ3YxQ4h+3AW+cMOIcdqzHbof2tI
TfwMfVlmVbgdIRnzYDVXGCh7odnd18Bt/xR/YSGJVpoMZMsMlav8QTNzVw8kkiIZ
35j2C/MBme3NPhXVsg7pgILgSQH0MdHqdC/aRMQQiqItVvobGgPpTf8KtGXwBbEy
7wEAlUkr4bgdsAkX1hNuFCtCPZ7fm2lJoxWm8sOUBkbp2gx+JaSmL4Qyv8CkWj+C
K2FNqlf4DFb6JyN21fENmou9lTfhUujC3/ECeOfRiip/6ol01VFebUDS6dQcM7PK
kQInY7SjFoCx0u8y4YMM
=CI1g
-----END PGP SIGNATURE-----

--------------060601010904040801080608
Content-Type: text/x-patch;
 name="s3typecover.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="s3typecover.patch"

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ed66fd..420810c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -702,6 +702,10 @@ static void hid_scan_collection(struct hid_parser *p=
arser, unsigned type)
 	if (((parser->global.usage_page << 16) =3D=3D HID_UP_SENSOR) &&
 	    type =3D=3D HID_COLLECTION_PHYSICAL)
 		hid->group =3D HID_GROUP_SENSOR_HUB;
+	if (hid->vendor =3D=3D USB_VENDOR_ID_MICROSOFT &&
+		hid->product =3D=3D USB_DEVICE_ID_MS_TYPE_COVER_3 &&
+		hid->group =3D=3D HID_GROUP_MULTITOUCH)
+	hid->group =3D HID_GROUP_GENERIC;
 }
=20
 static int hid_scan_main(struct hid_parser *parser, struct hid_item *ite=
m)
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 48b66bb..cd0ca8d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -638,6 +638,7 @@
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
+#define USB_DEVICE_ID_MS_TYPE_COVER_3   0x07dc
=20
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 8ba17a9..d878567 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -274,7 +274,8 @@ static const struct hid_device_id ms_devices[] =3D {
 		.driver_data =3D MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUS=
E_4500),
 		.driver_data =3D MS_DUPLICATE_USAGES },
-
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3=
),
+		.driver_data =3D MS_HIDINPUT },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESEN=
TER_8K_BT),
 		.driver_data =3D MS_PRESENTER },
 	{ }
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-qui=
rks.c
index 31e6727..18cd2c6 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -74,6 +74,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_N=
O_INIT_REPORTS },
 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGE=
T },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_=
INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GX680R_LED_PANEL, HID_QUIRK_NO_I=
NIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIR=
K_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT=
_REPORTS },
--------------060601010904040801080608
Content-Type: application/pgp-signature;
 name="s3typecover.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="s3typecover.patch.sig"

iQIcBAABAgAGBQJUSSVZAAoJED3oB8CFhvqe/cIP/i8ZbkEgj0DxzYb+0ZAAPQCwhuyw+Fz4
jnyXBNDb1GCWP4jyjWYHSHLvpfiPnaxEJSM9TI7xM2obSibsns+vyMT1cWSF5p1BiSqk23FF
bJkk7cdpMh2fv6yitPMNMEGhRKQY2JJG9jAOO0l+6YgYMivaxGgNMEHWOEvNyaJW6oq86Cyz
piSVh9lzSfXPl3xKKmhvDky9ODWibVpJ/jcwQ1Kop6qy9dEVb36Ph8Cy00oGffEmhsABjFR1
XP3JvApoiJ2oGdOauuDUbYef4Jqai8mnhPd5p3ttTI8y1+nPAQlovHLKXPRtcQhkeBcvMizP
ax179neREy8qvx1x9J8M7OR+RB+yQd4S/kk+/Z55/AvqRAg0ko9VxLnQ6jU73pb0zUUmntFA
XQ0PJYalu3AyIpFQRmcavPmgj1NGrUPPiG3dithQLBOYN461YoJ25TLl8kUps22TUvypdp4F
OqWhXkOMUKSJKwj8Bxz3MhClsphClrwPTlqRPsJZ/VCTy2Y1v+f2EOTwQs7tKe2v9q2ylg48
cl9hphdUs7DwVXKNKYCmk2sZKhAn1PDcLdyKXKlAdsqqiirv/QxG2lLkUFXKHrbTm3mE38e/
5yDcjXuCkSinxKw4XyOerb0z9+a3iNSYfUKAjNMJcdcvE4zsSQrjIvWzaoK4P4iRJjU4c9YS
HYCj
--------------060601010904040801080608--
