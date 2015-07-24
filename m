From: Henrik Rydberg <rydberg@bitmath.org>
Subject: [PATCH 1/3] Input: bcm5974 - Prepare for a new trackpad generation
Date: Fri, 24 Jul 2015 19:34:18 +0200
Message-ID: <1437759260-7748-1-git-send-email-rydberg@bitmath.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay7.public.one.com ([91.198.169.215]:54135 "EHLO
	mailrelay7.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbGXRem (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 13:34:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>

With the advent of the Macbook Pro 12, we see a new generation of
trackpads, capable of force sensoring and haptic feedback.

This patch prepares for the new device by adding configuration data
for the code paths that would otherwise look different.

Tested-by: John Horan <knasher@gmail.com>
Tested-by: Jochen Radmacher <jradmacher@gmx.de>
Tested-by: Yang Hongyang <burnef@gmail.com>
Tested-by: Yen-Chin, Lee <coldnew.tw@gmail.com>
Tested-by: George Hilios <ghilios@gmail.com>
Tested-by: Janez Urevc <janez@janezurevc.name>
Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
---
 drivers/input/mouse/bcm5974.c | 132 ++++++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 51 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index b10709f..a596b9b 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -184,17 +184,37 @@ enum tp_type {
 };
 
 /* trackpad finger data offsets, le16-aligned */
-#define FINGER_TYPE1		(13 * sizeof(__le16))
-#define FINGER_TYPE2		(15 * sizeof(__le16))
-#define FINGER_TYPE3		(19 * sizeof(__le16))
+#define HEADER_TYPE1		(13 * sizeof(__le16))
+#define HEADER_TYPE2		(15 * sizeof(__le16))
+#define HEADER_TYPE3		(19 * sizeof(__le16))
 
 /* trackpad button data offsets */
+#define BUTTON_TYPE1		0
 #define BUTTON_TYPE2		15
 #define BUTTON_TYPE3		23
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
 
+/* trackpad finger data block size */
+#define FSIZE_TYPE1		(14 * sizeof(__le16))
+#define FSIZE_TYPE2		(14 * sizeof(__le16))
+#define FSIZE_TYPE3		(14 * sizeof(__le16))
+
+/* offset from header to finger struct */
+#define DELTA_TYPE1		(0 * sizeof(__le16))
+#define DELTA_TYPE2		(0 * sizeof(__le16))
+#define DELTA_TYPE3		(0 * sizeof(__le16))
+
+/* usb control message mode switch data */
+#define USBMSG_TYPE1		8, 0x300, 0, 0, 0x1, 0x8
+#define USBMSG_TYPE2		8, 0x300, 0, 0, 0x1, 0x8
+#define USBMSG_TYPE3		8, 0x300, 0, 0, 0x1, 0x8
+
+/* Wellspring initialization constants */
+#define BCM5974_WELLSPRING_MODE_READ_REQUEST_ID		1
+#define BCM5974_WELLSPRING_MODE_WRITE_REQUEST_ID	9
+
 /* trackpad finger structure, le16-aligned */
 struct tp_finger {
 	__le16 origin;		/* zero when switching track finger */
@@ -213,8 +233,6 @@ struct tp_finger {
 
 /* trackpad finger data size, empirically at least ten fingers */
 #define MAX_FINGERS		16
-#define SIZEOF_FINGER		sizeof(struct tp_finger)
-#define SIZEOF_ALL_FINGERS	(MAX_FINGERS * SIZEOF_FINGER)
 #define MAX_FINGER_ORIENTATION	16384
 
 /* device-specific parameters */
@@ -232,8 +250,17 @@ struct bcm5974_config {
 	int bt_datalen;		/* data length of the button interface */
 	int tp_ep;		/* the endpoint of the trackpad interface */
 	enum tp_type tp_type;	/* type of trackpad interface */
-	int tp_offset;		/* offset to trackpad finger data */
+	int tp_header;		/* bytes in header block */
 	int tp_datalen;		/* data length of the trackpad interface */
+	int tp_button;		/* offset to button data */
+	int tp_fsize;		/* bytes in single finger block */
+	int tp_delta;		/* offset from header to finger struct */
+	int um_size;		/* usb control message length */
+	int um_req_val;		/* usb control message value */
+	int um_req_idx;		/* usb control message index */
+	int um_switch_idx;	/* usb control message mode switch index */
+	int um_switch_on;	/* usb control message mode switch on */
+	int um_switch_off;	/* usb control message mode switch off */
 	struct bcm5974_param p;	/* finger pressure limits */
 	struct bcm5974_param w;	/* finger width limits */
 	struct bcm5974_param x;	/* horizontal limits */
@@ -259,6 +286,24 @@ struct bcm5974 {
 	int slots[MAX_FINGERS];				/* slot assignments */
 };
 
+/* trackpad finger block data, le16-aligned */
+static const struct tp_finger *get_tp_finger(const struct bcm5974 *dev, int i)
+{
+	const struct bcm5974_config *c = &dev->cfg;
+	u8 *f_base = dev->tp_data + c->tp_header + c->tp_delta;
+
+	return (const struct tp_finger *)(f_base + i * c->tp_fsize);
+}
+
+#define DATAFORMAT(type)				\
+	type,						\
+	HEADER_##type,					\
+	HEADER_##type + (MAX_FINGERS) * (FSIZE_##type),	\
+	BUTTON_##type,					\
+	FSIZE_##type,					\
+	DELTA_##type,					\
+	USBMSG_##type
+
 /* logical signal quality */
 #define SN_PRESSURE	45		/* pressure signal-to-noise ratio */
 #define SN_WIDTH	25		/* width signal-to-noise ratio */
@@ -273,7 +318,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING_JIS,
 		0,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE1, FINGER_TYPE1, FINGER_TYPE1 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE1),
 		{ SN_PRESSURE, 0, 256 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4824, 5342 },
@@ -286,7 +331,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING2_JIS,
 		0,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE1, FINGER_TYPE1, FINGER_TYPE1 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE1),
 		{ SN_PRESSURE, 0, 256 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4824, 4824 },
@@ -299,7 +344,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING3_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4460, 5166 },
@@ -312,7 +357,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING4_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4620, 5140 },
@@ -325,7 +370,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4616, 5112 },
@@ -338,7 +383,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING5_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4415, 5050 },
@@ -351,7 +396,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING6_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4620, 5140 },
@@ -364,7 +409,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4750, 5280 },
@@ -377,7 +422,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4620, 5140 },
@@ -390,7 +435,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING7_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4750, 5280 },
@@ -403,7 +448,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING7A_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0x84, sizeof(struct bt_data),
-		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		0x81, DATAFORMAT(TYPE2),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4750, 5280 },
@@ -416,7 +461,7 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		USB_DEVICE_ID_APPLE_WELLSPRING8_JIS,
 		HAS_INTEGRATED_BUTTON,
 		0, sizeof(struct bt_data),
