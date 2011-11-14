From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: ucb1400_ts - convert to threaded IRQ
Date: Mon, 14 Nov 2011 00:36:10 -0800
Message-ID: <1321259771-10925-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56522 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab1KNIgW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:36:22 -0500
Received: by mail-yw0-f46.google.com with SMTP id 32so1950780ywt.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:36:22 -0800 (PST)
In-Reply-To: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>

Instead of manually create and handler kernel thread switch to threaded
IRQ and let kernel IRQ core manage thread for us.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |  235 +++++++++++++++-----------------
 include/linux/ucb1400.h                |    6 +-
 2 files changed, 115 insertions(+), 126 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 5c6b7b3..1862633 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -20,24 +20,24 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
 #include <linux/input.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
-#include <linux/suspend.h>
-#include <linux/kthread.h>
-#include <linux/freezer.h>
 #include <linux/ucb1400.h>
 
+#define UCB1400_TS_POLL_PERIOD	10 /* ms */
+
 static int adcsync;
 static int ts_delay = 55; /* us */
 static int ts_delay_pressure;	/* us */
 
 /* Switch to interrupt mode. */
-static void ucb1400_ts_mode_int(struct snd_ac97 *ac97)
+static void ucb1400_ts_mode_int(struct ucb1400_ts *ucb)
 {
-	ucb1400_reg_write(ac97, UCB_TS_CR,
+	ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
 			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
 			UCB_TS_CR_MODE_INT);
@@ -53,7 +53,9 @@ static unsigned int ucb1400_ts_read_pressure(struct ucb1400_ts *ucb)
 			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
 			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+
 	udelay(ts_delay_pressure);
+
 	return ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_TSPY, adcsync);
 }
 
@@ -127,26 +129,26 @@ static unsigned int ucb1400_ts_read_yres(struct ucb1400_ts *ucb)
 	return ucb1400_adc_read(ucb->ac97, 0, adcsync);
 }
 
-static int ucb1400_ts_pen_up(struct snd_ac97 *ac97)
+static int ucb1400_ts_pen_up(struct ucb1400_ts *ucb)
 {
-	unsigned short val = ucb1400_reg_read(ac97, UCB_TS_CR);
+	unsigned short val = ucb1400_reg_read(ucb->ac97, UCB_TS_CR);
 
 	return val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW);
 }
 
-static void ucb1400_ts_irq_enable(struct snd_ac97 *ac97)
+static void ucb1400_ts_irq_enable(struct ucb1400_ts *ucb)
 {
-	ucb1400_reg_write(ac97, UCB_IE_CLEAR, UCB_IE_TSPX);
-	ucb1400_reg_write(ac97, UCB_IE_CLEAR, 0);
-	ucb1400_reg_write(ac97, UCB_IE_FAL, UCB_IE_TSPX);
+	ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, UCB_IE_TSPX);
+	ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, 0);
+	ucb1400_reg_write(ucb->ac97, UCB_IE_FAL, UCB_IE_TSPX);
 }
 
-static void ucb1400_ts_irq_disable(struct snd_ac97 *ac97)
+static void ucb1400_ts_irq_disable(struct ucb1400_ts *ucb)
 {
-	ucb1400_reg_write(ac97, UCB_IE_FAL, 0);
+	ucb1400_reg_write(ucb->ac97, UCB_IE_FAL, 0);
 }
 
-static void ucb1400_ts_evt_add(struct input_dev *idev, u16 pressure, u16 x, u16 y)
+static void ucb1400_ts_report_event(struct input_dev *idev, u16 pressure, u16 x, u16 y)
 {
 	input_report_abs(idev, ABS_X, x);
 	input_report_abs(idev, ABS_Y, y);
@@ -162,7 +164,7 @@ static void ucb1400_ts_event_release(struct input_dev *idev)
 	input_sync(idev);
 }
 
-static void ucb1400_handle_pending_irq(struct ucb1400_ts *ucb)
+static void ucb1400_clear_pending_irq(struct ucb1400_ts *ucb)
 {
 	unsigned int isr;
 
@@ -171,32 +173,34 @@ static void ucb1400_handle_pending_irq(struct ucb1400_ts *ucb)
 	ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, 0);
 
 	if (isr & UCB_IE_TSPX)
