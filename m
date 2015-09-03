From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: logitech-hidpp: add support to disable tap-to-click on the K400
Date: Thu,  3 Sep 2015 09:08:30 -0400
Message-ID: <1441285710-21276-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43452 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031AbbICNIf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Sep 2015 09:08:35 -0400
In-Reply-To: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: simon@mungewell.org, BALATON Zoltan <balaton@eik.bme.hu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

The Logitech K400 keyboard has an embedded touchpad which is seen as a
mouse from the OS point of view. There is a hardware shortcut to disable
tap-to-click but the setting is not remembered accross reset, annoying
some users.

We can toggle this feature from the host by using the feature 0x6010:
Touchpad FW items

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 133 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 81d1bc0..452e5d5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -33,6 +33,11 @@ module_param(disable_raw_mode, bool, 0644);
 MODULE_PARM_DESC(disable_raw_mode,
 	"Disable Raw mode reporting for touchpads and keep firmware gestures.");
 
+static bool disable_tap_to_click;
+module_param(disable_tap_to_click, bool, 0644);
+MODULE_PARM_DESC(disable_tap_to_click,
+	"Disable Tap-To-Click mode reporting for touchpads (only on the K400 currently).");
+
 #define REPORT_ID_HIDPP_SHORT			0x10
 #define REPORT_ID_HIDPP_LONG			0x11
 
@@ -41,6 +46,7 @@ MODULE_PARM_DESC(disable_raw_mode,
 
 #define HIDPP_QUIRK_CLASS_WTP			BIT(0)
 #define HIDPP_QUIRK_CLASS_M560			BIT(1)
+#define HIDPP_QUIRK_CLASS_K400			BIT(2)
 
 /* bits 2..20 are reserved for classes */
 #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21)
@@ -557,6 +563,52 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 }
 
 /* -------------------------------------------------------------------------- */
+/* 0x6010: Touchpad FW items                                                  */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_TOUCHPAD_FW_ITEMS			0x6010
+
+#define CMD_TOUCHPAD_FW_ITEMS_SET			0x10
+
+struct hidpp_touchpad_fw_items {
+	uint8_t presence;
+	uint8_t desired_state;
+	uint8_t state;
+	uint8_t persistent;
+};
+
+/**
+ * send a set state command to the device by reading the current items->state
+ * field. items is then filled with the current state.
+ */
+static int hidpp_touchpad_fw_items_set(struct hidpp_device *hidpp,
+				       u8 feature_index,
+				       struct hidpp_touchpad_fw_items *items)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 *params = (u8 *)response.fap.params;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+		CMD_TOUCHPAD_FW_ITEMS_SET, &items->state, 1, &response);
+
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	items->presence = params[0];
+	items->desired_state = params[1];
+	items->state = params[2];
+	items->persistent = params[3];
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
 /* 0x6100: TouchPadRawXY                                                      */
 /* -------------------------------------------------------------------------- */
 
@@ -1136,6 +1188,75 @@ static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return -1;
 }
 
+/* ------------------------------------------------------------------------- */
+/* Logitech K400 devices                                                     */
+/* ------------------------------------------------------------------------- */
+
+/*
+ * The Logitech K400 keyboard has an embedded touchpad which is seen
+ * as a mouse from the OS point of view. There is a hardware shortcut to disable
+ * tap-to-click but the setting is not remembered accross reset, annoying some
+ * users.
+ *
+ * We can toggle this feature from the host by using the feature 0x6010:
+ * Touchpad FW items
+ */
+
+struct k400_private_data {
+	u8 feature_index;
+};
+
+static int k400_disable_tap_to_click(struct hidpp_device *hidpp)
+{
+	struct k400_private_data *k400 = hidpp->private_data;
+	struct hidpp_touchpad_fw_items items = {};
+	int ret;
+	u8 feature_type;
+
+	if (!k400->feature_index) {
+		ret = hidpp_root_get_feature(hidpp,
+			HIDPP_PAGE_TOUCHPAD_FW_ITEMS,
+			&k400->feature_index, &feature_type);
+		if (ret)
+			/* means that the device is not powered up */
+			return ret;
+	}
+
+	ret = hidpp_touchpad_fw_items_set(hidpp, k400->feature_index, &items);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int k400_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct k400_private_data *k400;
+
+	k400 = devm_kzalloc(&hdev->dev, sizeof(struct k400_private_data),
+			    GFP_KERNEL);
+	if (!k400)
+		return -ENOMEM;
+
+	hidpp->private_data = k400;
+
+	return 0;
+};
+
+static int k400_connect(struct hid_device *hdev, bool connected)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+
+	if (!connected)
+		return 0;
+
+	if (!disable_tap_to_click)
+		return 0;
+
+	return k400_disable_tap_to_click(hidpp);
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -1332,6 +1453,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		ret = m560_send_config_command(hdev, connected);
 		if (ret)
 			return;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_K400) {
+		ret = k400_connect(hdev, connected);
+		if (ret)
+			return;
 	}
 
 	if (!connected || hidpp->delayed_input)
@@ -1416,6 +1541,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = m560_allocate(hdev);
 		if (ret)
 			goto allocate_fail;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_K400) {
+		ret = k400_allocate(hdev);
+		if (ret)
+			goto allocate_fail;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
@@ -1510,6 +1639,10 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x402d),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
+	{ /* Keyboard logitech K400 */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4024),
+	  .driver_data = HIDPP_QUIRK_CONNECT_EVENTS | HIDPP_QUIRK_CLASS_K400 },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.4.3

