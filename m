From: Diego 'Flameeyes' =?utf-8?q?Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH] Disable numlock emulation for Apple Aluminium keyboards
Date: Thu, 1 May 2008 23:30:16 +0200
Message-ID: <200805012330.18152@enterprise.flameeyes.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3137338.jJIHHRD64E";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:13860 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334AbYEAVaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 May 2008 17:30:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so687977fgg.17
        for <linux-input@vger.kernel.org>; Thu, 01 May 2008 14:30:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--nextPart3137338.jJIHHRD64E
Content-Type: multipart/mixed;
  boundary="Boundary-01=_qZjGISA9AGqVgAO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_qZjGISA9AGqVgAO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This is the patch to fix bug #10584=20
(http://bugzilla.kernel.org/show_bug.cgi?id=3D10584).

HTH,
=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--Boundary-01=_qZjGISA9AGqVgAO
Content-Type: text/x-diff;
  charset="utf-8";
  name="apple-aluminium-keyboard-no-numlock.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="apple-aluminium-keyboard-no-numlock.patch"

Don't enable numlock emulation on all Apple keyboards, do so only for

=46rom: Diego 'Flameeyes' Petten=C3=B2 <flameeyes@gmail.com>

Laptop keyboards.

Signed-off-by: Diego 'Flameeyes' Petten=C3=B2 <flameeyes@gmail.com>
=2D--

 drivers/hid/hid-input.c         |    5 +++--
 drivers/hid/usbhid/hid-quirks.c |   32 ++++++++++++++++----------------
 include/linux/hid.h             |    1 +
 3 files changed, 20 insertions(+), 18 deletions(-)


diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c3eb3f1..452b94d 100644
=2D-- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -218,8 +218,9 @@ int hidinput_apple_event(struct hid_device *hid, struct=
 input_dev *input,
 			}
 		}
=20
=2D		if (test_bit(usage->code, hid->pb_pressed_numlock) ||
=2D				test_bit(LED_NUML, input->led)) {
+		if (hid->quirks & HID_QUIRK_APPLE_NUMLOCK_EMULATION && (
+				test_bit(usage->code, hid->pb_pressed_numlock) ||
+				test_bit(LED_NUML, input->led))) {
 			trans =3D find_translation(powerbook_numlock_keys, usage->code);
=20
 			if (trans) {
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirk=
s.c
index d3f8d91..6dc6a2c 100644
=2D-- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -611,28 +611,28 @@ static const struct hid_blacklist {
=20
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIR=
K_NOGET | HID_QUIRK_MULTI_INPUT },
=20
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_APP=
LE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_APPL=
E_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_APPLE=
_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_APPLE_=
HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_APPLE_=
HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_APPL=
E_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_APPLE=
_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_APPLE=
_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_APPL=
E_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APPLE=
_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APPLE=
_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_APPLE=
_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_APPLE_=
NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_APPLE_N=
UMLOCK_EMULATION | QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_APPLE_NU=
MLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUI=
RK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_APPLE_NU=
MLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_APPLE_=
NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_APPLE_N=
UMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QU=
IRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_APPLE_N=
UMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_APPLE_=
NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APPLE_N=
UMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QU=
IRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APPLE_N=
UMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI, HID_QUIRK_APPLE_HAS_=
=46N },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO, HID_QUIRK_APPLE_HAS_F=
N | HID_QUIRK_APPLE_ISO_KEYBOARD },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS, HID_QUIRK_APPLE_HAS_F=
N },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI, HID_QUIRK_A=
PPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO, HID_QUIRK_AP=
PLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS, HID_QUIRK_AP=
PLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO, HID_QUIRK_APPL=
E_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS, HID_QUIRK_APPL=
E_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI, HID_QUIRK_A=
PPLE_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO, HID_QUIRK_AP=
PLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS, HID_QUIRK_AP=
PLE_HAS_FN },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_=
APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=2D	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_A=
PPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
=20
 	{ USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_W7658, HID_QUIRK_RESET_LEDS },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KBD, HID_QUIRK_RESET_LED=
S },
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 4ce3b7a..6fc10d1 100644
=2D-- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -285,6 +285,7 @@ struct hid_item {
 #define HID_QUIRK_HWHEEL_WHEEL_INVERT		0x04000000
 #define HID_QUIRK_MICROSOFT_KEYS		0x08000000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
+#define HID_QUIRK_APPLE_NUMLOCK_EMULATION	0x20000000
=20
 /*
  * Separate quirks for runtime report descriptor fixup

--Boundary-01=_qZjGISA9AGqVgAO--

--nextPart3137338.jJIHHRD64E
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgaNmoACgkQe2h1+2mHVWP3/gCfVfcYYmq7HUOki5hT48JBHWv5
FtQAoN+amCrbcH1WyLSzz4nNCoBq+meT
=kQWR
-----END PGP SIGNATURE-----

--nextPart3137338.jJIHHRD64E--
