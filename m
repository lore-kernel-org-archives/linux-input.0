From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 09/17] Input: tsc2005 - rework driver initialization code
Date: Wed, 16 Mar 2011 00:18:46 -0700
Message-ID: <20110316071846.25664.36864.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37590 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHSv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:51 -0400
Received: by gwaa18 with SMTP id a18so544592gwa.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:50 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

We need to make sure we have time/work initialized before requesting and
enabling interrupts, otherwise we might start using them way too early.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |  213 +++++++++++++++++------------------
 1 files changed, 103 insertions(+), 110 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 09cbcb0..d7ea906 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -495,6 +495,16 @@ out:
 	mutex_unlock(&ts->mutex);
 }
 
+static struct attribute *tsc2005_attrs[] = {
+	&dev_attr_disable.attr,
+	&dev_attr_selftest.attr,
+	NULL
+};
+
+static struct attribute_group tsc2005_attr_group = {
+	.attrs = tsc2005_attrs,
+};
+
 static void __devinit tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 {
 	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, 0);
@@ -509,144 +519,128 @@ static void __devinit tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 	spi_message_add_tail(&ts->spi_z2.spi_xfer, &ts->spi_read_msg);
 }
 
-static struct attribute *tsc2005_attrs[] = {
-	&dev_attr_disable.attr,
-	&dev_attr_selftest.attr,
-	NULL
-};
-
-static struct attribute_group tsc2005_attr_group = {
-	.attrs = tsc2005_attrs,
-};
-
-static int __devinit tsc2005_setup(struct tsc2005 *ts,
-				   struct tsc2005_platform_data *pdata)
+static int __devinit tsc2005_probe(struct spi_device *spi)
 {
-	int r;
-	int fudge_x;
-	int fudge_y;
-	int fudge_p;
-	int p_max;
-	int x_max;
-	int y_max;
+	const struct tsc2005_platform_data *pdata = spi->dev.platform_data;
+	struct tsc2005 *ts;
+	struct input_dev *input_dev;
+	unsigned int max_x, max_y, max_p;
+	unsigned int fudge_x, fudge_y, fudge_p;
+	int error;
 
-	mutex_init(&ts->mutex);
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data\n");
+		return -ENODEV;
+	}
 
-	tsc2005_setup_spi_xfer(ts);
+	fudge_x	= pdata->ts_x_fudge	   ? : 4;
+	fudge_y	= pdata->ts_y_fudge	   ? : 8;
+	fudge_p	= pdata->ts_pressure_fudge ? : 2;
+	max_x	= pdata->ts_x_max	   ? : MAX_12BIT;
+	max_y	= pdata->ts_y_max	   ? : MAX_12BIT;
+	max_p	= pdata->ts_pressure_max   ? : MAX_12BIT;
 
-	init_timer(&ts->penup_timer);
-	setup_timer(&ts->penup_timer, tsc2005_penup_timer, (unsigned long)ts);
-	INIT_WORK(&ts->penup_work, tsc2005_penup_work);
+	if (spi->irq <= 0) {
+		dev_dbg(&spi->dev, "no irq\n");
+		return -ENODEV;
+	}
 
-	fudge_x		= pdata->ts_x_fudge	   ? : 4;
-	fudge_y		= pdata->ts_y_fudge	   ? : 8;
-	fudge_p		= pdata->ts_pressure_fudge ? : 2;
-	x_max		= pdata->ts_x_max	   ? : MAX_12BIT;
-	y_max		= pdata->ts_y_max	   ? : MAX_12BIT;
-	p_max		= pdata->ts_pressure_max   ? : MAX_12BIT;
-	ts->x_plate_ohm	= pdata->ts_x_plate_ohm	   ? : 280;
-	ts->esd_timeout	= pdata->esd_timeout_ms;
-	ts->set_reset	= pdata->set_reset;
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = TSC2005_SPI_MAX_SPEED_HZ;
 
-	ts->idev = input_allocate_device();
-	if (ts->idev == NULL)
-		return -ENOMEM;
-	ts->idev->name = "TSC2005 touchscreen";
-	snprintf(ts->phys, sizeof(ts->phys), "%s/input-ts",
-		 dev_name(&ts->spi->dev));
-	ts->idev->phys = ts->phys;
-	ts->idev->id.bustype = BUS_SPI;
-	ts->idev->dev.parent = &ts->spi->dev;
-	ts->idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
-	ts->idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
-	ts->idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-
-	input_set_abs_params(ts->idev, ABS_X, 0, x_max, fudge_x, 0);
-	input_set_abs_params(ts->idev, ABS_Y, 0, y_max, fudge_y, 0);
-	input_set_abs_params(ts->idev, ABS_PRESSURE, 0, p_max, fudge_p, 0);
-
-	r = request_threaded_irq(ts->spi->irq, tsc2005_irq_handler,
-				 tsc2005_irq_thread, IRQF_TRIGGER_RISING,
-				 "tsc2005", ts);
-	if (r) {
-		dev_err(&ts->spi->dev, "request_threaded_irq(): %d\n", r);
-		goto err1;
-	}
-	set_irq_wake(ts->spi->irq, 1);
+	error = spi_setup(spi);
+	if (error)
+		return error;
 
