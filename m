From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH 1/4] hid-lenovo: Add support for X1 Tablet cover special keys
Date: Fri, 9 Dec 2016 16:04:35 +0100
Message-ID: <c1f11a2a-caf7-df32-a649-531875ab727b@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org
List-Id: linux-input@vger.kernel.org

The Lenovo X1 Tablet Cover is connected via USB. It constists of
1 usb device with 3 usb interfaces. Interface 0 represents keyboard,
interface 1 the function / special keys and LED control, interface 2
is the Synaptics touchpad and pointing stick.

This patch will introduce the function / special keys handling of
USB interface 1.
---
 drivers/hid/hid-core.c   |   1 +
 drivers/hid/hid-ids.h    |   1 +
 drivers/hid/hid-lenovo.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cff060b..5b38afc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1932,6 +1932,7 @@ void hid_disconnect(struct hid_device *hdev)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ec277b9..961ee4f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -623,6 +623,7 @@
 #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
 #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
+#define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 1ac4ff4..4fc332c 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -3,9 +3,11 @@
  *  - ThinkPad USB Keyboard with TrackPoint (tpkbd)
  *  - ThinkPad Compact Bluetooth Keyboard with TrackPoint (cptkbd)
  *  - ThinkPad Compact USB Keyboard with TrackPoint (cptkbd)
+ *  - ThinkPad X1 Cover USB Keyboard with TrackPoint and Touchpad (tpx1cover)
  *
  *  Copyright (c) 2012 Bernhard Seibold
  *  Copyright (c) 2014 Jamie Lentin <jm@lentin.co.uk>
+ *  Copyright (c) 2016 Dennis Wassenberg <dennis.wassenberg@secunet.com>
  */
 
 /*
@@ -86,6 +88,55 @@ static int lenovo_input_mapping_tpkbd(struct hid_device *hdev,
 	return 0;
 }
 
+static int lenovo_input_mapping_tpx1cover(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if (usage->hid == HID_CP_CONSUMERCONTROL) {
+		/* Unknown keys -> Idenditied by usage index! */
+		switch (usage->usage_index) {
+		case 8:
+			// FNLock key
+			return -1;
+
+		case 9:
+			input_set_capability(hi->input, EV_KEY, KEY_MICMUTE);
+			map_key_clear(KEY_MICMUTE);
+			return 1;
+
+		case 10:
+			input_set_capability(hi->input, EV_KEY, KEY_CONFIG);
+			map_key_clear(KEY_CONFIG);
+			return 1;
+
+		case 11:
+			input_set_capability(hi->input, EV_KEY, KEY_SEARCH);
+			map_key_clear(KEY_SEARCH);
+			return 1;
+
+		case 12:
+			input_set_capability(hi->input, EV_KEY, KEY_SETUP);
+			map_key_clear(KEY_SETUP);
+			return 1;
+
+		case 13:
+			input_set_capability(hi->input, EV_KEY, KEY_SWITCHVIDEOMODE);
+			map_key_clear(KEY_SWITCHVIDEOMODE);
+			return 1;
+
+		case 14:
+			input_set_capability(hi->input, EV_KEY, KEY_RFKILL);
+			map_key_clear(KEY_RFKILL);
+			return 1;
+
+		}
+
+		return -1;
+	}
+
+	return 0;
+}
+
 static int lenovo_input_mapping_cptkbd(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit, int *max)
@@ -172,6 +223,9 @@ static int lenovo_input_mapping(struct hid_device *hdev,
 	case USB_DEVICE_ID_LENOVO_CBTKBD:
 		return lenovo_input_mapping_cptkbd(hdev, hi, field,
 							usage, bit, max);
+	case USB_DEVICE_ID_LENOVO_X1_COVER:
+		return lenovo_input_mapping_tpx1cover(hdev, hi, field,
+							usage, bit, max);
 	default:
 		return 0;
 	}
@@ -731,6 +785,107 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	return ret;
 }
 
