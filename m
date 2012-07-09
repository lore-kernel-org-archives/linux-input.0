From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 2/2] Input: bcm5974 - Add support for 2012 MacBook Pro Retina
Date: Mon,  9 Jul 2012 14:46:46 +0200
Message-ID: <1341838006-22407-2-git-send-email-rydberg@euromail.se>
References: <1341838006-22407-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341838006-22407-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

Add support for the 15'' MacBook Pro Retina model (MacBookPro10,1).

Patch originally written by clipcarl (forums.opensuse.org).

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Dmitry,

Here is a patch for the new retina I picked up from the anonymous
heroes on the linux forums. Looks simple enough for 3.5 to me.  Either
way, the usual sync with Jiri is needed.

Cheers,
Henrik

 drivers/input/mouse/bcm5974.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 2cf681d..d528c23 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -79,6 +79,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
 #define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
 #define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
+/* MacbookPro10,1 (unibody, June 2012) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI	0x0262
+#define USB_DEVICE_ID_APPLE_WELLSPRING7_ISO	0x0263
+#define USB_DEVICE_ID_APPLE_WELLSPRING7_JIS	0x0264
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -128,6 +132,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS),
+	/* MacbookPro10,1 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -354,6 +362,18 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ DIM_X, DIM_X / SN_COORD, -4620, 5140 },
 		{ DIM_Y, DIM_Y / SN_COORD, -150, 6600 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING7_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING7_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING7_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4750, 5280 },
+		{ DIM_Y, DIM_Y / SN_COORD, -150, 6730 }
+	},
 	{}
 };
 
-- 
1.7.11.1
