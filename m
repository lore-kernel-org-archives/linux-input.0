From: Aaron Skomra <skomra@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Add support for Express Key Remote.
Date: Thu, 20 Aug 2015 16:05:17 -0700
Message-ID: <1440111917-4496-2-git-send-email-skomra@gmail.com>
References: <1440111917-4496-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35280 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbHTXGB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 19:06:01 -0400
Received: by pacdd16 with SMTP id dd16so29476325pac.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 16:06:01 -0700 (PDT)
In-Reply-To: <1440111917-4496-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, benjamin.tissoires@redhat.com, killertofu@gmail.com, pinglinux@gmail.com, linux-input@vger.kernel.org
Cc: Aaron Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

This device is pad (buttons) only, there is no stylus or touch. Up to
five remotes can pair with the device's associated USB dongle.

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 Documentation/ABI/testing/sysfs-driver-wacom |  19 +++
 drivers/hid/wacom.h                          |   7 +-
 drivers/hid/wacom_sys.c                      | 195 +++++++++++++++++++++++++++
 drivers/hid/wacom_wac.c                      | 144 ++++++++++++++++++++
 drivers/hid/wacom_wac.h                      |   7 +-
 5 files changed, 370 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index c4f0fed..dca4293 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -77,3 +77,22 @@ Description:
 		The format is also scrambled, like in the USB mode, and it can
 		be summarized by converting 76543210 into GECA6420.
 					    HGFEDCBA      HFDB7531
+
+What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_remote/unpair_remote
+Date:		July 2015
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing the character sequence '*' followed by a newline to
+		this file will delete all of the current pairings on the
+		device. Other character sequences are reserved. This file is
+		write only.
+
+What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_remote/<serial_number>/remote_mode
+Date:		July 2015
+Contact:	linux-input@vger.kernel.org
+Description:
+		Reading from this file reports the mode status of the
+		remote as indicated by the LED lights on the device. If no
+		reports have been received from the paired device, reading
+		from this file will report '-1'. The mode is read-only
+		and cannot be set through the driver.
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index a533787..4681a65 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -113,7 +113,7 @@ struct wacom {
 	struct mutex lock;
 	struct work_struct work;
 	struct wacom_led {
-		u8 select[2]; /* status led selector (0..3) */
+		u8 select[5]; /* status led selector (0..3) */
 		u8 llv;       /* status led brightness no button (1..127) */
 		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
@@ -123,6 +123,8 @@ struct wacom {
 	struct power_supply *ac;
 	struct power_supply_desc battery_desc;
 	struct power_supply_desc ac_desc;
+	struct kobject *remote_dir;
+	struct attribute_group remote_group[5];
 };
 
 static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
@@ -147,4 +149,7 @@ int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value);
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report);
 void wacom_battery_work(struct work_struct *work);
+int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
+				   int index);
+void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 33443c1..1e835dc 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -23,9 +23,13 @@
 #define WAC_CMD_ICON_XFER	0x23
 #define WAC_CMD_ICON_BT_XFER	0x26
 #define WAC_CMD_RETRIES		10
+#define WAC_CMD_DELETE_PAIRING	0x20
+#define WAC_CMD_UNPAIR_ALL	0xFF
+#define WAC_REMOTE_SERIAL_MAX_STRLEN	9
 
 #define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
 #define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
+#define DEV_ATTR_RO_PERM (S_IRUSR | S_IRGRP)
 
 static int wacom_get_report(struct hid_device *hdev, u8 type, u8 *buf,
 			    size_t size, unsigned int retries)
