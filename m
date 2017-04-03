From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 3/4] hid-logitech-hidpp: add support for high res wheel
Date: Mon,  3 Apr 2017 16:35:31 -0300
Message-ID: <beaf4d8c0c84335b7323a5cf1754cc8cbdf694cf.1491247515.git.mchehab@s-opensource.com>
References: <cover.1491247515.git.mchehab@s-opensource.com>
 <61af20504c6b06adfb523ae4d734cbda6b6ff545.1491247515.git.mchehab@s-opensource.com>
 <d97a4e2f927e36a29d3f41c5e19f87e26db90509.1491247515.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdDCTfy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 15:35:54 -0400
In-Reply-To: <d97a4e2f927e36a29d3f41c5e19f87e26db90509.1491247515.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491247515.git.mchehab@s-opensource.com>
References: <cover.1491247515.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Some Logitech mouses (MX Anyware 2 and MX Master) have support
for a high-resolution wheel.

This wheel can work in backward-compatible mode, generating
wheel events via HID normal events, or it can use new
HID++ events that report not only the wheel movement, but also
the resolution.

Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/hid/hid-logitech-hidpp.c | 199 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2e2515a4c070..c208a5107511 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
+#define HIDPP_QUIRK_HIRES_SCROLL		BIT(25)
 
 #define HIDPP_QUIRK_DELAYED_INIT		(HIDPP_QUIRK_NO_HIDINPUT | \
 						 HIDPP_QUIRK_CONNECT_EVENTS)
@@ -1361,6 +1362,67 @@ static int hidpp_ff_deinit(struct hid_device *hid)
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x2121: High Resolution Wheel                                              */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_HIGH_RES_WHEEL		0x2121
+
+#define CMD_MOUSE_SET_WHEEL_MODE	0x20
+#define CMD_MOUSE_GET_WHEEL_RATCHET	0x30
+
+struct high_res_wheel_data {
+	u8 feature_index;
+	struct input_dev *input;
+	bool ratchet;
+};
+
+/**
+ * hidpp_mouse_set_wheel_mode - Sets high resolution wheel mode
+ *
+ * @invert:	if true, inverts wheel movement
+ * @high_res:	if true, wheel is in high-resolution mode. Otherwise, low res
+ * @hidpp:	if true, report wheel events via HID++ notification. If false,
+ *		use standard HID events
+ */
+static int hidpp_mouse_set_wheel_mode(struct hidpp_device *hidpp,
+				      bool invert,
+				      bool high_res,
+				      bool hidpp_mode)
+{
+	struct high_res_wheel_data *hrd = hidpp->private_data;
+	u8 feature_type;
+	struct hidpp_report response;
+	int ret;
+	u8 params[16] = { 0 };
+
+	if (!hrd->feature_index) {
+		ret = hidpp_root_get_feature(hidpp,
+					    HIDPP_HIGH_RES_WHEEL,
+					    &hrd->feature_index,
+					    &feature_type);
+		if (ret)
+			/* means that the device is not powered up */
+			return ret;
+	}
+
+	params[0] = invert     ? 0x4 : 0  |
+		    high_res   ? 0x2 : 0  |
+		    hidpp_mode ? 0x1 : 0;
+
+	ret = hidpp_send_fap_command_sync(hidpp, hrd->feature_index,
+					  CMD_MOUSE_SET_WHEEL_MODE,
+					  params, 16, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	return 0;
+}
 
 /* ************************************************************************** */
 /*                                                                            */
@@ -1816,6 +1878,119 @@ static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 }
 
 /* ------------------------------------------------------------------------- */
