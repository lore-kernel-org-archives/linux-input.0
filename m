From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: bcm5974: Add support for MacBookAir3
Date: Tue,  9 Nov 2010 17:38:42 +0100
Message-ID: <1289320722-1948-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:60089 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752826Ab0KIQjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Nov 2010 11:39:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Edgar (gimli) Hucek" <gimli@dark-green.com>, stable@kernel.org, Henrik Rydberg <rydberg@euromail.se>

From: Edgar (gimli) Hucek <gimli@dark-green.com>

This patch adds support for the MacBookAir3,1 and MacBookAir3,2
models.

[rydberg@euromail.se: touchpad range calibration]
Cc: stable@kernel.org
Signed-off-by: Edgar (gimli) Hucek <gimli@dark-green.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Dmitry, Jiri,

This patch was seen on lkml last week, and has now been excercised by
a larger set of users. As usual, this patch should go before or
together with the HID changes, so as not to break basic support from
the non-MT HID driver.

Cheers,
Henrik

 drivers/input/mouse/bcm5974.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index b952317..ee82851 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -55,6 +55,14 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI	0x0236
 #define USB_DEVICE_ID_APPLE_WELLSPRING3_ISO	0x0237
 #define USB_DEVICE_ID_APPLE_WELLSPRING3_JIS	0x0238
+/* MacbookAir3,2 (unibody), aka wellspring5 */
+#define USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI	0x023f
+#define USB_DEVICE_ID_APPLE_WELLSPRING4_ISO	0x0240
+#define USB_DEVICE_ID_APPLE_WELLSPRING4_JIS	0x0241
+/* MacbookAir3,1 (unibody), aka wellspring4 */
+#define USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI	0x0242
+#define USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO	0x0243
+#define USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS	0x0244
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -80,6 +88,14 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING3_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING3_JIS),
+	/* MacbookAir3,2 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4_JIS),
+	/* MacbookAir3,1 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -234,6 +250,30 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ DIM_X, DIM_X / SN_COORD, -4460, 5166 },
 		{ DIM_Y, DIM_Y / SN_COORD, -75, 6700 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING4_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING4_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4620, 5140 },
+		{ DIM_Y, DIM_Y / SN_COORD, -150, 6600 }
+	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4616, 5112 },
+		{ DIM_Y, DIM_Y / SN_COORD, -142, 5234 }
+	},
 	{}
 };
 
-- 
1.7.1