+static int lenovo_probe_tpx1cover_configure(struct hid_device *hdev)
+{
+	struct hid_report *report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[9];
+
+	if (!report)
+		return -ENOENT;
+
+	report->field[0]->value[0] = 0x54;
+	report->field[0]->value[1] = 0x20;
+	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
+	hid_hw_wait(hdev);
+
+	report->field[0]->value[0] = 0x54;
+	report->field[0]->value[1] = 0x08;
+	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
+	hid_hw_wait(hdev);
+
+	report->field[0]->value[0] = 0xA0;
+	report->field[0]->value[1] = 0x02;
+	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
+	hid_hw_wait(hdev);
+
+	return 0;
+}
+
+static int lenovo_probe_tpx1cover_special_functions(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	bool report_match = 1;
+
+	/* Used for LED control */
+	report = hid_validate_values(hdev, HID_INPUT_REPORT, 3, 0, 16);
+	report_match &= report ? 1 : 0;
+	/* Identify USB Intf 1 which is the only one with HID_FEATURE_REPORT 100 */
+	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 100, 0, 1);
+	report_match &= report ? 1 : 0;
+
+	if (!report_match)
+		return -ENODEV;
+
+	return lenovo_probe_tpx1cover_configure(hdev);
+}
+
+static int lenovo_probe_tpx1cover_touch(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	bool report_match = 1;
+	int ret = 0;
+
+	/* Identify USB Intf 2 which is the only one with HID_FEATURE_REPORT 15 */
+	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 15, 0, 3);
+	report_match &= report ? 1 : 0;
+
+	if (!report_match)
+		ret = -ENODEV;
+
+	return ret;
+}
+
+static int lenovo_probe_tpx1cover_keyboard(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	bool report_match = 1;
+	int ret = 0;
+
+	/* Identify USB Intf0 which is the only one with HID_INPUT_REPORT 0
+	 * and HID_OUTPUT_REPORT 0 */
+	report = hid_validate_values(hdev, HID_INPUT_REPORT, 0, 0, 1);
+	report_match &= report ? 1 : 0;
+	report = hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 1);
+	report_match &= report ? 1 : 0;
+
+	if (!report_match)
+		ret = -ENODEV;
+
+	return ret;
+}
+
+static int lenovo_probe_tpx1cover(struct hid_device *hdev)
+{
+	int ret = 0;
+
+	/*
+	 * Probing for special function keys and LED control -> usb intf 1
+	 * Probing for touch input -> usb intf 2 (handled by rmi4 driver)
+	 * Other (keyboard) -> usb intf 0
+	 */
+	if (!lenovo_probe_tpx1cover_special_functions(hdev)) {
+		/* special function keys and LED control */
+		ret = 0;
+	} else if (!lenovo_probe_tpx1cover_touch(hdev)) {
+		/* handled by rmi */
+		ret = -ENODEV;
+	} else {
+		/* keyboard */
+		ret = lenovo_probe_tpx1cover_keyboard(hdev);
+	}
+
+	return ret;
+}
+
 static int lenovo_probe_cptkbd(struct hid_device *hdev)
 {
 	int ret;
@@ -803,6 +958,9 @@ static int lenovo_probe(struct hid_device *hdev,
 	case USB_DEVICE_ID_LENOVO_CBTKBD:
 		ret = lenovo_probe_cptkbd(hdev);
 		break;
+	case USB_DEVICE_ID_LENOVO_X1_COVER:
+		ret = lenovo_probe_tpx1cover(hdev);
+		break;
 	default:
 		ret = 0;
 		break;
@@ -883,6 +1041,7 @@ static int lenovo_input_configured(struct hid_device *hdev,
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
 	{ }
 };
 
@@ -902,3 +1061,4 @@ static int lenovo_input_configured(struct hid_device *hdev,
 module_hid_driver(lenovo_driver);
 
 MODULE_LICENSE("GPL");
+
-- 
1.9.1
