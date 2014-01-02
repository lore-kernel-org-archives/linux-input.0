From: Conan <conan@braincalibration.de>
Subject: [PATCH] HID: quirk for Saitek RAT7 and MMO7 mices' mode button
Date: Thu, 02 Jan 2014 20:56:56 +0100
Message-ID: <52C5C488.3080106@braincalibration.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.59.56.47.78.clients.your-server.de ([78.47.56.59]:50196
	"EHLO www.braincalibration.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136AbaABUSA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jan 2014 15:18:00 -0500
Received: from p5b397b55.dip0.t-ipconnect.de ([91.57.123.85] helo=[192.168.2.113])
	by www.braincalibration.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <conan@braincalibration.de>)
	id 1VyoLb-0003rY-7u
	for linux-input@vger.kernel.org; Thu, 02 Jan 2014 20:54:27 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

this patch adds support for some saitek mice which implement a tristate
button (for switching button mappings in the official windows driver) by
keeping one of three (non-physical) buttons constantly pressed. This
breaks X and probably other userspace software.

The patch below implements a quirk which instantly sends a release event
for the affected buttons.

Disclaimer: this is not entirely my own work, it is based on a patch for
the R.A.T.7. which was posted here:
http://us.generation-nt.com/answer/patch-2-6-38-mode-button-quirk-saitek-cyborg-t-7-help-202649672.html

I merely added two usb ids and kept it up to date.

- --- a/drivers/hid/hid-ids.h	2013-10-08 15:20:58.781792791 +0200
+++ b/drivers/hid/hid-ids.h	2013-10-08 15:22:17.815804729 +0200
@@ -714,6 +714,9 @@
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
+#define USB_DEVICE_ID_SAITEK_RAT7	0x0ccb
+#define USB_DEVICE_ID_SAITEK_RAT7TOO	0x0cd7
+#define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0

 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
- --- a/drivers/hid/hid-input.c	2013-01-31 19:09:35.058570485 +0100
+++ b/drivers/hid/hid-input.c	2013-01-31 19:11:57.779833199 +0100
@@ -1039,6 +1039,25 @@

 	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type == EV_KEY))
 		input_event(input, usage->type, usage->code, 0);
+
+	/* hack for Saitek RAT mice which report release events for their
+	 * mode button on the NEXT press event: instant release
+	*/
+	if ((*quirks & HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE) &&
+		value && usage->type == EV_KEY &&
+		/* RAT7 uses buttons 13,14,15 */
+		((usage->code >= BTN_MOUSE + 8 && usage->code <= BTN_MOUSE + 10) ||
+		/* MMO7 uses button 20 */
+		(usage->code == BTN_MOUSE + 15)) &&
+		test_bit(usage->code, input->key)) {
+		input_event(input, usage->type, usage->code, 0);
+		/* we'll get a real release event from the mouse anyway, and
+		 * userspace should cope with the extra input-layer
+		 * button-up events anyway; just re-set the bit to stop
+		 * spurious button-down events
+		 */
+		set_bit(usage->code, input->key);
+	}
 }

 void hidinput_report_event(struct hid_device *hid, struct hid_report
*report)
- --- a/drivers/hid/usbhid/hid-quirks.c	2013-01-31 19:09:35.058570485 +0100
+++ b/drivers/hid/usbhid/hid-quirks.c	2013-01-31 19:12:58.195232311 +0100
@@ -82,6 +82,9 @@
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001,
HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008,
HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER,
HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7,
HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE },
+	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7TOO,
HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE },
+	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7,
HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE },
 	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB,
HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780,
HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
- --- a/include/linux/hid.h	2013-05-18 03:16:26.713052127 +0200
+++ b/include/linux/hid.h	2013-05-18 03:17:23.407343351 +0200
@@ -283,6 +283,7 @@
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
+#define HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE	0x00000200
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000

- -- 
Regards,
C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSxcSIAAoJECsSvCKD1CYc5LQH/ROXMVqulZsP1D4RTY8pL14k
D4udVjVfd60PlmqYmzSfijcD1nISUEldSSdOy1lf/DJUHvvfK/Ybjl1fAeqebqdi
pZZQM+2V2czdcdEB7ldT4stSig4MfHGdh/t5EGFdhIre0fXuXBV+dm9q8tcJitpn
UtJqk2TzDXTOwx847Mwo4kiJ4JdgF/oLgfNOtxCClHySSrBHw/kbgCduoIn5ISx7
4JELsD7LpW+ohbOdg7XBzEZZ4XbBd4eCTr8FogJAlBQSvCiMGXO1geCCaRCzB5Xg
HmULc8/zv1bE9kYHvGhRIodL8x8+De/MktFEiNOSJUw729dsO/eyW38vLvi2brQ=
=g13R
-----END PGP SIGNATURE-----
