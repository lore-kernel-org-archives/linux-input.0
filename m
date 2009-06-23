From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 1/2] tsc2007: remove HR timer
Date: Tue, 23 Jun 2009 13:54:48 +0200
Message-ID: <4A40C288.2060702@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758851AbZFWLzB@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

This patch removes the HR timer, since it's bad to do synchronous I2C
in the HR timer callback context. The new implementation makes use
of the global workqueue. The work is scheduled every 5ms when polling
rather than 5 us.

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.30/drivers/input/touchscreen/tsc2007.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30/drivers/input/touchscreen/tsc2007.c	(revision 932)
+++ linux-2.6.30/drivers/input/touchscreen/tsc2007.c	(revision 943)
@@ -21,15 +21,13 @@
  */

 #include <linux/module.h>
-#include <linux/hrtimer.h>
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>

-#define TS_POLL_DELAY	(10 * 1000)	/* ns delay before the first sample =
*/
-#define TS_POLL_PERIOD	(5 * 1000)	/* ns delay between samples */
+#define TS_POLL_PERIOD	msecs_to_jiffies(5) /* ms delay between samples=
 */

 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
 #define TSC2007_MEASURE_AUX		(0x2 << 4)
@@ -70,13 +68,11 @@
 struct tsc2007 {
 	struct input_dev	*input;
 	char			phys[32];
-	struct hrtimer		timer;
+	struct delayed_work	work;
 	struct ts_event		tc;

 	struct i2c_client	*client;

-	spinlock_t		lock;
-
 	u16			model;
 	u16			x_plate_ohms;

@@ -142,8 +138,7 @@
 	if (rt > MAX_12BIT) {
 		dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);

-		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
-			      HRTIMER_MODE_REL);
+		schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
 		return;
 	}

@@ -153,7 +148,7 @@
 	 * in some cases may not even settle at the expected value.
 	 *
 	 * The only safe way to check for the pen up condition is in the
-	 * timer by reading the pen signal state (it's a GPIO _and_ IRQ).
+	 * work function by reading the pen signal state (it's a GPIO and IRQ=
).
 	 */
 	if (rt) {
 		struct input_dev *input =3D ts->input;
@@ -175,8 +170,7 @@
 			x, y, rt);
 	}

-	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
-			HRTIMER_MODE_REL);
+	schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
 }

 static int tsc2007_read_values(struct tsc2007 *tsc)
@@ -197,13 +191,10 @@
 	return 0;
 }

-static enum hrtimer_restart tsc2007_timer(struct hrtimer *handle)
+static void tsc2007_work(struct work_struct *work)
 {
-	struct tsc2007 *ts =3D container_of(handle, struct tsc2007, timer);
-	unsigned long flags;
-
-	spin_lock_irqsave(&ts->lock, flags);
-
+	struct tsc2007 *ts =3D
+		container_of(to_delayed_work(work), struct tsc2007, work);
 	if (unlikely(!ts->get_pendown_state() && ts->pendown)) {
 		struct input_dev *input =3D ts->input;

@@ -222,30 +213,20 @@
 		tsc2007_read_values(ts);
 		tsc2007_send_event(ts);
 	}
-
-	spin_unlock_irqrestore(&ts->lock, flags);
-
-	return HRTIMER_NORESTART;
 }

 static irqreturn_t tsc2007_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts =3D handle;
-	unsigned long flags;

-	spin_lock_irqsave(&ts->lock, flags);
-
 	if (likely(ts->get_pendown_state())) {
 		disable_irq_nosync(ts->irq);
-		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
-					HRTIMER_MODE_REL);
+		schedule_delayed_work(&ts->work, 0);
 	}

 	if (ts->clear_penirq)
 		ts->clear_penirq();

-	spin_unlock_irqrestore(&ts->lock, flags);
-
 	return IRQ_HANDLED;
 }

@@ -278,11 +259,6 @@

 	ts->input =3D input_dev;

-	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ts->timer.function =3D tsc2007_timer;
-
-	spin_lock_init(&ts->lock);
-
 	ts->model             =3D pdata->model;
 	ts->x_plate_ohms      =3D pdata->x_plate_ohms;
 	ts->get_pendown_state =3D pdata->get_pendown_state;
@@ -308,6 +284,8 @@

 	ts->irq =3D client->irq;

+	INIT_DELAYED_WORK(&ts->work, tsc2007_work);
+
 	err =3D request_irq(ts->irq, tsc2007_irq, 0,
 			client->dev.driver->name, ts);
 	if (err < 0) {
@@ -325,7 +303,6 @@

  err_free_irq:
 	free_irq(ts->irq, ts);
-	hrtimer_cancel(&ts->timer);
  err_free_mem:
 	input_free_device(input_dev);
 	kfree(ts);
@@ -337,11 +314,13 @@
 	struct tsc2007	*ts =3D i2c_get_clientdata(client);
 	struct tsc2007_platform_data *pdata;

+	/* cancel any work */
+	cancel_delayed_work(&ts->work);
+
 	pdata =3D client->dev.platform_data;
 	pdata->exit_platform_hw();

 	free_irq(ts->irq, ts);
-	hrtimer_cancel(&ts->timer);
 	input_unregister_device(ts->input);
 	kfree(ts);
