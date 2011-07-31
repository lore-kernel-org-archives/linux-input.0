From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: PATCH [3/6] HID: lg4ff - Add range setting support and sysfs interface
Date: Sun, 31 Jul 2011 03:06:27 +0200
Message-ID: <7463671.m4dyOsCspX@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55735 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1GaBGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 21:06:31 -0400
Received: by fxh19 with SMTP id 19so3412906fxh.19
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2011 18:06:30 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, simon@mungewell.org

Wheel range of certain Logitech wheels - namely Driving Force GT, Drivi=
ng Force Pro, G25 and G27 can be adjusted. Minimum range=20
is 40 degrees, maximum 900. DFGT, G25 and G27 all use a common command,=
 DFP uses another one.
Range can be set from userspace by writing to "/sys/module/hid_logitech=
/drivers/hid:logitech/<dev>range". The driver uses a linked=20
list to store range of each connected wheel; it's not possible to use d=
river_data in hid_device struct as it's already being used by=20
hig-lg driver.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index e0ae4a0..e7a7bd1 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -406,6 +406,15 @@ err_free:
 	return ret;
 }
=20
+static void lg_remove(struct hid_device *hdev)
+{
+	unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+	if(quirks & LG_FF4)
+		lg4ff_deinit(hdev);
+
+	hid_hw_stop(hdev);
+}
+
 static const struct hid_device_id lg_devices[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVE=
R),
 		.driver_data =3D LG_RDESC | LG_WIRELESS },
@@ -481,6 +490,7 @@ static struct hid_driver lg_driver =3D {
 	.input_mapped =3D lg_input_mapped,
 	.event =3D lg_event,
 	.probe =3D lg_probe,
+	.remove =3D lg_remove,
 };
=20
 static int __init lg_init(void)
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index b0100ba..3a32959 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -21,8 +21,10 @@ static inline int lg3ff_init(struct hid_device *hdev=
) { return -1; }
=20
 #ifdef CONFIG_LOGIWII_FF
 int lg4ff_init(struct hid_device *hdev);
+int lg4ff_deinit(struct hid_device *hdev);
 #else
 static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
+static inline int lg4ff_deinit(struct hid_device *hdev) { return -1; }
 #endif
=20
 #endif
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index acef0cf..1ee78d3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -42,6 +42,29 @@
 #define G27_REV_MAJ 0x12
 #define G27_REV_MIN 0x38
=20
+#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
+
+static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
+static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)=
;
+static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr, char *buf);
+static ssize_t lg4ff_range_store(struct device *dev, struct device_att=
ribute *attr, const char *buf, size_t count);
+
+static DEVICE_ATTR(range, S_IRWXU | S_IRWXG | S_IRWXO, lg4ff_range_sho=
w, lg4ff_range_store);
+
+static bool list_inited;
+
+struct lg4ff_device_entry {
+	char  *device_id;	/* Use name in respective kobject structure's addre=
ss as the ID */
+	__u16 range;
+	__u16 min_range;
+	__u16 max_range;
+	__u8  leds;
+	struct list_head list;
+	void (*set_range)(struct hid_device *hid, u16 range);
+};
+
+static struct lg4ff_device_entry device_list;
+
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
 	FF_AUTOCENTER,
@@ -53,17 +76,18 @@ struct lg4ff_wheel {
 	const signed short *ff_effects;
 	const __u16 min_range;
 	const __u16 max_range;
+	void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
 static const struct lg4ff_wheel lg4ff_devices[] =3D {
-	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270},
-	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270},
-	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   lg4ff_wheel_effects, 40, 900},
-	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900},
-	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900},
-	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900},
-	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270},
-	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270}
+	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270, NU=
LL},
+	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270, NU=
LL},
+	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_dfp},
+	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900, hi=
d_lg4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270, NU=
LL},
+	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NU=
LL}
 };
=20
 struct lg4ff_native_cmd {
@@ -106,8 +130,7 @@ static const struct lg4ff_usb_revision lg4ff_revs[]=
 =3D {
 	{G27_REV_MAJ,  G27_REV_MIN,  &native_g27},	/* G27 */
 };
=20
-static int hid_lg4ff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+static int hid_lg4ff_play(struct input_dev *dev, void *data, struct ff=
_effect *effect)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -151,6 +174,77 @@ static void hid_lg4ff_set_autocenter(struct input_=
dev *dev, u16 magnitude)
 	usbhid_submit_report(hid, report, USB_DIR_OUT);
 }
