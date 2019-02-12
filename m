From: thesven73@gmail.com
Subject: [PATCH] Input: synaptics_i2c - remove redundant spinlock
Date: Mon, 11 Feb 2019 20:34:42 -0500
Message-ID: <20190212013442.26030-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-input@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

Remove a leftover spinlock.

This was required back when mod_delayed_work() did not exist,
and had to be implemented with a cancel + schedule. See
commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
__cancel + queue")

schedule_delayed_work() and mod_delayed_work() can now be used
concurrently. So the spinlock is no longer needed.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 8538318d332c..2b2230984ad5 100644
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
@@ -372,13 +371,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
 					  unsigned long delay)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&touch->lock, flags);
-
 	mod_delayed_work(system_wq, &touch->dwork, delay);
-
-	spin_unlock_irqrestore(&touch->lock, flags);
 }
 
 static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
@@ -530,7 +523,6 @@ static struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *clien
 	touch->scan_rate_param = scan_rate;
 	set_scan_rate(touch, scan_rate);
 	INIT_DELAYED_WORK(&touch->dwork, synaptics_i2c_work_handler);
-	spin_lock_init(&touch->lock);
 
 	return touch;
 }
-- 
2.17.1
