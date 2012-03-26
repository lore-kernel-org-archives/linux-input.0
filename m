From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC v2 1/1] HID: User-space I/O driver support for HID subsystem
Date: Mon, 26 Mar 2012 22:20:09 +0200
Message-ID: <1332793209-2950-2-git-send-email-dh.herrmann@googlemail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54288 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab2CZUUi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 16:20:38 -0400
In-Reply-To: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, anderson.lizardo@openbossa.org, marcel@holtmann.org, David Herrmann <dh.herrmann@googlemail.com>

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
file in Documentation/hid/ explaining the ABI and an example user-space
program that uses this interface in samples/uhid/.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/hid/uhid.txt  |  152 ++++++++++++++
 drivers/hid/Kconfig         |   21 ++
 drivers/hid/Makefile        |    2 +-
 drivers/hid/uhid.c          |  477 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild        |    1 +
 include/linux/uhid.h        |   84 ++++++++
 samples/uhid/Makefile       |   10 +
 samples/uhid/uhid-example.c |  381 ++++++++++++++++++++++++++++++++++
 8 files changed, 1127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/uhid.txt
 create mode 100644 drivers/hid/uhid.c
 create mode 100644 include/linux/uhid.h
 create mode 100644 samples/uhid/Makefile
 create mode 100644 samples/uhid/uhid-example.c

diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
new file mode 100644
index 0000000..cb9acae
--- /dev/null
+++ b/Documentation/hid/uhid.txt
@@ -0,0 +1,152 @@
+      UHID - User-space I/O driver support for HID subsystem
+     ========================================================
+
+The HID subsystem needs two kinds of drivers. In this document we call them:
+
+ 1. The "HID I/O Driver" is the driver that performs raw data I/O to the
+    low-level device. Internally, they register an hid_ll_driver structure with
+    the HID core. They perform device setup, read raw data from the device and
+    push it into the HID subsystem and they provide a callback so the HID
+    subsystem can send data to the device.
+
+ 2. The "HID Device Driver" is the driver that parses HID reports and reacts on
+    them. There are generic drivers like "generic-usb" and "generic-bluetooth"
+    which adhere to the HID specification and provide the standardizes features.
+    But there may be special drivers and quirks for each non-standard device out
+    there. Internally, they use the hid_driver structure.
+
+Historically, the USB stack was the first subsystem to provide an HID I/O
+Driver. However, other standards like Bluetooth have adopted the HID specs and
+may provide HID I/O Drivers, too. The UHID driver allows to implement HID I/O
+Drivers in user-space and feed the data into the kernel HID-subsystem.
+
+This allows user-space to operate on the same level as USB-HID, Bluetooth-HID
+and similar. It does not provide a way to write HID Device Drivers, though. Use
+hidraw for this purpose.
+
+There is an example user-space application in ./samples/uhid/uhid-example.c
+
+The UHID API
+------------
+
+UHID is accessed through a character misc-device. The minor-number is allocated
+dynamically so you need to rely on udev (or similar) to create the device node.
+This is /dev/uhid by default.
+
+If a new device is detected by your HID I/O Driver and you want to register this
+device with the HID subsystem, then you need to open /dev/uhid once for each
+device you want to register. All further communication is done by read()'ing or
+write()'ing "struct uhid_event" objects. Non-blocking operations are supported
+by setting O_NONBLOCK.
+
+struct uhid_event {
+        __u32 type;
+        union {
+                struct uhid_create_req create;
+                struct uhid_data_req data;
+                ...
+        } u;
+};
+
+The "type" field contains the ID of the event. Depending on the ID different
+payloads are sent. You must not split a single event across multiple read()'s or
+multiple write()'s. A single event must always be sent as a whole. Furthermore,
+only a single event can be sent per read() or write(). Pending data is ignored.
+If you want to handle multiple events in a single syscall, then use vectored
+I/O with readv()/writev().
+
+The first thing you should do is sending an UHID_CREATE event. This will
+register the device. UHID will respond with an UHID_START event. You can now
+start sending data to and reading data from UHID. However, unless UHID sends the
+UHID_OPEN event, the internally attached HID Device Driver has no user attached.
+That is, you might put your device asleep unless you receive the UHID_OPEN
+event. If you receive the UHID_OPEN event, you should start I/O. If the last
+user closes the HID device, you will receive an UHID_CLOSE event. This may be
+followed by an UHID_OPEN event again and so on. There is no need to perform
+reference-counting in user-space. That is, you will never receive multiple
+UHID_OPEN events without an UHID_CLOSE event. The HID subsystem performs
+ref-counting for you.
+You may decide to ignore UHID_OPEN/UHID_CLOSE, though. I/O is allowed even
+though the device may have no users.
+
+If you want to send data to the HID subsystem, you send an HID_INPUT event with
+your raw data payload. If the kernel wants to send data to the device, you will
+read an UHID_OUTPUT or UHID_OUTPUT_EV event.
+
+If your device disconnects, you should send an UHID_DESTROY event. This will
+unregister the device. You can now send UHID_CREATE again to register a new
+device.
+If you close() the fd, the device is automatically unregistered and destroyed
+internally.
+
+write()
+-------
+write() allows you to modify the state of the device and feed input data into
+the kernel. The following types are supported: UHID_CREATE, UHID_DESTROY and
+UHID_INPUT. The kernel will parse the event immediately and if the event ID is
+not supported, it will return -EOPNOTSUPP. If the payload is invalid, then
+-EINVAL is returned, otherwise, the amount of data that was read is returned and
+the request was handled successfully.
+
+  UHID_CREATE:
+  This creates the internal HID device. No I/O is possible until you send this
+  event to the kernel. The payload is of type struct uhid_create_req and
+  contains information about your device. You can start I/O now.
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
+  UHID_CREATE. This is always the first event that is sent.
+
+  UHID_STOP:
+  This is sent when the HID device is stopped. Consider this as an answer to
+  UHID_DESTROY.
+  If the kernel HID device driver closes the device manually (that is, you
+  didn't send UHID_DESTROY) then you should consider this device closed and send
+  an UHID_DESTROY event. You may want to reregister your device, though. This is
+  always the last message that is sent to you unless you reopen the device with
+  UHID_CREATE.
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
index 54cc92f..f6d47cd 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -55,6 +55,27 @@ config HIDRAW
 
 	If unsure, say Y.
 
+config UHID
+	tristate "User-space I/O driver support for HID subsystem"
+	depends on HID
+	default n
+	---help---
+	Say Y here if you want to provide HID I/O Drivers from user-space.
+	This allows to write I/O drivers in user-space and feed the data from
+	the device into the kernel. The kernel parses the HID reports, loads the
+	corresponding HID Device Driver or provides input devices on top of your
+	user-space device.
+
+	This driver cannot be used to parse HID-reports in user-space and write
+	special HID-drivers. You should use hidraw for that.
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
index 0000000..f386b63
--- /dev/null
+++ b/drivers/hid/uhid.c
@@ -0,0 +1,477 @@
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
+struct uhid_device {
+	struct mutex devlock;
+	bool running;
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
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+	uhid->assemble.type = UHID_CLOSE;
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+}
+
+static int uhid_hid_power(struct hid_device *hid, int level)
+{
+	/* TODO: Handle PM-hints. This isn't mandatory so we simply return 0
+	 * here.
+	 */
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
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+
+	uhid->assemble.type = UHID_OUTPUT_EV;
+	uhid->assemble.u.output_ev.type = type;
+	uhid->assemble.u.output_ev.code = code;
+	uhid->assemble.u.output_ev.value = value;
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
+	return hid_parse_report(hid, uhid->rd_data, uhid->rd_size);
+}
+
+static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
+				__u8 *buf, size_t count, unsigned char rtype)
+{
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
+	spin_lock_irqsave(&uhid->qlock, flags);
+	memset(&uhid->assemble, 0, sizeof(uhid->assemble));
+
+	uhid->assemble.type = UHID_OUTPUT;
+	uhid->assemble.u.output.size = count;
+	uhid->assemble.u.output.rtype = rtype;
+	memcpy(uhid->assemble.u.output.data, buf, count);
+
+	uhid_queue(uhid, &uhid->assemble);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return count;
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
+	if (uhid->running) {
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
+	hid->bus = ev->u.create.bus;
+	hid->vendor = ev->u.create.vendor;
+	hid->product = ev->u.create.product;
+	hid->version = ev->u.create.version;
+	hid->country = ev->u.create.country;
+	hid->phys[0] = 0;
+	hid->uniq[0] = 0;
+	hid->driver_data = uhid;
+	hid->dev.parent = uhid->parent;
+
+	uhid->hid = hid;
+	uhid->running = true;
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		pr_err("Cannot register HID device\n");
+		goto err_hid;
+	}
+
+	mutex_unlock(&uhid->devlock);
+
+	return 0;
+
+err_hid:
+	hid_destroy_device(hid);
+	uhid->hid = NULL;
+	uhid->running = false;
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
+	if (!uhid->running) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	hid_destroy_device(uhid->hid);
+	kfree(uhid->rd_data);
+	uhid->running = false;
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
+	if (!uhid->running) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
+				ev->u.input.size, 0);
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
+	uhid->running = false;
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
+	int ret;
+	unsigned long flags;
+	size_t len;
+
+	/* they need at least the "type" member of uhid_event */
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
+	ret = mutex_lock_interruptible(&uhid->devlock);
+	if (ret)
+		return ret;
+
+	if (uhid->head == uhid->tail) {
+		mutex_unlock(&uhid->devlock);
+		goto try_again;
+	} else {
+		len = min(count, sizeof(*uhid->outq));
+		if (copy_to_user(buffer, &uhid->outq[uhid->tail], len)) {
+			ret = -EFAULT;
+		} else {
+			spin_lock_irqsave(&uhid->qlock, flags);
+			uhid->tail = (uhid->tail + 1) % UHID_BUFSIZE;
+			spin_unlock_irqrestore(&uhid->qlock, flags);
+		}
+	}
+
+	mutex_unlock(&uhid->devlock);
+	return ret ? ret : len;
+}
+
+static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct uhid_device *uhid = file->private_data;
+	int ret;
+	size_t len;
+
+	/* we need at least the "type" member of uhid_event */
+	if (count < sizeof(__u32))
+		return -EINVAL;
+
+	memset(&uhid->input_buf, 0, sizeof(uhid->input_buf));
+	len = min(count, sizeof(uhid->input_buf));
+	if (copy_from_user(&uhid->input_buf, buffer, len))
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
+			ret = -EOPNOTSUPP;
+	}
+
+	/* return "count" not "len" to not confuse the caller */
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
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index c94e717..b8d5ed0 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -370,6 +370,7 @@ header-y += tty.h
 header-y += types.h
 header-y += udf_fs_i.h
 header-y += udp.h