+/* Logitech mouse devices with high resolution wheel                         */
+/* ------------------------------------------------------------------------- */
+
+static int high_res_raw_event(struct hid_device *hdev, u8 *data, int size)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct high_res_wheel_data *hrd = hidpp->private_data;
+
+	/* Don't handle special raw events before setting feature_index */
+	if (!hrd || !hrd->feature_index)
+		return 0;
+
+	if (data[0] != REPORT_ID_HIDPP_LONG ||
+	    data[2] != hrd->feature_index)
+		return 1;
+
+	if (size < 8) {
+		hid_err(hdev, "error in report: size = %d: %*ph\n", size,
+			size, data);
+		return 0;
+	}
+
+	/*
+	 * high res wheel mouse events
+	 *
+	 * Wheel movement events are like:
+	 *
+	 * 11 03 0b 00 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
+	 *
+	 * data[0] = 0x11
+	 * data[1] = device-id
+	 * data[2] = feature index (0b)
+	 * data[3] = event type: 0x00 - wheel movement
+	 * data[4] = bitmask:
+	 *		bits 0-3: number of sampling periods combined
+	 *		bit 4:
+	 *			0 = low resolution
+	 *			1 = high resolution
+	 * data[5] - deltaV MSB
+	 * data[6] = deltaV LSB
+	 * Remaining payload is reserved
+	 *
+	 * Ratchet events are like:
+	 * 11 03 0b 10 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+	 *
+	 * data[0] = 0x11
+	 * data[1] = device-id
+	 * data[2] = feature index
+	 * data[3] = event type: 0x10 - ratchet state
+	 * data[4] = bit 0:
+	 *		1 = ratchet
+	 *		0 = free wheel
+	 * Remaining payload is reserved
+	 */
+
+	if (data[3] == 0) {
+		s16 delta = data[6] | data[5] << 8;
+		bool res = data[4] & 0x10;
+
+		/*
+		 * Report high-resolution events as REL_HWHEEL and
+		 * low-resolution events as REL_WHEEL.
+		 */
+		if (res)
+			input_report_rel(hrd->input, REL_HIRES_WHEEL, delta);
+		else
+			input_report_rel(hrd->input, REL_WHEEL, delta);
+	}
+
+	/* FIXME: also report ratchet events to userspace */
+
+	return 1;
+}
+
+static void high_res_populate_input(struct hidpp_device *hidpp,
+		struct input_dev *input_dev, bool origin_is_hid_core)
+{
+	struct high_res_wheel_data *hrd = hidpp->private_data;
+
+	hrd->input = input_dev;
+
+	__set_bit(REL_WHEEL, hrd->input->relbit);
+	__set_bit(REL_HIRES_WHEEL, hrd->input->relbit);
+}
+
+
+static int high_res_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct high_res_wheel_data *hrd;
+
+	hrd = devm_kzalloc(&hdev->dev, sizeof(struct high_res_wheel_data),
+			GFP_KERNEL);
+	if (!hrd)
+		return -ENOMEM;
+
+	hidpp->private_data = hrd;
+
+	return 0;
+};
+
+static int high_res_connect(struct hid_device *hdev, bool connected)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+
+	if (!connected)
+		return 0;
+
+	/* Enable HID++ wheel event output mode */
+	return hidpp_mouse_set_wheel_mode(hidpp, false, false, true);
+}
+
+/* ------------------------------------------------------------------------- */
 /* Logitech K400 devices                                                     */
 /* ------------------------------------------------------------------------- */
 
@@ -1955,6 +2130,9 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input, origin_is_hid_core);
+	else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL)
+		high_res_populate_input(hidpp, input, origin_is_hid_core);
+
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -2054,6 +2232,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		return m560_raw_event(hdev, data, size);
+	else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL)
+		return high_res_raw_event(hdev, data, size);
 
 	return 0;
 }
@@ -2141,6 +2321,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		ret = k400_connect(hdev, connected);
 		if (ret)
 			return;
+	} else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL) {
+		ret = high_res_connect(hdev, connected);
+		if (ret)
+			return;
 	}
 
 	if (!connected || hidpp->delayed_input)
@@ -2215,6 +2399,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
 		hidpp->quirks &= ~HIDPP_QUIRK_CONNECT_EVENTS;
 		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
+		hidpp->quirks &= ~HIDPP_QUIRK_HIRES_SCROLL;
 	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
@@ -2229,6 +2414,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = k400_allocate(hdev);
 		if (ret)
 			goto allocate_fail;
+	} else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL) {
+		ret = high_res_allocate(hdev);
+		if (ret)
+			goto allocate_fail;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
@@ -2354,6 +2543,16 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x402d),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
+	{ /* Logitech MX Master with high resolution scroll */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4041),
+	  .driver_data = HIDPP_QUIRK_CONNECT_EVENTS |
+			 HIDPP_QUIRK_HIRES_SCROLL },
+	{ /* Logitech MX Anywhere 2 with high resolution scroll */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x404a),
+	  .driver_data = HIDPP_QUIRK_CONNECT_EVENTS |
+			 HIDPP_QUIRK_HIRES_SCROLL },
 	{ /* Keyboard logitech K400 */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
-- 
2.9.3


