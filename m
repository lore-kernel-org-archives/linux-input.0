From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH v2] Input: ads7846 - Replace spinlock by mutex to wrap disable()/enable()
Date: Sat, 21 Aug 2010 13:59:00 +0800
Message-ID: <1282370340-3157-1-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64431 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0HUFzk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Aug 2010 01:55:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, notasas@gmail.com, vapier@gentoo.org
Cc: linux-input@vger.kernel.org

The commit 9114337 introduces regulator operations in the ads7846
touchscreen driver. Among these operations, some are called in the
spinlock protected context.
On most platforms, the regulator operation is achieved through
i2c/spi bus transfer operations, some bus transfer operations will
call wait_for_completion function. It isn't allowable  to call
sleepable function in the atomic context. So replace the spinlock with
mutex to protect ads7846_disable()/ads7846_enable().

[tested on TI OMAP3530EVM board]

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
Diff vs V1:
Don't move regualtor_disable/enable out from ads7846_disable/enable,
but use mutext to replace spinlock.

I think this replace is safe because ads7846_disable/enable is called
in process context, it won't race with ads7846_irq/timer(irq&softirq).
While it is possible for ads7846_irq/timer to race with
ads7846_disable, but ads7846_diable can handle this situation already.

 drivers/input/touchscreen/ads7846.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1603193..0b875fa 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -130,6 +130,7 @@ struct ads7846 {
 	unsigned		irq_disabled:1;	/* P: lock */
 	unsigned		disabled:1;
 	unsigned		is_suspended:1;
+	struct mutex		mutex;
 
 	int			(*filter)(void *data, int data_idx, int *val);
 	void			*filter_data;
@@ -531,14 +532,14 @@ static ssize_t ads7846_disable_store(struct device *dev,
 	if (strict_strtoul(buf, 10, &i))
 		return -EINVAL;
 
-	spin_lock_irq(&ts->lock);
+	mutex_lock(&ts->mutex);
 
 	if (i)
 		ads7846_disable(ts);
 	else
 		ads7846_enable(ts);
 
-	spin_unlock_irq(&ts->lock);
+	mutex_unlock(&ts->mutex);
 
 	return count;
 }
@@ -848,11 +849,8 @@ static void ads7846_disable(struct ads7846 *ts)
 		/* the timer will run at least once more, and
 		 * leave everything in a clean state, IRQ disabled
 		 */
-		while (ts->pending) {
-			spin_unlock_irq(&ts->lock);
+		while (ts->pending)
 			msleep(1);
-			spin_lock_irq(&ts->lock);
-		}
 	}
 
 	regulator_disable(ts->reg);
@@ -879,12 +877,12 @@ static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
 {
 	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 
-	spin_lock_irq(&ts->lock);
+	mutex_lock(&ts->mutex);
 
 	ts->is_suspended = 1;
 	ads7846_disable(ts);
 
-	spin_unlock_irq(&ts->lock);
+	mutex_unlock(&ts->mutex);
 
 	if (device_may_wakeup(&ts->spi->dev))
 		enable_irq_wake(ts->spi->irq);
@@ -900,12 +898,12 @@ static int ads7846_resume(struct spi_device *spi)
 	if (device_may_wakeup(&ts->spi->dev))
 		disable_irq_wake(ts->spi->irq);
 
-	spin_lock_irq(&ts->lock);
+	mutex_lock(&ts->mutex);
 
 	ts->is_suspended = 0;
 	ads7846_enable(ts);
 
-	spin_unlock_irq(&ts->lock);
+	mutex_unlock(&ts->mutex);
 
 	return 0;
 }
@@ -999,6 +997,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	ts->timer.function = ads7846_timer;
 
 	spin_lock_init(&ts->lock);
+	mutex_init(&ts->mutex);
 
 	ts->model = pdata->model ? : 7846;
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
-- 
1.5.6.5