@@ -1120,6 +1124,189 @@ static ssize_t wacom_store_speed(struct device *dev,
 static DEVICE_ATTR(speed, DEV_ATTR_RW_PERM,
 		wacom_show_speed, wacom_store_speed);
 
+
+static ssize_t wacom_show_remote_mode(struct kobject *kobj,
+				      struct kobj_attribute *kattr,
+				      char *buf, int index)
+{
+	struct device *dev = container_of(kobj->parent, struct device, kobj);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	u8 mode;
+
+	mode = wacom->led.select[index];
+	if (mode >= 0 && mode < 3)
+		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+	else
+		return snprintf(buf, PAGE_SIZE, "%d\n", -1);
+}
+
+#define DEVICE_EKR_ATTR_GROUP(SET_ID)					\
+static ssize_t wacom_show_remote##SET_ID##_mode(struct kobject *kobj,	\
+			       struct kobj_attribute *kattr, char *buf)	\
+{									\
+	return wacom_show_remote_mode(kobj, kattr, buf, SET_ID);	\
+}									\
+static struct kobj_attribute remote##SET_ID##_mode_attr = {		\
+	.attr = {.name = "remote_mode",					\
+		.mode = DEV_ATTR_RO_PERM},				\
+	.show = wacom_show_remote##SET_ID##_mode,			\
+};									\
+static struct attribute *remote##SET_ID##_serial_attrs[] = {		\
+	&remote##SET_ID##_mode_attr.attr,				\
+	NULL								\
+};									\
+static struct attribute_group remote##SET_ID##_serial_group = {		\
+	.name = NULL,							\
+	.attrs = remote##SET_ID##_serial_attrs,				\
+}
+
+DEVICE_EKR_ATTR_GROUP(0);
+DEVICE_EKR_ATTR_GROUP(1);
+DEVICE_EKR_ATTR_GROUP(2);
+DEVICE_EKR_ATTR_GROUP(3);
+DEVICE_EKR_ATTR_GROUP(4);
+
+int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial, int index)
+{
+	int error = 0;
+	char *buf;
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+
+	wacom_wac->serial[index] = serial;
+
+	buf = kzalloc(WAC_REMOTE_SERIAL_MAX_STRLEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	snprintf(buf, WAC_REMOTE_SERIAL_MAX_STRLEN, "%d", serial);
+	wacom->remote_group[index].name = buf;
+
+	error = sysfs_create_group(wacom->remote_dir,
+				   &wacom->remote_group[index]);
+	if (error) {
+		hid_err(wacom->hdev,
+			"cannot create sysfs group err: %d\n", error);
+		kobject_put(wacom->remote_dir);
+		return error;
+	}
+
+	return 0;
+}
+
+void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
+{
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	int i;
+
+	if (!serial)
+		return;
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (wacom_wac->serial[i] == serial) {
+			wacom_wac->serial[i] = 0;
+			wacom->led.select[i] = WACOM_STATUS_UNKNOWN;
+			if (wacom->remote_group[i].name) {
+				sysfs_remove_group(wacom->remote_dir,
+						   &wacom->remote_group[i]);
+				kfree(wacom->remote_group[i].name);
+				wacom->remote_group[i].name = NULL;
+			}
+		}
+	}
+}
+
+static int wacom_cmd_unpair_remote(struct wacom *wacom, unsigned char selector)
+{
+	const size_t buf_size = 2;
+	unsigned char *buf;
+	int retval;
+
+	buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = WAC_CMD_DELETE_PAIRING;
+	buf[1] = selector;
+
+	retval = wacom_set_report(wacom->hdev, HID_OUTPUT_REPORT, buf,
+				  buf_size, WAC_CMD_RETRIES);
+	kfree(buf);
+
+	return retval;
+}
+
+static ssize_t wacom_store_unpair_remote(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	unsigned char selector = 0;
+	struct device *dev = container_of(kobj->parent, struct device, kobj);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	int err;
+
+	if (!strncmp(buf, "*\n", 2)) {
+		selector = WAC_CMD_UNPAIR_ALL;
+	} else {
+		hid_info(wacom->hdev, "remote: unrecognized unpair code: %s\n",
+			 buf);
+		return -1;
+	}
+
+	mutex_lock(&wacom->lock);
+
+	err = wacom_cmd_unpair_remote(wacom, selector);
+	mutex_unlock(&wacom->lock);
+
+	return err < 0 ? err : count;
+}
+
+static struct kobj_attribute unpair_remote_attr = {
+	.attr = {.name = "unpair_remote", .mode = 0200},
+	.store = wacom_store_unpair_remote,
+};
+
+static const struct attribute *remote_unpair_attrs[] = {
+	&unpair_remote_attr.attr,
+	NULL
+};
+
+static int wacom_initialize_remote(struct wacom *wacom)
+{
+	int error = 0;
+	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+	int i;
+
+	if (wacom->wacom_wac.features.type != REMOTE)
+		return 0;
+
+	wacom->remote_group[0] = remote0_serial_group;
+	wacom->remote_group[1] = remote1_serial_group;
+	wacom->remote_group[2] = remote2_serial_group;
+	wacom->remote_group[3] = remote3_serial_group;
+	wacom->remote_group[4] = remote4_serial_group;
+
+	wacom->remote_dir = kobject_create_and_add("wacom_remote",
+						   &wacom->hdev->dev.kobj);
+	if (!wacom->remote_dir)
+		return -ENOMEM;
+
+	error = sysfs_create_files(wacom->remote_dir, remote_unpair_attrs);
+
+	if (error) {
+		hid_err(wacom->hdev,
+			"cannot create sysfs group err: %d\n", error);
+		return error;
+	}
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		wacom->led.select[i] = WACOM_STATUS_UNKNOWN;
+		wacom_wac->serial[i] = 0;
+	}
+
+	return 0;
+}
+
 static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 {
 	struct input_dev *input_dev;
@@ -1165,6 +1352,8 @@ static void wacom_clean_inputs(struct wacom *wacom)
 		else
 			input_free_device(wacom->wacom_wac.pad_input);
 	}