-		ucb1400_ts_irq_disable(ucb->ac97);
+		ucb1400_ts_irq_disable(ucb);
 	else
-		dev_dbg(&ucb->ts_idev->dev, "ucb1400: unexpected IE_STATUS = %#x\n", isr);
-	enable_irq(ucb->irq);
+		dev_dbg(&ucb->ts_idev->dev,
+			"ucb1400: unexpected IE_STATUS = %#x\n", isr);
 }
 
-static int ucb1400_ts_thread(void *_ucb)
+/*
+ * A restriction with interrupts exists when using the ucb1400, as
+ * the codec read/write routines may sleep while waiting for codec
+ * access completion and uses semaphores for access control to the
+ * AC97 bus. Therefore the driver is forced to use threaded interrupt
+ * handler.
+ */
+static irqreturn_t ucb1400_irq(int irqnr, void *devid)
 {
-	struct ucb1400_ts *ucb = _ucb;
-	struct task_struct *tsk = current;
-	int valid = 0;
-	struct sched_param param = { .sched_priority = 1 };
+	struct ucb1400_ts *ucb = devid;
+	unsigned int x, y, p;
+	bool penup;
 
-	sched_setscheduler(tsk, SCHED_FIFO, &param);
+	if (unlikely(irqnr != ucb->irq))
+		return IRQ_NONE;
 
-	set_freezable();
-	while (!kthread_should_stop()) {
-		unsigned int x, y, p;
-		long timeout;
+	ucb1400_clear_pending_irq(ucb);
 
-		ucb->ts_restart = 0;
+	/* Start with a small delay before checking pendown state */
+	msleep(UCB1400_TS_POLL_PERIOD);
 
-		if (ucb->irq_pending) {
-			ucb->irq_pending = 0;
-			ucb1400_handle_pending_irq(ucb);
-		}
+	while (!ucb->stopped && !(penup = ucb1400_ts_pen_up(ucb))) {
 
 		ucb1400_adc_enable(ucb->ac97);
 		x = ucb1400_ts_read_xpos(ucb);
@@ -204,91 +208,62 @@ static int ucb1400_ts_thread(void *_ucb)
 		p = ucb1400_ts_read_pressure(ucb);
 		ucb1400_adc_disable(ucb->ac97);
 
-		/* Switch back to interrupt mode. */
-		ucb1400_ts_mode_int(ucb->ac97);
-
-		msleep(10);
-
-		if (ucb1400_ts_pen_up(ucb->ac97)) {
-			ucb1400_ts_irq_enable(ucb->ac97);
-
-			/*
-			 * If we spat out a valid sample set last time,
-			 * spit out a "pen off" sample here.
-			 */
-			if (valid) {
-				ucb1400_ts_event_release(ucb->ts_idev);
-				valid = 0;
-			}
-
-			timeout = MAX_SCHEDULE_TIMEOUT;
-		} else {
-			valid = 1;
-			ucb1400_ts_evt_add(ucb->ts_idev, p, x, y);
-			timeout = msecs_to_jiffies(10);
-		}
+		ucb1400_ts_report_event(ucb->ts_idev, p, x, y);
 
-		wait_event_freezable_timeout(ucb->ts_wait,
-			ucb->irq_pending || ucb->ts_restart ||
-			kthread_should_stop(), timeout);
+		wait_event_timeout(ucb->ts_wait, ucb->stopped,
+				   msecs_to_jiffies(UCB1400_TS_POLL_PERIOD));
 	}
 
-	/* Send the "pen off" if we are stopping with the pen still active */
-	if (valid)
-		ucb1400_ts_event_release(ucb->ts_idev);
+	ucb1400_ts_event_release(ucb->ts_idev);
 
-	ucb->ts_task = NULL;
-	return 0;
+	if (!ucb->stopped) {
+		/* Switch back to interrupt mode. */
+		ucb1400_ts_mode_int(ucb);
+		ucb1400_ts_irq_enable(ucb);
+	}
+
+	return IRQ_HANDLED;
 }
 
-/*
- * A restriction with interrupts exists when using the ucb1400, as
- * the codec read/write routines may sleep while waiting for codec
- * access completion and uses semaphores for access control to the
- * AC97 bus.  A complete codec read cycle could take  anywhere from
- * 60 to 100uSec so we *definitely* don't want to spin inside the
- * interrupt handler waiting for codec access.  So, we handle the
- * interrupt by scheduling a RT kernel thread to run in process
- * context instead of interrupt context.
- */
-static irqreturn_t ucb1400_hard_irq(int irqnr, void *devid)
+static void ucb1400_ts_stop(struct ucb1400_ts *ucb)
 {
-	struct ucb1400_ts *ucb = devid;
+	/* Signal IRQ thread to stop polling and disable the handler. */
+	ucb->stopped = true;
+	mb();
+	wake_up(&ucb->ts_wait);
+	disable_irq(ucb->irq);
 
-	if (irqnr == ucb->irq) {
-		disable_irq_nosync(ucb->irq);
-		ucb->irq_pending = 1;
-		wake_up(&ucb->ts_wait);
-		return IRQ_HANDLED;
-	}
-	return IRQ_NONE;
+	ucb1400_ts_irq_disable(ucb);
+	ucb1400_reg_write(ucb->ac97, UCB_TS_CR, 0);
+}
+
+/* Must be called with ts->lock held */
+static void ucb1400_ts_start(struct ucb1400_ts *ucb)
+{
+	/* Tell IRQ thread that it may poll the device. */
+	ucb->stopped = false;
+	mb();
+
+	ucb1400_ts_mode_int(ucb);
+	ucb1400_ts_irq_enable(ucb);
+
+	enable_irq(ucb->irq);
 }
 
 static int ucb1400_ts_open(struct input_dev *idev)
 {
 	struct ucb1400_ts *ucb = input_get_drvdata(idev);
-	int ret = 0;
-
-	BUG_ON(ucb->ts_task);
 
-	ucb->ts_task = kthread_run(ucb1400_ts_thread, ucb, "UCB1400_ts");
-	if (IS_ERR(ucb->ts_task)) {
-		ret = PTR_ERR(ucb->ts_task);
-		ucb->ts_task = NULL;
-	}
+	ucb1400_ts_start(ucb);
 
-	return ret;
+	return 0;
 }
 
 static void ucb1400_ts_close(struct input_dev *idev)
 {
 	struct ucb1400_ts *ucb = input_get_drvdata(idev);
 
-	if (ucb->ts_task)
-		kthread_stop(ucb->ts_task);
-
-	ucb1400_ts_irq_disable(ucb->ac97);
-	ucb1400_reg_write(ucb->ac97, UCB_TS_CR, 0);
+	ucb1400_ts_stop(ucb);
 }
 
 #ifndef NO_IRQ
@@ -342,11 +317,11 @@ static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb)
 	return 0;
 }
 
