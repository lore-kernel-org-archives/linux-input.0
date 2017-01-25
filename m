From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 3/8] HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface
Date: Wed, 25 Jan 2017 12:08:37 -0800
Message-ID: <1485374922-3417-4-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36031 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdAYUJ3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:29 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so14972500pfo.3
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:29 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

In addition to its USB interface, the second-generation Intuos Pro
includes a Bluetooth radio that offers two pairing interfaces: classic
and low-energy. The classic interface functions just like the earlier
Bluetooth-enabled Intuos4 and Graphire4 tablets, appearing as a HID device
that our driver can work with. The low-energy interface is intented to
be used by userspace applications that make use of its paper-to-digital
capabilities.

Despite the USB interface using Wacom's new vendor-defined HID usages,
the Bluetooth interface provides us with useless black-box "blob"
report descriptors like past devices. We thus have to explicitly add
support for the PIDs and reports used.

These devices pack a /lot/ of information into a single Bluetooth
input report. Each report contains up to seven snapshots of the pen
state, four snapshots of the touch state (of five touches each), pad
state, and battery data. Thankfully this isn't too hard for the driver
to report -- it just takes a fair amount of code to extract!

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c |  25 ++++++
 drivers/hid/wacom_wac.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/wacom_wac.h |   6 +-
 3 files changed, 226 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4dd7b80..4a70783 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -756,6 +756,10 @@ static int wacom_led_control(struct wacom *wacom)
 		report_id = WAC_CMD_WL_LED_CONTROL;
 		buf_size = 13;
 	}
+	else if (wacom->wacom_wac.features.type == INTUOSP2_BT) {
+		report_id = WAC_CMD_WL_INTUOSP2;
+		buf_size = 51;
+	}
 	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -781,6 +785,16 @@ static int wacom_led_control(struct wacom *wacom)
 		} else
 			buf[1] = led_bits;
 	}
+	else if (wacom->wacom_wac.features.type == INTUOSP2_BT) {
+		buf[0] = report_id;
+		buf[4] = 100; // Power Connection LED (ORANGE)
+		buf[5] = 100; // BT Connection LED (BLUE)
+		buf[6] = 100; // Paper Mode (RED?)
+		buf[7] = 100; // Paper Mode (GREEN?)
+		buf[8] = 100; // Paper Mode (BLUE?)
+		buf[9] = wacom->led.llv;
+		buf[10] = wacom->led.groups[0].select & 0x03;
+	}
 	else {
 		int led = wacom->led.groups[0].select | 0x4;
 
@@ -1409,6 +1423,17 @@ static int wacom_initialize_leds(struct wacom *wacom)
 						      &intuos5_led_attr_group);
 		break;
 
+	case INTUOSP2_BT:
+		wacom->led.llv = 50;
+		wacom->led.max_llv = 100;
+		error = wacom_leds_alloc_and_register(wacom, 1, 4, false);
+		if (error) {
+			hid_err(wacom->hdev,
+				"cannot create leds err: %d\n", error);
+			return error;
+		}
+		return 0;
+
 	case REMOTE:
 		wacom->led.llv = 255;
 		wacom->led.max_llv = 255;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a23b736..ef29f7a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1190,6 +1190,161 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	return count;
 }
 
