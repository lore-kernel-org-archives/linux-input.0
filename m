From: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
Subject: [PATCH] Add MacBookAir4,1 keyboard support
Date: Wed, 7 Sep 2011 16:15:52 -0400
Message-ID: <20110907201552.GA1962@Caligula>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57168 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1IGUQC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 16:16:02 -0400
Received: by vxj15 with SMTP id 15so31147vxj.19
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2011 13:16:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch adds support for the Apple MacBookAir4,1 released in July 
2011. It was inspired by Joshua Dillon's patch for the MacBookAir4,2
posted on http://www.almostsure.com/mba42/hid-apple-dkms.patch.

Signed-off-by: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
diff -uNr linux/drivers/hid/hid-apple.c patched/drivers/hid/hid-apple.c
--- linux/drivers/hid/hid-apple.c	2011-09-06 23:41:58.000000000 -0400
+++ patched/drivers/hid/hid-apple.c	2011-09-06 23:53:05.000000000 -0400
@@ -183,6 +183,9 @@
 		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
+		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI &&
+				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS)
+			table = macbookair_fn_keys;
 		else if (hid->product < 0x21d || hid->product >= 0x300)
 			table = powerbook_fn_keys;
 		else
@@ -493,6 +499,12 @@
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS),
 		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS),
+		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
diff -uNr linux/drivers/hid/hid-core.c patched/drivers/hid/hid-core.c
--- linux/drivers/hid/hid-core.c	2011-09-06 23:41:58.000000000 -0400
+++ patched/drivers/hid/hid-core.c	2011-09-06 23:56:22.000000000 -0400
@@ -1340,6 +1340,9 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_JIS) },
@@ -1892,6 +1895,9 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ }
diff -uNr linux/drivers/hid/hid-ids.h patched/drivers/hid/hid-ids.h
--- linux/drivers/hid/hid-ids.h	2011-09-06 23:41:58.000000000 -0400
+++ patched/drivers/hid/hid-ids.h	2011-09-06 23:57:39.000000000 -0400
@@ -109,6 +109,9 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI	0x0245
 #define USB_DEVICE_ID_APPLE_WELLSPRING5_ISO	0x0246
 #define USB_DEVICE_ID_APPLE_WELLSPRING5_JIS	0x0247
+#define USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI	0x0249
+#define USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO	0x024a
+#define USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS	0x024b
 #define USB_DEVICE_ID_APPLE_ALU_REVB_ANSI	0x024f
 #define USB_DEVICE_ID_APPLE_ALU_REVB_ISO	0x0250
 #define USB_DEVICE_ID_APPLE_ALU_REVB_JIS	0x0251
