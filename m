From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH] HID: hig-lg, hif-lg4ff: Allow for custom device properties to be stored as private driver data
Date: Mon, 12 Mar 2012 22:56:08 +0100
Message-ID: <2576330.lyEl61c5nA@qosmio-x300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21839982.YVbKTIv9Uj"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55565 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757574Ab2CLV4U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 17:56:20 -0400
Received: by wejx9 with SMTP id x9so3753937wej.19
        for <linux-input@vger.kernel.org>; Mon, 12 Mar 2012 14:56:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org


--nextPart21839982.YVbKTIv9Uj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello,

this is sort of a response to Simon Wood's recent G27 LED's patch but s=
ince the patch touches
a completely different part of the Logitech driver I submitted it separ=
ately.

The main goal of this patch is to allow for some custom device specific=
 properties like the rotation
range to be stored as private driver data. Up until now the hid-lg trea=
ted the pointer to driver_data
as unsigned long as stored some device quirks there. Because of the sco=
pe of the changes, Simon's
implementation of the G27 LEDs code is unfortunately incompatible with =
this patch
because it uses the linked list I'm trying to get rid of.

The patch also introduces some spinlocking to hid-lg and hid-lg4ff to (=
hopefully) prevent any nasty
race conditions you were concerned about.

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
---
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index e7a7bd1..69a5ed0 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -109,23 +109,25 @@ static __u8 dfp_rdesc_fixed[] =3D {
 static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 =09=09unsigned int *rsize)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09unsigned long flags;
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
=20
-=09if ((quirks & LG_RDESC) && *rsize >=3D 90 && rdesc[83] =3D=3D 0x26 =
&&
+=09spin_lock_irqsave(&drv_data->lock, flags);
+=09if ((drv_data->quirks & LG_RDESC) && *rsize >=3D 90 && rdesc[83] =3D=
=3D 0x26 &&
 =09=09=09rdesc[84] =3D=3D 0x8c && rdesc[85] =3D=3D 0x02) {
 =09=09hid_info(hdev,
 =09=09=09 "fixing up Logitech keyboard report descriptor\n");
 =09=09rdesc[84] =3D rdesc[89] =3D 0x4d;
 =09=09rdesc[85] =3D rdesc[90] =3D 0x10;
 =09}
-=09if ((quirks & LG_RDESC_REL_ABS) && *rsize >=3D 50 &&
+=09if ((drv_data->quirks & LG_RDESC_REL_ABS) && *rsize >=3D 50 &&
 =09=09=09rdesc[32] =3D=3D 0x81 && rdesc[33] =3D=3D 0x06 &&
 =09=09=09rdesc[49] =3D=3D 0x81 && rdesc[50] =3D=3D 0x06) {
 =09=09hid_info(hdev,
 =09=09=09 "fixing up rel/abs in Logitech report descriptor\n");
 =09=09rdesc[33] =3D rdesc[50] =3D 0x02;
 =09}
-=09if ((quirks & LG_FF4) && *rsize >=3D 101 &&
+=09if ((drv_data->quirks & LG_FF4) && *rsize >=3D 101 &&
 =09=09=09rdesc[41] =3D=3D 0x95 && rdesc[42] =3D=3D 0x0B &&
 =09=09=09rdesc[47] =3D=3D 0x05 && rdesc[48] =3D=3D 0x09) {
 =09=09hid_info(hdev, "fixing up Logitech Speed Force Wireless button d=
escriptor\n");
@@ -134,6 +136,7 @@ static __u8 *lg_report_fixup(struct hid_device *hde=
v, __u8 *rdesc,
 =09=09rdesc[47] =3D 0x95;
 =09=09rdesc[48] =3D 0x0B;
 =09}
+=09spin_unlock_irqrestore(&drv_data->lock, flags);
=20
 =09switch (hdev->product) {
 =09case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
@@ -278,7 +281,8 @@ static int lg_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 =09=09  0,  0,  0,  0,  0,183,184,185,186,187,
 =09=09188,189,190,191,192,193,194,  0,  0,  0
 =09};
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09unsigned long flags;
+=09struct lg_drv_data* drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
 =09unsigned int hid =3D usage->hid;
=20
 =09if (hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_RECEIVER &&
@@ -289,28 +293,37 @@ static int lg_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
 =09=09=09lg_dinovo_mapping(hi, usage, bit, max))
 =09=09return 1;
=20
-=09if ((quirks & LG_WIRELESS) && lg_wireless_mapping(hi, usage, bit, m=
ax))
+=09spin_lock_irqsave(&drv_data->lock, flags);
+=09if ((drv_data->quirks & LG_WIRELESS) && lg_wireless_mapping(hi, usa=
ge, bit, max)) {
+=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09return 1;
+=09}
=20
-=09if ((hid & HID_USAGE_PAGE) !=3D HID_UP_BUTTON)
+=09if ((hid & HID_USAGE_PAGE) !=3D HID_UP_BUTTON) {
+=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09return 0;
+=09}
=20
 =09hid &=3D HID_USAGE;
=20
 =09/* Special handling for Logitech Cordless Desktop */
 =09if (field->application =3D=3D HID_GD_MOUSE) {
-=09=09if ((quirks & LG_IGNORE_DOUBLED_WHEEL) &&
-=09=09=09=09(hid =3D=3D 7 || hid =3D=3D 8))
+=09=09if ((drv_data->quirks & LG_IGNORE_DOUBLED_WHEEL) &&
+=09=09=09=09(hid =3D=3D 7 || hid =3D=3D 8)) {
+=09=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09=09return -1;
+=09=09}
 =09} else {
-=09=09if ((quirks & LG_EXPANDED_KEYMAP) &&
+=09=09if ((drv_data->quirks & LG_EXPANDED_KEYMAP) &&
 =09=09=09=09hid < ARRAY_SIZE(e_keymap) &&
 =09=09=09=09e_keymap[hid] !=3D 0) {
 =09=09=09hid_map_usage(hi, usage, bit, max, EV_KEY,
 =09=09=09=09=09e_keymap[hid]);
+=09=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09=09return 1;
 =09=09}
 =09}
+=09spin_unlock_irqrestore(&drv_data->lock, flags);
=20
 =09return 0;
 }
@@ -319,15 +332,22 @@ static int lg_input_mapped(struct hid_device *hde=
v, struct hid_input *hi,
 =09=09struct hid_field *field, struct hid_usage *usage,
 =09=09unsigned long **bit, int *max)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09unsigned long flags;
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
=20
-=09if ((quirks & LG_BAD_RELATIVE_KEYS) && usage->type =3D=3D EV_KEY &&=

-=09=09=09(field->flags & HID_MAIN_ITEM_RELATIVE))
+=09spin_lock_irqsave(&drv_data->lock, flags);
+=09if ((drv_data->quirks & LG_BAD_RELATIVE_KEYS) && usage->type =3D=3D=
 EV_KEY &&
+=09=09=09(field->flags & HID_MAIN_ITEM_RELATIVE)) {
+=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09field->flags &=3D ~HID_MAIN_ITEM_RELATIVE;
+=09}
=20
-=09if ((quirks & LG_DUPLICATE_USAGES) && (usage->type =3D=3D EV_KEY ||=

-=09=09=09 usage->type =3D=3D EV_REL || usage->type =3D=3D EV_ABS))
+=09if ((drv_data->quirks & LG_DUPLICATE_USAGES) && (usage->type =3D=3D=
 EV_KEY ||
+=09=09=09 usage->type =3D=3D EV_REL || usage->type =3D=3D EV_ABS)) {
+=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09clear_bit(usage->code, *bit);
+=09}
+=09spin_unlock_irqrestore(&drv_data->lock, flags);
=20
 =09return 0;
 }
@@ -335,26 +355,39 @@ static int lg_input_mapped(struct hid_device *hde=
v, struct hid_input *hi,
 static int lg_event(struct hid_device *hdev, struct hid_field *field,
 =09=09struct hid_usage *usage, __s32 value)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09unsigned long flags;
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
=20
-=09if ((quirks & LG_INVERT_HWHEEL) && usage->code =3D=3D REL_HWHEEL) {=

+=09spin_lock_irqsave(&drv_data->lock, flags);
+=09if ((drv_data->quirks & LG_INVERT_HWHEEL) && usage->code =3D=3D REL=
_HWHEEL) {
 =09=09input_event(field->hidinput->input, usage->type, usage->code,
 =09=09=09=09-value);
+=09=09spin_unlock_irqrestore(&drv_data->lock, flags);
 =09=09return 1;
 =09}
+=09spin_unlock_irqrestore(&drv_data->lock, flags);
=20
 =09return 0;
 }
=20
 static int lg_probe(struct hid_device *hdev, const struct hid_device_i=
d *id)
 {
-=09unsigned long quirks =3D id->driver_data;
 =09unsigned int connect_mask =3D HID_CONNECT_DEFAULT;
 =09int ret;
+=09
+=09/* Allocate memory for driver data */
+=09struct lg_drv_data *drv_data =3D kzalloc(sizeof(struct lg_drv_data)=
, GFP_KERNEL);
+=09if (!drv_data) {
+=09=09hid_err(hdev, "Cannot initialize device, insufficient memory.");=

+=09=09ret =3D -ENOMEM;
+=09=09goto err_free;
+=09}
+=09spin_lock_init(&drv_data->lock);
+=09drv_data->quirks =3D id->driver_data;
=20
-=09hid_set_drvdata(hdev, (void *)quirks);
+=09hid_set_drvdata(hdev, (void *)drv_data);
=20
-=09if (quirks & LG_NOGET)
+=09if (drv_data->quirks & LG_NOGET)
 =09=09hdev->quirks |=3D HID_QUIRK_NOGET;
=20
 =09ret =3D hid_parse(hdev);
@@ -363,7 +396,7 @@ static int lg_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
 =09=09goto err_free;
 =09}
=20
-=09if (quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
+=09if (drv_data->quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
 =09=09connect_mask &=3D ~HID_CONNECT_FF;
=20
 =09ret =3D hid_hw_start(hdev, connect_mask);
@@ -392,14 +425,14 @@ static int lg_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
 =09=09}
 =09}
=20
-=09if (quirks & LG_FF)
+=09if (drv_data->quirks & LG_FF)
 =09=09lgff_init(hdev);
-=09if (quirks & LG_FF2)
+=09if (drv_data->quirks & LG_FF2)
 =09=09lg2ff_init(hdev);
-=09if (quirks & LG_FF3)
+=09if (drv_data->quirks & LG_FF3)
 =09=09lg3ff_init(hdev);
-=09if (quirks & LG_FF4)
-=09=09lg4ff_init(hdev);
+=09if (drv_data->quirks & LG_FF4)
+=09=09return lg4ff_init(hdev);
=20
 =09return 0;
 err_free:
@@ -408,10 +441,17 @@ err_free:
=20
 static void lg_remove(struct hid_device *hdev)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
-=09if(quirks & LG_FF4)
+=09unsigned long flags;
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
+=09
+=09spin_lock_irqsave(&drv_data->lock, flags);
+=09if (drv_data->quirks & LG_FF4)
 =09=09lg4ff_deinit(hdev);
=20
+=09spin_unlock_irqrestore(&drv_data->lock, flags);
+=09kfree(drv_data);
+=09
 =09hid_hw_stop(hdev);
 }
=20
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index 4b09728..7b10cdc 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -1,6 +1,15 @@
 #ifndef __HID_LG_H
 #define __HID_LG_H
=20
+#include <linux/spinlock.h>
+
+/* Driver data struct */
+struct lg_drv_data {
+=09spinlock_t lock;
+=09unsigned long quirks;
+=09void *dev_props;
+};
+
 #ifdef CONFIG_LOGITECH_FF
 int lgff_init(struct hid_device *hdev);
 #else
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 6ecc9e2..98d83fe 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -51,20 +51,14 @@ static ssize_t lg4ff_range_store(struct device *dev=
, struct device_attribute *at
=20
 static DEVICE_ATTR(range, S_IRWXU | S_IRWXG | S_IRWXO, lg4ff_range_sho=
w, lg4ff_range_store);
=20
-static bool list_inited;
-
 struct lg4ff_device_entry {
-=09char  *device_id;=09/* Use name in respective kobject structure's a=
ddress as the ID */
 =09__u16 range;
 =09__u16 min_range;
 =09__u16 max_range;
 =09__u8  leds;
-=09struct list_head list;
 =09void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
-static struct lg4ff_device_entry device_list;
-
 static const signed short lg4ff_wheel_effects[] =3D {
 =09FF_CONSTANT,
 =09FF_AUTOCENTER,
@@ -91,13 +85,13 @@ static const struct lg4ff_wheel lg4ff_devices[] =3D=
 {
 };
=20
 struct lg4ff_native_cmd {
-=09const __u8 cmd_num;=09/* Number of commands to send */
-=09const __u8 cmd[];
+=09const u8 cmd_num;=09/* Number of commands to send */
+=09const u8 cmd[];
 };
=20
 struct lg4ff_usb_revision {
-=09const __u16 rev_maj;
-=09const __u16 rev_min;
+=09const u16 rev_maj;
+=09const u16 rev_min;
 =09const struct lg4ff_native_cmd *command;
 };
=20
@@ -285,22 +279,30 @@ static void hid_lg4ff_switch_native(struct hid_de=
vice *hid, const struct lg4ff_n
 /* Read current range and display it in terminal */
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
 {
-=09struct lg4ff_device_entry *uninitialized_var(entry);
-=09struct list_head *h;
-=09struct hid_device *hid =3D to_hid_device(dev);
 =09size_t count;
+=09struct hid_device *hid =3D to_hid_device(dev);
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hid);
+=09struct lg4ff_device_entry *uninitialized_var(entry);
+=09__u16 out_rng;
=20
-=09list_for_each(h, &device_list.list) {
-=09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
-=09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0)
-=09=09=09break;
+
+=09if (!drv_data) {
+=09=09hid_err(hid, "Device data not found.");
+=09=09return 0;
 =09}
-=09if (h =3D=3D &device_list.list) {
-=09=09dbg_hid("Device not found!");
+
+=09spin_lock(&drv_data->lock);
+=09entry =3D (struct lg4ff_device_entry *)drv_data->dev_props;
+=09if (!entry) {
+=09=09hid_err(hid, "Device properties not found.");
+=09=09spin_unlock(&drv_data->lock);
 =09=09return 0;
 =09}
=20
-=09count =3D scnprintf(buf, PAGE_SIZE, "%u\n", entry->range);
+=09out_rng =3D entry->range;
+=09spin_unlock(&drv_data->lock);
+=09count =3D scnprintf(buf, PAGE_SIZE, "%u\n", out_rng);
+=09
 =09return count;
 }
=20
@@ -308,18 +310,21 @@ static ssize_t lg4ff_range_show(struct device *de=
v, struct device_attribute *att
  * according to the type of the wheel */
 static ssize_t lg4ff_range_store(struct device *dev, struct device_att=
ribute *attr, const char *buf, size_t count)
 {
-=09struct lg4ff_device_entry *uninitialized_var(entry);
-=09struct list_head *h;
 =09struct hid_device *hid =3D to_hid_device(dev);
+=09struct lg_drv_data* drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hid);
+=09struct lg4ff_device_entry *uninitialized_var(entry);
 =09__u16 range =3D simple_strtoul(buf, NULL, 10);
=20
-=09list_for_each(h, &device_list.list) {
-=09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
-=09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0)
-=09=09=09break;
+=09if (!drv_data) {
+=09=09hid_err(hid, "Device data not found.");
+=09=09return count;
 =09}
-=09if (h =3D=3D &device_list.list) {
-=09=09dbg_hid("Device not found!");
+
+=09spin_lock(&drv_data->lock);
+=09entry =3D (struct lg4ff_device_entry *)drv_data->dev_props;=20
+=09if (!entry) {
+=09=09hid_err(hid, "Device properties not found.");
+=09=09spin_unlock(&drv_data->lock);
 =09=09return count;
 =09}
=20
@@ -332,6 +337,7 @@ static ssize_t lg4ff_range_store(struct device *dev=
, struct device_attribute *at
 =09=09entry->set_range(hid, range);
 =09=09entry->range =3D range;
 =09}
+=09spin_unlock(&drv_data->lock);
=20
 =09return count;
 }
@@ -339,10 +345,12 @@ static ssize_t lg4ff_range_store(struct device *d=
ev, struct device_attribute *at
 int lg4ff_init(struct hid_device *hid)
 {
 =09struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct =
hid_input, list);
+=09unsigned long flags;
 =09struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPO=
RT].report_list;
 =09struct input_dev *dev =3D hidinput->input;
 =09struct hid_report *report;
 =09struct hid_field *field;
+=09struct lg_drv_data *drv_data;
 =09struct lg4ff_device_entry *entry;
 =09struct usb_device_descriptor *udesc;
 =09int error, i, j;
@@ -423,28 +431,26 @@ int lg4ff_init(struct hid_device *hid)
 =09=09dev->ff->set_autocenter(dev, 0);
 =09}
=20
-=09=09/* Initialize device_list if this is the first device to handle =
by lg4ff */
-=09if (!list_inited) {
-=09=09INIT_LIST_HEAD(&device_list.list);
-=09=09list_inited =3D 1;
-=09}
-
 =09/* Add the device to device_list */
 =09entry =3D kzalloc(sizeof(struct lg4ff_device_entry), GFP_KERNEL);
 =09if (!entry) {
 =09=09hid_err(hid, "Cannot add device, insufficient memory.\n");
 =09=09return -ENOMEM;
 =09}
-=09entry->device_id =3D kstrdup((&hid->dev)->kobj.name, GFP_KERNEL);
-=09if (!entry->device_id) {
-=09=09hid_err(hid, "Cannot set device_id, insufficient memory.\n");
-=09=09kfree(entry);
-=09=09return -ENOMEM;
-=09}
 =09entry->min_range =3D lg4ff_devices[i].min_range;
 =09entry->max_range =3D lg4ff_devices[i].max_range;
 =09entry->set_range =3D lg4ff_devices[i].set_range;
-=09list_add(&entry->list, &device_list.list);
+=09
+=09drv_data =3D (struct lg_drv_data *)hid_get_drvdata(hid);
+=09spin_lock_irqsave(&drv_data->lock, flags);
+=09drv_data->dev_props =3D entry;
+=09
+=09/* Set the maximum range to start with */
+=09entry->range =3D entry->max_range;
+=09if (entry->set_range !=3D NULL)
+=09=09entry->set_range(hid, entry->range);
+=09
+=09spin_unlock_irqrestore(&drv_data->lock, flags);
=20
 =09/* Create sysfs interface */
 =09error =3D device_create_file(&hid->dev, &dev_attr_range);
@@ -452,34 +458,17 @@ int lg4ff_init(struct hid_device *hid)
 =09=09return error;
 =09dbg_hid("sysfs interface created\n");
=20
-=09/* Set the maximum range to start with */
-=09entry->range =3D entry->max_range;
-=09if (entry->set_range !=3D NULL)
-=09=09entry->set_range(hid, entry->range);
-
 =09hid_info(hid, "Force feedback for Logitech Speed Force Wireless by =
Simon Wood <simon@mungewell.org>\n");
 =09return 0;
 }
=20
 int lg4ff_deinit(struct hid_device *hid)
 {
-=09bool found =3D 0;
-=09struct lg4ff_device_entry *entry;
-=09struct list_head *h, *g;
-=09list_for_each_safe(h, g, &device_list.list) {
-=09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
-=09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0) {=

-=09=09=09list_del(h);
-=09=09=09kfree(entry->device_id);
-=09=09=09kfree(entry);
-=09=09=09found =3D 1;
-=09=09=09break;
-=09=09}
-=09}
-
-=09if (!found) {
-=09=09dbg_hid("Device entry not found!\n");
-=09=09return -1;
+=09/* This is called  from lg_remove with a spinlock held */
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)drv_data;
+=09if (drv_data) {
+=09=09if (drv_data->dev_props)
+=09=09=09kfree(drv_data->dev_props);
 =09}
=20
 =09device_remove_file(&hid->dev, &dev_attr_range);

--nextPart21839982.YVbKTIv9Uj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPXnD4AAoJEERrVaOJCK16IKUH/R9ffVIwMpGIG0tqQbRasvcr
zYKlLhY1i2NPHEPtDDuPLZx1Nevd8qfOvtq8M2jMb2UFV6W1Ik9T8iP+AIHz8fXa
/hx80TzvCVDelKxWRgfxL6sgHta5Fr/UiGQAF1J97IlP5kuTg4uZSX6iK62JJjOX
DxYlFz5atNerpGTLRNHG5BYm4TSjQOp8jivz5XsyxMa1Vczn8XHRZrP6BofttNOa
6+b1heMcrjsQawC7cgG6DI7bN7EVTdSnzheDPHL/91DAmCBvvfzO1Ufguc2NFnDq
PSfhuial8AZTc+pq88YRIbREnJTZE3vPdK51OGVJigxJJrFDfSGQFjm2cO0IqYM=
=Y0ua
-----END PGP SIGNATURE-----

--nextPart21839982.YVbKTIv9Uj--