+static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
+{
+	const int pen_frame_len = 14;
+	const int pen_frames = 7;
+
+	struct input_dev *pen_input = wacom->pen_input;
+	unsigned char *data = wacom->data;
+	int i;
+
+	wacom->serial[0] = get_unaligned_le64(&data[99]);
+	wacom->id[0]     = get_unaligned_le16(&data[107]);
+	if (wacom->serial[0] >> 52 == 1) {
+		/* Add back in missing bits of ID for non-USI pens */
+		wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
+	}
+	wacom->tool[0]   = wacom_intuos_get_tool_type(wacom_intuos_id_mangle(wacom->id[0]));
+
+	for (i = 0; i < pen_frames; i++) {
+		unsigned char *frame = &data[i*pen_frame_len + 1];
+
+		if (!(frame[0] & 0x80))
+			continue;
+
+		input_report_abs(pen_input, ABS_X, get_unaligned_le16(&frame[1]));
+		input_report_abs(pen_input, ABS_Y, get_unaligned_le16(&frame[3]));
+		input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
+		input_report_abs(pen_input, ABS_TILT_X, frame[7]);
+		input_report_abs(pen_input, ABS_TILT_Y, frame[8]);
+		input_report_abs(pen_input, ABS_Z, get_unaligned_le16(&frame[9]));
+		input_report_abs(pen_input, ABS_WHEEL, get_unaligned_le16(&frame[11]));
+		input_report_abs(pen_input, ABS_DISTANCE, frame[13]);
+
+		input_report_key(pen_input, BTN_TOUCH, frame[0] & 0x01);
+		input_report_key(pen_input, BTN_STYLUS, frame[0] & 0x02);
+		input_report_key(pen_input, BTN_STYLUS2, frame[0] & 0x04);
+
+		input_report_key(pen_input, wacom->tool[0], 1);
+		input_event(pen_input, EV_MSC, MSC_SERIAL, wacom->serial[0]);
+		input_report_abs(pen_input, ABS_MISC,
+				 wacom_intuos_id_mangle(wacom->id[0])); /* report tool id */
+
+		wacom->shared->stylus_in_proximity = frame[0] & 0x40;
+
+		input_sync(pen_input);
+	}
+}
+
+static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
+{
+	const int finger_touch_len = 8;
+	const int finger_frames = 4;
+	const int finger_frame_len = 43;
+
+	struct input_dev *touch_input = wacom->touch_input;
+	unsigned char *data = wacom->data;
+	int num_contacts_left = 5;
+	int i, j;
+
+	for (i = 0; i < finger_frames; i++) {
+		unsigned char *frame = &data[i*finger_frame_len + 109];
+		int current_num_contacts = frame[0] & 0x7F;
+		int contacts_to_send;
+
+		if (!(frame[0] & 0x80))
+			continue;
+
+		/*
+		 * First packet resets the counter since only the first
+		 * packet in series will have non-zero current_num_contacts.
+		 */
+		if (current_num_contacts)
+			wacom->num_contacts_left = current_num_contacts;
+
+		contacts_to_send = min(num_contacts_left, wacom->num_contacts_left);
+
+		for (j = 0; j < contacts_to_send; j++) {
+			unsigned char *touch = &frame[j*finger_touch_len + 1];
+			int slot = input_mt_get_slot_by_key(touch_input, touch[0]);
+			int x = get_unaligned_le16(&touch[2]);
+			int y = get_unaligned_le16(&touch[4]);
+			int w = touch[6] * input_abs_get_res(touch_input, ABS_MT_POSITION_X);
+			int h = touch[7] * input_abs_get_res(touch_input, ABS_MT_POSITION_Y);
+
+			if (slot < 0)
+				continue;
+
+			input_mt_slot(touch_input, slot);
+			input_mt_report_slot_state(touch_input, MT_TOOL_FINGER, touch[1] & 0x01);
+			input_report_abs(touch_input, ABS_MT_POSITION_X, x);
+			input_report_abs(touch_input, ABS_MT_POSITION_Y, y);
+			input_report_abs(touch_input, ABS_MT_TOUCH_MAJOR, max(w, h));
+			input_report_abs(touch_input, ABS_MT_TOUCH_MINOR, min(w, h));
+			input_report_abs(touch_input, ABS_MT_ORIENTATION, w > h);
+		}
+
+		input_mt_sync_frame(touch_input);
+
+		wacom->num_contacts_left -= contacts_to_send;
+		if (wacom->num_contacts_left <= 0) {
+			wacom->num_contacts_left = 0;
+			wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
+		}
+	}
+
+	input_report_switch(touch_input, SW_MUTE_DEVICE, !(data[281] >> 7));
+	input_sync(touch_input);
+}
+
+static void wacom_intuos_pro2_bt_pad(struct wacom_wac *wacom)
+{
+	struct input_dev *pad_input = wacom->pad_input;
+	unsigned char *data = wacom->data;
+
+	int buttons = (data[282] << 1) | ((data[281] >> 6) & 0x01);
+	int ring = data[285];
+	int prox = buttons | (ring & 0x80);
+
+	wacom_report_numbered_buttons(pad_input, 9, buttons);
+
+	input_report_abs(pad_input, ABS_WHEEL, (ring & 0x80) ? (ring & 0x7f) : 0);
+
+	input_report_key(pad_input, wacom->tool[1], prox ? 1 : 0);
+	input_report_abs(pad_input, ABS_MISC, prox ? PAD_DEVICE_ID : 0);
+	input_event(pad_input, EV_MSC, MSC_SERIAL, 0xffffffff);
+
+	input_sync(pad_input);
+}
+
+static void wacom_intuos_pro2_bt_battery(struct wacom_wac *wacom)
+{
+	unsigned char *data = wacom->data;
+
+	bool chg = data[284] & 0x80;
+	int battery_status = data[284] & 0x7F;
+
+	wacom_notify_battery(wacom, battery_status, chg, 1, chg);
+}
+
+static int wacom_intuos_pro2_bt_irq(struct wacom_wac *wacom, size_t len)
+{
+	unsigned char *data = wacom->data;
+
+	if (data[0] != 0x80) {
+		dev_dbg(wacom->pen_input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
+		return 0;
+	}
+
+	wacom_intuos_pro2_bt_pen(wacom);
+	wacom_intuos_pro2_bt_touch(wacom);
+	wacom_intuos_pro2_bt_pad(wacom);
+	wacom_intuos_pro2_bt_battery(wacom);
+	return 0;
+}
+
 static int wacom_24hdt_irq(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->touch_input;
@@ -2667,6 +2822,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 			sync = wacom_intuos_irq(wacom_wac);
 		break;
 
+	case INTUOSP2_BT:
+		sync = wacom_intuos_pro2_bt_irq(wacom_wac, len);
+		break;
+
 	case TABLETPC:
 	case TABLETPCE:
 	case TABLETPC2FG:
@@ -2838,6 +2997,13 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	if (features->type == REMOTE)
 		features->device_type = WACOM_DEVICETYPE_PAD;
 
+	if (features->type == INTUOSP2_BT) {
+		features->device_type |= WACOM_DEVICETYPE_PEN |
+					 WACOM_DEVICETYPE_PAD |
+					 WACOM_DEVICETYPE_TOUCH;
+		features->quirks |= WACOM_QUIRK_BATTERY;
+	}
+
 	switch (features->type) {
 	case PL:
 	case DTU:
@@ -2984,6 +3150,7 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
+	case INTUOSP2_BT:
 		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 				      features->distance_max,
 				      features->distance_fuzz, 0);
@@ -3092,6 +3259,27 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	}
 
 	switch (features->type) {
+	case INTUOSP2_BT:
+		input_dev->evbit[0] |= BIT_MASK(EV_SW);
+		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
+
+		if (wacom_wac->shared->touch->product == 0x361) {
+			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+					     0, 12440, 4, 0);
+			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+					     0, 8640, 4, 0);
+		}
+		else if (wacom_wac->shared->touch->product == 0x360) {
+			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+					     0, 8960, 4, 0);
+			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+					     0, 5920, 4, 0);
+		}
+		input_abs_set_res(input_dev, ABS_MT_POSITION_X, 40);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_X, 40);
+
+		/* fall through */
+
 	case INTUOS5:
 	case INTUOS5L:
 	case INTUOSPM:
