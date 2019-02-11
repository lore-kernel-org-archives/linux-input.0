From: thesven73@gmail.com
Subject: [PATCH] Input: qt2160 - remove redundant spinlock
Date: Sun, 10 Feb 2019 21:32:22 -0500
Message-ID: <20190211023222.29168-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-input@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

Remove a spinlock which prevents schedule_delayed_work() and
mod_delayed_work() from executing concurrently.

This was required back when mod_delayed_work() did not exist,
and had to be implemented with a cancel + schedule. See
commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
__cancel + queue")

schedule_delayed_work() and mod_delayed_work() can now be used
concurrently. So the spinlock is no longer needed.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 43b86482dda0..23dc7c0c7d78 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -69,7 +69,6 @@ struct qt2160_data {
 	struct i2c_client *client;
 	struct input_dev *input;
 	struct delayed_work dwork;
-	spinlock_t lock;        /* Protects canceling/rescheduling of dwork */
 	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
 	u16 key_matrix;
 #ifdef CONFIG_LEDS_CLASS
@@ -221,22 +220,15 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 static irqreturn_t qt2160_irq(int irq, void *_qt2160)
 {
 	struct qt2160_data *qt2160 = _qt2160;
-	unsigned long flags;
-
-	spin_lock_irqsave(&qt2160->lock, flags);
 
 	mod_delayed_work(system_wq, &qt2160->dwork, 0);
 
-	spin_unlock_irqrestore(&qt2160->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
 static void qt2160_schedule_read(struct qt2160_data *qt2160)
 {
-	spin_lock_irq(&qt2160->lock);
 	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
-	spin_unlock_irq(&qt2160->lock);
 }
 
 static void qt2160_worker(struct work_struct *work)
@@ -406,7 +398,6 @@ static int qt2160_probe(struct i2c_client *client,
 	qt2160->client = client;
 	qt2160->input = input;
 	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
-	spin_lock_init(&qt2160->lock);
 
 	input->name = "AT42QT2160 Touch Sense Keyboard";
 	input->id.bustype = BUS_I2C;
-- 
2.17.1
