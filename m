From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] hid: wellspring device quirks
Date: Sun, 13 Jul 2008 17:34:36 +0200
Message-ID: <1215963466.12757.0.camel@alnilam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:34219 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754865AbYGMPhi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jul 2008 11:37:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org

From: Henrik Rydberg <rydberg@euromail.se>

This patch adds the HID_QUIRK_IGNORE_MOUSE quirk for the Apple USB
multitouch devices based on BCM5974, aka Wellspring. These devices
will instead be picked up by the new bcm5974 driver.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---

The bcm5974 driver is currently in Andrew Morton's mm tree:
input-bcm5974-055-smoother-motion-irq-simplification.patch

This patch is against the linux-next tree: v2.6.26-rc9-7639-g60392c2

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 61e78a4..b15f882 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -654,12 +654,12 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI, HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS, HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI, HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS, HID_QUIRK_APPLE_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD | HID_QUIRK_IGNORE_MOUSE},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS, HID_QUIRK_APPLE_HAS_FN  | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 