@@ -3389,6 +3577,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
+	case INTUOSP2_BT:
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		break;
 
@@ -3947,6 +4136,12 @@ static const struct wacom_features wacom_features_0x343 =
 	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
+static const struct wacom_features wacom_features_0x360 =
+	{ "Wacom Intuos Pro M", 44800, 29600, 8191, 63,
+	  INTUOSP2_BT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 9, .touch_max = 10 };
+static const struct wacom_features wacom_features_0x361 =
+	{ "Wacom Intuos Pro L", 62200, 43200, 8191, 63,
+	  INTUOSP2_BT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 9, .touch_max = 10 };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC, .oVid = HID_ANY_ID, .oPid = HID_ANY_ID };
@@ -4113,6 +4308,8 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x33D) },
 	{ USB_DEVICE_WACOM(0x33E) },
 	{ USB_DEVICE_WACOM(0x343) },
+	{ BT_DEVICE_WACOM(0x360) },
+	{ BT_DEVICE_WACOM(0x361) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
 	{ USB_DEVICE_WACOM(0x5000) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 804fda3..d3482de 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -12,8 +12,8 @@
 #include <linux/types.h>
 #include <linux/hid.h>
 
-/* maximum packet length for USB devices */
-#define WACOM_PKGLEN_MAX	192
+/* maximum packet length for USB/BT devices */
+#define WACOM_PKGLEN_MAX	361
 
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
@@ -80,6 +80,7 @@
 #define WAC_CMD_ICON_BT_XFER            0x26
 #define WAC_CMD_DELETE_PAIRING          0x20
 #define WAC_CMD_UNPAIR_ALL              0xFF
+#define WAC_CMD_WL_INTUOSP2             0x82
 
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
@@ -179,6 +180,7 @@ enum {
 	INTUOSPS,
 	INTUOSPM,
 	INTUOSPL,
+	INTUOSP2_BT,
 	WACOM_21UX2,
 	WACOM_22HD,
 	DTK,
-- 
2.7.4

