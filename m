From: Alessandro Di Marco <dmr@c0nc3pt.com>
Subject: [PATCH 2.6.29.2] input: activity counters
Date: Mon, 11 May 2009 11:27:12 +0200
Message-ID: <87r5ywugdn.fsf@c0nc3pt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bin.disi.unige.it ([130.251.61.176]:33556 "EHLO c0nc3pt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756323AbZEKJrW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 05:47:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru

This patch provides the input infrastructure with activity
counters. Their purpose is to ease the development of idle triggers,
such as screen-savers - see the followed-up Perl script as an example
(X11 agnostic).

I had submitted something similar a couple of years ago, by way of a
kernel module named SIN (http://lkml.org/lkml/2007/1/18/138).

Despite SIN has been properly maintained along this period, soon it
revealed some design weaknesses which urged me towards alternative
approaches. IMO the resulting patch fits the target: it is quite
straightforward, yet provides good features such as:

1) userland programs retains the whole control logic

2) userland programs are EVIOCGRAB hassle free

3) userland programs do not get biased towards a specific environment
(e.g. one monitor, one keyboard...)

4) userland programs do not need superuser privileges to do their work

Regards,

Signed-off-by: Alessandro Di Marco <dmr@c0nc3pt.com>
---
 drivers/input/input.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/input.h |    3 +++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c13ced3..1758144 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -73,6 +73,11 @@ static void input_pass_event(struct input_dev *dev,
 {
 	struct input_handle *handle;

+	dev->activity = ktime_get();
+
+	if (dev->activity_notifier)
+		sysfs_notify_dirent(dev->activity_notifier);
+
 	rcu_read_lock();

 	handle = rcu_dereference(dev->grab);
@@ -1012,11 +1017,25 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 }
 static DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);

+static ssize_t input_dev_show_activity(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct input_dev *id = to_input_dev(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "A: %lld\nD: %lld\n",
+			 ktime_to_ns(id->activity),
+			 ktime_to_us(ktime_sub(ktime_get(), id->activity)));
+}
+
+static DEVICE_ATTR(activity, S_IRUGO, input_dev_show_activity, NULL);
+
 static struct attribute *input_dev_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_phys.attr,
 	&dev_attr_uniq.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_activity.attr,
 	NULL
 };

@@ -1227,10 +1246,33 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 	return 0;
 }

+static inline int warp_activity(struct device *dev)
+{
+	struct input_dev *id = to_input_dev(dev);
+
+	id->activity = ktime_sub(ktime_get(), id->activity);
+	return 0;
+}
+
+int input_dev_suspend(struct device *dev, pm_message_t state)
+{
+	if (state.event & (PM_EVENT_FREEZE|PM_EVENT_SUSPEND))
+		(void) warp_activity(dev);
+
+	return 0;
+}
+
+int input_dev_resume(struct device *dev)
+{
+	return warp_activity(dev);
+}
+
 static struct device_type input_dev_type = {
 	.groups		= input_dev_attr_groups,
 	.release	= input_dev_release,
 	.uevent		= input_dev_uevent,
+	.suspend	= input_dev_suspend,
+	.resume		= input_dev_resume,
 };

 struct class input_class = {
@@ -1401,6 +1443,8 @@ int input_register_device(struct input_dev *dev)
 		dev->name ? dev->name : "Unspecified device", path ? path : "N/A");
 	kfree(path);

+	dev->activity_notifier = sysfs_get_dirent(dev->dev.kobj.sd, "activity");
+
 	error = mutex_lock_interruptible(&input_mutex);
 	if (error) {
 		device_del(&dev->dev);
@@ -1446,6 +1490,9 @@ void input_unregister_device(struct input_dev *dev)

 	mutex_unlock(&input_mutex);

+	sysfs_put(dev->activity_notifier);
+	dev->activity_notifier = NULL;
+
 	device_unregister(&dev->dev);
 }
 EXPORT_SYMBOL(input_unregister_device);
diff --git a/include/linux/input.h b/include/linux/input.h
index 9a6355f..d372bb9 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1096,6 +1096,9 @@ struct input_dev {

 	struct input_handle *grab;

+	struct sysfs_dirent *activity_notifier;
+	ktime_t activity;
+
 	spinlock_t event_lock;
 	struct mutex mutex;

