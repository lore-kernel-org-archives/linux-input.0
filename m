From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 18:01:23 +0100
Message-ID: <4EC3EC63.4020700@gmail.com>
References: <20111116095030.GC3335@slate>	<CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>	<20111116102514.GA3831@slate>	<CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>	<20111116145518.GA7080@slate>	<20111116154049.GA8444@slate> <CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53986 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122Ab1KPRB1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 12:01:27 -0500
Received: by bke11 with SMTP id 11so814471bke.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 09:01:26 -0800 (PST)
In-Reply-To: <CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Cedric Sodhi <manday@gmx.net>, linux-input@vger.kernel.org

On 11/16/2011 05:15 PM, Chris Bagwell wrote:

> On Wed, Nov 16, 2011 at 9:40 AM, Cedric Sodhi <manday@gmx.net> wrote:
>> Thanks to Benjamin's help and his neat patch which allows tempering with
>> quirks through sysfs, I got the device
>>
>> eGalax 0eef:a001
>>
>> to work. It works with the quirks
>>
>> MT_QUIRK_SLOT_IS_CONTACTID | MT_QUIRK_ALWAYS_VALID ( = 18 )
>>
>> so, using Benjamin's interface:
>>
>> (1) Adding the device with
>> $ cd '/sys/modules/hid_multitouch/driver/hid:hid-multitouch'
>> $ echo "3 0eef a001 1" > new_id
>>
>> (2) Setting the quirks with
>> $ echo 18 > '0003:0EEF:A001.0001/quirks'
>>
>> That's it. The device works!
> 
> Benjamin, do you have a take away from this?  We are setting quirks to
> 0x62 which should same as 0x12 for most purposes.  Combine this with
> the Acer eGalax patch and my guess is its .maxcontacts = 2 thats
> hurting things?


Well, Cedric as troubles again. I don't think the hiddev interface problem is related to hid-multitouch.
The point is that his device "works", i.e. it emits events in /dev/input/eventX, but the hiddev event doesn't.

BTW, my patch is nearly ready. I mainly missed the Documentation ABI:

>From a1890f599e9a2e3af3b1161a0224e470915065b0 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date: Wed, 16 Nov 2011 17:48:34 +0100
Subject: [PATCH 2/2] hid-multitouch: WIP: create sysfs attribute to control
 quirks from user-space

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c |  120 +++++++++++++++++++++++++++++++++++------
 1 files changed, 102 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 77dea57..3094d37 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -60,9 +60,19 @@ struct mt_slot {
 	bool seen_in_this_frame;/* has this slot been updated */
 };
 
+struct mt_class {
+	__s32 name;	/* MT_CLS */
+	__s32 quirks;
+	__s32 sn_move;	/* Signal/noise ratio for move events */
+	__s32 sn_width;	/* Signal/noise ratio for width events */
+	__s32 sn_height;	/* Signal/noise ratio for height events */
+	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
+	__u8 maxcontacts;
+};
+
 struct mt_device {
 	struct mt_slot curdata;	/* placeholder of incoming data */
-	struct mt_class *mtclass;	/* our mt device class */
+	struct mt_class mtclass;	/* our mt device class */
 	unsigned last_field_index;	/* last field index of the report */
 	unsigned last_slot_field;	/* the last field of a slot */
 	int last_mt_collection;	/* last known mt-related collection */
@@ -74,16 +84,6 @@ struct mt_device {
 	struct mt_slot *slots;
 };
 
-struct mt_class {
-	__s32 name;	/* MT_CLS */
-	__s32 quirks;
-	__s32 sn_move;	/* Signal/noise ratio for move events */
-	__s32 sn_width;	/* Signal/noise ratio for width events */
-	__s32 sn_height;	/* Signal/noise ratio for height events */
-	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
-	__u8 maxcontacts;
-};
-
 /* classes of device behavior */
 #define MT_CLS_DEFAULT				0x0001
 
@@ -188,6 +188,87 @@ struct mt_class mt_classes[] = {
 	{ }
 };
 
+static ssize_t mt_show_quirks(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	return sprintf(buf, "%u\n", td->mtclass.quirks);
+}
+
+static ssize_t mt_set_quirks(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	unsigned long val;
+
+	if (strict_strtoul(buf, 0, &val))
+		return -EINVAL;
+
+	td->mtclass.quirks = val;
+
+	return count;
+}
+
+static DEVICE_ATTR(quirks, S_IWUSR | S_IRUGO, mt_show_quirks, mt_set_quirks);
+
+static ssize_t mt_show_class(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	return sprintf(buf, "0x%x\n", td->mtclass.name);
+}
+
+static ssize_t mt_set_class(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_class *mtclass = NULL; /* MT_CLS_DEFAULT */
+	int i;
+
+	unsigned long val;
+
+	if (strict_strtoul(buf, 0, &val))
+		return -EINVAL;
+
+
+	for (i = 0; mt_classes[i].name ; i++) {
+		if (val == mt_classes[i].name) {
+			mtclass = &(mt_classes[i]);
+			break;
+		}
+	}
+
+	if (!mtclass)
+		return -EINVAL;
+
+	td->mtclass = *mtclass;
+
+	return count;
+}
+
+static DEVICE_ATTR(class, S_IWUSR | S_IRUGO, mt_show_class, mt_set_class);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_quirks.attr,
+	&dev_attr_class.attr,
+	NULL
+};
+
+static struct attribute_group mt_attribute_group = {
+	.attrs = sysfs_attrs
+};
+
 static void mt_feature_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
