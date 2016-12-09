From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH 2/4] hid-lenovo: Add support for X1 Tablet cover LED control
Date: Fri, 9 Dec 2016 16:05:12 +0100
Message-ID: <ef83e1ec-48d5-a011-c95e-8dba060bc8c3@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org
List-Id: linux-input@vger.kernel.org

Add support for controlling MUTE, MICMUTE and FNLOCK LEDs.
In ordner to enable MUTE and MICMUTE LED control over thinkpad_helper
the external interface hid_lenovo_led_set is introduced.
This enables setting Lenovo LEDs from external.
This is needed because the X1 Tablet Cover is the first
thinkpad_helper controlable device which is connected via USB.
Additionally the led state is stored inside the hid-lenovo driver to
make the driver able to set the led appropriate after device attach.
---
 drivers/hid/hid-lenovo.c   | 262 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid-lenovo.h |  15 +++
 2 files changed, 277 insertions(+)
 create mode 100644 include/linux/hid-lenovo.h

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 4fc332c..2efd5b0 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -21,11 +21,27 @@
 #include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/hid-lenovo.h>
 #include <linux/input.h>
 #include <linux/leds.h>
 
 #include "hid-ids.h"
 
+struct lenovo_led_list_entry {
+	struct led_classdev *dev;
+	enum hid_lenovo_led_type type;
+	struct list_head list;
+};
+
+struct lenovo_led_type_entry {
+	struct led_classdev *dev;
+	enum hid_lenovo_led_type type;
+	struct list_head list;
+};
+
+static struct list_head hid_lenovo_leds = LIST_HEAD_INIT(hid_lenovo_leds);
+static enum led_brightness hid_lenovo_initial_leds[HID_LENOVO_LED_MAX];
+
 struct lenovo_drvdata_tpkbd {
 	int led_state;
 	struct led_classdev led_mute;
@@ -44,6 +60,44 @@ struct lenovo_drvdata_cptkbd {
 	int sensitivity;
 };
 
+struct lenovo_drvdata_tpx1cover {
+	uint16_t led_state;
+	uint8_t fnlock_state;
+	uint8_t led_present;
+	struct led_classdev led_mute;
+	struct led_classdev led_micmute;
+	struct led_classdev led_fnlock;
+};
+
+int hid_lenovo_led_set(enum hid_lenovo_led_type led, bool on)
+{
+	struct led_classdev *dev = NULL;
+	struct lenovo_led_list_entry *entry;
+
+	if (led >= HID_LENOVO_LED_MAX)
+		return -EINVAL;
+
+	hid_lenovo_initial_leds[led] = on ? LED_FULL : LED_OFF;
+
+	list_for_each_entry(entry, &hid_lenovo_leds, list) {
+		if (entry->type == led) {
+			dev = entry->dev;
+			break;
+		}
+	}
+
+	if (!dev)
+		return -ENODEV;
+
+	if (!dev->brightness_set)
+		return -ENODEV;
+
+	dev->brightness_set(dev, on ? LED_FULL : LED_OFF);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hid_lenovo_led_set);
+
 #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
 static const __u8 lenovo_pro_dock_need_fixup_collection[] = {
@@ -416,6 +470,62 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 	return 0;
 }
 
+static enum led_brightness lenovo_led_brightness_get_tpx1cover(
+			struct led_classdev *led_cdev)
+{
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
+	enum hid_lenovo_led_type led;
+
+	if (led_cdev == &drv_data->led_mute)
+		led = HID_LENOVO_LED_MUTE;
+	else if (led_cdev == &drv_data->led_micmute)
+		led = HID_LENOVO_LED_MICMUTE;
+	else if (led_cdev == &drv_data->led_fnlock)
+		led = HID_LENOVO_LED_FNLOCK;
+	else
+		return LED_OFF;
+
+	return drv_data->led_state & (1 << led)
+				? LED_FULL
+				: LED_OFF;
+}
+
+static void lenovo_led_brightness_set_tpx1cover(struct led_classdev *led_cdev,
+			enum led_brightness value)
+{
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
+	struct hid_report *report;
+	enum hid_lenovo_led_type led;
+
+	if (led_cdev == &drv_data->led_mute) {
+		led = HID_LENOVO_LED_MUTE;
+	} else if (led_cdev == &drv_data->led_micmute) {
+		led = HID_LENOVO_LED_MICMUTE;
+	} else if (led_cdev == &drv_data->led_fnlock) {
+		led = HID_LENOVO_LED_FNLOCK;
+	} else {
+		hid_warn(hdev, "Invalid LED to set.\n");
+		return;
+	}
+
+	if (value == LED_OFF)
+		drv_data->led_state &= ~(1 << led);
+	else
+		drv_data->led_state |= 1 << led;
+
+	report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[9];
+	if (report) {
+		report->field[0]->value[0] = ((led + 1) << 4) | 0x44;
+		report->field[0]->value[1] = (drv_data->led_state & (1 << led))
+			? 0x02 : 0x01;
+		hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
+	}
+}
+
 static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -788,6 +898,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 static int lenovo_probe_tpx1cover_configure(struct hid_device *hdev)
 {
 	struct hid_report *report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[9];
+	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
 
 	if (!report)
 		return -ENOENT;
@@ -807,14 +918,33 @@ static int lenovo_probe_tpx1cover_configure(struct hid_device *hdev)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 	hid_hw_wait(hdev);
 
+	lenovo_led_brightness_set_tpx1cover(&drv_data->led_mute,
+		hid_lenovo_initial_leds[HID_LENOVO_LED_MUTE]);
+
+	hid_hw_wait(hdev);
+
+	lenovo_led_brightness_set_tpx1cover(&drv_data->led_micmute,
+		hid_lenovo_initial_leds[HID_LENOVO_LED_MICMUTE]);
+	hid_hw_wait(hdev);
+
+	lenovo_led_brightness_set_tpx1cover(&drv_data->led_fnlock, LED_FULL);
+
 	return 0;
 }
 
 static int lenovo_probe_tpx1cover_special_functions(struct hid_device *hdev)
 {
+	struct device *dev = &hdev->dev;
+	struct lenovo_drvdata_tpx1cover *drv_data = NULL;
+	struct lenovo_led_list_entry *mute_entry = NULL;
+	struct lenovo_led_list_entry *micmute_entry = NULL;
+	struct lenovo_led_list_entry *fnlock_entry = NULL;
+
 	struct hid_report *report;
 	bool report_match = 1;
 
+	int ret = 0;
+
 	/* Used for LED control */
 	report = hid_validate_values(hdev, HID_INPUT_REPORT, 3, 0, 16);
 	report_match &= report ? 1 : 0;
@@ -825,7 +955,97 @@ static int lenovo_probe_tpx1cover_special_functions(struct hid_device *hdev)
 	if (!report_match)
 		return -ENODEV;
 
+	drv_data = devm_kzalloc(&hdev->dev,
+			sizeof(struct lenovo_drvdata_tpx1cover),
+			GFP_KERNEL);
+
+	if (!drv_data) {
+		hid_err(hdev,
+			"Could not allocate memory for tpx1cover driver data\n");
+		return -ENOMEM;
+	}
+
+	mute_entry = kzalloc(sizeof(*mute_entry), GFP_KERNEL);
+	if (!mute_entry) {
+		hid_err(hdev, "Could not allocate memory for led mute entry\n");
+		ret = -ENOMEM;
+		goto err_cleanup;
+	}
+	drv_data->led_mute.name = "MUTE_LED";
+	drv_data->led_mute.brightness_get = lenovo_led_brightness_get_tpx1cover;
+	drv_data->led_mute.brightness_set = lenovo_led_brightness_set_tpx1cover;
+	devm_led_classdev_register(dev, &drv_data->led_mute);
+
+	INIT_LIST_HEAD(&mute_entry->list);
+	mute_entry->dev = &drv_data->led_mute;
+	mute_entry->type = HID_LENOVO_LED_MUTE;
+	list_add_tail(&mute_entry->list, &hid_lenovo_leds);
+
+
+	micmute_entry = kzalloc(sizeof(*micmute_entry), GFP_KERNEL);
+	if (!micmute_entry) {
+		hid_err(hdev, "Could not allocate memory for led micmute entry\n");
+		ret = -ENOMEM;
+		goto err_cleanup;
+	}
+
+	drv_data->led_micmute.name = "MICMUTE_LED";
+	drv_data->led_micmute.brightness_get = lenovo_led_brightness_get_tpx1cover;
+	drv_data->led_micmute.brightness_set = lenovo_led_brightness_set_tpx1cover;
+	devm_led_classdev_register(dev, &drv_data->led_micmute);
+
+	INIT_LIST_HEAD(&micmute_entry->list);
+	micmute_entry->dev = &drv_data->led_micmute;
+	micmute_entry->type = HID_LENOVO_LED_MICMUTE;
+	list_add_tail(&micmute_entry->list, &hid_lenovo_leds);
+
+
+	fnlock_entry = kzalloc(sizeof(*fnlock_entry), GFP_KERNEL);
+	if (!fnlock_entry) {
+		hid_err(hdev, "Could not allocate memory for led fnlock entry\n");
+		ret = -ENOMEM;
+		goto err_cleanup;
+	}
+
+	drv_data->led_fnlock.brightness_get = lenovo_led_brightness_get_tpx1cover;
+	drv_data->led_fnlock.brightness_set = lenovo_led_brightness_set_tpx1cover;
+	drv_data->led_fnlock.name = "FNLOCK_LED";
+	devm_led_classdev_register(dev, &drv_data->led_fnlock);
+
+	INIT_LIST_HEAD(&fnlock_entry->list);
+	fnlock_entry->dev = &drv_data->led_fnlock;
+	fnlock_entry->type = HID_LENOVO_LED_FNLOCK;
+	list_add_tail(&fnlock_entry->list, &hid_lenovo_leds);
+
+
+	drv_data->led_state = 0;
+	drv_data->fnlock_state = 1;
+	drv_data->led_present = 1;
+
+	hid_set_drvdata(hdev, drv_data);
+
 	return lenovo_probe_tpx1cover_configure(hdev);
+
+err_cleanup:
+	if (mute_entry) {
+		list_del(&mute_entry->list);
+		kfree (mute_entry);
+	}
+
+	if (micmute_entry) {
+		list_del(&micmute_entry->list);
+		kfree (micmute_entry);
+	}
+
+	if (fnlock_entry) {
+		list_del(&fnlock_entry->list);
+		kfree (fnlock_entry);
+	}
+
+	if (drv_data)
+		kfree(drv_data);
+
+	return ret;
 }
 
 static int lenovo_probe_tpx1cover_touch(struct hid_device *hdev)
@@ -846,6 +1066,7 @@ static int lenovo_probe_tpx1cover_touch(struct hid_device *hdev)
 
 static int lenovo_probe_tpx1cover_keyboard(struct hid_device *hdev)
 {
+	struct lenovo_drvdata_tpx1cover *drv_data;
 	struct hid_report *report;
 	bool report_match = 1;
 	int ret = 0;
@@ -860,6 +1081,21 @@ static int lenovo_probe_tpx1cover_keyboard(struct hid_device *hdev)
 	if (!report_match)
 		ret = -ENODEV;
 
+	drv_data = devm_kzalloc(&hdev->dev,
+				sizeof(struct lenovo_drvdata_tpx1cover),
+				GFP_KERNEL);
+
+	if (!drv_data) {
+		hid_err(hdev,
+			"Could not allocate memory for tpx1cover driver data\n");
+		return -ENOMEM;
+	}
+
+	drv_data->led_state = 0;
+	drv_data->led_present = 0;
+	drv_data->fnlock_state = 0;
+	hid_set_drvdata(hdev, drv_data);
+
 	return ret;
 }
 
@@ -1001,6 +1237,29 @@ static void lenovo_remove_cptkbd(struct hid_device *hdev)
 			&lenovo_attr_group_cptkbd);
 }
 
