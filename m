From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] Fix build failure in hiddev_ioctl with gcc 3.2
Date: Sun, 2 Mar 2008 23:12:09 +0100
Message-ID: <20080302231209.36e2c619@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-dmz-236-saturday.dmz.nerim.net ([195.5.254.236]:59399 "EHLO
	kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753686AbYCBWhw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Mar 2008 17:37:52 -0500
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [62.4.17.100])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 9415F26125
	for <linux-input@vger.kernel.org>; Sun,  2 Mar 2008 23:14:08 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Alexander <pikachu@millennium.udm.ru>, bunk@kernel.org

Fix build failure in hiddev_ioctl with gcc 3.2:
http://bugzilla.kernel.org/show_bug.cgi?id=10121

The trick is to move the handling of ioctls which need to allocate
memory to separate functions.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Needs review and testing.

 drivers/hid/usbhid/hiddev.c |  286 ++++++++++++++++++++++---------------------
 1 file changed, 150 insertions(+), 136 deletions(-)

--- linux-2.6.24.orig/drivers/hid/usbhid/hiddev.c	2008-02-29 22:22:56.000000000 +0100
+++ linux-2.6.24/drivers/hid/usbhid/hiddev.c	2008-02-29 22:49:31.000000000 +0100
@@ -393,6 +393,153 @@ static unsigned int hiddev_poll(struct f
 /*
  * "ioctl" file op
  */
+static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd, void __user *user_arg)
+{
+	struct hid_device *hid = hiddev->hid;
+	struct hiddev_report_info rinfo;
+	struct hiddev_usage_ref_multi *uref_multi = NULL;
+	struct hiddev_usage_ref *uref;
+	struct hid_report *report;
+	struct hid_field *field;
+	int i;
+
+	uref_multi = kmalloc(sizeof(struct hiddev_usage_ref_multi), GFP_KERNEL);
+	if (!uref_multi)
+		return -ENOMEM;
+	uref = &uref_multi->uref;
+	if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
+		if (copy_from_user(uref_multi, user_arg,
+				   sizeof(*uref_multi)))
+			goto fault;
+	} else {
+		if (copy_from_user(uref, user_arg, sizeof(*uref)))
+			goto fault;
+	}
+
+	switch (cmd) {
+	case HIDIOCGUCODE:
+		rinfo.report_type = uref->report_type;
+		rinfo.report_id = uref->report_id;
+		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
+			goto inval;
+
+		if (uref->field_index >= report->maxfield)
+			goto inval;
+
+		field = report->field[uref->field_index];
+		if (uref->usage_index >= field->maxusage)
+			goto inval;
+
+		uref->usage_code = field->usage[uref->usage_index].hid;
+
+		if (copy_to_user(user_arg, uref, sizeof(*uref)))
+			goto fault;
+
+		kfree(uref_multi);
+		return 0;
+
+	default:
+		if (cmd != HIDIOCGUSAGE &&
+		    cmd != HIDIOCGUSAGES &&
+		    uref->report_type == HID_REPORT_TYPE_INPUT)
+			goto inval;
+
+		if (uref->report_id == HID_REPORT_ID_UNKNOWN) {
+			field = hiddev_lookup_usage(hid, uref);
+			if (field == NULL)
+				goto inval;
+		} else {
+			rinfo.report_type = uref->report_type;
+			rinfo.report_id = uref->report_id;
+			if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
+				goto inval;
+
+			if (uref->field_index >= report->maxfield)
+				goto inval;
+
+			field = report->field[uref->field_index];
+
+			if (cmd == HIDIOCGCOLLECTIONINDEX) {
+				if (uref->usage_index >= field->maxusage)
+					goto inval;
+			} else if (uref->usage_index >= field->report_count)
+				goto inval;
+
+			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
+				 (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
+				  uref->usage_index + uref_multi->num_values > field->report_count))
+				goto inval;
+			}
+
+		switch (cmd) {
+		case HIDIOCGUSAGE:
+			uref->value = field->value[uref->usage_index];
+			if (copy_to_user(user_arg, uref, sizeof(*uref)))
+				goto fault;
+			goto goodreturn;
+
+		case HIDIOCSUSAGE:
+			field->value[uref->usage_index] = uref->value;
+			goto goodreturn;
+
+		case HIDIOCGCOLLECTIONINDEX:
+			kfree(uref_multi);
+			return field->usage[uref->usage_index].collection_index;
+		case HIDIOCGUSAGES:
+			for (i = 0; i < uref_multi->num_values; i++)
+				uref_multi->values[i] =
+				    field->value[uref->usage_index + i];
+			if (copy_to_user(user_arg, uref_multi,
+					 sizeof(*uref_multi)))
+				goto fault;
+			goto goodreturn;
+		case HIDIOCSUSAGES:
+			for (i = 0; i < uref_multi->num_values; i++)
+				field->value[uref->usage_index + i] =
+				    uref_multi->values[i];
+			goto goodreturn;
+		}
+
+goodreturn:
+		kfree(uref_multi);
+		return 0;
+fault:
+		kfree(uref_multi);
+		return -EFAULT;
+inval:
+		kfree(uref_multi);
+		return -EINVAL;
+	}
+}
+
+static noinline int hiddev_ioctl_string(struct hiddev *hiddev, unsigned int cmd, void __user *user_arg)
+{
+	struct hid_device *hid = hiddev->hid;
+	struct usb_device *dev = hid_to_usb_dev(hid);
+	int idx, len;
+	char *buf;
+
+	if (get_user(idx, (int __user *)user_arg))
+		return -EFAULT;
+
+	if ((buf = kmalloc(HID_STRING_SIZE, GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	if ((len = usb_string(dev, idx, buf, HID_STRING_SIZE-1)) < 0) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	if (copy_to_user(user_arg+sizeof(int), buf, len+1)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	kfree(buf);
+
+	return len;
+}
+
 static int hiddev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct hiddev_list *list = file->private_data;
@@ -402,8 +549,6 @@ static int hiddev_ioctl(struct inode *in
 	struct hiddev_collection_info cinfo;
 	struct hiddev_report_info rinfo;
 	struct hiddev_field_info finfo;
-	struct hiddev_usage_ref_multi *uref_multi = NULL;
-	struct hiddev_usage_ref *uref;
 	struct hiddev_devinfo dinfo;
 	struct hid_report *report;
 	struct hid_field *field;
@@ -470,30 +615,7 @@ static int hiddev_ioctl(struct inode *in
 		}
 
 	case HIDIOCGSTRING:
-		{
-			int idx, len;
-			char *buf;
-
-			if (get_user(idx, (int __user *)arg))
-				return -EFAULT;
-
-			if ((buf = kmalloc(HID_STRING_SIZE, GFP_KERNEL)) == NULL)
-				return -ENOMEM;
-
-			if ((len = usb_string(dev, idx, buf, HID_STRING_SIZE-1)) < 0) {
-				kfree(buf);
-				return -EINVAL;
-			}
-
-			if (copy_to_user(user_arg+sizeof(int), buf, len+1)) {
-				kfree(buf);
-				return -EFAULT;
-			}
-
-			kfree(buf);
-
-			return len;
-		}
+		return hiddev_ioctl_string(hiddev, cmd, user_arg);
 
 	case HIDIOCINITREPORT:
 		usbhid_init_reports(hid);
@@ -578,121 +700,13 @@ static int hiddev_ioctl(struct inode *in
 		return 0;
 
 	case HIDIOCGUCODE:
-		uref_multi = kmalloc(sizeof(struct hiddev_usage_ref_multi), GFP_KERNEL);
-		if (!uref_multi)
-			return -ENOMEM;
-		uref = &uref_multi->uref;
-		if (copy_from_user(uref, user_arg, sizeof(*uref)))
-			goto fault;
-
-		rinfo.report_type = uref->report_type;
-		rinfo.report_id = uref->report_id;
-		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
-			goto inval;
-
-		if (uref->field_index >= report->maxfield)
-			goto inval;
-
-		field = report->field[uref->field_index];
-		if (uref->usage_index >= field->maxusage)
-			goto inval;
-
-		uref->usage_code = field->usage[uref->usage_index].hid;
-
-		if (copy_to_user(user_arg, uref, sizeof(*uref)))
-			goto fault;
-
-		kfree(uref_multi);
-		return 0;
-
+		/* fall through */
 	case HIDIOCGUSAGE:
 	case HIDIOCSUSAGE:
 	case HIDIOCGUSAGES:
 	case HIDIOCSUSAGES:
 	case HIDIOCGCOLLECTIONINDEX:
-		uref_multi = kmalloc(sizeof(struct hiddev_usage_ref_multi), GFP_KERNEL);
-		if (!uref_multi)
-			return -ENOMEM;
-		uref = &uref_multi->uref;
-		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
-			if (copy_from_user(uref_multi, user_arg,
-					   sizeof(*uref_multi)))
-				goto fault;
-		} else {
-			if (copy_from_user(uref, user_arg, sizeof(*uref)))
-				goto fault;
-		}
-
-		if (cmd != HIDIOCGUSAGE &&
-		    cmd != HIDIOCGUSAGES &&
-		    uref->report_type == HID_REPORT_TYPE_INPUT)
-			goto inval;
-
-		if (uref->report_id == HID_REPORT_ID_UNKNOWN) {
-			field = hiddev_lookup_usage(hid, uref);
-			if (field == NULL)
-				goto inval;
-		} else {
-			rinfo.report_type = uref->report_type;
-			rinfo.report_id = uref->report_id;
-			if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
-				goto inval;
-
-			if (uref->field_index >= report->maxfield)
-				goto inval;
-
-			field = report->field[uref->field_index];
-
-			if (cmd == HIDIOCGCOLLECTIONINDEX) {
-				if (uref->usage_index >= field->maxusage)
-					goto inval;
-			} else if (uref->usage_index >= field->report_count)
-				goto inval;
-
-			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
-				 (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-				  uref->usage_index + uref_multi->num_values > field->report_count))
-				goto inval;
-			}
-
-		switch (cmd) {
-			case HIDIOCGUSAGE:
-				uref->value = field->value[uref->usage_index];
-				if (copy_to_user(user_arg, uref, sizeof(*uref)))
-					goto fault;
-				goto goodreturn;
-
-			case HIDIOCSUSAGE:
-				field->value[uref->usage_index] = uref->value;
-				goto goodreturn;
-
-			case HIDIOCGCOLLECTIONINDEX:
-				kfree(uref_multi);
-				return field->usage[uref->usage_index].collection_index;
-			case HIDIOCGUSAGES:
-				for (i = 0; i < uref_multi->num_values; i++)
-					uref_multi->values[i] =
-					    field->value[uref->usage_index + i];
-				if (copy_to_user(user_arg, uref_multi,
-						 sizeof(*uref_multi)))
-					goto fault;
-				goto goodreturn;
-			case HIDIOCSUSAGES:
-				for (i = 0; i < uref_multi->num_values; i++)
-					field->value[uref->usage_index + i] =
-					    uref_multi->values[i];
-				goto goodreturn;
-		}
-
-goodreturn:
-		kfree(uref_multi);
-		return 0;
-fault:
-		kfree(uref_multi);
-		return -EFAULT;
-inval:
-		kfree(uref_multi);
-		return -EINVAL;
+		return hiddev_ioctl_usage(hiddev, cmd, user_arg);
 
 	case HIDIOCGCOLLECTIONINFO:
 		if (copy_from_user(&cinfo, user_arg, sizeof(cinfo)))


-- 
Jean Delvare