-static int __devinit ucb1400_ts_probe(struct platform_device *dev)
+static int __devinit ucb1400_ts_probe(struct platform_device *pdev)
 {
+	struct ucb1400_ts *ucb = pdev->dev.platform_data;
 	int error, x_res, y_res;
 	u16 fcsr;
-	struct ucb1400_ts *ucb = dev->dev.platform_data;
 
 	ucb->ts_idev = input_allocate_device();
 	if (!ucb->ts_idev) {
@@ -362,21 +337,13 @@ static int __devinit ucb1400_ts_probe(struct platform_device *dev)
 			goto err_free_devs;
 		}
 	}
+	printk(KERN_DEBUG "UCB1400: found IRQ %d\n", ucb->irq);
 
 	init_waitqueue_head(&ucb->ts_wait);
 
-	error = request_irq(ucb->irq, ucb1400_hard_irq, IRQF_TRIGGER_RISING,
-				"UCB1400", ucb);
-	if (error) {
-		printk(KERN_ERR "ucb1400: unable to grab irq%d: %d\n",
-				ucb->irq, error);
-		goto err_free_devs;
-	}
-	printk(KERN_DEBUG "UCB1400: found IRQ %d\n", ucb->irq);
-
 	input_set_drvdata(ucb->ts_idev, ucb);
 
