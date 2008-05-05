From: Diego 'Flameeyes' =?utf-8?q?Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH] Split Numlock emulation quirk from HID_QUIRK_APPLE_HAS_FN.
Date: Mon, 05 May 2008 16:20:50 +0200
Message-ID: <20080505142050.2145.20872.stgit@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.251]:53977 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbYEEOUz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 May 2008 10:20:55 -0400
Received: by hs-out-0708.google.com with SMTP id 4so565529hsl.5
        for <linux-input@vger.kernel.org>; Mon, 05 May 2008 07:20:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org

Since 2.6.25 the HID_QUIRK_APPLE_HAS_FN quirk is enabled even for
non-laptop Apple keyboards of the Aluminium series. The USB version of
these don't need Numlock emulation, like the laptop (and Aluminium
Wireless) do, as they have a proper keypad.

This patch splits the Numlock emulation for Apple keyboards in a
different quirk flag, so that it can be enabled for all the keyboards
but the Aluminium USB ones.

If the Numlock emulation is enabled for Aluminium USB keyboards, the
JKL and UIO keys become the numeric pad, and the rest of the keyboard
is disabled, included the key used to disable Numlock.

Additionally, these keyboard should not have a Numlock at all, as the
Numlock key is instead replaced by the 'Clear' key as usual for Apple
USB keyboards.

Aluminium Wireless (Bluetooth) keyboards don't have a keypad so they
still need the numlock emulation, although I'm not sure whether their
numlock key will work to disable it after enabling, as I don't have
hardware to test those.

Signed-off-by: Diego 'Flameeyes' Petten=C3=B2 <flameeyes@gmail.com>
---

 drivers/hid/hid-input.c         |    5 +++--
 drivers/hid/usbhid/hid-quirks.c |   38 +++++++++++++++++++------------=
-------
 include/linux/hid.h             |    1 +
 3 files changed, 23 insertions(+), 21 deletions(-)


diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c3eb3f1..452b94d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -218,8 +218,9 @@ int hidinput_apple_event(struct hid_device *hid, st=
ruct input_dev *input,
 			}
 		}
=20
-		if (test_bit(usage->code, hid->pb_pressed_numlock) ||
-				test_bit(LED_NUML, input->led)) {
+		if (hid->quirks & HID_QUIRK_APPLE_NUMLOCK_EMULATION && (
+				test_bit(usage->code, hid->pb_pressed_numlock) ||
+				test_bit(LED_NUML, input->led))) {
 			trans =3D find_translation(powerbook_numlock_keys, usage->code);
=20
 			if (trans) {
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-q=
uirks.c
index d3f8d91..a2fc8d4 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -611,28 +611,28 @@ static const struct hid_blacklist {
=20
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_=
QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
=20
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_A=
PPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_AP=
PLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_APP=
LE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_APPL=
E_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_APPL=
E_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_AP=
PLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_APP=
LE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_APP=
LE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_AP=
PLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APP=
LE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APP=
LE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_A=
PPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUS=
E },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE=
 },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_APPL=
E_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE |=
 HID_QUIRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_APPL=
E_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE }=
,
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE=
 },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
| HID_QUIRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_AP=
PLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE=
 },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
| HID_QUIRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APP=
LE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE =
},
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI, HID_QUIRK_APPLE_=
HAS_FN },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO, HID_QUIRK_APPLE_H=
AS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS, HID_QUIRK_APPLE_H=
AS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI, HID_QUIRK=
_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO, HID_QUIRK_=
APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS, HID_QUIRK_=
APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI, HID_QUI=
RK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO, HID_QUIR=
K_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS, HID_QUIR=
K_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIR=
K_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK=
_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI, HID_QUIRK=
_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MO=
USE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO, HID_QUIRK_=
APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOU=
SE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS, HID_QUIRK_=
APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOU=
SE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI, HID_QUI=
RK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO, HID_QUIR=
K_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_IS=
O_KEYBOARD },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS, HID_QUIR=
K_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIR=
K_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_M=
OUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK=
_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MO=
USE },
=20
 	{ USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_W7658, HID_QUIRK_RESET_LEDS =
},
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KBD, HID_QUIRK_RESET=
_LEDS },
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 4ce3b7a..6fc10d1 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -285,6 +285,7 @@ struct hid_item {
 #define HID_QUIRK_HWHEEL_WHEEL_INVERT		0x04000000
 #define HID_QUIRK_MICROSOFT_KEYS		0x08000000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
+#define HID_QUIRK_APPLE_NUMLOCK_EMULATION	0x20000000
=20
 /*
  * Separate quirks for runtime report descriptor fixup


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
