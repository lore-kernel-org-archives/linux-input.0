From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: [PATCH] input: add a input_dev_reset callback
Date: Wed, 29 Jun 2011 13:25:22 +0800
Message-ID: <1309325122.2601.3.camel@ymzhang>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8105 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab1F2FZx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 01:25:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.orglinux-input@vger.kernel.org

From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Date: Tue, 28 Jun 2011 10:48:03 +0800
Subject: [PATCH] input: add a input_dev_reset callback

input_polled_dev starts a worker if it's opened. During
suspend-2-ram, kernel need cancel the worker and restart it
after resuming.

We add a new callback, input_dev_reset, into input_dev.
input_dev's suspend/resume callbacks would call it to notify
input_polled_dev.

Patch is against 3.0-rc3.

Signed-off-by: Yanmin Zhang <yanmin_zhang@linux.intel.com>

---

--- linux-3.0-rc3/drivers/input/input.c	2011-06-14 06:29:59.000000000 +0800
+++ linux-3.0-rc3_new/drivers/input/input.c	2011-06-28 13:12:35.000000000 +0800
@@ -1587,6 +1587,13 @@ EXPORT_SYMBOL(input_reset_device);
 static int input_dev_suspend(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
+	int ret;
+
+	if (input_dev->input_dev_reset) {
+		ret = input_dev->input_dev_reset(input_dev, false);
+		if (ret)
+			return ret;
+	}
 
 	mutex_lock(&input_dev->mutex);
 
@@ -1601,10 +1608,14 @@ static int input_dev_suspend(struct devi
 static int input_dev_resume(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
+	int ret = 0;
 
 	input_reset_device(input_dev);
 
-	return 0;
+	if (input_dev->input_dev_reset)
+		ret = input_dev->input_dev_reset(input_dev, true);
+
+	return ret;
 }
 
 static const struct dev_pm_ops input_dev_pm_ops = {
--- linux-3.0-rc3/drivers/input/input-polldev.c	2011-06-14 06:29:59.000000000 +0800
+++ linux-3.0-rc3_new/drivers/input/input-polldev.c	2011-06-28 13:14:54.000000000 +0800
@@ -52,6 +52,7 @@ static int input_open_polled_device(stru
 	if (dev->poll_interval > 0)
 		queue_delayed_work(system_freezable_wq, &dev->work, 0);
 
+	dev->opened = 1;
 	return 0;
 }
 
@@ -63,6 +64,24 @@ static void input_close_polled_device(st
 
 	if (dev->close)
 		dev->close(dev);
+
+	dev->opened = 0;
+}
+
+static int input_polled_dev_reset(struct input_dev *input, bool activate)
+{
+	struct input_polled_dev *dev = input_get_drvdata(input);
+
+	if (!dev->opened)
+		return 0;
+
+	if (activate) {
+		/* Only start polling if polling is enabled */
+		if (dev->poll_interval > 0)
+			queue_delayed_work(system_freezable_wq, &dev->work, 0);
+	} else
+		cancel_delayed_work_sync(&dev->work);
+	return 0;
 }
 
 /* SYSFS interface */
@@ -205,6 +224,7 @@ int input_register_polled_device(struct
 		dev->poll_interval_max = dev->poll_interval;
 	input->open = input_open_polled_device;
 	input->close = input_close_polled_device;
+	input->input_dev_reset = input_polled_dev_reset;
 
 	error = input_register_device(input);
 	if (error)
--- linux-3.0-rc3/include/linux/input.h	2011-06-14 06:29:59.000000000 +0800
+++ linux-3.0-rc3_new/include/linux/input.h	2011-06-28 11:12:10.000000000 +0800
@@ -1269,6 +1269,7 @@ struct input_dev {
 	void (*close)(struct input_dev *dev);
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
+	int (*input_dev_reset)(struct input_dev *dev, bool activate);
 
 	struct input_handle __rcu *grab;
 
--- linux-3.0-rc3/include/linux/input-polldev.h	2011-06-14 06:29:59.000000000 +0800
+++ linux-3.0-rc3_new/include/linux/input-polldev.h	2011-06-28 11:12:10.000000000 +0800
@@ -44,6 +44,8 @@ struct input_polled_dev {
 	unsigned int poll_interval_max; /* msec */
 	unsigned int poll_interval_min; /* msec */
 
+	int opened;
+
 	struct input_dev *input;
 
 /* private: */


