From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH rev2] input: bcm5974: Add support for the Macbook 5 (Unibody)
Date: Mon, 27 Apr 2009 23:11:51 +0200
Message-ID: <1240866711-6468-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761085AbZD0VMX@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

This patch adds support for the new unibody Macbook, with physically
integrated button and trackpad. Since the integrated button changes
the logic for touch-and-click, a device capability bit mask is now
reported in input_id.version, which can be picked up by user space
via a EVIOCGID call.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Tested-by: David M. Lary <dmlary@gmail.com>
---
 drivers/input/mouse/bcm5974.c |   45 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index a170574..7c44199 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -51,6 +51,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI	0x0230
 #define USB_DEVICE_ID_APPLE_WELLSPRING2_ISO	0x0231
 #define USB_DEVICE_ID_APPLE_WELLSPRING2_JIS	0x0232
+/* Macbook5,1 (unibody), aka wellspring3 */
+#define USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI	0x0236
+#define USB_DEVICE_ID_APPLE_WELLSPRING3_ISO	0x0237
+#define USB_DEVICE_ID_APPLE_WELLSPRING3_JIS	0x0238
 
 #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -72,6 +76,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING2_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING2_JIS),
+	/* Macbook5,1 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING3_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING3_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -98,11 +106,19 @@ struct bt_data {
 
 /* trackpad header types */
 enum tp_type {
-	TYPE1			/* plain trackpad */
+	TYPE1,			/* plain trackpad */
+	TYPE2			/* button integrated in trackpad */
 };
 
 /* trackpad finger data offsets */
 #define FINGER_TYPE1		26
+#define FINGER_TYPE2		30
+
+/* trackpad button data offsets */
+#define BUTTON_TYPE2		15
+
+/* list of device capability bits */
+#define HAS_INTEGRATED_BUTTON	1
 
 /* trackpad finger structure */
 struct tp_finger {
@@ -135,6 +151,7 @@ struct bcm5974_param {
 /* device-specific configuration */
 struct bcm5974_config {
 	int ansi, iso, jis;	/* the product id of this device */
+	int caps;		/* device capability bitmask */
 	int bt_ep;		/* the endpoint of the button interface */
 	int bt_datalen;		/* data length of the button interface */
 	int tp_ep;		/* the endpoint of the trackpad interface */
@@ -184,6 +201,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING_ANSI,
 		USB_DEVICE_ID_APPLE_WELLSPRING_ISO,
 		USB_DEVICE_ID_APPLE_WELLSPRING_JIS,
+		0,
 		0x84, sizeof(struct bt_data),
 		0x81, TYPE1, FINGER_TYPE1, FINGER_TYPE1 + SIZEOF_ALL_FINGERS,
 		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 256 },
@@ -195,6 +213,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI,
 		USB_DEVICE_ID_APPLE_WELLSPRING2_ISO,
 		USB_DEVICE_ID_APPLE_WELLSPRING2_JIS,
+		0,
 		0x84, sizeof(struct bt_data),
 		0x81, TYPE1, FINGER_TYPE1, FINGER_TYPE1 + SIZEOF_ALL_FINGERS,
 		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 256 },
@@ -202,6 +221,18 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ DIM_X, DIM_X / SN_COORD, -4824, 4824 },
 		{ DIM_Y, DIM_Y / SN_COORD, -172, 4290 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING3_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING3_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4460, 5166 },
+		{ DIM_Y, DIM_Y / SN_COORD, -75, 6700 }
+	},
 	{}
 };
 
@@ -281,7 +312,7 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 	const struct tp_finger *f;
 	struct input_dev *input = dev->input;
 	int raw_p, raw_w, raw_x, raw_y, raw_n;
-	int ptest = 0, origin = 0, nmin = 0, nmax = 0;
+	int ptest = 0, origin = 0, ibt = 0, nmin = 0, nmax = 0;
 	int abs_p = 0, abs_w = 0, abs_x = 0, abs_y = 0;
 
 	if (size < c->tp_offset || (size - c->tp_offset) % SIZEOF_FINGER != 0)
@@ -303,6 +334,10 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 
 		ptest = int2bound(&c->p, raw_p);
 		origin = raw2int(f->origin);
+
+		/* set the integrated button if applicable */
+		if (c->tp_type == TYPE2)
+			ibt = raw2int(dev->tp_data[BUTTON_TYPE2]);
 	}
 
 	/* while tracking finger still valid, count all fingers */
@@ -346,6 +381,10 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 
 	}
 
+	/* type 2 reports button events via ibt only */
+	if (c->tp_type == TYPE2)
+		input_report_key(input, BTN_LEFT, ibt);
+
 	input_sync(input);
 
 	return 0;
@@ -655,6 +694,8 @@ static int bcm5974_probe(struct usb_interface *iface,
 	input_dev->name = "bcm5974";
 	input_dev->phys = dev->phys;
 	usb_to_input_id(dev->udev, &input_dev->id);
+	/* report driver capabilities via the version field */
+	input_dev->id.version = cfg->caps;
 	input_dev->dev.parent = &iface->dev;
 
 	input_set_drvdata(input_dev, dev);
-- 
1.5.6.3