+	if (wacom->remote_dir)
+		kobject_put(wacom->remote_dir);
 	wacom->wacom_wac.pen_input = NULL;
 	wacom->wacom_wac.touch_input = NULL;
 	wacom->wacom_wac.pad_input = NULL;
@@ -1244,10 +1433,16 @@ static int wacom_register_inputs(struct wacom *wacom)
 		error = wacom_initialize_leds(wacom);
 		if (error)
 			goto fail_leds;
+
+		error = wacom_initialize_remote(wacom);
+		if (error)
+			goto fail_remote;
 	}
 
 	return 0;
 
+fail_remote:
+	wacom_destroy_leds(wacom);
 fail_leds:
 	input_unregister_device(pad_input_dev);
 	pad_input_dev = NULL;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a19aeae..ff627e8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -645,6 +645,130 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	return 0;
 }
 
+static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
+{
+	unsigned char *data = wacom_wac->data;
+	struct input_dev *input = wacom_wac->pad_input;
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct wacom_features *features = &wacom_wac->features;
+	int bat_charging, bat_percent, touch_ring_mode;
+	__u32 serial;
+	int i;
+
+	if (data[0] != WACOM_REPORT_REMOTE) {
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d", __func__, data[0]);
+		return 0;
+	}
+
+	serial = data[3] + (data[4] << 8) + (data[5] << 16);
+	wacom_wac->id[0] = PAD_DEVICE_ID;
+
+	input_report_key(input, BTN_0, (data[9] & 0x01));
+	input_report_key(input, BTN_1, (data[9] & 0x02));
+	input_report_key(input, BTN_2, (data[9] & 0x04));
+	input_report_key(input, BTN_3, (data[9] & 0x08));
+	input_report_key(input, BTN_4, (data[9] & 0x10));
+	input_report_key(input, BTN_5, (data[9] & 0x20));
+	input_report_key(input, BTN_6, (data[9] & 0x40));
+	input_report_key(input, BTN_7, (data[9] & 0x80));
+
+	input_report_key(input, BTN_8, (data[10] & 0x01));
+	input_report_key(input, BTN_9, (data[10] & 0x02));
+	input_report_key(input, BTN_A, (data[10] & 0x04));
+	input_report_key(input, BTN_B, (data[10] & 0x08));
+	input_report_key(input, BTN_C, (data[10] & 0x10));
+	input_report_key(input, BTN_X, (data[10] & 0x20));
+	input_report_key(input, BTN_Y, (data[10] & 0x40));
+	input_report_key(input, BTN_Z, (data[10] & 0x80));
+
+	input_report_key(input, BTN_BASE, (data[11] & 0x01));
+	input_report_key(input, BTN_BASE2, (data[11] & 0x02));
+
+	if (data[12] & 0x80)
+		input_report_abs(input, ABS_WHEEL, (data[12] & 0x7f));
+	else
+		input_report_abs(input, ABS_WHEEL, 0);
+
+	bat_percent = data[7] & 0x7f;
+	bat_charging = !!(data[7] & 0x80);
+
+	if (data[9] | data[10] | (data[11] & 0x03) | data[12])
+		input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+	else
+		input_report_abs(input, ABS_MISC, 0);
+
+	input_event(input, EV_MSC, MSC_SERIAL, serial);
+
+	/*Which mode select (LED light) is currently on?*/
+	touch_ring_mode = (data[11] & 0xC0) >> 6;
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (wacom_wac->serial[i] == serial)
+			wacom->led.select[i] = touch_ring_mode;
+	}
+
+	if (!wacom->battery &&
+	    !(features->quirks & WACOM_QUIRK_BATTERY)) {
+		features->quirks |= WACOM_QUIRK_BATTERY;
+		INIT_WORK(&wacom->work, wacom_battery_work);
+		wacom_schedule_work(wacom_wac);
+	}
+
+	wacom_notify_battery(wacom_wac, bat_percent, bat_charging, 1,
+			     bat_charging);
+
+	return 1;
+}
+
+static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
+{
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	unsigned char *data = wacom_wac->data;
+	int i;
+
+	if (data[0] != WACOM_REPORT_DEVICE_LIST)
+		return 0;
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		int j = i * 6;
+		int serial = (data[j+6] << 16) + (data[j+5] << 8) + data[j+4];
+		bool connected = data[j+2];
+
+		if (connected) {
+			int k;
+
+			if (wacom_wac->serial[i] == serial)
+				continue;
+
+			if (wacom_wac->serial[i]) {
+				wacom_remote_destroy_attr_group(wacom,
+							wacom_wac->serial[i]);
+			}
+
+			/* A remote can pair more than once with an EKR,
+			 * check to make sure this serial isn't already paired.
+			 */
+			for (k = 0; k < WACOM_MAX_REMOTES; k++) {
+				if (wacom_wac->serial[k] == serial)
+					break;
+			}
+
+			if (k < WACOM_MAX_REMOTES) {
+				wacom_wac->serial[i] = serial;
+				continue;
+			}
+			wacom_remote_create_attr_group(wacom, serial, i);
+
+		} else if (wacom_wac->serial[i]) {
+			wacom_remote_destroy_attr_group(wacom,
+							wacom_wac->serial[i]);
+		}
+	}
+
+	return 0;
+}
+
 static void wacom_intuos_general(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -2118,6 +2242,13 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		sync = wacom_wireless_irq(wacom_wac, len);
 		break;
 
+	case REMOTE:
+		if (wacom_wac->data[0] == WACOM_REPORT_DEVICE_LIST)
+			sync = wacom_remote_status_irq(wacom_wac, len);
+		else
+			sync = wacom_remote_irq(wacom_wac, len);
+		break;
+
 	default:
 		sync = false;
 		break;
@@ -2228,6 +2359,9 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	if (features->type == BAMBOO_PAD)
 		features->device_type = WACOM_DEVICETYPE_TOUCH;
 
+	if (features->type == REMOTE)
+		features->device_type = WACOM_DEVICETYPE_PAD;
+
 	if (wacom->hdev->bus == BUS_BLUETOOTH)
 		features->quirks |= WACOM_QUIRK_BATTERY;
 
@@ -2653,6 +2787,11 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 		break;
 
+	case REMOTE:
+		input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
+		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
+		break;
+
 	default:
 		/* no pad supported */
 		return -ENODEV;
@@ -3122,6 +3261,10 @@ static const struct wacom_features wacom_features_0x323 =
 	{ "Wacom Intuos P M", 21600, 13500, 1023, 31,
 	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x331 =
+	{ "Wacom Express Key Remote", 0, 0, 0, 0,
+	  REMOTE, 0, 0, 18, .check_for_hid_type = true,
+	  .hid_type = HID_TYPE_USBNONE };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC };
@@ -3277,6 +3420,7 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x32B) },
 	{ USB_DEVICE_WACOM(0x32C) },
 	{ USB_DEVICE_WACOM(0x32F) },
