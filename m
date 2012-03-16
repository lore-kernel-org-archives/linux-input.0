From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Fri, 16 Mar 2012 15:53:37 +0100
Message-ID: <1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44926 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761777Ab2CPOy2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 10:54:28 -0400
In-Reply-To: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com, David Herrmann <dh.herrmann@googlemail.com>

This driver allows to write I/O drivers in user-space and feed the input
into the HID subsystem. It operates on the same level as USB-HID and
Bluetooth-HID (HIDP). It does not provide support to write special HID
device drivers but rather provides support for user-space I/O devices to
feed their data into the kernel HID subsystem. The HID subsystem then
loads the HID device drivers for the device and provides input-devices
based on the user-space HID I/O device.

This driver register a new char-device (/dev/uhid). A user-space process
has to open this file for each device that it wants to provide to the
kernel. It can then use write/read to communicate with the UHID driver.
Both input and output data is sent with a uhid_event structure. The "type"
field of the structure specifies what kind of event is sent. There is a
file in Documentation/ explaining the ABI.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/hid/uhid.txt |   95 +++++++++
 drivers/hid/Kconfig        |   21 ++
 drivers/hid/Makefile       |    2 +-
 drivers/hid/uhid.c         |  502 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/uhid.h       |   71 +++++++
 5 files changed, 690 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/uhid.txt
 create mode 100644 drivers/hid/uhid.c
 create mode 100644 include/linux/uhid.h

diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
new file mode 100644
index 0000000..67b138d
--- /dev/null
+++ b/Documentation/hid/uhid.txt
@@ -0,0 +1,95 @@
+      UHID - User-space I/O driver support for HID subsystem
+     ========================================================
+
+The UHID driver provides an interface for user-space I/O drivers to feed their
+data into the HID subsystem. The HID subsystem then parses the HID reports and
+loads the corresponding HID device driver which then provides the parsed data
+via input-devices to user-space.
+
+This allows user-space to operate on the same level as USB-HID, Bluetooth-HID
+and similar. It does not provide a way to write HID device drivers, though! Use
+HIDRAW for this purpose.
+
+UHID dynamically allocates the minor/major number, meaning that you should rely
+on udev to create the UHID device node. Typically this is created as /dev/uhid.
+
+The UHID API
+------------
+
+For each device that you want to register with the HID core, you need to open a
+separate file-descriptor on /dev/uhid. All communication is done by read()'ing
+or write()'ing "struct uhid_event" objects to the file. Non-blocking operations
+via O_NONBLOCK are supported.
+
+struct uhid_event {
+        __u32 type;
+        ... payload ...
+};
+
+write()
+-------
+write() allows you to modify the state of the device and feed input data into
+the kernel. The following types are supported: UHID_CREATE, UHID_DESTROY and
+UHID_INPUT.
+
+  UHID_CREATE:
+  This creates the internal HID device. No I/O is possible until you send this
+  event to the kernel. The payload is of type struct uhid_create_req and
+  contains information about your device.
+
+  UHID_DESTROY:
+  This destroys the internal HID device. No further I/O will be accepted. There
+  may still be pending messages that you can receive with read() but no further
+  UHID_INPUT events can be sent to the kernel.
+  You can create a new device by sending UHID_CREATE again. There is no need to
+  reopen the character device.
+
+  UHID_INPUT:
+  You must send UHID_CREATE before sending input to the kernel! This event
+  contains a data-payload. This is the raw data that you read from your device.
+  The kernel will parse the HID reports and react on it.
+
+read()
+------
+read() will return a queued ouput report. These output reports can be of type
+UHID_START, UHID_STOP, UHID_OPEN, UHID_CLOSE, UHID_OUTPUT or UHID_OUTPUT_EV. No
+reaction is required to any of them but you should handle them according to your
+needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
+
+  UHID_START:
+  This is sent when the HID device is started. Consider this as an answer to
+  UHID_CREATE. This is always the first event that is sent. No I/O is possible
+  before you read this.
+
+  UHID_STOP:
+  This is sent when the HID device is stopped. Consider this as an answer to
+  UHID_DESTROY. No further I/O will be possible after receiving this.
+  If the kernel HID device driver closes the device manually (that is, you
+  didn't send UHID_DESTROY) then you should consider this device closed and send
+  an UHID_DESTROY event. You may want to reregister your device, though.
+
+  UHID_OPEN:
+  This is sent when the HID device is opened. That is, the data that the HID
+  device provides is read by some other process. You may ignore this event but
+  it is useful for power-management. As long as you haven't received this event
+  there is actually no other process that reads your data so there is no need to
+  send UHID_INPUT events to the kernel.
+
+  UHID_CLOSE:
+  This is sent when there are no more processes which read the HID data. It is
+  the counterpart of UHID_OPEN and you may as well ignore this event.
+
+  UHID_OUTPUT:
+  This is sent if the HID device driver wants to send raw data to the I/O
+  device. You should read the payload and forward it to the device. The payload
+  is of type "struct uhid_data_req".
+  This may be received even though you haven't received UHID_OPEN, yet.
+
+  UHID_OUTPUT_EV:
+  Same as UHID_OUTPUT but this contains a "struct input_event" as payload. This
+  is called for force-feedback, LED or similar events which are received through
+  an input device by the HID subsystem. You should convert this into raw reports
+  and send them to your device similar to events of type UHID_OUTPUT.
+
+Document by:
+  David Herrmann <dh.herrmann@googlemail.com>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 54cc92f..cabe771 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -55,6 +55,27 @@ config HIDRAW
 
 	If unsure, say Y.
 
+config UHID
+	tristate "User-space I/O driver support for HID subsystem"
+	depends on HID
+	default n
+	---help---
+	Say Y here if you want to provide HID I/O drivers from user-space.
+	This allows to write I/O drivers in user-space and feed the data from
+	the device into the kernel. The kernel parses the HID reports, loads the
+	corresponding HID device driver or provides input devices on top of your
+	user-space device.
+
+	This driver cannot be used to parse HID-reports in user-space and write
+	special HID-drivers. You should use HIDRAW for that.
+	Instead, this driver allows to write the transport-layer driver in
+	user-space like USB-HID and Bluetooth-HID do in kernel-space.
+
+	If unsure, say N.
+
+	To compile this driver as a module, choose M here: the
+	module will be called uhid.
+
 source "drivers/hid/usbhid/Kconfig"
 
 menu "Special HID drivers"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 22f1d16..cadb84f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -8,6 +8,7 @@ ifdef CONFIG_DEBUG_FS
 endif
 
 obj-$(CONFIG_HID)		+= hid.o
+obj-$(CONFIG_UHID)		+= uhid.o
 
 hid-$(CONFIG_HIDRAW)		+= hidraw.o
 
@@ -88,4 +89,3 @@ obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
 obj-$(CONFIG_USB_KBD)		+= usbhid/
-
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
new file mode 100644
index 0000000..1bb16a7
--- /dev/null
+++ b/drivers/hid/uhid.c
@@ -0,0 +1,502 @@
+/*
+ * User-space I/O driver support for HID subsystem
+ * Copyright (c) 2012 David Herrmann
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/uhid.h>
+#include <linux/wait.h>
+
+#define UHID_NAME	"uhid"
+#define UHID_BUFSIZE	32
+
+enum uhid_state {
+	UHID_NEW,
+	UHID_RUNNING,
+};
+
+struct uhid_device {
+	struct mutex devlock;
+	enum uhid_state state;
+	struct device *parent;
+
+	__u8 *rd_data;
+	uint rd_size;
+
+	struct hid_device *hid;
+	struct uhid_event input_buf;
+
+	wait_queue_head_t waitq;
+	spinlock_t qlock;
+	struct uhid_event assemble;
+	__u8 head;
+	__u8 tail;
+	struct uhid_event outq[UHID_BUFSIZE];
+};
+
+static void uhid_queue(struct uhid_device *uhid, const struct uhid_event *ev)
+{
+	__u8 newhead;
+
+	newhead = (uhid->head + 1) % UHID_BUFSIZE;
+
+	if (newhead != uhid->tail) {
+		memcpy(&uhid->outq[uhid->head], ev, sizeof(struct uhid_event));
+		uhid->head = newhead;
+		wake_up_interruptible(&uhid->waitq);
+	} else {
+		pr_warn("Output queue is full\n");
+	}
+}
+
+static int uhid_hid_start(struct hid_device *hid)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+	uhid->assemble.type = UHID_START;
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return 0;
+}
+
+static void uhid_hid_stop(struct hid_device *hid)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+
+	if (uhid->state != UHID_RUNNING)
+		return;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+	uhid->assemble.type = UHID_STOP;
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	hid->claimed = 0;
+}
+
+static int uhid_hid_open(struct hid_device *hid)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+	uhid->assemble.type = UHID_OPEN;
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return 0;
+}
+
+static void uhid_hid_close(struct hid_device *hid)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+
+	if (uhid->state != UHID_RUNNING)
+		return;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+	uhid->assemble.type = UHID_CLOSE;
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+}
+
+static int uhid_hid_power(struct hid_device *hid, int level)
+{
+	struct uhid_device *uhid = hid->driver_data;
+
+	/* TODO: Handle PM-hints. This isn't mandatory so we simply return 0
+	 * here.
+	 */
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int uhid_hid_input(struct input_dev *input, unsigned int type,
+				unsigned int code, int value)
+{
+	struct hid_device *hid = input_get_drvdata(input);
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+
+	uhid->assemble.type = UHID_OUTPUT_EV;
+	uhid->assemble.u.data_ev.type = type;
+	uhid->assemble.u.data_ev.code = code;
+	uhid->assemble.u.data_ev.value = value;
+
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return 0;
+}
+
+static int uhid_hid_parse(struct hid_device *hid)
+{
+	struct uhid_device *uhid = hid->driver_data;
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	return hid_parse_report(hid, uhid->rd_data, uhid->rd_size);
+}
+
+static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
+				__u8 *buf, size_t count, unsigned char rtype)
+{
+	struct uhid_device *uhid = hid->driver_data;
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	/* TODO: we currently do not support this request. If we want this we
+	 * would need some kind of stream-locking but it isn't needed by the
+	 * main drivers, anyway.
+	 */
+
+	return -EOPNOTSUPP;
+}
+
+static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, size_t count,
+				unsigned char report_type)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	__u8 rtype;
+	unsigned long flags;
+
+	switch (report_type) {
+		case HID_FEATURE_REPORT:
+			rtype = UHID_FEATURE_REPORT;
+			break;
+		case HID_OUTPUT_REPORT:
+			rtype = UHID_OUTPUT_REPORT;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	if (count < 1 || count > UHID_DATA_MAX)
+		return -EINVAL;
+
+	if (uhid->state != UHID_RUNNING)
+		return -ENODEV;
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+
+	uhid->assemble.type = UHID_OUTPUT;
+	uhid->assemble.u.data.size = count;
+	uhid->assemble.u.data.rtype = rtype;
+	memcpy(uhid->assemble.u.data.data, buf, count);
+
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return 0;
+}
+
+static struct hid_ll_driver uhid_hid_driver = {
+	.start = uhid_hid_start,
+	.stop = uhid_hid_stop,
+	.open = uhid_hid_open,
+	.close = uhid_hid_close,
+	.power = uhid_hid_power,
+	.hidinput_input_event = uhid_hid_input,
+	.parse = uhid_hid_parse,
+};
+
+static int uhid_dev_create(struct uhid_device *uhid,
+				const struct uhid_event *ev)
+{
+	struct hid_device *hid;
+	int ret;
+
+	ret = mutex_lock_interruptible(&uhid->devlock);
+	if (ret)
+		return ret;
+
+	if (uhid->state != UHID_NEW) {
+		ret = -EALREADY;
+		goto unlock;
+	}
+
+	uhid->rd_size = ev->u.create.rd_size;
+	uhid->rd_data = kzalloc(uhid->rd_size, GFP_KERNEL);
+	if (!uhid->rd_data) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	if (copy_from_user(uhid->rd_data, ev->u.create.rd_data,
+				uhid->rd_size)) {
+		ret = -EFAULT;
+		goto err_free;
+	}
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		ret = PTR_ERR(hid);
+		goto err_free;
+	}
+
+	strncpy(hid->name, ev->u.create.name, 128);
+	hid->name[127] = 0;
+	hid->ll_driver = &uhid_hid_driver;
+	hid->hid_get_raw_report = uhid_hid_get_raw;
+	hid->hid_output_raw_report = uhid_hid_output_raw;
+	hid->bus = BUS_VIRTUAL;
+	hid->country = ev->u.create.country;
+	hid->vendor = ev->u.create.vendor;
+	hid->product = ev->u.create.product;
+	hid->version = ev->u.create.version;
+	hid->phys[0] = 0;
+	hid->uniq[0] = 0;
+	hid->driver_data = uhid;
+	hid->dev.parent = uhid->parent;
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		pr_err("Cannot register HID device\n");
+		goto err_hid;
+	}
+
+	uhid->hid = hid;
+	uhid->state = UHID_RUNNING;
+	mutex_unlock(&uhid->devlock);
+
+	return 0;
+
+err_hid:
+	hid_destroy_device(hid);
+err_free:
+	kfree(uhid->rd_data);
+unlock:
+	mutex_unlock(&uhid->devlock);
+	return ret;
+}
+
+static int uhid_dev_destroy(struct uhid_device *uhid)
+{
+	int ret;
+
+	ret = mutex_lock_interruptible(&uhid->devlock);
+	if (ret)
+		return ret;
+
+	if (uhid->state != UHID_RUNNING) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	hid_destroy_device(uhid->hid);
+	kfree(uhid->rd_data);
+	uhid->state = UHID_NEW;
+
+unlock:
+	mutex_unlock(&uhid->devlock);
+	return ret;
+}
+
+static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
+{
+	int ret;
+
+	ret = mutex_lock_interruptible(&uhid->devlock);
+	if (ret)
+		return ret;
+
+	if (uhid->state != UHID_RUNNING) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.data.data,
+				ev->u.data.size, 0);
+
+unlock:
+	mutex_unlock(&uhid->devlock);
+	return ret;
+}
+
+static int uhid_char_open(struct inode *inode, struct file *file)
+{
+	struct uhid_device *uhid;
+
+	uhid = kzalloc(sizeof(*uhid), GFP_KERNEL);
+	if (!uhid)
+		return -ENOMEM;
+
+	mutex_init(&uhid->devlock);
+	spin_lock_init(&uhid->qlock);
+	init_waitqueue_head(&uhid->waitq);
+	uhid->state = UHID_NEW;
+	uhid->parent = NULL;
+
+	file->private_data = uhid;
+	nonseekable_open(inode, file);
+
+	return 0;
+}
+
+static int uhid_char_release(struct inode *inode, struct file *file)
+{
+	struct uhid_device *uhid = file->private_data;
+
+	uhid_dev_destroy(uhid);
+	kfree(uhid);
+
+	return 0;
+}
+
+static ssize_t uhid_char_read(struct file *file, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct uhid_device *uhid = file->private_data;
+	int ret = 0;
+	unsigned long flags;
+	size_t len;
+
+	/* we need at least the "type" member of uhid_event */
+	if (count < sizeof(__u32))
+		return -EINVAL;
+
+try_again:
+	if (file->f_flags & O_NONBLOCK) {
+		if (uhid->head == uhid->tail)
+			return -EAGAIN;
+	} else {
+		ret = wait_event_interruptible(uhid->waitq,
+						uhid->head != uhid->tail);
+		if (ret)
+			return ret;
+	}
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+
+	if (uhid->head != uhid->tail) {
+		len = min_t(size_t, count, sizeof(struct uhid_event));
+		if (copy_to_user(buffer, &uhid->outq[uhid->tail], len))
+			ret = -EFAULT;
+		else
+			uhid->tail = (uhid->tail + 1) % UHID_BUFSIZE;
+		spin_unlock_irqrestore(&uhid->qlock, flags);
+	} else {
+		spin_unlock_irqrestore(&uhid->qlock, flags);
+		goto try_again;
+	}
+
+	return ret ? ret : len;
+}
+
+static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct uhid_device *uhid = file->private_data;
+	int ret;
+
+	/* we need at least the "type" member of uhid_event */
+	if (count < sizeof(__u32))
+		return -EINVAL;
+
+	memset(&uhid->input_buf, 0, sizeof(uhid->input_buf));
+	if (copy_from_user(&uhid->input_buf, buffer, count))
+		return -EFAULT;
+
+	switch (uhid->input_buf.type) {
+		case UHID_CREATE:
+			ret = uhid_dev_create(uhid, &uhid->input_buf);
+			break;
+		case UHID_DESTROY:
+			ret = uhid_dev_destroy(uhid);
+			break;
+		case UHID_INPUT:
+			ret = uhid_dev_input(uhid, &uhid->input_buf);
+			break;
+		default:
+			ret = -EINVAL;
+	}
+
+	return ret ? ret : count;
+}
+
+static unsigned int uhid_char_poll(struct file *file, poll_table *wait)
+{
+	struct uhid_device *uhid = file->private_data;
+
+	poll_wait(file, &uhid->waitq, wait);
+
+	if (uhid->head != uhid->tail)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static const struct file_operations uhid_fops = {
+	.owner		= THIS_MODULE,
+	.open		= uhid_char_open,
+	.release	= uhid_char_release,
+	.read		= uhid_char_read,
+	.write		= uhid_char_write,
+	.poll		= uhid_char_poll,
+	.llseek		= no_llseek,
+};
+
+static struct miscdevice uhid_misc = {
+	.fops		= &uhid_fops,
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= UHID_NAME,
+};
+
+static int __init uhid_init(void)
+{
+	return misc_register(&uhid_misc);
+}
+
+static void __exit uhid_exit(void)
+{
+	misc_deregister(&uhid_misc);
+}
+
+module_init(uhid_init);
+module_exit(uhid_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
+MODULE_DESCRIPTION("User-space I/O driver support for HID subsystem");
diff --git a/include/linux/uhid.h b/include/linux/uhid.h
new file mode 100644
index 0000000..1a7df0d
--- /dev/null
+++ b/include/linux/uhid.h
@@ -0,0 +1,71 @@
+#ifndef __UHID_H_
+#define __UHID_H_
+
+/*
+ * User-space I/O driver support for HID subsystem
+ * Copyright (c) 2012 David Herrmann
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/input.h>
+#include <linux/types.h>
+
+enum uhid_event_type {
+	UHID_CREATE,
+	UHID_DESTROY,
+	UHID_START,
+	UHID_STOP,
+	UHID_OPEN,
+	UHID_CLOSE,
+	UHID_OUTPUT,
+	UHID_OUTPUT_EV,
+	UHID_INPUT,
+};
+
+struct uhid_create_req {
+	__u8 __user name[128];
+	__u8 __user *rd_data;
+	__u16 rd_size;
+
+	__u16 vendor;
+	__u16 product;
+	__u16 version;
+	__u8 country;
+};
+
+#define UHID_DATA_MAX 4096
+
+enum uhid_report_type {
+	UHID_FEATURE_REPORT,
+	UHID_OUTPUT_REPORT,
+};
+
+struct uhid_data_req {
+	__u8 data[UHID_DATA_MAX];
+	__u16 size;
+	__u8 rtype;
+};
+
+struct uhid_data_ev_req {
+	__u16 type;
+	__u16 code;
+	__s32 value;
+};
+
+struct uhid_event {
+	__u32 type;
+
+	union {
+		struct uhid_create_req create;
+		struct uhid_data_req data;
+		struct input_event data_ev;
+	} u;
+};
+
+#endif /* __UHID_H_ */
-- 
1.7.9.4

