From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH] input: enable / disable methods with sysfs entry
Date: Thu,  3 Dec 2009 12:58:19 +0200
Message-ID: <1259837900-10803-2-git-send-email-samu.p.onkalo@nokia.com>
References: <1259837900-10803-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23337 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZLCK6d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 05:58:33 -0500
In-Reply-To: <1259837900-10803-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Add optional enable and disable methods to input system.
Add sysfs entry for enabling and disabling input device.

When registering a device to input system, device can provide
optional enable and disable methods. State is set to enabled by default.
Opening / closing the input device doesn't change the state.
If the callback functions are not provided, sysfs entry returns
ENOSYS error code.

Purpose:
Several user space applications can keep device open at the same time.
One user space application can enable and disable the device
via sysfs entry. Depending on the device driver, disable / enable
functions can totally turn off the HW or prevent interrupts to
come trough.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/input.h |    8 ++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5d6421b..3cd47b4 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1077,11 +1077,54 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 }
 static DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
 
+static ssize_t input_dev_get_enable(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	return sprintf(buf, "%u\n", input_dev->enabled);
+}
+
+static ssize_t input_dev_set_enable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	long i;
+	int ret;
+
+	if (!(input_dev->disable && input_dev->enable))
+		return -ENOSYS;
+
+	ret = strict_strtoul(buf, 0, &i);
+	if (ret)
+		return -EINVAL;
+	i = !!i;
+
+	mutex_lock(&input_dev->mutex);
+	if (input_dev->enabled == i) {
+		mutex_unlock(&input_dev->mutex);
+		return count;
+	}
+	input_dev->enabled = i;
+
+	if (i)
+		input_dev->enable(input_dev);
+	else
+		input_dev->disable(input_dev);
+
+	mutex_unlock(&input_dev->mutex);
+	return count;
+}
+
+static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, input_dev_get_enable,
+		input_dev_set_enable);
+
 static struct attribute *input_dev_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_phys.attr,
 	&dev_attr_uniq.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_enable.attr,
 	NULL
 };
 
@@ -1539,6 +1582,8 @@ int input_register_device(struct input_dev *dev)
 		return error;
 	}
 
+	dev->enabled = true;
+
 	list_add_tail(&dev->node, &input_dev_list);
 
 	list_for_each_entry(handler, &input_handler_list, node)
diff --git a/include/linux/input.h b/include/linux/input.h
index db563bb..31b462b 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1057,6 +1057,11 @@ struct ff_effect {
  *	or EV_SND. The device is expected to carry out the requested
  *	action (turn on a LED, play sound, etc.) The call is protected
  *	by @event_lock and must not sleep
+ * @enable: method is called when user wants to enable driver which was
+ *	disabled using disable-method (optional).
+ * @disable: method is called when user wants to temporarily disable the
+ *	driver (example: tell keyboard driver to disable scanning at
+ *	HW level) (optional).
  * @grab: input handle that currently has the device grabbed (via
  *	EVIOCGRAB ioctl). When a handle grabs a device it becomes sole
  *	recipient for all input events coming from the device
@@ -1125,6 +1130,8 @@ struct input_dev {
 	void (*close)(struct input_dev *dev);
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
+	int (*enable)(struct input_dev *dev);
+	int (*disable)(struct input_dev *dev);
 
 	struct input_handle *grab;
 
@@ -1133,6 +1140,7 @@ struct input_dev {
 
 	unsigned int users;
 	bool going_away;
+	bool enabled;
 
 	struct device dev;
 
-- 
1.6.0.4