-	ucb->ts_idev->dev.parent	= &dev->dev;
+	ucb->ts_idev->dev.parent	= &pdev->dev;
 	ucb->ts_idev->name		= "UCB1400 touchscreen interface";
 	ucb->ts_idev->id.vendor		= ucb1400_reg_read(ucb->ac97,
 						AC97_VENDOR_ID1);
@@ -404,6 +371,17 @@ static int __devinit ucb1400_ts_probe(struct platform_device *dev)
 	input_set_abs_params(ucb->ts_idev, ABS_Y, 0, y_res, 0, 0);
 	input_set_abs_params(ucb->ts_idev, ABS_PRESSURE, 0, 0, 0, 0);
 
+	ucb1400_ts_stop(ucb);
+
+	error = request_threaded_irq(ucb->irq, NULL, ucb1400_irq,
+				     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				     "UCB1400", ucb);
+	if (error) {
+		printk(KERN_ERR "ucb1400: unable to grab irq%d: %d\n",
+				ucb->irq, error);
+		goto err_free_devs;
+	}
+
 	error = input_register_device(ucb->ts_idev);
 	if (error)
 		goto err_free_irq;
@@ -418,9 +396,9 @@ err:
 	return error;
 }
 
-static int __devexit ucb1400_ts_remove(struct platform_device *dev)
+static int __devexit ucb1400_ts_remove(struct platform_device *pdev)
 {
-	struct ucb1400_ts *ucb = dev->dev.platform_data;
+	struct ucb1400_ts *ucb = pdev->dev.platform_data;
 
 	free_irq(ucb->irq, ucb);
 	input_unregister_device(ucb->ts_idev);
@@ -429,24 +407,37 @@ static int __devexit ucb1400_ts_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int ucb1400_ts_suspend(struct device *dev)
+{
+	struct ucb1400_ts *ucb = dev->platform_data;
+	struct input_dev *idev = ucb->ts_idev;
+
+	mutex_lock(&idev->mutex);
+
+	if (idev->users)
+		ucb1400_ts_start(ucb);
+
+	mutex_unlock(&idev->mutex);
+	return 0;
+}
+
 static int ucb1400_ts_resume(struct device *dev)
 {
 	struct ucb1400_ts *ucb = dev->platform_data;
+	struct input_dev *idev = ucb->ts_idev;
 
-	if (ucb->ts_task) {
-		/*
-		 * Restart the TS thread to ensure the
-		 * TS interrupt mode is set up again
-		 * after sleep.
-		 */
-		ucb->ts_restart = 1;
-		wake_up(&ucb->ts_wait);
-	}
+	mutex_lock(&idev->mutex);
+
+	if (idev->users)
+		ucb1400_ts_stop(ucb);
+
+	mutex_unlock(&idev->mutex);
 	return 0;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops, NULL, ucb1400_ts_resume);
+static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops,
+			 ucb1400_ts_suspend, ucb1400_ts_resume);
 
 static struct platform_driver ucb1400_ts_driver = {
 	.probe	= ucb1400_ts_probe,
diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
index 5c75153..d21b33c 100644
--- a/include/linux/ucb1400.h
+++ b/include/linux/ucb1400.h
@@ -96,13 +96,11 @@ struct ucb1400_gpio {
 
 struct ucb1400_ts {
 	struct input_dev	*ts_idev;
-	struct task_struct	*ts_task;
 	int			id;
-	wait_queue_head_t	ts_wait;
-	unsigned int		ts_restart:1;
 	int			irq;
-	unsigned int		irq_pending;	/* not bit field shared */
 	struct snd_ac97		*ac97;
+	wait_queue_head_t	ts_wait;
+	bool			stopped;
 };
 
 struct ucb1400 {
-- 
1.7.6.4

