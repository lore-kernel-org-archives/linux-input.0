From: Avraham Shukron <avraham.shukron@gmail.com>
Subject: [PATCH] hid: usbhid: hiddev.c: fix checkpatch.pl errors
Date: Sun, 26 Feb 2017 22:10:01 +0200
Message-ID: <cbe21238-e75c-8074-963d-6c1e849f2182@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

- Extracted assignments out of 'if' statements
- Removed unnecessary spaces
- Broke long lines
- Added empty lines after declarations

Signed-off-by: Avraham Shukron <avraham.shukron@gmail.com>
---
 drivers/hid/usbhid/hiddev.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 700145b..a75ff0a 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -60,7 +60,7 @@ struct hiddev_list {
 	struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
 	int head;
 	int tail;
-	unsigned flags;
+	unsigned int flags;
 	struct fasync_struct *fasync;
 	struct hiddev *hiddev;
 	struct list_head node;
@@ -187,7 +187,7 @@ static void hiddev_send_event(struct hid_device *hid,
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value)
 {
-	unsigned type = field->report_type;
+	unsigned int type = field->report_type;
 	struct hiddev_usage_ref uref;

 	uref.report_type =
@@ -206,7 +206,7 @@ EXPORT_SYMBOL_GPL(hiddev_hid_event);

 void hiddev_report_event(struct hid_device *hid, struct hid_report *report)
 {
-	unsigned type = report->type;
+	unsigned int type = report->type;
 	struct hiddev_usage_ref uref;

 	memset(&uref, 0, sizeof(uref));
@@ -234,7 +234,7 @@ static int hiddev_fasync(int fd, struct file *file, int on)
 /*
  * release file op
  */
-static int hiddev_release(struct inode * inode, struct file * file)
+static int hiddev_release(struct inode *inode, struct file *file)
 {
 	struct hiddev_list *list = file->private_data;
 	unsigned long flags;
@@ -279,7 +279,8 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	hid = usb_get_intfdata(intf);
 	hiddev = hid->hiddev;

-	if (!(list = vzalloc(sizeof(struct hiddev_list))))
+	list = vzalloc(sizeof(struct hiddev_list));
+	if (!list)
 		return -ENOMEM;
 	mutex_init(&list->thread_lock);
 	list->hiddev = hiddev;
@@ -310,6 +311,7 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	if (!list->hiddev->open++)
 		if (list->hiddev->exist) {
 			struct hid_device *hid = hiddev->hid;
+
 			res = usbhid_get_power(hid);
 			if (res < 0) {
 				res = -EIO;
@@ -330,7 +332,8 @@ static int hiddev_open(struct inode *inode, struct file *file)
 /*
  * "write" file op
  */
-static ssize_t hiddev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_write(struct file *file, const char __user *buffer,
+		size_t count, loff_t *ppos)
 {
 	return -EINVAL;
 }
@@ -338,7 +341,8 @@ static ssize_t hiddev_write(struct file * file, const char __user * buffer, size
 /*
  * "read" file op
  */
-static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_read(struct file *file, char __user *buffer,
+		size_t count, loff_t *ppos)
 {
 	DEFINE_WAIT(wait);
 	struct hiddev_list *list = file->private_data;
@@ -358,7 +362,8 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun

 	while (retval == 0) {
 		if (list->head == list->tail) {
-			prepare_to_wait(&list->hiddev->wait, &wait, TASK_INTERRUPTIBLE);
+			prepare_to_wait(&list->hiddev->wait,
+					&wait, TASK_INTERRUPTIBLE);

 			while (list->head == list->tail) {
 				if (signal_pending(current)) {
@@ -446,7 +451,8 @@ static unsigned int hiddev_poll(struct file *file, poll_table *wait)
 /*
  * "ioctl" file op
  */
-static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd, void __user *user_arg)
+static noinline int hiddev_ioctl_usage(struct hiddev *hiddev,
+		unsigned int cmd, void __user *user_arg)
 {
 	struct hid_device *hid = hiddev->hid;
 	struct hiddev_report_info rinfo;
@@ -473,7 +479,8 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 	case HIDIOCGUCODE:
 		rinfo.report_type = uref->report_type;
 		rinfo.report_id = uref->report_id;
-		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
+		report = hiddev_lookup_report(hid, &rinfo);
+		if (report == NULL)
 			goto inval;

 		if (uref->field_index >= report->maxfield)
@@ -503,7 +510,8 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 		} else {
 			rinfo.report_type = uref->report_type;
 			rinfo.report_id = uref->report_id;
-			if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
+			report = hiddev_lookup_report(hid, &rinfo);
+			if (report == NULL)
 				goto inval;

 			if (uref->field_index >= report->maxfield)
@@ -565,7 +573,8 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 	}
 }

-static noinline int hiddev_ioctl_string(struct hiddev *hiddev, unsigned int cmd, void __user *user_arg)
+static noinline int hiddev_ioctl_string(struct hiddev *hiddev,
+		unsigned int cmd, void __user *user_arg)
 {
 	struct hid_device *hid = hiddev->hid;
 	struct usb_device *dev = hid_to_usb_dev(hid);
@@ -575,10 +584,12 @@ static noinline int hiddev_ioctl_string(struct hiddev *hiddev, unsigned int cmd,
 	if (get_user(idx, (int __user *)user_arg))
 		return -EFAULT;

-	if ((buf = kmalloc(HID_STRING_SIZE, GFP_KERNEL)) == NULL)
+	buf = kmalloc(HID_STRING_SIZE, GFP_KERNEL);
+	if (buf == NULL)
 		return -ENOMEM;

-	if ((len = usb_string(dev, idx, buf, HID_STRING_SIZE-1)) < 0) {
+	len = usb_string(dev, idx, buf, HID_STRING_SIZE-1);
+	if (len < 0) {
 		kfree(buf);
 		return -EINVAL;
 	}
@@ -816,8 +827,10 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)

 		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGNAME(0))) {
 			int len = strlen(hid->name) + 1;
+
 			if (len > _IOC_SIZE(cmd))
-				 len = _IOC_SIZE(cmd);
+				len = _IOC_SIZE(cmd);
+
 			r = copy_to_user(user_arg, hid->name, len) ?
 				-EFAULT : len;
 			break;
@@ -825,6 +838,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)

 		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGPHYS(0))) {
 			int len = strlen(hid->phys) + 1;
+
 			if (len > _IOC_SIZE(cmd))
 				len = _IOC_SIZE(cmd);
 			r = copy_to_user(user_arg, hid->phys, len) ?
@@ -839,7 +853,8 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }

 #ifdef CONFIG_COMPAT
-static long hiddev_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long hiddev_compat_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg)
 {
 	return hiddev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
@@ -883,6 +898,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)

 	if (!force) {
 		unsigned int i;
+
 		for (i = 0; i < hid->maxcollection; i++)
 			if (hid->collection[i].type ==
 			    HID_COLLECTION_APPLICATION &&
@@ -893,7 +909,8 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 			return -1;
 	}

-	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
+	hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL);
+	if (!hiddev)
 		return -1;

 	init_waitqueue_head(&hiddev->wait);
-- 
2.7.4
