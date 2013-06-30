From: rydberg@euromail.se
Subject: [PATCH 2/2] Input: bcm5974 - Add support for the 2013 MacBook Air
Date: Sun, 30 Jun 2013 21:04:46 +0200
Message-ID: <1372619086-3532-3-git-send-email-rydberg@euromail.se>
References: <1372619086-3532-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372619086-3532-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The June 2013 Macbook Air (13'') has a new trackpad protocol; four new
values are inserted in the header, and the mode switch is no longer
needed. This patch adds support for the new devices.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Brad Ford <plymouthffl@gmail.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 2baff1b..4ef4d5e 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -88,6 +88,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI	0x0259
 #define USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO	0x025a
 #define USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS	0x025b
+/* MacbookAir6,2 (unibody, June 2013) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0291
+#define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0292
+#define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0293
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -145,6 +149,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7A_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7A_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS),
+	/* MacbookAir6,2 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING8_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING8_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -172,15 +180,18 @@ struct bt_data {
 /* trackpad header types */
 enum tp_type {
 	TYPE1,			/* plain trackpad */
-	TYPE2			/* button integrated in trackpad */
+	TYPE2,			/* button integrated in trackpad */
+	TYPE3			/* additional header fields since June 2013 */
 };
 
 /* trackpad finger data offsets, le16-aligned */
 #define FINGER_TYPE1		(13 * sizeof(__le16))
 #define FINGER_TYPE2		(15 * sizeof(__le16))
+#define FINGER_TYPE3		(19 * sizeof(__le16))
 
 /* trackpad button data offsets */
 #define BUTTON_TYPE2		15
+#define BUTTON_TYPE3		23
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
@@ -400,6 +411,19 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ SN_COORD, -150, 6730 },
 		{ SN_ORIENT, -MAX_FINGER_ORIENTATION, MAX_FINGER_ORIENTATION }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING8_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING8_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0, sizeof(struct bt_data),
+		0x83, TYPE3, FINGER_TYPE3, FINGER_TYPE3 + SIZEOF_ALL_FINGERS,
+		{ SN_PRESSURE, 0, 300 },
+		{ SN_WIDTH, 0, 2048 },
+		{ SN_COORD, -4620, 5140 },
+		{ SN_COORD, -150, 6600 },
+		{ SN_ORIENT, -MAX_FINGER_ORIENTATION, MAX_FINGER_ORIENTATION }
+	},
 	{}
 };
 
@@ -557,6 +581,9 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 		input_report_key(input, BTN_LEFT, ibt);
 	}
 
+	if (c->tp_type == TYPE3)
+		input_report_key(input, BTN_LEFT, dev->tp_data[BUTTON_TYPE3]);
+
 	input_sync(input);
 
 	return 0;
@@ -572,9 +599,14 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 
 static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 {
-	char *data = kmalloc(8, GFP_KERNEL);
 	int retval = 0, size;
+	char *data;
+
+	/* Type 3 does not require a mode switch */
+	if (dev->cfg.tp_type == TYPE3)
+		return 0;
 
+	data = kmalloc(8, GFP_KERNEL);
 	if (!data) {
 		dev_err(&dev->intf->dev, "out of memory\n");
 		retval = -ENOMEM;
-- 
1.8.3.1