=20
+/* Sends command to set range compatible with G25/G27/Driving Force GT=
 */
+static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)
+{
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	dbg_hid("G25/G27/DFGT: setting range to %u\n", range);
+
+	report->field[0]->value[0] =3D 0xf8;
+	report->field[0]->value[1] =3D 0x81;
+	report->field[0]->value[2] =3D range & 0x00ff;
+	report->field[0]->value[3] =3D (range & 0xff00) >> 8;
+	report->field[0]->value[4] =3D 0x00;
+	report->field[0]->value[5] =3D 0x00;
+	report->field[0]->value[6] =3D 0x00;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
+/* Sends commands to set range compatible with Driving Force Pro wheel=
 */
+static void hid_lg4ff_set_range_dfp(struct hid_device *hid, __u16 rang=
e)
+{
+	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
+	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
+	int start_left, start_right, full_range;
+	dbg_hid("Driving Force Pro: setting range to %u\n", range);
+
+	/* Prepare "coarse" limit command */
+	report->field[0]->value[0] =3D 0xf8;
+	report->field[0]->value[1] =3D 0x00; 	/* Set later */
+	report->field[0]->value[2] =3D 0x00;
+	report->field[0]->value[3] =3D 0x00;
+	report->field[0]->value[4] =3D 0x00;
+	report->field[0]->value[5] =3D 0x00;
+	report->field[0]->value[6] =3D 0x00;
+
+	if (range > 200) {
+		report->field[0]->value[1] =3D 0x03;
+		full_range =3D 900;
+	} else {
+		report->field[0]->value[1] =3D 0x02;
+		full_range =3D 200;
+	}
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+
+	/* Prepare "fine" limit command */
+	report->field[0]->value[0] =3D 0x81;
+	report->field[0]->value[1] =3D 0x0b;
+	report->field[0]->value[2] =3D 0x00;
+	report->field[0]->value[3] =3D 0x00;
+	report->field[0]->value[4] =3D 0x00;
+	report->field[0]->value[5] =3D 0x00;
+	report->field[0]->value[6] =3D 0x00;
+
+	if (range =3D=3D 200 || range =3D=3D 900) {	/* Do not apply any fine =
limit */
+		usbhid_submit_report(hid, report, USB_DIR_OUT);
+		return;
+	}
+
+	/* Construct fine limit command */
+	start_left =3D (((full_range - range + 1) * 2047) / full_range);
+	start_right =3D 0xfff - start_left;
+
+	report->field[0]->value[2] =3D start_left >> 4;
+	report->field[0]->value[3] =3D start_right >> 4;
+	report->field[0]->value[4] =3D 0xff;
+	report->field[0]->value[5] =3D (start_right & 0xe) << 4 | (start_left=
 & 0xe);
+	report->field[0]->value[6] =3D 0xff;
+
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
 static void hid_lg4ff_switch_native(struct hid_device *hid, const stru=
ct lg4ff_native_cmd *cmd)
 {
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
@@ -166,6 +260,60 @@ static void hid_lg4ff_switch_native(struct hid_dev=
ice *hid, const struct lg4ff_n
 	}
 }
=20
+/* Read current range and display it in terminal */
+static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
+{
+	struct lg4ff_device_entry *entry =3D 0;
+	struct list_head *h;
+	struct hid_device *hid =3D to_hid_device(dev);
+	size_t count;
+
+	list_for_each(h, &device_list.list) {
+		entry =3D list_entry(h, struct lg4ff_device_entry, list);
+		if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0)
+			break;
+	}
+	if (h =3D=3D &device_list.list) {
+		dbg_hid("Device not found!");
+		return 0;
+	}
+
+	count =3D scnprintf(buf, PAGE_SIZE, "%u\n", entry->range);
+	return count;
+}
+
+/* Set range to user specified value, call appropriate function
+ * according to the type of the wheel */
+static ssize_t lg4ff_range_store(struct device *dev, struct device_att=
ribute *attr, const char *buf, size_t count)
+{
+	struct lg4ff_device_entry *entry =3D 0;
+	struct list_head *h;
+	struct hid_device *hid =3D to_hid_device(dev);
+	__u16 range =3D simple_strtoul(buf, NULL, 10);
+
+	list_for_each(h, &device_list.list) {
+		entry =3D list_entry(h, struct lg4ff_device_entry, list);
+		if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0)
+			break;
+	}
+	if (h =3D=3D &device_list.list) {
+		dbg_hid("Device not found!");
+		return count;
+	}
+
+	if (range =3D=3D 0)
+		range =3D entry->max_range;
+
+	/* Check if the wheel supports range setting
+	 * and that the range is within limits for the wheel */
+	if (entry->set_range !=3D NULL && range >=3D entry->min_range && rang=
e <=3D entry->max_range) {
+		entry->set_range(hid, range);
+		entry->range =3D range;
+	}
+
+	return count;
+}
+
 int lg4ff_init(struct hid_device *hid)
 {
 	struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct hi=
d_input, list);
@@ -173,7 +321,8 @@ int lg4ff_init(struct hid_device *hid)
 	struct input_dev *dev =3D hidinput->input;
 	struct hid_report *report;
 	struct hid_field *field;
