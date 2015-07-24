From: Henrik Rydberg <rydberg@bitmath.org>
Subject: [PATCH 3/3] Input: bcm597 - Add support for the 2015 Macbook Pro
Date: Fri, 24 Jul 2015 19:34:20 +0200
Message-ID: <1437759260-7748-3-git-send-email-rydberg@bitmath.org>
References: <1437759260-7748-1-git-send-email-rydberg@bitmath.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay6.public.one.com ([91.198.169.200]:27407 "EHLO
	mailrelay6.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbbGXRew (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 13:34:52 -0400
In-Reply-To: <1437759260-7748-1-git-send-email-rydberg@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Horan <knasher@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

From: John Horan <knasher@gmail.com>

Add support for the MacBookPro12,1 model. This patch needs to be
applied together with the accompanied HID patch, as usual.

Tested-by: John Horan <knasher@gmail.com>
Tested-by: Jochen Radmacher <jradmacher@gmx.de>
Tested-by: Yang Hongyang <burnef@gmail.com>
Tested-by: Yen-Chin, Lee <coldnew.tw@gmail.com>
Tested-by: George Hilios <ghilios@gmail.com>
Tested-by: Janez Urevc <janez@janezurevc.name>
Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
---
 drivers/input/mouse/bcm5974.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index a596b9b..30e3442 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -2,6 +2,7 @@
  * Apple USB BCM5974 (Macbook Air and Penryn Macbook Pro) multitouch driver
  *
  * Copyright (C) 2008	   Henrik Rydberg (rydberg@euromail.se)
+ * Copyright (C) 2015      John Horan (knasher@gmail.com)
  *
  * The USB initialization and package decoding was made by
  * Scott Shawcroft as part of the touchd user-space driver project:
@@ -91,6 +92,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
+/* MacbookPro12,1 (2015) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI	0x0272
+#define USB_DEVICE_ID_APPLE_WELLSPRING9_ISO	0x0273
+#define USB_DEVICE_ID_APPLE_WELLSPRING9_JIS	0x0274
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -152,6 +157,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING8_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING8_JIS),
+	/* MacbookPro12,1 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING9_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING9_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -180,18 +189,21 @@ struct bt_data {
 enum tp_type {
 	TYPE1,			/* plain trackpad */
 	TYPE2,			/* button integrated in trackpad */
-	TYPE3			/* additional header fields since June 2013 */
+	TYPE3,			/* additional header fields since June 2013 */
+	TYPE4			/* additional header field for pressure data */
 };
 
 /* trackpad finger data offsets, le16-aligned */
 #define HEADER_TYPE1		(13 * sizeof(__le16))
 #define HEADER_TYPE2		(15 * sizeof(__le16))
 #define HEADER_TYPE3		(19 * sizeof(__le16))
+#define HEADER_TYPE4		(23 * sizeof(__le16))
 
 /* trackpad button data offsets */
 #define BUTTON_TYPE1		0
 #define BUTTON_TYPE2		15
 #define BUTTON_TYPE3		23
+#define BUTTON_TYPE4		31
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
@@ -200,16 +212,19 @@ enum tp_type {
 #define FSIZE_TYPE1		(14 * sizeof(__le16))
 #define FSIZE_TYPE2		(14 * sizeof(__le16))
 #define FSIZE_TYPE3		(14 * sizeof(__le16))
+#define FSIZE_TYPE4		(15 * sizeof(__le16))
 
 /* offset from header to finger struct */
 #define DELTA_TYPE1		(0 * sizeof(__le16))
 #define DELTA_TYPE2		(0 * sizeof(__le16))
 #define DELTA_TYPE3		(0 * sizeof(__le16))
+#define DELTA_TYPE4		(1 * sizeof(__le16))
 
 /* usb control message mode switch data */
 #define USBMSG_TYPE1		8, 0x300, 0, 0, 0x1, 0x8
 #define USBMSG_TYPE2		8, 0x300, 0, 0, 0x1, 0x8
 #define USBMSG_TYPE3		8, 0x300, 0, 0, 0x1, 0x8
+#define USBMSG_TYPE4		2, 0x302, 2, 1, 0x1, 0x0
 
 /* Wellspring initialization constants */
 #define BCM5974_WELLSPRING_MODE_READ_REQUEST_ID		1
@@ -227,7 +242,8 @@ struct tp_finger {
 	__le16 orientation;	/* 16384 when point, else 15 bit angle */
 	__le16 touch_major;	/* touch area, major axis */
 	__le16 touch_minor;	/* touch area, minor axis */
-	__le16 unused[3];	/* zeros */
+	__le16 unused[2];	/* zeros */
+	__le16 pressure;	/* pressure on forcetouch touchpad */
 	__le16 multi;		/* one finger: varies, more fingers: constant */
 } __attribute__((packed,aligned(2)));
 
@@ -468,6 +484,19 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ SN_COORD, -150, 6600 },
 		{ SN_ORIENT, -MAX_FINGER_ORIENTATION, MAX_FINGER_ORIENTATION }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING9_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING9_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0, sizeof(struct bt_data),
+		0x83, DATAFORMAT(TYPE4),
+		{ SN_PRESSURE, 0, 300 },
+		{ SN_WIDTH, 0, 2048 },
+		{ SN_COORD, -4828, 5345 },
+		{ SN_COORD, -203, 6803 },
+		{ SN_ORIENT, -MAX_FINGER_ORIENTATION, MAX_FINGER_ORIENTATION }
+	},
 	{}
 };
 
-- 
2.4.5

