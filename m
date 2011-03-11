From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 2/2] Input: bcm5974 - add support for MacBookPro8
Date: Fri, 11 Mar 2011 19:45:23 +0100
Message-ID: <1299869123-18346-3-git-send-email-rydberg@euromail.se>
References: <1299869123-18346-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299869123-18346-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Botting <andy@andybotting.com>, stable@kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

From: Andy Botting <andy@andybotting.com>

This patch add multitouch support for the MacBookPro8,1 and
MacBookPro8,2 models.

Cc: stable@kernel.org
Signed-off-by: Andy Botting <andy@andybotting.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index ee82851..3185314 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -63,6 +63,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI	0x0242
 #define USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO	0x0243
 #define USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS	0x0244
+/* Macbook8 (unibody, March 2011) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI	0x0245
+#define USB_DEVICE_ID_APPLE_WELLSPRING5_ISO	0x0246
+#define USB_DEVICE_ID_APPLE_WELLSPRING5_JIS	0x0247
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -96,6 +100,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4A_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4A_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS),
+	/* MacbookPro8 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -274,6 +282,18 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ DIM_X, DIM_X / SN_COORD, -4616, 5112 },
 		{ DIM_Y, DIM_Y / SN_COORD, -142, 5234 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING5_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING5_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4415, 5050 },
+		{ DIM_Y, DIM_Y / SN_COORD, -55, 6680 }
+	},
 	{}
 };
 
-- 
1.7.4.1
