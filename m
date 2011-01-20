From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC] Input: input-polldev - create workqueue upfront
Date: Wed, 19 Jan 2011 23:42:15 -0800
Message-ID: <20110120074215.GB30522@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58711 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1ATHmV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 02:42:21 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>

Input: input-polldev - create workqueue upfront

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

With introduction of concurrency-managed work queues there is no point
in creating workqueues on demand; they can be created upfront as it does
not cause creation of unused threads.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

I wonder if it would be even simpler if we had a freezable system-wide
workqueue, in addition to system_wq, system_long_wq, system_nrt_wq and
system_unbound_wq...

 drivers/input/input-polldev.c |   72 ++++++++++++++---------------------------
 1 files changed, 24 insertions(+), 48 deletions(-)


diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 3037842..0a5304c 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -13,6 +13,7 @@
 #include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <linux/input-polldev.h>
 
 MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
@@ -20,44 +21,8 @@ MODULE_DESCRIPTION("Generic implementation of a polled input device");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION("0.1");
 
-static DEFINE_MUTEX(polldev_mutex);
-static int polldev_users;
 static struct workqueue_struct *polldev_wq;
 
-static int input_polldev_start_workqueue(void)
-{
-	int retval;
-
-	retval = mutex_lock_interruptible(&polldev_mutex);
-	if (retval)
-		return retval;
-
-	if (!polldev_users) {
-		polldev_wq = create_singlethread_workqueue("ipolldevd");
-		if (!polldev_wq) {
-			pr_err("failed to create ipolldevd workqueue\n");
-			retval = -ENOMEM;
-			goto out;
-		}
-	}
-
-	polldev_users++;
-
- out:
-	mutex_unlock(&polldev_mutex);
-	return retval;
-}
-
-static void input_polldev_stop_workqueue(void)
-{
-	mutex_lock(&polldev_mutex);
-
-	if (!--polldev_users)
-		destroy_workqueue(polldev_wq);
-
-	mutex_unlock(&polldev_mutex);
-}
-
 static void input_polldev_queue_work(struct input_polled_dev *dev)
 {
 	unsigned long delay;
@@ -81,11 +46,6 @@ static void input_polled_device_work(struct work_struct *work)
 static int input_open_polled_device(struct input_dev *input)
 {
 	struct input_polled_dev *dev = input_get_drvdata(input);
-	int error;
-
-	error = input_polldev_start_workqueue();
-	if (error)
-		return error;
 
 	if (dev->open)
 		dev->open(dev);
@@ -102,13 +62,6 @@ static void input_close_polled_device(struct input_dev *input)
 	struct input_polled_dev *dev = input_get_drvdata(input);
 
 	cancel_delayed_work_sync(&dev->work);
-	/*
-	 * Clean up work struct to remove references to the workqueue.
-	 * It may be destroyed by the next call. This causes problems
-	 * at next device open-close in case of poll_interval == 0.
-	 */
-	INIT_DELAYED_WORK(&dev->work, dev->work.work.func);
-	input_polldev_stop_workqueue();
 
 	if (dev->close)
 		dev->close(dev);
@@ -296,3 +249,26 @@ void input_unregister_polled_device(struct input_polled_dev *dev)
 }
 EXPORT_SYMBOL(input_unregister_polled_device);
 
+static int __init input_polldev_init(void)
+{
+	/*
+	 * We are using a dedicated workqueue because we want it to
+	 * be freezable. This ensures that we stop polling when
+	 * system goes into sleep mode.
+	 */
+	polldev_wq = alloc_workqueue("ipolldev_wq",
+				     WQ_FREEZEABLE | WQ_UNBOUND, 0);
+	if (!polldev_wq) {
+		pr_err("failed to create ipolldev_wq workqueue\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+module_init(input_polldev_init);
+
+static void __exit input_polldev_exit(void)
+{
+	destroy_workqueue(polldev_wq);
+}
+module_exit(input_polldev_exit);
