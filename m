From: Sean Young <sean@mess.org>
Subject: [PATCH v2] HID: Add support for pressure sensitive buttons
Date: Tue, 15 Nov 2011 21:40:19 +0000
Message-ID: <1321393219-19394-1-git-send-email-sean@mess.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pequod.mess.org ([188.220.58.213]:43856 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932570Ab1KOVkz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 16:40:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, simon@mungewell.org, Sean Young <sean@mess.org>

This driver needs drvdata for each input device, but this has already
been used for storing a pointer to the hid device. The drvdata of the
hid device could be used if there was one for each input device, but
this is not so (HID_QUIRK_MULTI_INPUT with up to four ports). So I've
reused the private data of the forced feedback to store the data.

Signed-off-by: Sean Young <sean@mess.org>
---
v2:
 - Explaining what the device is being instructed to do more exactly
 - Fix comment style
 - Add documentation for sysfs attributes in Documentation/ABI

Note:
 - With the documented fields, do we need the available_* sysfs attributes?
 - Is using the same hid report from force feedback and sysfs racey?

 Documentation/ABI/testing/sysfs-driver-hid-sjoy |   25 +++
 drivers/hid/Kconfig                             |    3 +-
 drivers/hid/hid-sjoy.c                          |  241 ++++++++++++++++++++++-
 drivers/input/ff-memless.c                      |    8 +
 include/linux/input.h                           |    1 +
 5 files changed, 273 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-sjoy

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-sjoy b/Documentation/ABI/testing/sysfs-driver-hid-sjoy
new file mode 100644
index 0000000..63845c7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-sjoy
@@ -0,0 +1,25 @@
+What:		/sys/bus/hid/drivers/hid-sjoy/<dev>/controller_mode
+What:		/sys/bus/hid/drivers/hid-sjoy/<dev>/available_controller_modes
+Date		November 2011
+KernelVersion:	3.3
+Contact:	Sean Young <sean@mess.org>
+Description:	available_controller_modes lists the available modes:
+		auto	 : analog sticks can be enabled or disabled on
+			   the controler itself with the analog button (default)
+		digital	 : disable analog sticks, analog button does not work
+		analog	 : enable analog sticks, analog button does not work
+		pressure : enable analog sticks and two buttons as pressure
+			   sensitive buttons, analog button does not work
+
+What:		/sys/bus/hid/drivers/hid-sjoy/<dev>/pressure_button_0
+What:		/sys/bus/hid/drivers/hid-sjoy/<dev>/pressure_button_1
+What:		/sys/bus/hid/drivers/hid-sjoy/<dev>/available_pressure_buttons
+Date		November 2011
+KernelVersion:	3.3
+Contact:	Sean Young <sean@mess.org>
+Description:	Only two buttons can be configured to read pressure
+		sensitivity. The available buttons are listed in
+		available_pressure_buttons: triangle circle cross square l1
+		r1 l2 r2. Note that the two buttons must be different.
+
+		The default buttons are cross and square.
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4d07288..92b1e9c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -549,8 +549,7 @@ config HID_SMARTJOYPLUS
 	Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
 	Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
 
-	Note that DDR (Dance Dance Revolution) mode is not supported, nor
-	is pressure sensitive buttons on the pro models.
+	Note that DDR (Dance Dance Revolution) mode is not supported.
 
 config SMARTJOYPLUS_FF
 	bool "SmartJoy PLUS PS2/USB adapter force feedback support"
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 670da91..cd9ef2a 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -35,10 +35,31 @@
 #ifdef CONFIG_SMARTJOYPLUS_FF
 #include "usbhid/usbhid.h"
 
+enum mode {
+	MODE_AUTO,
+	MODE_ANALOG,
+	MODE_DIGITAL,
+	MODE_PRESSURE
+};
+
+static const char * const mode_names[] = {
+	"auto", "analog", "digital", "pressure"
+};
+
+static const char * const button_names[] = {
+	"triangle", "circle", "cross", "square", "l1", "r1", "l2", "r2"
+};
+
 struct sjoyff_device {
 	struct hid_report *report;
+	enum mode mode;
+	int buttons[2];
 };
 
+/*
+ * The dual shock controller has two vibration feedback motors, one weak
+ * and one strong. The weak one only can only be turned on or off.
+ */
 static int hid_sjoyff_play(struct input_dev *dev, void *data,
 			 struct ff_effect *effect)
 {
@@ -53,14 +74,186 @@ static int hid_sjoyff_play(struct input_dev *dev, void *data,
 	left = left * 0xff / 0xffff;
 	right = (right != 0); /* on/off only */
 
+	sjoyff->report->field[0]->value[0] = 1;
 	sjoyff->report->field[0]->value[1] = right;
 	sjoyff->report->field[0]->value[2] = left;
-	dev_dbg(&dev->dev, "running with 0x%02x 0x%02x\n", left, right);
+	dev_dbg(&dev->dev, "port %u running with 0x%02x 0x%02x\n",
+					sjoyff->report->id, left, right);
 	usbhid_submit_report(hid, sjoyff->report, USB_DIR_OUT);
 
 	return 0;
 }
 
+/*
+ * When the controller is in pressure sensitive mode, two buttons can
+ * be configured to provide pressure sensitivity. The low four bits
+ * of the second byte specify the first button and the high four bits
+ * the second button. If the third byte is 0, the buttons will no
+ * longer report digital presses, when it is 1 they will continue to
+ * report digital presses as normal as well as pressure sensitivity.
+ */
+static void hid_sjoy_set_buttons(struct device *dev)
+{
+	struct input_dev *idev = to_input_dev(dev);
+	struct sjoyff_device *sjoy = input_ff_get_data(idev);
+	struct hid_device *hid = input_get_drvdata(idev);
+	struct hid_report *report = sjoy->report;
+
+	report->field[0]->value[0] = 6;
+	report->field[0]->value[1] = sjoy->buttons[0] | (sjoy->buttons[1] << 4);
+	report->field[0]->value[2] = 1;
+	report->field[0]->value[3] = 0;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
+/*
+ * The controller can be set into different modes. In auto mode, the
+ * analog sticks can be turned on or off using the analog button on the
+ * controller. In analog mode, the analog sticks are enabled and cannot
+ * be turned off with the analog button; with digital mode, the analog
+ * sticks are turned off and cannot be enabled; in pressure mode, the
+ * analog sticks are enabled, and two buttons will report pressure
+ * sensitivity.
+ */
+static void hid_sjoy_set_mode(struct device *dev, enum mode mode)
+{
+	struct input_dev *idev = to_input_dev(dev);
+	struct sjoyff_device *sjoy = input_ff_get_data(idev);
+	struct hid_device *hid = input_get_drvdata(idev);
+	struct hid_report *report = sjoy->report;
+
+	sjoy->mode = mode;
+
+	report->field[0]->value[0] = 3;
+
+	switch (mode) {
+	case MODE_AUTO:
+		report->field[0]->value[1] = 0;
+		report->field[0]->value[2] = 2;
+		report->field[0]->value[3] = 0;
+		break;
+	case MODE_ANALOG:
+		report->field[0]->value[1] = 1;
+		report->field[0]->value[2] = 3;
+		report->field[0]->value[3] = 0;
+		break;
+	case MODE_DIGITAL:
+		report->field[0]->value[1] = 0;
+		report->field[0]->value[2] = 3;
+		report->field[0]->value[3] = 0;
+		break;
+	case MODE_PRESSURE:
+		report->field[0]->value[1] = 1;
+		report->field[0]->value[2] = 3;
+		report->field[0]->value[3] = 1;
+		break;
+	}
+
+	dev_dbg(&hid->dev, "switching port %u mode to %s\n", report->id,
+							mode_names[mode]);
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
+static ssize_t store_mode(struct device *dev, struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	int i, rc = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mode_names); i++) {
+		if (sysfs_streq(mode_names[i], buf)) {
+			hid_sjoy_set_mode(dev, i);
+			rc = count;
+			break;
+		}
+	}
+
+	return rc;
+}
+
+#define store_button(button)	\
+static ssize_t store_button_##button(struct device *dev,		\
+		struct device_attribute *attr, const char *buf, size_t count) \
+{									      \
+	struct input_dev *idev = to_input_dev(dev);			      \
+	struct sjoyff_device *sjoy = input_ff_get_data(idev);		      \
+	struct hid_device *hid = input_get_drvdata(idev);		      \
+	int i, rc = -EINVAL;						      \
+									      \
+	for (i = 0; i < ARRAY_SIZE(button_names); i++) {		      \
+		if (sysfs_streq(button_names[i], buf)) {		      \
+			if (sjoy->buttons[!button] == i)		      \
+				break;					      \
+									      \
+			dev_dbg(&hid->dev, "port %u pressure button %d: %s\n",\
+				sjoy->report->id, button, button_names[i]);   \
+			sjoy->buttons[button] = i;			      \
+			hid_sjoy_set_buttons(dev);			      \
+			rc = count;					      \
+			break;						      \
+		}							      \
+	}								      \
+									      \
+	return rc;							      \
+}									      \
+									      \
+static ssize_t show_button_##button(struct device *dev,			      \
+				struct device_attribute *attr, char *buf)     \
+{									      \
+	struct input_dev *idev = to_input_dev(dev);			      \
+	struct sjoyff_device *sjoy = input_ff_get_data(idev);		      \
+									      \
+	return snprintf(buf, PAGE_SIZE, "%s\n",				      \
+				button_names[sjoy->buttons[button]]);	      \
+}
+
+store_button(0);
+store_button(1);
+
+static ssize_t show_mode(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct input_dev *idev = to_input_dev(dev);
+	struct sjoyff_device *sjoy = input_ff_get_data(idev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", mode_names[sjoy->mode]);
+}
+
+static ssize_t show_modes(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", "auto analog digital pressure");
+}
+
+static ssize_t show_buttons(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+		"triangle circle cross square l1 r1 l2 r2");
+}
+
+static DEVICE_ATTR(pressure_button_0, S_IRUGO | S_IWUSR | S_IWGRP,
+						show_button_0, store_button_0);
+static DEVICE_ATTR(pressure_button_1, S_IRUGO | S_IWUSR | S_IWGRP,
+						show_button_1, store_button_1);
+static DEVICE_ATTR(available_pressure_buttons, S_IRUGO, show_buttons, NULL);
+static DEVICE_ATTR(controller_mode, S_IRUGO | S_IWUSR | S_IWGRP, show_mode,
+							store_mode);
+static DEVICE_ATTR(available_controller_modes, S_IRUGO, show_modes, NULL);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_controller_mode.attr,
+	&dev_attr_available_controller_modes.attr,
+	&dev_attr_pressure_button_0.attr,
+	&dev_attr_pressure_button_1.attr,
+	&dev_attr_available_pressure_buttons.attr,
+	NULL
+};
+
+static struct attribute_group sjoy_attribute_group = {
+	.attrs = sysfs_attrs
+};
+
 static int sjoyff_init(struct hid_device *hid)
 {
 	struct sjoyff_device *sjoyff;
@@ -115,17 +308,57 @@ static int sjoyff_init(struct hid_device *hid)
 		sjoyff->report->field[0]->value[1] = 0x00;
 		sjoyff->report->field[0]->value[2] = 0x00;
 		usbhid_submit_report(hid, sjoyff->report, USB_DIR_OUT);
+
+		/*
+		 * Only the pro models support changing mode, and the
+		 * same devices also have the noget quirk.
+		 */
+		if (!(hid->quirks & HID_QUIRK_NOGET))
+			continue;
+
+		if (report->field[0]->report_count < 4) {
+			hid_err(hid, "not enough values in the field\n");
+			continue;
+		}
+
+		hid_sjoy_set_mode(&dev->dev, MODE_AUTO);
+
+		sjoyff->buttons[0] = 2; /* cross */
+		sjoyff->buttons[1] = 3; /* square */
+
+		hid_sjoy_set_buttons(&dev->dev);
+
+		error = sysfs_create_group(&dev->dev.kobj,
+							&sjoy_attribute_group);
+		if (error)
+			hid_warn(hid, "failed to create sysfs attributes: %d\n",
+									error);
 	}
 
 	hid_info(hid, "Force feedback for SmartJoy PLUS PS2/USB adapter\n");
 
 	return 0;
 }
