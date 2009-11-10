From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH v2 1/1] Input polldev: Sysfs interface for setting of polling interval
Date: Tue, 10 Nov 2009 10:00:47 +0200
Message-ID: <1257840047-7751-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52983 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbZKJIBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 03:01:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Sysfs entry for reading and setting of the polling interval.
If the interval is set to 0, polling is stopped. Polling
is restarted when interval is changed to non-zero.

sysfs entries:
poll = current polling interval in msec (RW)
max = max allowed polling interval (RO)
min = min allowed polling interval (RO)

Minimum and maximum limit for interval can be set while setting up the
device.

Interval can be adjusted even if the input device is not currently open.

applicable to Dmitry Torokhov's input-tree->next
(git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git->next)

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input-polldev.c |  107 ++++++++++++++++++++++++++++++++++++++--
 include/linux/input-polldev.h |    2 +
 2 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 910220c..4921dd6 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -56,14 +56,10 @@ static void input_polldev_stop_workqueue(void)
 	mutex_unlock(&polldev_mutex);
 }
 
-static void input_polled_device_work(struct work_struct *work)
+static void input_polldev_queue_work(struct input_polled_dev *dev)
 {
-	struct input_polled_dev *dev =
-		container_of(work, struct input_polled_dev, work.work);
 	unsigned long delay;
 
-	dev->poll(dev);
-
 	delay = msecs_to_jiffies(dev->poll_interval);
 	if (delay >= HZ)
 		delay = round_jiffies_relative(delay);
@@ -71,6 +67,15 @@ static void input_polled_device_work(struct work_struct *work)
 	queue_delayed_work(polldev_wq, &dev->work, delay);
 }
 
+static void input_polled_device_work(struct work_struct *work)
+{
+	struct input_polled_dev *dev =
+		container_of(work, struct input_polled_dev, work.work);
+
+	dev->poll(dev);
+	input_polldev_queue_work(dev);
+}
+
 static int input_open_polled_device(struct input_dev *input)
 {
 	struct input_polled_dev *dev = input_get_drvdata(input);
@@ -100,6 +105,81 @@ static void input_close_polled_device(struct input_dev *input)
 		dev->close(dev);
 }
 
+/* SYSFS interface */
+
+static ssize_t input_polldev_get_poll(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct input_polled_dev *polldev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", polldev->poll_interval);
+}
+
+static ssize_t input_polldev_set_poll(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct input_polled_dev *polldev = dev_get_drvdata(dev);
+	unsigned long interval;
+
+	if (strict_strtoul(buf, 0, &interval))
+		return -EINVAL;
+
+	if (interval < polldev->poll_interval_min)
+		return -EINVAL;
+
+	if (interval > polldev->poll_interval_max)
+		return -EINVAL;
+
+	mutex_lock(&polldev->input->mutex);
+
+	polldev->poll_interval = interval;
+
+	if (polldev->input->users) {
+		cancel_delayed_work_sync(&polldev->work);
+		if (polldev->poll_interval > 0)
+			input_polldev_queue_work(polldev);
+	}
+	mutex_unlock(&polldev->input->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(poll, S_IRUGO | S_IWUSR, input_polldev_get_poll,
+					    input_polldev_set_poll);
+
+
+static ssize_t input_polldev_get_max(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct input_polled_dev *polldev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", polldev->poll_interval_max);
+}
+
+static DEVICE_ATTR(max, S_IRUGO , input_polldev_get_max, NULL);
+
+static ssize_t input_polldev_get_min(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct input_polled_dev *polldev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", polldev->poll_interval_min);
+}
+
+static DEVICE_ATTR(min, S_IRUGO , input_polldev_get_min, NULL);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_poll.attr,
+	&dev_attr_max.attr,
+	&dev_attr_min.attr,
+	NULL
+};
+
+static struct attribute_group input_polldev_attribute_group = {
+	.attrs = sysfs_attrs
+};
+
 /**
  * input_allocate_polled_device - allocated memory polled device
  *
@@ -153,15 +233,27 @@ EXPORT_SYMBOL(input_free_polled_device);
 int input_register_polled_device(struct input_polled_dev *dev)
 {
 	struct input_dev *input = dev->input;
+	int error;
 
 	input_set_drvdata(input, dev);
 	INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
 	if (!dev->poll_interval)
 		dev->poll_interval = 500;
+	if (!dev->poll_interval_max)
+		dev->poll_interval_max = dev->poll_interval;
 	input->open = input_open_polled_device;
 	input->close = input_close_polled_device;
 
-	return input_register_device(input);
+	error = input_register_device(input);
+	if (error < 0)
+		goto fail;
+
+	error = sysfs_create_group(&input->dev.kobj,
+				   &input_polldev_attribute_group);
+	if (error < 0)
+		input_unregister_device(input);
+fail:
+	return error;
 }
 EXPORT_SYMBOL(input_register_polled_device);
 
@@ -177,6 +269,9 @@ EXPORT_SYMBOL(input_register_polled_device);
  */
 void input_unregister_polled_device(struct input_polled_dev *dev)
 {
+	sysfs_remove_group(&dev->input->dev.kobj,
+			   &input_polldev_attribute_group);
+
 	input_unregister_device(dev->input);
 	dev->input = NULL;
 }
diff --git a/include/linux/input-polldev.h b/include/linux/input-polldev.h
index 5c0ec68..5fbde34 100644
--- a/include/linux/input-polldev.h
+++ b/include/linux/input-polldev.h
@@ -36,6 +36,8 @@ struct input_polled_dev {
 	void (*close)(struct input_polled_dev *dev);
 	void (*poll)(struct input_polled_dev *dev);
 	unsigned int poll_interval; /* msec */
+	unsigned int poll_interval_max; /* msec */
+	unsigned int poll_interval_min; /* msec */
 
 	struct input_dev *input;
 	struct delayed_work work;
-- 
1.5.6.3

