From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 2/8] HID: sony: Make the DS4 touchpad a separate device
Date: Wed, 23 Nov 2016 14:07:07 -0800
Message-ID: <1479938833-26424-3-git-send-email-roderick@gaikai.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35797 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933813AbcKWWIL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 17:08:11 -0500
Received: by mail-yw0-f169.google.com with SMTP id i145so23766209ywg.2
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 14:08:10 -0800 (PST)
In-Reply-To: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The dualshock 4 supports both analog sticks of which one uses
ABS_X/_Y and a touchpad. In a recent discussion with Dmitry about
some input-mt changes we proposed for disabling pointer emulation from
input_mt_sync_frame, Dmitry mentioned ABS_X/_Y should report the
same data as ABS_MT_POSITION_X/_Y. The current driver is mixing axes
for different subdevices. It was suggested to make the touchpad
its own sub-device.

This patch turns the touchpad into its own device. In addition
this patch also moves the button underneath the touchpad into
the new device. It felt like this button should be part of the
device. No known user space application (not even SDL2) seems to
be using it.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 105 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 3385006..995b5cf 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -376,7 +376,7 @@ static u8 dualshock4_usb_rdesc[] = {
 	0x65, 0x00,         /*      Unit,                           */
 	0x05, 0x09,         /*      Usage Page (Button),            */
 	0x19, 0x01,         /*      Usage Minimum (01h),            */
-	0x29, 0x0E,         /*      Usage Maximum (0Eh),            */
+	0x29, 0x0D,         /*      Usage Maximum (0Dh),            */
 	0x15, 0x00,         /*      Logical Minimum (0),            */
 	0x25, 0x01,         /*      Logical Maximum (1),            */
 	0x75, 0x01,         /*      Report Size (1),                */
@@ -689,7 +689,7 @@ static u8 dualshock4_bt_rdesc[] = {
 	0x81, 0x42,         /*      Input (Variable, Null State),   */
 	0x05, 0x09,         /*      Usage Page (Button),            */
 	0x19, 0x01,         /*      Usage Minimum (01h),            */
-	0x29, 0x0E,         /*      Usage Maximum (0Eh),            */
+	0x29, 0x0D,         /*      Usage Maximum (0Dh),            */
 	0x15, 0x00,         /*      Logical Minimum (0),            */
 	0x25, 0x01,         /*      Logical Maximum (1),            */
 	0x75, 0x01,         /*      Report Size (1),                */
@@ -1033,9 +1033,12 @@ struct motion_output_report_02 {
 /* Offsets relative to USB input report (0x1). Bluetooth (0x11) requires an
  * additional +2.
  */
+#define DS4_INPUT_REPORT_BUTTON_OFFSET    5
 #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
 #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
 
+#define DS4_TOUCHPAD_SUFFIX " Touchpad"
+
 static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
@@ -1044,6 +1047,7 @@ struct sony_sc {
 	spinlock_t lock;
 	struct list_head list_node;
 	struct hid_device *hdev;
+	struct input_dev *touchpad;
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
 	struct work_struct state_worker;
@@ -1228,9 +1232,6 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 
 static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
-	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
-						struct hid_input, list);
-	struct input_dev *input_dev = hidinput->input;
 	unsigned long flags;
 	int n, m, offset, num_touch_data, max_touch_data;
 	u8 cable_state, battery_capacity, battery_charging;
@@ -1238,6 +1239,10 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	/* When using Bluetooth the header is 2 bytes longer, so skip these. */
 	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 0 : 2;
 
+	/* Second bit of third button byte is for the touchpad button. */
+	offset = data_offset + DS4_INPUT_REPORT_BUTTON_OFFSET;
+	input_report_key(sc->touchpad, BTN_LEFT, rd[offset+2] & 0x2);
+
 	/*
 	 * The lower 4 bits of byte 30 (or 32 for BT) contain the battery level
 	 * and the 5th bit contains the USB cable state.
@@ -1303,18 +1308,18 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 			y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
 
 			active = !(rd[offset] >> 7);
-			input_mt_slot(input_dev, n);
-			input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, active);
+			input_mt_slot(sc->touchpad, n);
+			input_mt_report_slot_state(sc->touchpad, MT_TOOL_FINGER, active);
 
 			if (active) {
-				input_report_abs(input_dev, ABS_MT_POSITION_X, x);
-				input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
+				input_report_abs(sc->touchpad, ABS_MT_POSITION_X, x);
+				input_report_abs(sc->touchpad, ABS_MT_POSITION_Y, y);
 			}
 
 			offset += 4;
 		}
-		input_mt_sync_frame(input_dev);
-		input_sync(input_dev);
+		input_mt_sync_frame(sc->touchpad);
+		input_sync(sc->touchpad);
 	}
 }
 
@@ -1415,22 +1420,77 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static int sony_register_touchpad(struct hid_input *hi, int touch_count,
+static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 					int w, int h)
 {
-	struct input_dev *input_dev = hi->input;
+	size_t name_sz;
+	char *name;
 	int ret;
 
-	ret = input_mt_init_slots(input_dev, touch_count, 0);
+	sc->touchpad = input_allocate_device();
+	if (!sc->touchpad)
+		return -ENOMEM;
+
+	input_set_drvdata(sc->touchpad, sc);
+	sc->touchpad->dev.parent = &sc->hdev->dev;
+	sc->touchpad->phys = sc->hdev->phys;
+	sc->touchpad->uniq = sc->hdev->uniq;
+	sc->touchpad->id.bustype = sc->hdev->bus;
+	sc->touchpad->id.vendor = sc->hdev->vendor;
+	sc->touchpad->id.product = sc->hdev->product;
+	sc->touchpad->id.version = sc->hdev->version;
+
+	/* Append a suffix to the controller name as there are various
+	 * DS4 compatible non-Sony devices with different names.
+	 */
+	name_sz = strlen(sc->hdev->name) + sizeof(DS4_TOUCHPAD_SUFFIX);
+	name = kzalloc(name_sz, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);
+	sc->touchpad->name = name;
+
+	ret = input_mt_init_slots(sc->touchpad, touch_count, 0);
 	if (ret < 0)
-		return ret;
+		goto err;
+
+	/* We map the button underneath the touchpad to BTN_LEFT. */
+	__set_bit(EV_KEY, sc->touchpad->evbit);
+	__set_bit(BTN_LEFT, sc->touchpad->keybit);
+	__set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);
 
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, w, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, h, 0, 0);
+	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);
+	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
+
+	ret = input_register_device(sc->touchpad);
+	if (ret < 0)
+		goto err;
 
 	return 0;