-	r = input_register_device(ts->idev);
-	if (r) {
-		dev_err(&ts->spi->dev, "input_register_device(): %d\n", r);
-		goto err2;
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
-	r = sysfs_create_group(&ts->spi->dev.kobj, &tsc2005_attr_group);
-	if (r)
-		dev_warn(&ts->spi->dev, "sysfs entry creation failed: %d\n", r);
+	ts->spi = spi;
+	ts->x_plate_ohm	= pdata->ts_x_plate_ohm	? : 280;
+	ts->esd_timeout	= pdata->esd_timeout_ms;
+	ts->set_reset	= pdata->set_reset;
 
-	tsc2005_start_scan(ts);
+	mutex_init(&ts->mutex);
 
-	if (!ts->esd_timeout || !ts->set_reset)
-		goto done;
+	setup_timer(&ts->penup_timer, tsc2005_penup_timer, (unsigned long)ts);
+	INIT_WORK(&ts->penup_work, tsc2005_penup_work);
 
-	/* start the optional ESD watchdog */
 	setup_timer(&ts->esd_timer, tsc2005_esd_timer, (unsigned long)ts);
 	INIT_WORK(&ts->esd_work, tsc2005_esd_work);
-	mod_timer(&ts->esd_timer,
-		  round_jiffies(jiffies + msecs_to_jiffies(ts->esd_timeout)));
 
-done:
-	return 0;
-
-err2:
-	free_irq(ts->spi->irq, ts);
-
-err1:
-	input_free_device(ts->idev);
-	return r;
-}
-
-static int __devinit tsc2005_probe(struct spi_device *spi)
-{
-	struct tsc2005_platform_data *pdata = spi->dev.platform_data;
-	struct tsc2005 *ts;
-	int r;
+	tsc2005_setup_spi_xfer(ts);
 
-	if (spi->irq < 0) {
-		dev_dbg(&spi->dev, "no irq\n");
-		return -ENODEV;
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input-ts", dev_name(&spi->dev));
+
+	input_dev->name = "TSC2005 touchscreen";
+	input_dev->phys = ts->phys;
+	input_dev->id.bustype = BUS_SPI;
+	input_dev->dev.parent = &spi->dev;
+	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X, 0, max_x, fudge_x, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, max_y, fudge_y, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
+
+	error = request_threaded_irq(spi->irq,
+				     tsc2005_irq_handler, tsc2005_irq_thread,
+				     IRQF_TRIGGER_RISING, "tsc2005", ts);
+	if (error) {
+		dev_err(&spi->dev, "Failed to request irq, err: %d\n", error);
+		goto err_free_mem;
 	}
 
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data\n");
-		return -ENODEV;
+	spi_set_drvdata(spi, ts);
+	error = sysfs_create_group(&spi->dev.kobj, &tsc2005_attr_group);
+	if (error) {
+		dev_err(&spi->dev,
+			"Failed to create sysfs attributes, err: %d\n", error);
+		goto err_clear_drvdata;
 	}
 
-	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (ts == NULL)
-		return -ENOMEM;
+	error = input_register_device(ts->idev);
+	if (error) {
+		dev_err(&spi->dev,
+			"Failed to register input device, err: %d\n", error);
+		goto err_remove_sysfs;
+	}
 
-	spi_set_drvdata(spi, ts);
-	ts->spi = spi;
-	spi->dev.power.power_state = PMSG_ON;
-	spi->mode = SPI_MODE_0;
-	spi->bits_per_word = 8;
-	if (!spi->max_speed_hz)
-		spi->max_speed_hz = TSC2005_SPI_MAX_SPEED_HZ;
-	spi_setup(spi);
+	tsc2005_start_scan(ts);
 
-	r = tsc2005_setup(ts, pdata);
-	if (r) {
-		kfree(ts);
-		spi_set_drvdata(spi, NULL);
+	if (ts->esd_timeout && ts->set_reset) {
+		/* start the optional ESD watchdog */
+		mod_timer(&ts->esd_timer, round_jiffies(jiffies +
+					msecs_to_jiffies(ts->esd_timeout)));
 	}
-	return r;
+
+	set_irq_wake(spi->irq, 1);
+	return 0;
+
+err_remove_sysfs:
+	sysfs_remove_group(&spi->dev.kobj, &tsc2005_attr_group);
+err_clear_drvdata:
+	spi_set_drvdata(spi, NULL);
+	free_irq(spi->irq, ts);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+	return error;
 }
 
 static int __devexit tsc2005_remove(struct spi_device *spi)
 {
 	struct tsc2005 *ts = spi_get_drvdata(spi);
 
+	sysfs_remove_group(&ts->spi->dev.kobj, &tsc2005_attr_group);
+
 	mutex_lock(&ts->mutex);
 	tsc2005_disable(ts);
 	mutex_unlock(&ts->mutex);
@@ -658,7 +652,6 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 	flush_work(&ts->esd_work);
 	flush_work(&ts->penup_work);
 
-	sysfs_remove_group(&ts->spi->dev.kobj, &tsc2005_attr_group);
 	free_irq(ts->spi->irq, ts);
 	input_unregister_device(ts->idev);
 	kfree(ts);

