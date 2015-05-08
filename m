From: Sean Young <sean@mess.org>
Subject: [PATCH v2] HID: core: remove phidgets from ignore list
Date: Fri,  8 May 2015 10:29:58 +0100
Message-ID: <1431077398-3530-1-git-send-email-sean@mess.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gofer.mess.org ([80.229.237.210]:56123 "EHLO gofer.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbEHJaA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 May 2015 05:30:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Once there were kernel drivers for some of the phidgets devices, and for
those kernel drivers to work the hid system needed exceptions. Now the
kernel drivers are long gone in favour of the user-space drivers.

The user-space drivers support many more phidget devices and uses libusb.
The udev rules set up permissions so that the kernel hid driver can be
unbound from libusb, as it does for many devices not in hid_ignore_list.

http://www.phidgets.com/docs/OS_-_Linux

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/hid/hid-core.c | 11 -----------
 drivers/hid/hid-ids.h  | 13 -------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1855b65..0731d96 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2245,14 +2245,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0001) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0002) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_0_4_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_16_16_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_8_8_8_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_7_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_8_IF_KIT) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_PHIDGET_MOTORCONTROL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_SUPER_Q2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_GOGOPEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOTOP, USB_DEVICE_ID_PENPOWER) },
@@ -2384,9 +2376,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_CYCLOPS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LCSPEC) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RISO_KAGAKU, USB_DEVICE_ID_RI_KA_WEBMAIL) },
 	{ }
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9c47867..f078ac8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -362,16 +362,6 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
-#define USB_VENDOR_ID_GLAB		0x06c2
-#define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
-#define USB_DEVICE_ID_1_PHIDGETSERVO_30	0x0039
-#define USB_DEVICE_ID_0_0_4_IF_KIT	0x0040
-#define USB_DEVICE_ID_0_16_16_IF_KIT	0x0044
-#define USB_DEVICE_ID_8_8_8_IF_KIT	0x0045
-#define USB_DEVICE_ID_0_8_7_IF_KIT	0x0051
-#define USB_DEVICE_ID_0_8_8_IF_KIT	0x0053
-#define USB_DEVICE_ID_PHIDGET_MOTORCONTROL	0x0058
-
 #define USB_VENDOR_ID_GOODTOUCH		0x1aad
 #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
 
@@ -973,9 +963,6 @@
 
 #define USB_VENDOR_ID_WISEGROUP		0x0925
 #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
-#define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
-#define USB_DEVICE_ID_4_PHIDGETSERVO_20	0x8104
-#define USB_DEVICE_ID_8_8_4_IF_KIT	0x8201
 #define USB_DEVICE_ID_SUPER_JOY_BOX_3	0x8888
 #define USB_DEVICE_ID_QUAD_USB_JOYPAD	0x8800
 #define USB_DEVICE_ID_DUAL_USB_JOYPAD	0x8866
-- 
2.1.0