+
+err:
+	kfree(sc->touchpad->name);
+	sc->touchpad->name = NULL;
+
+	input_free_device(sc->touchpad);
+	sc->touchpad = NULL;
+
+	return ret;
 }
 
+static void sony_unregister_touchpad(struct sony_sc *sc)
+{
+	if (!sc->touchpad)
+		return;
+
+	kfree(sc->touchpad->name);
+	sc->touchpad->name = NULL;
+
+	input_unregister_device(sc->touchpad);
+	sc->touchpad = NULL;
+}
 
 /*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
@@ -2422,7 +2482,7 @@ static int sony_input_configured(struct hid_device *hdev,
 		 * The Dualshock 4 touchpad supports 2 touches and has a
 		 * resolution of 1920x942 (44.86 dots/mm).
 		 */
-		ret = sony_register_touchpad(hidinput, 2, 1920, 942);
+		ret = sony_register_touchpad(sc, 2, 1920, 942);
 		if (ret) {
 			hid_err(sc->hdev,
 			"Unable to initialize multi-touch slots: %d\n",
@@ -2544,13 +2604,16 @@ static void sony_remove(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	hid_hw_close(hdev);
+
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(sc);
 
-	if (sc->quirks & SONY_BATTERY_SUPPORT) {
-		hid_hw_close(hdev);
+	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
-	}
+
+	if (sc->touchpad)
+		sony_unregister_touchpad(sc);
 
 	sony_cancel_work_sync(sc);
 
-- 
2.7.4

