From: thesven73@gmail.com
Subject: [PATCH v2] Input: synaptics_i2c - remove redundant spinlock
Date: Sun, 17 Feb 2019 01:10:53 -0500
Message-ID: <20190217061053.4559-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-input@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

Remove a leftover spinlock.

This was required back when mod_delayed_work() did not exist,
and had to be implemented with a cancel + queue. See
commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
__cancel + queue")

schedule_delayed_work() and mod_delayed_work() can now be used
concurrently. So the spinlock is no longer needed.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

v2: replace useless synaptics_i2c_reschedule_work() with
		mod_delayed_work().

 drivers/input/mouse/synaptics_i2c.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 8538318d332c..fa304648d611 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -219,7 +219,6 @@ struct synaptics_i2c {
 	struct i2c_client	*client;
 	struct input_dev	*input;
 	struct delayed_work	dwork;
-	spinlock_t		lock;
 	int			no_data_count;
 	int			no_decel_param;
 	int			reduce_report_param;
@@ -369,23 +368,11 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 	return xy_delta || gesture;
 }
 
-static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
-					  unsigned long delay)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&touch->lock, flags);
-
-	mod_delayed_work(system_wq, &touch->dwork, delay);
-
-	spin_unlock_irqrestore(&touch->lock, flags);
-}
-
 static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 {
 	struct synaptics_i2c *touch = dev_id;
 
-	synaptics_i2c_reschedule_work(touch, 0);
+	mod_delayed_work(system_wq, &touch->dwork, 0);
 
 	return IRQ_HANDLED;
 }
@@ -461,7 +448,7 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
 	 * We poll the device once in THREAD_IRQ_SLEEP_SECS and
 	 * if error is detected, we try to reset and reconfigure the touchpad.
 	 */
-	synaptics_i2c_reschedule_work(touch, delay);
+	mod_delayed_work(system_wq, &touch->dwork, delay);
 }
 
 static int synaptics_i2c_open(struct input_dev *input)
@@ -474,7 +461,7 @@ static int synaptics_i2c_open(struct input_dev *input)
 		return ret;
 
 	if (polling_req)
-		synaptics_i2c_reschedule_work(touch,
+		mod_delayed_work(system_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
@@ -530,7 +517,6 @@ static struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *clien
 	touch->scan_rate_param = scan_rate;
 	set_scan_rate(touch, scan_rate);
 	INIT_DELAYED_WORK(&touch->dwork, synaptics_i2c_work_handler);
-	spin_lock_init(&touch->lock);
 
 	return touch;
 }
@@ -637,7 +623,7 @@ static int __maybe_unused synaptics_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	synaptics_i2c_reschedule_work(touch,
+	mod_delayed_work(system_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
-- 
2.17.1
