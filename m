From: Ryan Bourgeois <bluedragonx@gmail.com>
Subject: [PATCH] MacBook Pro Retina Keyboard Support
Date: Sun, 8 Jul 2012 21:36:33 -0500
Message-ID: <CAMUYeoea-v0+kYvdMjLzdjV3d8BDu3ygNVt5hrw4p+x118X11w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54201 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab2GICgf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jul 2012 22:36:35 -0400
Received: by wibhr14 with SMTP id hr14so2866070wib.1
        for <linux-input@vger.kernel.org>; Sun, 08 Jul 2012 19:36:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org

This is a patch to enable full keyboard support for the MacBook Pro
Retina. It enables the function key shortcuts present in previous
MacBook iterations. The patch is against 3.5-r6.


diff -urNp a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
--- a/drivers/hid/hid-apple.c	2012-07-08 00:32:24.923451001 -0500
+++ b/drivers/hid/hid-apple.c	2012-07-08 00:35:16.763450998 -0500
@@ -517,6 +517,12 @@ static const struct hid_device_id apple_
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ISO),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS),
+		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
diff -urNp a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2012-07-08 00:32:24.927451001 -0500
+++ b/drivers/hid/hid-core.c	2012-07-08 00:38:08.946451088 -0500
@@ -1503,6 +1503,9 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING7_JIS) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
diff -urNp a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2012-07-08 00:32:24.926451001 -0500
+++ b/drivers/hid/hid-ids.h	2012-07-08 00:34:31.641450978 -0500
@@ -125,6 +125,9 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI	0x024c
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ISO	0x024d
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_JIS	0x024e
+#define USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI	0x0262
+#define USB_DEVICE_ID_APPLE_WELLSPRING7_ISO	0x0263
+#define USB_DEVICE_ID_APPLE_WELLSPRING7_JIS	0x0264
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI  0x0239
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO   0x023a
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS   0x023b


Signed-off-by: Ryan Bourgeois <bluedragonx@gmail.com>