+	{ USB_DEVICE_WACOM(0x331) },
 	{ USB_DEVICE_WACOM(0x333) },
 	{ USB_DEVICE_WACOM(0x335) },
 	{ USB_DEVICE_WACOM(0x336) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 5f9d495..19e1191 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -16,6 +16,8 @@
 #define WACOM_PKGLEN_MAX	192
 
 #define WACOM_NAME_MAX		64
+#define WACOM_MAX_REMOTES	5
+#define WACOM_STATUS_UNKNOWN	255
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9
@@ -65,6 +67,8 @@
 #define WACOM_REPORT_USB		192
 #define WACOM_REPORT_BPAD_PEN		3
 #define WACOM_REPORT_BPAD_TOUCH		16
+#define WACOM_REPORT_DEVICE_LIST	16
+#define WACOM_REPORT_REMOTE		17
 
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
@@ -130,6 +134,7 @@ enum {
 	WACOM_24HDT,
 	WACOM_27QHDT,
 	BAMBOO_PAD,
+	REMOTE,
 	TABLETPC,   /* add new TPC below */
 	TABLETPCE,
 	TABLETPC2FG,
@@ -205,7 +210,7 @@ struct wacom_wac {
 	unsigned char data[WACOM_PKGLEN_MAX];
 	int tool[2];
 	int id[2];
-	__u32 serial[2];
+	__u32 serial[5];
 	bool reporting_data;
 	struct wacom_features features;
 	struct wacom_shared *shared;
-- 
2.4.3