+header-y += uhid.h
 header-y += uinput.h
 header-y += uio.h
 header-y += ultrasound.h
diff --git a/include/linux/uhid.h b/include/linux/uhid.h
new file mode 100644
index 0000000..67d9c8d
--- /dev/null
+++ b/include/linux/uhid.h
@@ -0,0 +1,84 @@
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
+/*
+ * Public header for user-space communication. We try to keep every structure
+ * aligned but to be safe we also use __attribute__((packed)). Therefore, the
+ * communication should be ABI compatible even between architectures.
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
+	__u8 name[128];
+	__u8 __user *rd_data;
+	__u16 rd_size;
+
+	__u16 bus;
+	__u32 vendor;
+	__u32 product;
+	__u32 version;
+	__u32 country;
+} __attribute__((packed));
+
+#define UHID_DATA_MAX 4096
+
+enum uhid_report_type {
+	UHID_FEATURE_REPORT,
+	UHID_OUTPUT_REPORT,
+};
+
+struct uhid_input_req {
+	__u8 data[UHID_DATA_MAX];
+	__u16 size;
+} __attribute__((packed));
+
+struct uhid_output_req {
+	__u8 data[UHID_DATA_MAX];
+	__u16 size;
+	__u8 rtype;
+} __attribute__((packed));
+
+struct uhid_output_ev_req {
+	__u16 type;
+	__u16 code;
+	__s32 value;
+} __attribute__((packed));
+
+struct uhid_event {
+	__u32 type;
+
+	union {
+		struct uhid_create_req create;
+		struct uhid_input_req input;
+		struct uhid_output_req output;
+		struct uhid_output_ev_req output_ev;
+	} u;
+} __attribute__((packed));
+
+#endif /* __UHID_H_ */
diff --git a/samples/uhid/Makefile b/samples/uhid/Makefile
new file mode 100644
index 0000000..c95a696
--- /dev/null
+++ b/samples/uhid/Makefile
@@ -0,0 +1,10 @@
+# kbuild trick to avoid linker error. Can be omitted if a module is built.
+obj- := dummy.o
+
+# List of programs to build
+hostprogs-y := uhid-example
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_uhid-example.o += -I$(objtree)/usr/include
diff --git a/samples/uhid/uhid-example.c b/samples/uhid/uhid-example.c
new file mode 100644
index 0000000..03ce3c0
--- /dev/null
+++ b/samples/uhid/uhid-example.c
@@ -0,0 +1,381 @@
+/*
+ * UHID Example
+ *
+ * Copyright (c) 2012 David Herrmann <dh.herrmann@googlemail.com>
+ *
+ * The code may be used by anyone for any purpose,
+ * and can serve as a starting point for developing
+ * applications using uhid.
+ */
+
+/* UHID Example
+ * This example emulates a basic 3 buttons mouse with wheel over UHID. Run this
+ * program as root and then use the following keys to control the mouse:
+ *   q: Quit the application
+ *   1: Toggle left button (down, up, ...)
+ *   2: Toggle right button
+ *   3: Toggle middle button
+ *   a: Move mouse left
+ *   d: Move mouse right
+ *   w: Move mouse up
+ *   s: Move mouse down
+ *   r: Move wheel up
+ *   f: Move wheel down
+ *
+ * If uhid is not available as /dev/uhid, then you can pass a different path as
+ * first argument.
+ * If <linux/uhid.h> is not installed in /usr, then compile this with:
+ *   gcc -o ./uhid_test -Wall -I./include ./samples/uhid/uhid-example.c
+ * And ignore the warning about kernel headers. However, it is recommended to
+ * use the installed uhid.h if available.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <termios.h>
+#include <unistd.h>
+#include <linux/uhid.h>
+
+/* HID Report Desciptor
+ * We emulate a basic 3 button mouse with wheel. This is the report-descriptor
+ * as the kernel will parse it:
+ *
+ * INPUT[INPUT]
+ *   Field(0)
+ *     Physical(GenericDesktop.Pointer)
+ *     Application(GenericDesktop.Mouse)
+ *     Usage(3)
+ *       Button.0001
+ *       Button.0002
+ *       Button.0003
+ *     Logical Minimum(0)
+ *     Logical Maximum(1)
+ *     Report Size(1)
+ *     Report Count(3)
+ *     Report Offset(0)
+ *     Flags( Variable Absolute )
+ *   Field(1)
+ *     Physical(GenericDesktop.Pointer)
+ *     Application(GenericDesktop.Mouse)
+ *     Usage(3)
+ *       GenericDesktop.X
+ *       GenericDesktop.Y
+ *       GenericDesktop.Wheel
+ *     Logical Minimum(-128)
+ *     Logical Maximum(127)
+ *     Report Size(8)
+ *     Report Count(3)
+ *     Report Offset(8)
+ *     Flags( Variable Relative )
+ *
+ * This is the mapping that we expect:
+ *   Button.0001 ---> Key.LeftBtn
+ *   Button.0002 ---> Key.RightBtn
+ *   Button.0003 ---> Key.MiddleBtn
+ *   GenericDesktop.X ---> Relative.X
+ *   GenericDesktop.Y ---> Relative.Y
+ *   GenericDesktop.Wheel ---> Relative.Wheel
+ *
+ * This information can be verified by reading /sys/kernel/debug/hid/<dev>/rdesc
+ * This file should print the same information as showed above.
+ */
+
+static unsigned char rdesc[] = {
+	0x05, 0x01, 0x09, 0x02, 0xa1, 0x01, 0x09, 0x01,
+	0xa1, 0x00, 0x05, 0x09, 0x19, 0x01, 0x29, 0x03,
+	0x15, 0x00, 0x25, 0x01, 0x95, 0x03, 0x75, 0x01,
+	0x81, 0x02, 0x95, 0x01, 0x75, 0x05, 0x81, 0x01,
+	0x05, 0x01, 0x09, 0x30, 0x09, 0x31, 0x09, 0x38,
+	0x15, 0x80, 0x25, 0x7f, 0x75, 0x08, 0x95, 0x03,
+	0x81, 0x06, 0xc0, 0xc0,
+};
+
+static int uhid_write(int fd, const struct uhid_event *ev)
+{
+	ssize_t ret;
+
+	ret = write(fd, ev, sizeof(*ev));
+	if (ret < 0) {
+		fprintf(stderr, "Cannot write to uhid: %m\n");
+		return -errno;
+	} else if (ret != sizeof(*ev)) {
+		fprintf(stderr, "Wrong size written to uhid: %ld != %lu\n",
+			ret, sizeof(ev));
+		return -EFAULT;
+	} else {
+		return 0;
+	}
+}
+
+static int create(int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char*)ev.u.create.name, "test-uhid-device");
+	ev.u.create.rd_data = rdesc;
+	ev.u.create.rd_size = sizeof(rdesc);
+	ev.u.create.bus = BUS_USB;
+	ev.u.create.vendor = 0x15d9;
+	ev.u.create.product = 0x0a37;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+
+	return uhid_write(fd, &ev);
+}
+
+static void destroy(int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	uhid_write(fd, &ev);
+}
+
+static int event(int fd)
+{
+	struct uhid_event ev;
+	ssize_t ret;
+
+	memset(&ev, 0, sizeof(ev));
+	ret = read(fd, &ev, sizeof(ev));
+	if (ret == 0) {
+		fprintf(stderr, "Read HUP on uhid-cdev\n");
+		return -EFAULT;
+	} else if (ret < 0) {
+		fprintf(stderr, "Cannot read uhid-cdev: %m\n");
+		return -errno;
+	} else if (ret != sizeof(ev)) {
+		fprintf(stderr, "Invalid size read from uhid-dev: %ld != %lu\n",
+			ret, sizeof(ev));
+		return -EFAULT;
+	}
+
+	switch (ev.type) {
+	case UHID_START:
+		fprintf(stderr, "UHID_START from uhid-dev\n");
+		break;
+	case UHID_STOP:
+		fprintf(stderr, "UHID_STOP from uhid-dev\n");
+		break;
+	case UHID_OPEN:
+		fprintf(stderr, "UHID_OPEN from uhid-dev\n");
+		break;
+	case UHID_CLOSE:
+		fprintf(stderr, "UHID_CLOSE from uhid-dev\n");
+		break;
+	case UHID_OUTPUT:
+		fprintf(stderr, "UHID_OUTPUT from uhid-dev\n");
+		break;
+	case UHID_OUTPUT_EV:
+		fprintf(stderr, "UHID_OUTPUT_EV from uhid-dev\n");
+		break;
+	default:
+		fprintf(stderr, "Invalid event from uhid-dev: %u\n", ev.type);
+	}
+
+	return 0;
+}
+
+static bool btn1_down;
+static bool btn2_down;
+static bool btn3_down;
+static signed char abs_hor;
+static signed char abs_ver;
+static signed char wheel;
+
+static int send_event(int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = 4;
+
+	if (btn1_down)
+		ev.u.input.data[0] |= 0x1;
+	if (btn2_down)
+		ev.u.input.data[0] |= 0x2;
+	if (btn3_down)
+		ev.u.input.data[0] |= 0x4;
+
+	ev.u.input.data[1] = abs_hor;
+	ev.u.input.data[2] = abs_ver;
+	ev.u.input.data[3] = wheel;
+
+	return uhid_write(fd, &ev);
+}
+
+static int keyboard(int fd)
+{
+	char buf[128];
+	ssize_t ret, i;
+
+	ret = read(STDIN_FILENO, buf, sizeof(buf));
+	if (ret == 0) {
+		fprintf(stderr, "Read HUP on stdin\n");
+		return -EFAULT;
+	} else if (ret < 0) {
+		fprintf(stderr, "Cannot read stdin: %m\n");
+		return -errno;
+	}
+
+	for (i = 0; i < ret; ++i) {
+		switch (buf[i]) {
+		case '1':
+			btn1_down = !btn1_down;
+			ret = send_event(fd);
+			if (ret)
+				return ret;
+			break;
+		case '2':
+			btn2_down = !btn2_down;
+			ret = send_event(fd);
+			if (ret)
+				return ret;
+			break;
+		case '3':
+			btn3_down = !btn3_down;
+			ret = send_event(fd);
+			if (ret)
+				return ret;
+			break;
+		case 'a':
+			abs_hor = -20;
+			ret = send_event(fd);
+			abs_hor = 0;
+			if (ret)
+				return ret;
+			break;
+		case 'd':
+			abs_hor = 20;
+			ret = send_event(fd);
+			abs_hor = 0;
+			if (ret)
+				return ret;
+			break;
+		case 'w':
+			abs_ver = -20;
+			ret = send_event(fd);
+			abs_ver = 0;
+			if (ret)
+				return ret;
+			break;
+		case 's':
+			abs_ver = 20;
+			ret = send_event(fd);
+			abs_ver = 0;
+			if (ret)
+				return ret;
+			break;
+		case 'r':
+			wheel = 1;
+			ret = send_event(fd);
+			wheel = 0;
+			if (ret)
+				return ret;
+			break;
+		case 'f':
+			wheel = -1;
+			ret = send_event(fd);
+			wheel = 0;
+			if (ret)
+				return ret;
+			break;
+		case 'q':
+			return -ECANCELED;
+		default:
+			fprintf(stderr, "Invalid input: %c\n", buf[i]);
+		}
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+	const char *path = "/dev/uhid";
+	struct pollfd pfds[2];
+	int ret;
+	struct termios state;
+
+	ret = tcgetattr(STDIN_FILENO, &state);
+	if (ret) {
+		fprintf(stderr, "Cannot get tty state\n");
+	} else {
+		state.c_lflag &= ~ICANON;
+		state.c_cc[VMIN] = 1;
+		ret = tcsetattr(STDIN_FILENO, TCSANOW, &state);
+		if (ret)
+			fprintf(stderr, "Cannot set tty state\n");
+	}
+
+	if (argc >= 2) {
+		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
+			fprintf(stderr, "Usage: %s [%s]\n", argv[0], path);
+			return EXIT_SUCCESS;
+		} else {
+			path = argv[1];
+		}
+	}
+
+	fprintf(stderr, "Open uhid-cdev %s\n", path);
+	fd = open(path, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open uhid-cdev %s: %m\n", path);
+		return EXIT_FAILURE;
+	}
+
+	fprintf(stderr, "Create uhid device\n");
+	ret = create(fd);
+	if (ret) {
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
+	pfds[0].fd = STDIN_FILENO;
+	pfds[0].events = POLLIN;
+	pfds[1].fd = fd;
+	pfds[1].events = POLLIN;
+
+	fprintf(stderr, "Press 'q' to quit...\n");
+	while (1) {
+		ret = poll(pfds, 2, -1);
+		if (ret < 0) {
+			fprintf(stderr, "Cannot poll for fds: %m\n");
+			break;
+		}
+		if (pfds[0].revents & POLLHUP) {
+			fprintf(stderr, "Received HUP on stdin\n");
+			break;
+		}
+		if (pfds[1].revents & POLLHUP) {
+			fprintf(stderr, "Received HUP on uhid-cdev\n");
+			break;
+		}
+
+		if (pfds[0].revents & POLLIN) {
+			ret = keyboard(fd);
+			if (ret)
+				break;
+		}
+		if (pfds[1].revents & POLLIN) {
+			ret = event(fd);
+			if (ret)
+				break;
+		}
+	}
+
+	fprintf(stderr, "Destroy uhid device\n");
+	destroy(fd);
+	return EXIT_SUCCESS;
+}
-- 
1.7.9.4