+
+static void sjoy_remove(struct hid_device *hid)
+{
+	struct hid_input *hidinput;
+	struct input_dev *dev;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		dev = hidinput->input;
+		sysfs_remove_group(&dev->dev.kobj, &sjoy_attribute_group);
+	}
+
+	hid_hw_stop(hid);
+}
 #else
 static inline int sjoyff_init(struct hid_device *hid)
 {
 	return 0;
 }
+
+#define sjoy_remove NULL
 #endif
 
 static int sjoy_probe(struct hid_device *hdev, const struct hid_device_id *id)
@@ -154,7 +387,8 @@ err:
 }
 
 static const struct hid_device_id sjoy_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO),
+		.driver_data = HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_DUAL_BOX_PRO),
 		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
@@ -163,7 +397,7 @@ static const struct hid_device_id sjoy_devices[] = {
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD),
-		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
+		.driver_data = HID_QUIRK_MULTI_INPUT |
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ }
 };
@@ -173,6 +407,7 @@ static struct hid_driver sjoy_driver = {
 	.name = "smartjoyplus",
 	.id_table = sjoy_devices,
 	.probe = sjoy_probe,
+	.remove = sjoy_remove
 };
 
 static int __init sjoy_init(void)
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 117a59a..42c83a5 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -544,3 +544,11 @@ int input_ff_create_memless(struct input_dev *dev, void *data,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(input_ff_create_memless);
+
+void *input_ff_get_data(struct input_dev *input)
+{
+	struct ml_device *ml = input->ff->private;
+
+	return ml->private;
+}
+EXPORT_SYMBOL_GPL(input_ff_get_data);
diff --git a/include/linux/input.h b/include/linux/input.h
index 771d6d8..d7a1ce2 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1617,6 +1617,7 @@ int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file);
 
 int input_ff_create_memless(struct input_dev *dev, void *data,
 		int (*play_effect)(struct input_dev *, void *, struct ff_effect *));
+void *input_ff_get_data(struct input_dev *dev);
 
 #endif
 #endif
-- 
1.7.7.1

