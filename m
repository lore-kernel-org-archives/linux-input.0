From: Goffredo Baroncelli <kreijack@libero.it>
Subject: [PATCH] Add driver for mouse logitech M560
Date: Sun, 10 May 2015 18:49:32 +0200
Message-ID: <1431276572-3258-2-git-send-email-kreijack@libero.it>
References: <1431276572-3258-1-git-send-email-kreijack@libero.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-33.italiaonline.it ([212.48.25.161]:53982 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751599AbbEJQto (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2015 12:49:44 -0400
In-Reply-To: <1431276572-3258-1-git-send-email-kreijack@libero.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>

From: Goffredo Baroncelli <kreijack@inwind.it>

The Logitech M560 is a wireless mouse designed for windows 8 which uses
the unifying receiver.
Compared to a standard one, some buttons (the middle one and the
two ones placed on the side) are bound to a key combination
instead of a generating classic "mouse" button events.

The device shows up as a mouse and keyboard combination: when the middle
button is pressed it sends a key (as keyboard) combination, the same
happens for the two side button. The left/right/wheel work as expected
from a mouse. To complicate things further, the middle button sends
different keys combinations between odd and even presses.
In the "even" press it also sends a left click. But the worst thing
is that no event is generated when the middle button is released.

It is possible to re-configure the mouse sending a command (see function
m560_send_config_command()). After this command the mouse sends some
useful data when the buttons are pressed and/or released.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 drivers/hid/hid-logitech-hidpp.c | 241 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b3cf6fd..2275f2a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -40,8 +40,9 @@ MODULE_PARM_DESC(disable_raw_mode,
 #define HIDPP_REPORT_LONG_LENGTH		20
 
 #define HIDPP_QUIRK_CLASS_WTP			BIT(0)
+#define HIDPP_QUIRK_CLASS_M560			BIT(1)
 
-/* bits 1..20 are reserved for classes */
+/* bits 2..20 are reserved for classes */
 #define HIDPP_QUIRK_DELAYED_INIT		BIT(21)
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_MULTI_INPUT			BIT(23)
@@ -941,6 +942,221 @@ static int wtp_connect(struct hid_device *hdev, bool connected)
 			true, true);
 }
 
+/*
+ * copied from hid-core.c
+ */
+static u32 hidpp_extract(u8 *report, unsigned offset, unsigned n)
+{
+	u64 x;
+
+	report += offset >> 3;  /* adjust byte index */
+	offset &= 7;            /* now only need bit offset into one byte */
+	x = get_unaligned_le64(report);
+	x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
+	return (u32)x;
+}
+
+/* ------------------------------------------------------------------------- */
+/* Logitech M560 devices                                                     */
+/* ------------------------------------------------------------------------- */
+
+/*
+ * Logitech M560 protocol overview
+ *
+ * The Logitech M560 mouse, is designed for windows 8. When the middle and/or
+ * the sides buttons are pressed, it sends some keyboard keys events
+ * instead of buttons ones.
+ * To complicate things further, the middle button keys sequence
+ * is different from the odd press and the even press.
+ *
+ * forward button -> Super_R
+ * backward button -> Super_L+'d' (press only)
+ * middle button -> 1st time: Alt_L+SuperL+XF86TouchpadOff (press only)
+ *                  2nd time: left-click (press only)
+ * NB: press-only means that when the button is pressed, the
+ * KeyPress/ButtonPress and KeyRelease/ButtonRelease events are generated
+ * together sequentially; instead when the button is released, no event is
+ * generated !
+ *
+ * With the command
+ *	10<xx>0a 3500af03 (where <xx> is the mouse id),
+ * the mouse reacts differently:
+ * - it never sends a keyboard key event
+ * - for the three mouse button it sends:
+ *	middle button               press   11<xx>0a 3500af00...
+ *	side 1 button (forward)     press   11<xx>0a 3500b000...
+ *	side 2 button (backward)    press   11<xx>0a 3500ae00...
+ *	middle/side1/side2 button   release 11<xx>0a 35000000...
+ */
+
+static const u8 m560_config_parameter[] = {0x00, 0xaf, 0x03};
+
+struct m560_private_data {
+	struct input_dev *input;
+};
+
+/* how buttons are mapped in the report */
+#define M560_MOUSE_BTN_LEFT		0x01
+#define M560_MOUSE_BTN_RIGHT		0x02
+#define M560_MOUSE_BTN_WHEEL_LEFT	0x08
+#define M560_MOUSE_BTN_WHEEL_RIGHT	0x10
+
+#define M560_SUB_ID			0x0a
+#define M560_BUTTON_MODE_REGISTER	0x35
+
+static int m560_send_config_command(struct hid_device *hdev, bool connected)
+{
+	struct hidpp_report response;
+	struct hidpp_device *hidpp_dev;
+
+	hidpp_dev = hid_get_drvdata(hdev);
+
+	if (!connected)
+		return -ENODEV;
+
+	return hidpp_send_rap_command_sync(
+		hidpp_dev,
+		REPORT_ID_HIDPP_SHORT,
+		M560_SUB_ID,
+		M560_BUTTON_MODE_REGISTER,
+		(u8 *)m560_config_parameter,
+		sizeof(m560_config_parameter),
+		&response
+	);
+}
+
+static int m560_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct m560_private_data *d;
+
+	d = devm_kzalloc(&hdev->dev, sizeof(struct m560_private_data),
+			GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	hidpp->private_data = d;
+
+	return 0;
+};
+
+static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct m560_private_data *mydata = hidpp->private_data;
+
+	/* sanity check */
+	if (!mydata || !mydata->input) {
+		hid_err(hdev, "error in parameter\n");
+		return -EINVAL;
+	}
+
+	if (size < 7) {
+		hid_err(hdev, "error in report\n");
+		return 0;
+	}
+
+	if (data[0] == REPORT_ID_HIDPP_LONG &&
+	    data[2] == M560_SUB_ID && data[6] == 0x00) {
+		/*
+		 * m560 mouse report for middle, forward and backward button
+		 *
+		 * data[0] = 0x11
+		 * data[1] = device-id
+		 * data[2] = 0x0a
+		 * data[5] = 0xaf -> middle
+		 *	     0xb0 -> forward
+		 *	     0xae -> backward
+		 *	     0x00 -> release all
+		 * data[6] = 0x00
+		 */
+
+		switch (data[5]) {
+		case 0xaf:
+			input_report_key(mydata->input, BTN_MIDDLE, 1);
+			break;
+		case 0xb0:
+			input_report_key(mydata->input, BTN_FORWARD, 1);
+			break;
+		case 0xae:
+			input_report_key(mydata->input, BTN_BACK, 1);
+			break;
+		case 0x00:
+			input_report_key(mydata->input, BTN_BACK, 0);
+			input_report_key(mydata->input, BTN_FORWARD, 0);
+			input_report_key(mydata->input, BTN_MIDDLE, 0);
+			break;
+		default:
+			hid_err(hdev, "error in report\n");
+			return 0;
+		}
+		input_sync(mydata->input);
+
+	} else if (data[0] == 0x02) {
+		/*
+		 * Logitech M560 mouse report
+		 *
+		 * data[0] = type (0x02)
+		 * data[1..2] = buttons
+		 * data[3..5] = xy
+		 * data[6] = wheel
+		 */
+
+		int v;
+
+		input_report_key(mydata->input, BTN_LEFT,
+			!!(data[1] & M560_MOUSE_BTN_LEFT));
+		input_report_key(mydata->input, BTN_RIGHT,
+			!!(data[1] & M560_MOUSE_BTN_RIGHT));
+
+		if (data[1] & M560_MOUSE_BTN_WHEEL_LEFT)
+			input_report_rel(mydata->input, REL_HWHEEL, -1);
+		else if (data[1] & M560_MOUSE_BTN_WHEEL_RIGHT)
+			input_report_rel(mydata->input, REL_HWHEEL, 1);
+
+		v = hid_snto32(hidpp_extract(data+3, 0, 12), 12);
+		input_report_rel(mydata->input, REL_X, v);
+
+		v = hid_snto32(hidpp_extract(data+3, 12, 12), 12);
+		input_report_rel(mydata->input, REL_Y, v);
+
+		v = hid_snto32(data[6], 8);
+		input_report_rel(mydata->input, REL_WHEEL, v);
+
+		input_sync(mydata->input);
+	}
+
+	return 1;
+}
+
+static void m560_populate_input(struct hidpp_device *hidpp,
+		struct input_dev *input_dev, bool origin_is_hid_core)
+{
+	struct m560_private_data *mydata = hidpp->private_data;
+
+	mydata->input = input_dev;
+
+	__set_bit(EV_KEY, mydata->input->evbit);
+	__set_bit(BTN_MIDDLE, mydata->input->keybit);
+	__set_bit(BTN_RIGHT, mydata->input->keybit);
+	__set_bit(BTN_LEFT, mydata->input->keybit);
+	__set_bit(BTN_BACK, mydata->input->keybit);
+	__set_bit(BTN_FORWARD, mydata->input->keybit);
+
+	__set_bit(EV_REL, mydata->input->evbit);
+	__set_bit(REL_X, mydata->input->relbit);
+	__set_bit(REL_Y, mydata->input->relbit);
+	__set_bit(REL_WHEEL, mydata->input->relbit);
+	__set_bit(REL_HWHEEL, mydata->input->relbit);
+}
+
+static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	return -1;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -953,6 +1169,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_input_mapping(hdev, hi, field, usage, bit, max);
+	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
+			field->application != HID_GD_MOUSE)
+		return m560_input_mapping(hdev, hi, field, usage, bit, max);
 
 	return 0;
 }
