From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/RFT][PATCH] Input: tsc2007 - convert to threaded IRQ
Date: Mon, 22 Aug 2011 23:17:38 -0700
Message-ID: <20110823061738.GA25272@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35907 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab1HWGRp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 02:17:45 -0400
Received: by gxk21 with SMTP id 21so4108649gxk.19
        for <linux-input@vger.kernel.org>; Mon, 22 Aug 2011 23:17:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>

This is completely untested but I believe it should work better than original
workqueue solution, especially when we do not have get_pendown_state method
available. I wonder if it will help Richard's issue with IRQ getting re-raised
after pen up event.

Anyone who has hardware - please give it a spin.

Thanks!

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2007.c |  150 +++++++++++++++--------------------
 1 files changed, 66 insertions(+), 84 deletions(-)


diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index fadc115..0fbc530 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -66,7 +66,6 @@ struct ts_event {
 struct tsc2007 {
 	struct input_dev	*input;
 	char			phys[32];
-	struct delayed_work	work;
 
 	struct i2c_client	*client;
 
@@ -76,9 +75,11 @@ struct tsc2007 {
 	unsigned long		poll_delay;
 	unsigned long		poll_period;
 
-	bool			pendown;
 	int			irq;
 
+	wait_queue_head_t	wait;
+	bool			stopped;
+
 	int			(*get_pendown_state)(void);
 	void			(*clear_penirq)(void);
 };
@@ -141,25 +142,8 @@ static u32 tsc2007_calculate_pressure(struct tsc2007 *tsc, struct ts_event *tc)
 	return rt;
 }
 
-static void tsc2007_send_up_event(struct tsc2007 *tsc)
-{
-	struct input_dev *input = tsc->input;
-
-	dev_dbg(&tsc->client->dev, "UP\n");
-
-	input_report_key(input, BTN_TOUCH, 0);
-	input_report_abs(input, ABS_PRESSURE, 0);
-	input_sync(input);
-}
-
-static void tsc2007_work(struct work_struct *work)
+static bool tsc2007_is_pen_down(struct tsc2007 *ts)
 {
-	struct tsc2007 *ts =
-		container_of(to_delayed_work(work), struct tsc2007, work);
-	bool debounced = false;
-	struct ts_event tc;
-	u32 rt;
-
 	/*
 	 * NOTE: We can't rely on the pressure to determine the pen down
 	 * state, even though this controller has a pressure sensor.
@@ -170,79 +154,82 @@ static void tsc2007_work(struct work_struct *work)
 	 * The only safe way to check for the pen up condition is in the
 	 * work function by reading the pen signal state (it's a GPIO
 	 * and IRQ). Unfortunately such callback is not always available,
-	 * in that case we have rely on the pressure anyway.
+	 * in that case we assume that the pen is down and expect caller
+	 * to fall back on the pressure reading.
 	 */
-	if (ts->get_pendown_state) {
-		if (unlikely(!ts->get_pendown_state())) {
-			tsc2007_send_up_event(ts);
-			ts->pendown = false;
-			goto out;
-		}
 
-		dev_dbg(&ts->client->dev, "pen is still down\n");
-	}
+	if (!ts->get_pendown_state)
+		return true;
 
-	tsc2007_read_values(ts, &tc);
+	return ts->get_pendown_state();
+}
 
-	rt = tsc2007_calculate_pressure(ts, &tc);
-	if (rt > ts->max_rt) {
-		/*
-		 * Sample found inconsistent by debouncing or pressure is
-		 * beyond the maximum. Don't report it to user space,
-		 * repeat at least once more the measurement.
-		 */
-		dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
-		debounced = true;
-		goto out;
+static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
+{
+	struct tsc2007 *ts = handle;
+	struct input_dev *input = ts->input;
+	struct ts_event tc;
+	u32 rt;
 
-	}
+	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
+
+		/* pen is down, continue with the measurement */
+		tsc2007_read_values(ts, &tc);
 
-	if (rt) {
-		struct input_dev *input = ts->input;
+		rt = tsc2007_calculate_pressure(ts, &tc);
 
-		if (!ts->pendown) {
-			dev_dbg(&ts->client->dev, "DOWN\n");
+		if (rt == 0 && !ts->get_pendown_state) {
+			/*
+			 * If pressure reported is 0 and we don't have
+			 * callback to check pendown state, we have to
+			 * assume that pen was lifted up.
+			 */
+			break;
+		}
+
+		if (rt <= ts->max_rt) {
+			dev_dbg(&ts->client->dev,
+				"DOWN point(%4d,%4d), pressure (%4u)\n",
+				tc.x, tc.y, rt);
 
 			input_report_key(input, BTN_TOUCH, 1);
-			ts->pendown = true;
+			input_report_abs(input, ABS_X, tc.x);
+			input_report_abs(input, ABS_Y, tc.y);
+			input_report_abs(input, ABS_PRESSURE, rt);
+
+			input_sync(input);
+
+		} else {
+			/*
+			 * Sample found inconsistent by debouncing or pressure is
+			 * beyond the maximum. Don't report it to user space,
+			 * repeat at least once more the measurement.
+			 */
+			dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
 		}
 
-		input_report_abs(input, ABS_X, tc.x);
-		input_report_abs(input, ABS_Y, tc.y);
-		input_report_abs(input, ABS_PRESSURE, rt);
+		wait_event_timeout(ts->wait, ts->stopped,
+				   msecs_to_jiffies(ts->poll_period));
+	}
 
-		input_sync(input);
+	dev_dbg(&ts->client->dev, "UP\n");
 
-		dev_dbg(&ts->client->dev, "point(%4d,%4d), pressure (%4u)\n",
-			tc.x, tc.y, rt);
+	input_report_key(input, BTN_TOUCH, 0);
+	input_report_abs(input, ABS_PRESSURE, 0);
+	input_sync(input);
 
-	} else if (!ts->get_pendown_state && ts->pendown) {
-		/*
-		 * We don't have callback to check pendown state, so we
-		 * have to assume that since pressure reported is 0 the
-		 * pen was lifted up.
-		 */
-		tsc2007_send_up_event(ts);
-		ts->pendown = false;
-	}
+	if (ts->clear_penirq)
+		ts->clear_penirq();
 
- out:
-	if (ts->pendown || debounced)
-		schedule_delayed_work(&ts->work,
-				      msecs_to_jiffies(ts->poll_period));
-	else
-		enable_irq(ts->irq);
+	return IRQ_HANDLED;
 }
 
-static irqreturn_t tsc2007_irq(int irq, void *handle)
+static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts = handle;
 
-	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
-		disable_irq_nosync(ts->irq);
-		schedule_delayed_work(&ts->work,
-				      msecs_to_jiffies(ts->poll_delay));
-	}
+	if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
+		return IRQ_WAKE_THREAD;
 
 	if (ts->clear_penirq)
 		ts->clear_penirq();
