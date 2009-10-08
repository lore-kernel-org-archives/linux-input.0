From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [RFC][PATCH] Input: support the specified input device number
Date: Thu, 08 Oct 2009 11:11:23 +0900
Message-ID: <4ACD4A4B.3080200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58630 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbZJHCMB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2009 22:12:01 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KR600IB6BEZMX@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 08 Oct 2009 11:11:23 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KR600E39BEZSV@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 08 Oct 2009 11:11:23 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

Currently, the input device number is decided by order of driver probe.
But we need the specified input device number regardless of order of
driver probe because the platform or the middleware tends to access
using fixed device node of the input devices.

This patch supports to use the specified input device number when the
input device is registered. If the input device number bigger than zero
is registered before by other input device, returns error.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/evdev.c |   12 ++++--------
 drivers/input/input.c |   41 ++++++++++++++++++++++++++++++++++++++---
 include/linux/input.h |    2 ++
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 1148140..91ee7a0 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -791,16 +791,12 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 			 const struct input_device_id *id)
 {
 	struct evdev *evdev;
-	int minor;
+	int minor = dev->input_no;
 	int error;
 
-	for (minor = 0; minor < EVDEV_MINORS; minor++)
-		if (!evdev_table[minor])
-			break;
-
-	if (minor == EVDEV_MINORS) {
-		printk(KERN_ERR "evdev: no more free evdev devices\n");
-		return -ENFILE;
+	if (minor >= EVDEV_MINORS) {
+		printk(KERN_ERR "evdev: invalid evdev device number\n");
+		return -EINVAL;
 	}
 
 	evdev = kzalloc(sizeof(struct evdev), GFP_KERNEL);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index b8ed429..4d568e3 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/smp_lock.h>
+#include <linux/idr.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
@@ -59,6 +60,8 @@ static LIST_HEAD(input_handler_list);
  */
 static DEFINE_MUTEX(input_mutex);
 
+static DEFINE_IDR(input_idr);
+
 static struct input_handler *input_table[8];
 
 static inline int is_event_supported(unsigned int code,
@@ -287,6 +290,36 @@ static void input_handle_event(struct input_dev *dev,
 		input_pass_event(dev, type, code, value);
 }
 
+/*
+ * Get new free input device number and associate pointer with it or associate
+ * pointer with specified number bigger than zero.
+ */
+static int input_no_get(struct idr *p, int n)
+{
+	int input_no;
+	int start_no = 0;
+	int err;
+
+	if (n > 0)
+		start_no = n;
+
+	do {
+		err = -ENOMEM;
+		if (idr_pre_get(p, GFP_KERNEL))
+			err = idr_get_new_above(p, NULL, start_no, &input_no);
+	} while (err == -EAGAIN);
+
+	if (err)
+		return err;
+
+	if (n > 0 && input_no != n) {
+		idr_remove(p, input_no);
+		return -EINVAL;
+	}
+
+	return input_no;
+}
+
 /**
  * input_event() - report new input event
  * @dev: device that generated the event
@@ -1463,7 +1496,6 @@ EXPORT_SYMBOL(input_set_capability);
  */
 int input_register_device(struct input_dev *dev)
 {
-	static atomic_t input_no = ATOMIC_INIT(0);
 	struct input_handler *handler;
 	const char *path;
 	int error;
@@ -1489,8 +1521,11 @@ int input_register_device(struct input_dev *dev)
 	if (!dev->setkeycode)
 		dev->setkeycode = input_default_setkeycode;
 
-	dev_set_name(&dev->dev, "input%ld",
-		     (unsigned long) atomic_inc_return(&input_no) - 1);
+	error = input_no_get(&input_idr, dev->input_no);
+	if (error < 0)
+		return error;
+	dev->input_no = error;
+	dev_set_name(&dev->dev, "input%d", dev->input_no);
 
 	error = device_add(&dev->dev);
 	if (error)
diff --git a/include/linux/input.h b/include/linux/input.h
index 0ccfc30..6145fb7 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1002,6 +1002,7 @@ struct ff_effect {
  * @phys: physical path to the device in the system hierarchy
  * @uniq: unique identification code for the device (if device has it)
  * @id: id of the device (struct input_id)
+ * @input_no: number of the input device
  * @evbit: bitmap of types of events supported by the device (EV_KEY,
  *	EV_REL, etc.)
  * @keybit: bitmap of keys/buttons this device has
@@ -1074,6 +1075,7 @@ struct input_dev {
 	const char *phys;
 	const char *uniq;
 	struct input_id id;
+	int input_no;
 
 	unsigned long evbit[BITS_TO_LONGS(EV_CNT)];
 	unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
-- 
1.6.0.4
