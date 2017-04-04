From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 36/37] hid-logitech-hidpp: add support for high res wheel
Date: Tue,  4 Apr 2017 09:22:36 -0300
Message-ID: <222928e1897ef65d377872a13f9225d8619302de.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491308444.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491308444.git.mchehab@s-opensource.com>
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
 <55d263f13237495276213de295ae1c6d67f0588b.1491308444.git.mchehab@s-opensource.com>
 <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491308444.git.mchehab@s-opensource.com>
 <a6e09069e3a232652651c2aac6d0906e728422e2.1491308444.git.mchehab@s-opensource.com>
 <a016a7ed8bf8b5e9f292f188c0763a15937c28c5.1491308444.git.mchehab@s-opensource.com>
 <178fde32a3be0f5b05dc60787f6a96c704960bbb.1491308444.git.mchehab@s-opensource.com>
 <c0f94891efafd6b7c18766ce3e42b82cf805f813.1491308444.git.mchehab@s-opensource.com>
 <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34666
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753842AbdDDMXV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:21 -0400
In-Reply-To: <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

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