-	struct usb_device_descriptor *udesc =3D 0;
+	struct lg4ff_device_entry *entry;
+	struct usb_device_descriptor *udesc;
 	int error, i, j;
 	__u16 bcdDevice, rev_maj, rev_min;
=20
@@ -195,7 +344,7 @@ int lg4ff_init(struct hid_device *hid)
 		hid_err(hid, "NULL field\n");
 		return -1;
 	}
-=09
+
 	/* Check what wheel has been connected */
 	for (i =3D 0; i < ARRAY_SIZE(lg4ff_devices); i++) {
 		if (hid->product =3D=3D lg4ff_devices[i].product_id) {
@@ -244,7 +393,66 @@ int lg4ff_init(struct hid_device *hid)
 	if (test_bit(FF_AUTOCENTER, dev->ffbit))
 		dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter;
=20
+		/* Initialize device_list if this is the first device to handle by l=
g4ff */
+	if (!list_inited) {
+		INIT_LIST_HEAD(&device_list.list);
+		list_inited =3D 1;
+	}
+
+	/* Add the device to device_list */
+	entry =3D (struct lg4ff_device_entry *)kzalloc(sizeof(struct lg4ff_de=
vice_entry), GFP_KERNEL);
+	if (!entry) {
+		hid_err(hid, "Cannot add device, insufficient memory.\n");
+		return -ENOMEM;
+	}
+	entry->device_id =3D (char *)kzalloc(strlen((&hid->dev)->kobj.name) +=
 1, GFP_KERNEL);
+	if (!entry->device_id) {
+		hid_err(hid, "Cannot set device_id, insufficient memory.\n");
+		return -ENOMEM;
+	}
+	strcpy(entry->device_id, (&hid->dev)->kobj.name);
+	entry->min_range =3D lg4ff_devices[i].min_range;
+	entry->max_range =3D lg4ff_devices[i].max_range;
+	entry->set_range =3D lg4ff_devices[i].set_range;
+	list_add(&entry->list, &device_list.list);
+
+	/* Create sysfs interface */
+	error =3D device_create_file(&hid->dev, &dev_attr_range);
+	if (error)
+		return error;
+	dbg_hid("sysfs interface created\n");
+
+	/* Set the maximum range to start with */
+	entry->range =3D entry->max_range;
+	if (entry->set_range !=3D NULL)
+		entry->set_range(hid, entry->range);
+
 	hid_info(hid, "Force feedback for Logitech Speed Force Wireless by Si=
mon Wood <simon@mungewell.org>\n");
 	return 0;
 }
=20
+int lg4ff_deinit(struct hid_device *hid)
+{
+	bool found =3D 0;
+	struct lg4ff_device_entry *entry;
+	struct list_head *h, *g;
+	list_for_each_safe(h, g, &device_list.list) {
+		entry =3D list_entry(h, struct lg4ff_device_entry, list);
+		if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0) {
+			list_del(h);
+			kfree(entry->device_id);
+			kfree(entry);
+			found =3D 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		dbg_hid("Device entry not found!\n");
+		return -1;
+	}
+
+	device_remove_file(&hid->dev, &dev_attr_range);
+	dbg_hid("Device successfully unregistered\n");
+	return 0;
+}

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