@@ -962,6 +1181,8 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 {
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
+	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
+		m560_populate_input(hidpp, input, origin_is_hid_core);
 }
 
 static void hidpp_input_configured(struct hid_device *hdev,
@@ -1049,6 +1270,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
+	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
+		return m560_raw_event(hdev, data, size);
 
 	return 0;
 }
@@ -1126,6 +1349,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		ret = wtp_connect(hdev, connected);
 		if (ret)
 			return;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560) {
+		ret = m560_send_config_command(hdev, connected);
+		if (ret)
+			return;
 	}
 
 	if (!connected || hidpp->delayed_input)
@@ -1201,7 +1428,11 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_allocate(hdev, id);
 		if (ret)
-			goto wtp_allocate_fail;
+			goto allocate_fail;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560) {
+		ret = m560_allocate(hdev);
+		if (ret)
+			goto allocate_fail;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
@@ -1268,7 +1499,7 @@ hid_hw_start_fail:
 hid_parse_fail:
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
-wtp_allocate_fail:
+allocate_fail:
 	hid_set_drvdata(hdev, NULL);
 	return ret;
 }
@@ -1301,6 +1532,10 @@ static const struct hid_device_id hidpp_devices[] = {
 		USB_VENDOR_ID_LOGITECH, 0x4102),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
 			 HIDPP_QUIRK_CLASS_WTP },
+	{ /* Mouse logitech M560 */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x402d),
+	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.1.4