-		0x83, TYPE3, FINGER_TYPE3, FINGER_TYPE3 + SIZEOF_ALL_FINGERS,
+		0x83, DATAFORMAT(TYPE3),
 		{ SN_PRESSURE, 0, 300 },
 		{ SN_WIDTH, 0, 2048 },
 		{ SN_COORD, -4620, 5140 },
@@ -549,19 +594,18 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 	struct input_dev *input = dev->input;
 	int raw_n, i, n = 0;
 
-	if (size < c->tp_offset || (size - c->tp_offset) % SIZEOF_FINGER != 0)
+	if (size < c->tp_header || (size - c->tp_header) % c->tp_fsize != 0)
 		return -EIO;
 
-	/* finger data, le16-aligned */
-	f = (const struct tp_finger *)(dev->tp_data + c->tp_offset);
-	raw_n = (size - c->tp_offset) / SIZEOF_FINGER;
+	raw_n = (size - c->tp_header) / c->tp_fsize;
 
 	for (i = 0; i < raw_n; i++) {
-		if (raw2int(f[i].touch_major) == 0)
+		f = get_tp_finger(dev, i);
+		if (raw2int(f->touch_major) == 0)
 			continue;
-		dev->pos[n].x = raw2int(f[i].abs_x);
-		dev->pos[n].y = c->y.min + c->y.max - raw2int(f[i].abs_y);
-		dev->index[n++] = &f[i];
+		dev->pos[n].x = raw2int(f->abs_x);
+		dev->pos[n].y = c->y.min + c->y.max - raw2int(f->abs_y);
+		dev->index[n++] = f;
 	}
 
 	input_mt_assign_slots(input, dev->slots, dev->pos, n, 0);
