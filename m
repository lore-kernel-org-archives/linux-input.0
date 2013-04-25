From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] Input: touchscreen: ads7846: copy info from pdata to private struct
Date: Thu, 25 Apr 2013 13:33:52 +0200
Message-ID: <1366889633-12577-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:43982 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757514Ab3DYLnk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Apr 2013 07:43:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: broonie@kernel.org, grant.likely@linaro.org, dmitry.torokhov@gmail.com, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com, Daniel Mack <zonque@gmail.com>

In preparation for DT bindings, we have to store all runtime information
inside struct ads7846. Add more variable to struct ads7846 and refactor
some code so the probe-time supplied pdata is not used from any other
function than the probe() callback.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 132 +++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 84ccf14..1c9c83a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -106,11 +106,17 @@ struct ads7846 {
 	u16			model;
 	u16			vref_mv;
 	u16			vref_delay_usecs;
+	u16			x_min, x_max;
+	u16			y_min, y_max;
 	u16			x_plate_ohms;
+	u16			y_plate_ohms;
+	u16			pressure_min;
 	u16			pressure_max;
 
+	bool			keep_vref_on;
 	bool			swap_xy;
 	bool			use_internal;
+	bool			wakeup;
 
 	struct ads7846_packet	*packet;
 
@@ -129,6 +135,8 @@ struct ads7846 {
 	u16			debounce_tol;
 	u16			debounce_rep;
 
+	u16			settle_delay_usecs;
+	int			gpio_pendown_debounce;
 	u16			penirq_recheck_delay_usecs;
 
 	struct mutex		lock;
@@ -141,6 +149,7 @@ struct ads7846 {
 	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
 	int			gpio_pendown;
+	unsigned long		irq_flags;
 
 	void			(*wait_for_sync)(void);
 };
@@ -960,10 +969,8 @@ static int ads7846_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 
-static int ads7846_setup_pendown(struct spi_device *spi,
-					   struct ads7846 *ts)
+static int ads7846_setup_pendown(struct spi_device *spi, struct ads7846 *ts)
 {
-	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	int err;
 
 	/*
@@ -972,24 +979,19 @@ static int ads7846_setup_pendown(struct spi_device *spi,
 	 * the pendown state.
 	 */
 
-	if (pdata->get_pendown_state) {
-		ts->get_pendown_state = pdata->get_pendown_state;
-	} else if (gpio_is_valid(pdata->gpio_pendown)) {
-
-		err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
+	if (!ts->get_pendown_state && gpio_is_valid(ts->gpio_pendown)) {
+		err = gpio_request_one(ts->gpio_pendown, GPIOF_IN,
 				       "ads7846_pendown");
 		if (err) {
 			dev_err(&spi->dev,
 				"failed to request/setup pendown GPIO%d: %d\n",
-				pdata->gpio_pendown, err);
+				ts->gpio_pendown, err);
 			return err;
 		}
 
-		ts->gpio_pendown = pdata->gpio_pendown;
-
-		if (pdata->gpio_pendown_debounce)
-			gpio_set_debounce(pdata->gpio_pendown,
-					  pdata->gpio_pendown_debounce);
+		if (ts->gpio_pendown_debounce)
+			gpio_set_debounce(ts->gpio_pendown,
+					  ts->gpio_pendown_debounce);
 	} else {
 		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
 		return -EINVAL;
@@ -1002,13 +1004,12 @@ static int ads7846_setup_pendown(struct spi_device *spi,
  * Set up the transfers to read touchscreen state; this assumes we
  * use formula #2 for pressure, not #3.
  */
-static void ads7846_setup_spi_msg(struct ads7846 *ts,
-				const struct ads7846_platform_data *pdata)
+static void ads7846_setup_spi_msg(struct ads7846 *ts)
 {
 	struct spi_message *m = &ts->msg[0];
 	struct spi_transfer *x = ts->xfer;
 	struct ads7846_packet *packet = ts->packet;
-	int vref = pdata->keep_vref_on;
+	int vref = ts->keep_vref_on;
 
 	if (ts->model == 7873) {
 		/*
@@ -1050,8 +1051,8 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	 * optionally discard it, using a second one after the signals
 	 * have had enough time to stabilize.
 	 */
-	if (pdata->settle_delay_usecs) {
-		x->delay_usecs = pdata->settle_delay_usecs;
+	if (ts->settle_delay_usecs) {
+		x->delay_usecs = ts->settle_delay_usecs;
 
 		x++;
 		x->tx_buf = &packet->read_y;
@@ -1093,8 +1094,8 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	}
 
 	/* ... maybe discard first sample ... */
-	if (pdata->settle_delay_usecs) {
-		x->delay_usecs = pdata->settle_delay_usecs;
+	if (ts->settle_delay_usecs) {
+		x->delay_usecs = ts->settle_delay_usecs;
 
 		x++;
 		x->tx_buf = &packet->read_x;
@@ -1126,8 +1127,8 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 		spi_message_add_tail(x, m);
 
 		/* ... maybe discard first sample ... */
-		if (pdata->settle_delay_usecs) {
-			x->delay_usecs = pdata->settle_delay_usecs;
+		if (ts->settle_delay_usecs) {
+			x->delay_usecs = ts->settle_delay_usecs;
 
 			x++;
 			x->tx_buf = &packet->read_z1;
@@ -1157,8 +1158,8 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 		spi_message_add_tail(x, m);
 
 		/* ... maybe discard first sample ... */
-		if (pdata->settle_delay_usecs) {
-			x->delay_usecs = pdata->settle_delay_usecs;
+		if (ts->settle_delay_usecs) {
+			x->delay_usecs = ts->settle_delay_usecs;
 
 			x++;
 			x->tx_buf = &packet->read_z2;
@@ -1256,10 +1257,44 @@ static int ads7846_probe(struct spi_device *spi)
 	mutex_init(&ts->lock);
 	init_waitqueue_head(&ts->wait);
 
-	ts->model = pdata->model ? : 7846;
-	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
-	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
-	ts->pressure_max = pdata->pressure_max ? : ~0;
+	ts->model = pdata->model;
+	ts->keep_vref_on = pdata->keep_vref_on;
+	ts->swap_xy = pdata->swap_xy;
+	ts->vref_delay_usecs = pdata->vref_delay_usecs;
+	ts->x_plate_ohms = pdata->x_plate_ohms;
+	ts->y_plate_ohms = pdata->y_plate_ohms;
+	ts->x_min = pdata->x_min;
+	ts->x_max = pdata->x_max;
+	ts->y_min = pdata->y_min;
+	ts->y_max = pdata->y_max;
+	ts->pressure_min = pdata->pressure_min;
+	ts->pressure_max = pdata->pressure_max;
+	ts->debounce_max = pdata->debounce_max;
+	ts->debounce_tol = pdata->debounce_tol;
+	ts->debounce_rep = pdata->debounce_rep;
+	ts->gpio_pendown = pdata->gpio_pendown;
+	ts->gpio_pendown_debounce = pdata->gpio_pendown_debounce;
+	ts->penirq_recheck_delay_usecs = pdata->penirq_recheck_delay_usecs;
+	ts->filter = pdata->filter;
+	ts->filter_cleanup = pdata->filter_cleanup;
+	ts->wait_for_sync = pdata->wait_for_sync;
+	ts->wakeup = pdata->wakeup;
+	ts->irq_flags = pdata->irq_flags;
+
+	if (ts->model == 0)
+		ts->model = 7846;
+
+	if (ts->vref_delay_usecs == 0)
+		ts->vref_delay_usecs = 100;
+
+	if (ts->x_plate_ohms == 0)
+		ts->x_plate_ohms = 400;
+
+	if (ts->pressure_max == 0)
+		ts->pressure_max = ~0;
+
+	if (ts->wait_for_sync == NULL)
+		ts->wait_for_sync = null_wait_for_sync;
 
 	if (pdata->filter != NULL) {
 		if (pdata->filter_init != NULL) {
@@ -1267,14 +1302,9 @@ static int ads7846_probe(struct spi_device *spi)
 			if (err < 0)
 				goto err_free_mem;
 		}
-		ts->filter = pdata->filter;
-		ts->filter_cleanup = pdata->filter_cleanup;
-	} else if (pdata->debounce_max) {
-		ts->debounce_max = pdata->debounce_max;
+	} else if (ts->debounce_max) {
 		if (ts->debounce_max < 2)
 			ts->debounce_max = 2;
-		ts->debounce_tol = pdata->debounce_tol;
-		ts->debounce_rep = pdata->debounce_rep;
 		ts->filter = ads7846_debounce_filter;
 		ts->filter_data = ts;
 	} else {
@@ -1285,12 +1315,6 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err)
 		goto err_cleanup_filter;
 
-	if (pdata->penirq_recheck_delay_usecs)
-		ts->penirq_recheck_delay_usecs =
-				pdata->penirq_recheck_delay_usecs;
-
-	ts->wait_for_sync = pdata->wait_for_sync ? : null_wait_for_sync;
-
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&spi->dev));
 	snprintf(ts->name, sizeof(ts->name), "ADS%d Touchscreen", ts->model);
 
@@ -1301,17 +1325,17 @@ static int ads7846_probe(struct spi_device *spi)
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 	input_set_abs_params(input_dev, ABS_X,
-			pdata->x_min ? : 0,
-			pdata->x_max ? : MAX_12BIT,
-			0, 0);
+			     ts->x_min ? : 0,
+			     ts->x_max ? : MAX_12BIT,
+			     0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-			pdata->y_min ? : 0,
-			pdata->y_max ? : MAX_12BIT,
-			0, 0);
+			     ts->y_min ? : 0,
+			     ts->y_max ? : MAX_12BIT,
+			     0, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+			     ts->pressure_min, ts->pressure_max, 0, 0);
 
-	ads7846_setup_spi_msg(ts, pdata);
+	ads7846_setup_spi_msg(ts);
 
 	ts->reg = regulator_get(&spi->dev, "vcc");
 	if (IS_ERR(ts->reg)) {
@@ -1326,18 +1350,18 @@ static int ads7846_probe(struct spi_device *spi)
 		goto err_put_regulator;
 	}
 
-	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
+	irq_flags = ts->irq_flags ? : IRQF_TRIGGER_FALLING;
 	irq_flags |= IRQF_ONESHOT;
 
 	err = request_threaded_irq(spi->irq, ads7846_hard_irq, ads7846_irq,
 				   irq_flags, spi->dev.driver->name, ts);
-	if (err && !pdata->irq_flags) {
+	if (err && !ts->irq_flags) {
 		dev_info(&spi->dev,
 			"trying pin change workaround on irq %d\n", spi->irq);
 		irq_flags |= IRQF_TRIGGER_RISING;
 		err = request_threaded_irq(spi->irq,
-				  ads7846_hard_irq, ads7846_irq,
-				  irq_flags, spi->dev.driver->name, ts);
+					   ads7846_hard_irq, ads7846_irq,
+					   irq_flags, spi->dev.driver->name, ts);
 	}
 
 	if (err) {
@@ -1368,7 +1392,7 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err)
 		goto err_remove_attr_group;
 
-	device_init_wakeup(&spi->dev, pdata->wakeup);
+	device_init_wakeup(&spi->dev, ts->wakeup);
 
 	return 0;
 
-- 
1.8.1.4

