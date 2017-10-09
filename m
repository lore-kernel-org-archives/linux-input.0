From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: joydev - blacklist ds3/ds4/udraw motion sensors
Date: Mon,  9 Oct 2017 15:34:10 -0700
Message-ID: <20171009223410.17164-3-dmitry.torokhov@gmail.com>
References: <20171009223410.17164-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009223410.17164-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Introduce a device table used for blacklisting devices. We currently
blacklist the motion sensor subdevice of THQ Udraw and Sony ds3/ds4.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joydev.c | 70 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 29d677c714d2..7b29a8944039 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -747,6 +747,68 @@ static void joydev_cleanup(struct joydev *joydev)
 		input_close_device(handle);
 }
 
+/*
+ * These codes are copied from from hid-ids.h, unfortunately there is no common
+ * usb_ids/bt_ids.h header.
+ */
+#define USB_VENDOR_ID_SONY			0x054c
+#define USB_DEVICE_ID_SONY_PS3_CONTROLLER		0x0268
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER		0x05c4
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2		0x09cc
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE	0x0ba0
+
+#define USB_VENDOR_ID_THQ			0x20d6
+#define USB_DEVICE_ID_THQ_PS3_UDRAW			0xcb17
+
+#define ACCEL_DEV(vnd, prd)						\
+	{								\
+		.flags = INPUT_DEVICE_ID_MATCH_VENDOR |			\
+				INPUT_DEVICE_ID_MATCH_PRODUCT |		\
+				INPUT_DEVICE_ID_MATCH_PROPBIT,		\
+		.vendor = (vnd),					\
+		.product = (prd),					\
+		.propbit = { BIT_MASK(INPUT_PROP_ACCELEROMETER) },	\
+	}
+
+static const struct input_device_id joydev_blacklist[] = {
+	/* Avoid touchpads and touchscreens */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH) },
+	},
+	/* Avoid tablets, digitisers and similar devices */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_DIGI)] = BIT_MASK(BTN_DIGI) },
+	},
+	/* Disable accelerometers on composite devices */
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE),
+	ACCEL_DEV(USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW),
+	{ /* sentinel */ }
+};
+
+static bool joydev_dev_is_blacklisted(struct input_dev *dev)
+{
+	const struct input_device_id *id;
+
+	for (id = joydev_blacklist; id->flags; id++) {
+		if (input_match_device_id(dev, id)) {
+			dev_dbg(&dev->dev,
+				"joydev: blacklisting '%s'\n", dev->name);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
 {
 	DECLARE_BITMAP(jd_scratch, KEY_CNT);
@@ -807,12 +869,8 @@ static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
 
 static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 {
-	/* Avoid touchpads and touchscreens */
-	if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_TOUCH, dev->keybit))
-		return false;
-
-	/* Avoid tablets, digitisers and similar devices */
-	if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_DIGI, dev->keybit))
+	/* Disable blacklisted devices */
+	if (joydev_dev_is_blacklisted(dev))
 		return false;
 
 	/* Avoid absolute mice */
-- 
2.14.2.920.gcf0c67979c-goog