+static void lenovo_remove_tpx1cover(struct hid_device *hdev)
+{
+	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
+	struct lenovo_led_list_entry *entry, *head;
+
+	if (!drv_data)
+		return;
+
+	if (drv_data->led_present) {
+		list_for_each_entry_safe(entry, head, &hid_lenovo_leds, list) {
+			if (entry->dev == &drv_data->led_fnlock
+				|| entry->dev == &drv_data->led_micmute
+				|| entry->dev == &drv_data->led_mute) {
+
+				list_del(&entry->list);
+				kfree(entry);
+			}
+		}
+	}
+
+	hid_set_drvdata(hdev, NULL);
+}
+
 static void lenovo_remove(struct hid_device *hdev)
 {
 	switch (hdev->product) {
@@ -1011,6 +1270,9 @@ static void lenovo_remove(struct hid_device *hdev)
 	case USB_DEVICE_ID_LENOVO_CBTKBD:
 		lenovo_remove_cptkbd(hdev);
 		break;
+	case USB_DEVICE_ID_LENOVO_X1_COVER:
+		lenovo_remove_tpx1cover(hdev);
+		break;
 	}
 
 	hid_hw_stop(hdev);
diff --git a/include/linux/hid-lenovo.h b/include/linux/hid-lenovo.h
new file mode 100644
index 0000000..00eb140
--- /dev/null
+++ b/include/linux/hid-lenovo.h
@@ -0,0 +1,15 @@
+
+#ifndef __HID_LENOVO_H__
+#define __HID_LENOVO_H__
+
+
+enum hid_lenovo_led_type {
+	HID_LENOVO_LED_FNLOCK = 0,
+	HID_LENOVO_LED_MUTE,
+	HID_LENOVO_LED_MICMUTE,
+	HID_LENOVO_LED_MAX
+};
+
+int hid_lenovo_led_set(enum hid_lenovo_led_type led, bool on);
+
+#endif /* __HID_LENOVO_H_ */
-- 
1.9.1
