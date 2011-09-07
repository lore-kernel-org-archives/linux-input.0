From: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
Subject: [PATCH] Add MacBookAir4,1 trackpad support
Date: Wed, 7 Sep 2011 16:16:39 -0400
Message-ID: <20110907201639.GA2004@Caligula>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45534 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab1IGUYB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 16:24:01 -0400
Received: by vxj15 with SMTP id 15so37615vxj.19
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2011 13:24:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch adds trackpad support for the MacBookAir4,1, released in July 2011.
It is very similar to the MacBookAir4,2 patch submitted by Joshua Dillon and
Chase Douglas.

Signed-off-by: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
--- linux/drivers/input/mouse/bcm5974.c	2011-09-06 23:41:58.000000000 -0400
+++ patched/drivers/input/mouse/bcm5974.c	2011-09-07 00:02:44.000000000 -0400
@@ -67,6 +67,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI	0x0245
 #define USB_DEVICE_ID_APPLE_WELLSPRING5_ISO	0x0246
 #define USB_DEVICE_ID_APPLE_WELLSPRING5_JIS	0x0247
+/* MacbookAir4,1 (unibody, July 2011) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI	0x0249
+#define USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO	0x024a
+#define USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS	0x024b
 /* MacbookAir4,2 (unibody, July 2011) */
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI	0x024c
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ISO	0x024d
@@ -112,6 +116,10 @@
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_JIS),
+	/* MacbookAir4,1 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS),
 	/* MacbookAir4,2 */
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_ISO),
@@ -334,6 +342,18 @@
 		{ DIM_X, DIM_X / SN_COORD, -4750, 5280 },
 		{ DIM_Y, DIM_Y / SN_COORD, -150, 6730 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4620, 5140 },
+		{ DIM_Y, DIM_Y / SN_COORD, -150, 6600 }
+	},
 	{}
 };
 