@@ -252,15 +239,10 @@ static irqreturn_t tsc2007_irq(int irq, void *handle)
 
 static void tsc2007_free_irq(struct tsc2007 *ts)
 {
+	ts->stopped = true;
+	mb();
+	wake_up(&ts->wait);
 	free_irq(ts->irq, ts);
-	if (cancel_delayed_work_sync(&ts->work)) {
-		/*
-		 * Work was pending, therefore we need to enable
-		 * IRQ here to balance the disable_irq() done in the
-		 * interrupt handler.
-		 */
-		enable_irq(ts->irq);
-	}
 }
 
 static int __devinit tsc2007_probe(struct i2c_client *client,
@@ -290,7 +272,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->irq = client->irq;
 	ts->input = input_dev;
-	INIT_DELAYED_WORK(&ts->work, tsc2007_work);
+	init_waitqueue_head(&ts->wait);
 
 	ts->model             = pdata->model;
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
@@ -318,8 +300,8 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	if (pdata->init_platform_hw)
 		pdata->init_platform_hw();
 
-	err = request_irq(ts->irq, tsc2007_irq, 0,
-			client->dev.driver->name, ts);
+	err = request_threaded_irq(ts->irq, tsc2007_hard_irq, tsc2007_soft_irq,
+				   0, client->dev.driver->name, ts);
 	if (err < 0) {
 		dev_err(&client->dev, "irq %d busy?\n", ts->irq);
 		goto err_free_mem;
-- 
Dmitry
