From: Darren Salt <devspam@moreofthesa.me.uk>
Subject: [PATCH] hid-saitek: add USB ID for older R.A.T. 7
Date: Thu, 29 Jan 2015 13:58:09 +0000
Message-ID: <5493074094%devspam@moreofthesa.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch is against 3.18.4, but should apply to 3.16.x and later.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>

diff -ur linux-3.18.orig/drivers/hid/hid-core.c linux-3.18/drivers/hid/hid-core.c
--- linux-3.18.orig/drivers/hid/hid-core.c	2015-01-29 12:01:23.620657746 +0000
+++ linux-3.18/drivers/hid/hid-core.c	2015-01-29 12:51:15.920015501 +0000
@@ -1909,6 +1909,7 @@
 #endif
 #if IS_ENABLED(CONFIG_HID_SAITEK)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
 #endif
diff -ur linux-3.18.orig/drivers/hid/hid-ids.h linux-3.18/drivers/hid/hid-ids.h
--- linux-3.18.orig/drivers/hid/hid-ids.h	2015-01-29 12:43:02.137146055 +0000
+++ linux-3.18/drivers/hid/hid-ids.h	2015-01-29 12:50:19.929617706 +0000
@@ -787,6 +787,7 @@
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
+#define USB_DEVICE_ID_SAITEK_RAT7_OLD	0x0ccb
 #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
 #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
 
diff -ur linux-3.18.orig/drivers/hid/hid-saitek.c linux-3.18/drivers/hid/hid-saitek.c
--- linux-3.18.orig/drivers/hid/hid-saitek.c	2014-10-05 20:23:04.000000000 +0100
+++ linux-3.18/drivers/hid/hid-saitek.c	2015-01-29 12:50:33.521228771 +0000
@@ -177,6 +177,8 @@
 static const struct hid_device_id saitek_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000),
 		.driver_data = SAITEK_FIX_PS1000 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD),
+		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7),

-- 
|  _  | Darren Salt, using Debian GNU/Linux (and Android)
| ( ) |
|  X  | ASCII Ribbon campaign against HTML e-mail
| / \ | http://www.asciiribbon.org/
