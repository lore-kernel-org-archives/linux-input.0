From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: ad7879 - use threaded IRQ
Date: Fri, 25 Jun 2010 01:22:18 -0700
Message-ID: <20100625082218.8617.36197.stgit@localhost.localdomain>
References: <20100625081847.8617.31150.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44354 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0FYIWY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 04:22:24 -0400
Received: by pxi8 with SMTP id 8so593923pxi.19
        for <linux-input@vger.kernel.org>; Fri, 25 Jun 2010 01:22:23 -0700 (PDT)
In-Reply-To: <20100625081847.8617.31150.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7879.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 4b32fb4..f947457 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -44,7 +44,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
@@ -131,13 +130,12 @@ typedef struct i2c_client	bus_device;
 struct ad7879 {
 	bus_device		*bus;
 	struct input_dev	*input;
-	struct work_struct	work;
 	struct timer_list	timer;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gc;
 #endif
 	struct mutex		mutex;
-	unsigned		disabled:1;	/* P: mutex */
+	bool			disabled;	/* P: mutex */
 
 #if defined(CONFIG_TOUCHSCREEN_AD7879_SPI) || defined(CONFIG_TOUCHSCREEN_AD7879_SPI_MODULE)
 	struct spi_message	msg;
@@ -196,16 +194,6 @@ static void ad7879_report(struct ad7879 *ts)
 	}
 }
 
-static void ad7879_work(struct work_struct *work)
-{
-	struct ad7879 *ts = container_of(work, struct ad7879, work);
-
-	/* use keventd context to read the result registers */
-	ad7879_collect(ts);
-	ad7879_report(ts);
-	mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
-}
-
 static void ad7879_ts_event_release(struct ad7879 *ts)
 {
 	struct input_dev *input_dev = ts->input;
@@ -225,13 +213,10 @@ static irqreturn_t ad7879_irq(int irq, void *handle)
 {
 	struct ad7879 *ts = handle;
 
-	/* The repeated conversion sequencer controlled by TMR kicked off too fast.
-	 * We ignore the last and process the sample sequence currently in the queue.
-	 * It can't be older than 9.4ms
-	 */
+	ad7879_collect(ts);
+	ad7879_report(ts);
 
-	if (!work_pending(&ts->work))
-		schedule_work(&ts->work);
+	mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 
 	return IRQ_HANDLED;
 }
@@ -249,11 +234,9 @@ static void ad7879_disable(struct ad7879 *ts)
 
 	if (!ts->disabled) {
 
-		ts->disabled = 1;
+		ts->disabled = true;
 		disable_irq(ts->bus->irq);
 
-		cancel_work_sync(&ts->work);
-
 		if (del_timer_sync(&ts->timer))
 			ad7879_ts_event_release(ts);
 
@@ -270,7 +253,7 @@ static void ad7879_enable(struct ad7879 *ts)
 
 	if (ts->disabled) {
 		ad7879_setup(ts);
-		ts->disabled = 0;
+		ts->disabled = false;
 		enable_irq(ts->bus->irq);
 	}
 
@@ -458,7 +441,6 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 	ts->input = input_dev;
 
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
-	INIT_WORK(&ts->work, ad7879_work);
 	mutex_init(&ts->mutex);
 
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
@@ -526,9 +508,9 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 
 	ad7879_setup(ts);
 
-	err = request_irq(bus->irq, ad7879_irq,
-			  IRQF_TRIGGER_FALLING, bus->dev.driver->name, ts);
-
+	err = request_threaded_irq(bus->irq, NULL, ad7879_irq,
+				   IRQF_TRIGGER_FALLING,
+				   bus->dev.driver->name, ts);
 	if (err) {
 		dev_err(&bus->dev, "irq %d busy?\n", bus->irq);
 		goto err_free_mem;

