From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/3] Input: ads7846 - introduce .gpio_pendown to get pendown state
Date: Thu, 4 Sep 2008 17:21:05 +0800
Message-ID: <f17812d70809040221u606f5bfaxe4ae41fae644391f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:28984 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbYIDJVH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Sep 2008 05:21:07 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1846883yxm.1
        for <linux-input@vger.kernel.org>; Thu, 04 Sep 2008 02:21:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-input@vger.kernel.org, David Brownell <david-b@pacbell.net>

The GPIO connected to ADS7846 nPENIRQ signal is usually used to get
the pendown state as well. Introduce a .gpio_pendown, and use this
to decide the pendown state if .get_pendown_state is NULL.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/touchscreen/ads7846.c |   73 ++++++++++++++++++++++++++++-------
 include/linux/spi/ads7846.h         |    4 ++
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c
b/drivers/input/touchscreen/ads7846.c
index ce6f48c..4fd449a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <asm/irq.h>
@@ -116,6 +117,7 @@ struct ads7846 {
 	void			*filter_data;
 	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
+	int			gpio_pendown;
 };

 /* leave chip selected when we're done, for quicker re-select? */
@@ -491,6 +493,17 @@ static struct attribute_group ads784x_attr_group = {

 /*--------------------------------------------------------------------------*/

+static int get_pendown_state(struct ads7846 *ts)
+{
+	if (ts->get_pendown_state)
+		return ts->get_pendown_state();
+
+	if (ts->gpio_pendown != -1)
+		return !gpio_get_value(ts->gpio_pendown);
+
+	return 0;
+}
+
 /*
  * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
  * to retrieve touchscreen status.
@@ -550,7 +563,7 @@ static void ads7846_rx(void *ads)
 	 */
 	if (ts->penirq_recheck_delay_usecs) {
 		udelay(ts->penirq_recheck_delay_usecs);
-		if (!ts->get_pendown_state())
+		if (!get_pendown_state(ts))
 			Rt = 0;
 	}

@@ -677,7 +690,7 @@ static enum hrtimer_restart ads7846_timer(struct
hrtimer *handle)

 	spin_lock_irq(&ts->lock);

-	if (unlikely(!ts->get_pendown_state() ||
+	if (unlikely(!get_pendown_state(ts) ||
 		     device_suspended(&ts->spi->dev))) {
 		if (ts->pendown) {
 			struct input_dev *input = ts->input;
@@ -716,7 +729,7 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 	unsigned long flags;

 	spin_lock_irqsave(&ts->lock, flags);
-	if (likely(ts->get_pendown_state())) {
+	if (likely(get_pendown_state(ts))) {
 		if (!ts->irq_disabled) {
 			/* The ARM do_simple_IRQ() dispatcher doesn't act
 			 * like the other dispatchers:  it will report IRQs
@@ -806,6 +819,38 @@ static int ads7846_resume(struct spi_device *spi)
 	return 0;
 }

+static int __devinit setup_pendown(struct spi_device *spi, struct ads7846 *ts)
+{
+	struct ads7846_platform_data *pdata = spi->dev.platform_data;
+	int err;
+
+	ts->gpio_pendown = -1;
+
+	/* REVISIT when the irq can be triggered active-low, or if for some
+	 * reason the touchscreen isn't hooked up, we don't need to access
+	 * the pendown state.
+	 */
+	if (pdata->get_pendown_state == NULL && pdata->gpio_pendown == -1) {
+		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
+		return -EINVAL;
+	}
+
+	if (pdata->get_pendown_state) {
+		ts->get_pendown_state = pdata->get_pendown_state;
+		return 0;
+	}
+
+	err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
+	if (err) {
+		dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
+				pdata->gpio_pendown);
+		return err;
+	}
+
+	ts->gpio_pendown = pdata->gpio_pendown;
+	return 0;
+}
+
 static int __devinit ads7846_probe(struct spi_device *spi)
 {
 	struct ads7846			*ts;
@@ -833,15 +878,6 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		return -EINVAL;
 	}

-	/* REVISIT when the irq can be triggered active-low, or if for some
-	 * reason the touchscreen isn't hooked up, we don't need to access
-	 * the pendown state.
-	 */
-	if (pdata->get_pendown_state == NULL) {
-		dev_dbg(&spi->dev, "no get_pendown_state function?\n");
-		return -EINVAL;
-	}
-
 	/* We'd set TX wordsize 8 bits and RX wordsize to 13 bits ... except
 	 * that even if the hardware can do that, the SPI controller driver
 	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
@@ -893,7 +929,10 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		ts->filter_data = ts;
 	} else
 		ts->filter = ads7846_no_filter;
-	ts->get_pendown_state = pdata->get_pendown_state;
+
+	err = setup_pendown(spi, ts);
+	if (err)
+		goto err_cleanup_filter;

 	if (pdata->penirq_recheck_delay_usecs)
 		ts->penirq_recheck_delay_usecs =
@@ -1085,7 +1124,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 			spi->dev.driver->name, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
-		goto err_cleanup_filter;
+		goto err_free_gpio;
 	}

 	err = ads784x_hwmon_register(spi, ts);
@@ -1116,6 +1155,9 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	ads784x_hwmon_unregister(spi, ts);
  err_free_irq:
 	free_irq(spi->irq, ts);
+ err_free_gpio:
+	if (ts->gpio_pendown != -1)
+		gpio_free(ts->gpio_pendown);
  err_cleanup_filter:
 	if (ts->filter_cleanup)
 		ts->filter_cleanup(ts->filter_data);
@@ -1140,6 +1182,9 @@ static int __devexit ads7846_remove(struct
spi_device *spi)
 	/* suspend left the IRQ disabled */
 	enable_irq(ts->spi->irq);

+	if (ts->gpio_pendown != -1)
+		gpio_free(ts->gpio_pendown);
+
 	if (ts->filter_cleanup)
 		ts->filter_cleanup(ts->filter_data);

diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index daf7440..5850605 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -43,6 +43,10 @@ struct ads7846_platform_data {
 	u16	debounce_tol;		/* tolerance used for filtering */
 	u16	debounce_rep;		/* additional consecutive good readings
 					 * required after the first two */
+	int	gpio_pendown;		/* the GPIO usually connected to PENIRQ
+					 * and used to decide pendown state
+					 * (-1) to use (*get_pendown_state) */
+
 	int	(*get_pendown_state)(void);
 	int	(*filter_init)	(struct ads7846_platform_data *pdata,
 				 void **filter_data);
-- 
1.5.4.3