@@ -199,9 +280,9 @@ static void mt_feature_mapping(struct hid_device *hdev,
 		break;
 	case HID_DG_CONTACTMAX:
 		td->maxcontacts = field->value[0];
-		if (td->mtclass->maxcontacts)
+		if (td->mtclass.maxcontacts)
 			/* check if the maxcontacts is given by the class */
-			td->maxcontacts = td->mtclass->maxcontacts;
+			td->maxcontacts = td->mtclass.maxcontacts;
 
 		break;
 	}
@@ -221,7 +302,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		unsigned long **bit, int *max)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	struct mt_class *cls = td->mtclass;
+	struct mt_class *cls = &td->mtclass;
 	__s32 quirks = cls->quirks;
 
 	/* Only map fields from TouchScreen or TouchPad collections.
@@ -370,7 +451,7 @@ static int mt_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 
 static int mt_compute_slot(struct mt_device *td)
 {
-	__s32 quirks = td->mtclass->quirks;
+	__s32 quirks = td->mtclass.quirks;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID)
 		return td->curdata.contactid;
@@ -414,7 +495,7 @@ static void mt_emit_event(struct mt_device *td, struct input_dev *input)
 
 	for (i = 0; i < td->maxcontacts; ++i) {
 		struct mt_slot *s = &(td->slots[i]);
-		if ((td->mtclass->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP) &&
+		if ((td->mtclass.quirks & MT_QUIRK_NOT_SEEN_MEANS_UP) &&
 			!s->seen_in_this_frame) {
 			s->touch_state = false;
 		}
@@ -451,7 +532,7 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
-	__s32 quirks = td->mtclass->quirks;
+	__s32 quirks = td->mtclass.quirks;
 
 	if (hid->claimed & HID_CLAIMED_INPUT && td->slots) {
 		switch (usage->hid) {
@@ -559,7 +640,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->mtclass = mtclass;
+	td->mtclass = *mtclass;
 	td->inputmode = -1;
 	td->last_mt_collection = -1;
 	hid_set_drvdata(hdev, td);
@@ -581,6 +662,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto fail;
 	}
 
+	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
+
 	mt_set_input_mode(hdev);
 
 	return 0;
@@ -601,6 +684,7 @@ static int mt_reset_resume(struct hid_device *hdev)
 static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
+	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
 	kfree(td->slots);
 	kfree(td);
-- 
1.7.4.4




> 
> If so, do you have enough report descriptors to know if we can remove
> it for all or if we need to create an MT_CLS_EGALAX_HAS_MAXCONTACTS?
> My guess is for the ones that have correct MAXCONTACTS, they also have
> valid logical X/Y sizes and so we can remote that quirk as well.  At
> least this one does.


I'll have to digg it through them....

Cheers,
Benjamin

> 
> Chris
> 
>>
>> regards,
>> Cedric
>>