@@ -572,32 +616,22 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 
 	input_mt_sync_frame(input);
 
-	report_synaptics_data(input, c, f, raw_n);
+	report_synaptics_data(input, c, get_tp_finger(dev, 0), raw_n);
 
-	/* type 2 reports button events via ibt only */
-	if (c->tp_type == TYPE2) {
-		int ibt = raw2int(dev->tp_data[BUTTON_TYPE2]);
+	/* later types report button events via integrated button only */
+	if (c->caps & HAS_INTEGRATED_BUTTON) {
+		int ibt = raw2int(dev->tp_data[c->tp_button]);
 		input_report_key(input, BTN_LEFT, ibt);
 	}
 
-	if (c->tp_type == TYPE3)
-		input_report_key(input, BTN_LEFT, dev->tp_data[BUTTON_TYPE3]);
-
 	input_sync(input);
 
 	return 0;
 }
 
-/* Wellspring initialization constants */
-#define BCM5974_WELLSPRING_MODE_READ_REQUEST_ID		1
-#define BCM5974_WELLSPRING_MODE_WRITE_REQUEST_ID	9
-#define BCM5974_WELLSPRING_MODE_REQUEST_VALUE		0x300
-#define BCM5974_WELLSPRING_MODE_REQUEST_INDEX		0
-#define BCM5974_WELLSPRING_MODE_VENDOR_VALUE		0x01
-#define BCM5974_WELLSPRING_MODE_NORMAL_VALUE		0x08
-
 static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 {
+	const struct bcm5974_config *c = &dev->cfg;
 	int retval = 0, size;
 	char *data;
 
@@ -605,7 +639,7 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 	if (dev->cfg.tp_type == TYPE3)
 		return 0;
 
-	data = kmalloc(8, GFP_KERNEL);
+	data = kmalloc(c->um_size, GFP_KERNEL);
 	if (!data) {
 		dev_err(&dev->intf->dev, "out of memory\n");
 		retval = -ENOMEM;
@@ -616,28 +650,24 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 	size = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
 			BCM5974_WELLSPRING_MODE_READ_REQUEST_ID,
 			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			BCM5974_WELLSPRING_MODE_REQUEST_VALUE,
-			BCM5974_WELLSPRING_MODE_REQUEST_INDEX, data, 8, 5000);
+			c->um_req_val, c->um_req_idx, data, c->um_size, 5000);
 
-	if (size != 8) {
+	if (size != c->um_size) {
 		dev_err(&dev->intf->dev, "could not read from device\n");
 		retval = -EIO;
 		goto out;
 	}
 
 	/* apply the mode switch */
-	data[0] = on ?
-		BCM5974_WELLSPRING_MODE_VENDOR_VALUE :
-		BCM5974_WELLSPRING_MODE_NORMAL_VALUE;
+	data[c->um_switch_idx] = on ? c->um_switch_on : c->um_switch_off;
 
 	/* write configuration */
 	size = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 			BCM5974_WELLSPRING_MODE_WRITE_REQUEST_ID,
 			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			BCM5974_WELLSPRING_MODE_REQUEST_VALUE,
-			BCM5974_WELLSPRING_MODE_REQUEST_INDEX, data, 8, 5000);
+			c->um_req_val, c->um_req_idx, data, c->um_size, 5000);
 
-	if (size != 8) {
+	if (size != c->um_size) {
 		dev_err(&dev->intf->dev, "could not write to device\n");
 		retval = -EIO;
 		goto out;
-- 
2.4.5

