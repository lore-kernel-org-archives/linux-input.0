From: Andi Shyti <andi@etezian.org>
Subject: [PATCH] Input: ads7846 - use managed allocated resources
Date: Thu,  9 Nov 2017 16:00:38 +0200
Message-ID: <20171109140038.19771-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Use managed allocated resources to simplify error handling during
probing.

Fix goto labels and remove function accordingly.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ads7846.c | 103 ++++++++++--------------------------
 1 file changed, 28 insertions(+), 75 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a2f45aefce08..2bd7bfd0dc9f 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -527,19 +527,13 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 		break;
 	}
 
-	ts->hwmon = hwmon_device_register_with_groups(&spi->dev, spi->modalias,
-						      ts, ads7846_attr_groups);
+	ts->hwmon = devm_hwmon_device_register_with_groups(&spi->dev,
+							   spi->modalias, ts,
+							   ads7846_attr_groups);
 
 	return PTR_ERR_OR_ZERO(ts->hwmon);
 }
 
-static void ads784x_hwmon_unregister(struct spi_device *spi,
-				     struct ads7846 *ts)
-{
-	if (ts->hwmon)
-		hwmon_device_unregister(ts->hwmon);
-}
-
 #else
 static inline int ads784x_hwmon_register(struct spi_device *spi,
 					 struct ads7846 *ts)
@@ -547,10 +541,6 @@ static inline int ads784x_hwmon_register(struct spi_device *spi,
 	return 0;
 }
 
-static inline void ads784x_hwmon_unregister(struct spi_device *spi,
-					    struct ads7846 *ts)
-{
-}
 #endif
 
 static ssize_t ads7846_pen_down_show(struct device *dev,
@@ -947,8 +937,8 @@ static int ads7846_setup_pendown(struct spi_device *spi,
 		ts->get_pendown_state = pdata->get_pendown_state;
 	} else if (gpio_is_valid(pdata->gpio_pendown)) {
 
-		err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
-				       "ads7846_pendown");
+		err = devm_gpio_request_one(&spi->dev, pdata->gpio_pendown,
+					    GPIOF_IN, "ads7846_pendown");
 		if (err) {
 			dev_err(&spi->dev,
 				"failed to request/setup pendown GPIO%d: %d\n",
@@ -1283,13 +1273,13 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
-	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
-	packet = kzalloc(sizeof(struct ads7846_packet), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !packet || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	ts = devm_kzalloc(&spi->dev, sizeof(struct ads7846), GFP_KERNEL);
+	packet = devm_kzalloc(&spi->dev,
+			      sizeof(struct ads7846_packet),
+			      GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&spi->dev);
+	if (!ts || !packet || !input_dev)
+		return -ENOMEM;
 
 	spi_set_drvdata(spi, ts);
 
@@ -1303,10 +1293,8 @@ static int ads7846_probe(struct spi_device *spi)
 	pdata = dev_get_platdata(&spi->dev);
 	if (!pdata) {
 		pdata = ads7846_probe_dt(&spi->dev);
-		if (IS_ERR(pdata)) {
-			err = PTR_ERR(pdata);
-			goto err_free_mem;
-		}
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
 	}
 
 	ts->model = pdata->model ? : 7846;
@@ -1321,7 +1309,7 @@ static int ads7846_probe(struct spi_device *spi)
 		if (pdata->filter_init != NULL) {
 			err = pdata->filter_init(pdata, &ts->filter_data);
 			if (err < 0)
-				goto err_free_mem;
+				return err;
 		}
 		ts->filter = pdata->filter;
 		ts->filter_cleanup = pdata->filter_cleanup;
@@ -1369,41 +1357,42 @@ static int ads7846_probe(struct spi_device *spi)
 
 	ads7846_setup_spi_msg(ts, pdata);
 
-	ts->reg = regulator_get(&spi->dev, "vcc");
+	ts->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (IS_ERR(ts->reg)) {
 		err = PTR_ERR(ts->reg);
 		dev_err(&spi->dev, "unable to get regulator: %d\n", err);
-		goto err_free_gpio;
+		goto err_cleanup_filter;
 	}
 
 	err = regulator_enable(ts->reg);
 	if (err) {
 		dev_err(&spi->dev, "unable to enable regulator: %d\n", err);
-		goto err_put_regulator;
+		goto err_cleanup_filter;
 	}
 
 	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
 	irq_flags |= IRQF_ONESHOT;
 
-	err = request_threaded_irq(spi->irq, ads7846_hard_irq, ads7846_irq,
-				   irq_flags, spi->dev.driver->name, ts);
+	err = devm_request_threaded_irq(&spi->dev, spi->irq,
+					ads7846_hard_irq, ads7846_irq,
+					irq_flags, spi->dev.driver->name, ts);
 	if (err && !pdata->irq_flags) {
 		dev_info(&spi->dev,
 			"trying pin change workaround on irq %d\n", spi->irq);
 		irq_flags |= IRQF_TRIGGER_RISING;
-		err = request_threaded_irq(spi->irq,
+		err = devm_request_threaded_irq(&spi->dev, spi->irq,
 				  ads7846_hard_irq, ads7846_irq,
 				  irq_flags, spi->dev.driver->name, ts);
 	}
 
 	if (err) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-		goto err_disable_regulator;
+		goto err_cleanup_filter;
 	}
 
 	err = ads784x_hwmon_register(spi, ts);
 	if (err)
-		goto err_free_irq;
+		goto err_cleanup_filter;
 
 	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
 
@@ -1416,13 +1405,13 @@ static int ads7846_probe(struct spi_device *spi)
 	else
 		(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
 
-	err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
+	err = devm_device_add_group(&spi->dev, &ads784x_attr_group);
 	if (err)
-		goto err_remove_hwmon;
+		goto err_cleanup_filter;
 
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr_group;
+		goto err_cleanup_filter;
 
 	device_init_wakeup(&spi->dev, pdata->wakeup);
 
@@ -1435,26 +1424,10 @@ static int ads7846_probe(struct spi_device *spi)
 
 	return 0;
 
- err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
- err_remove_hwmon:
-	ads784x_hwmon_unregister(spi, ts);
- err_free_irq:
-	free_irq(spi->irq, ts);
- err_disable_regulator:
-	regulator_disable(ts->reg);
- err_put_regulator:
-	regulator_put(ts->reg);
- err_free_gpio:
-	if (!ts->get_pendown_state)
-		gpio_free(ts->gpio_pendown);
  err_cleanup_filter:
 	if (ts->filter_cleanup)
 		ts->filter_cleanup(ts->filter_data);
- err_free_mem:
-	input_free_device(input_dev);
-	kfree(packet);
-	kfree(ts);
+
 	return err;
 }
 
@@ -1462,31 +1435,11 @@ static int ads7846_remove(struct spi_device *spi)
 {
 	struct ads7846 *ts = spi_get_drvdata(spi);
 
-	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
-
 	ads7846_disable(ts);
-	free_irq(ts->spi->irq, ts);
-
-	input_unregister_device(ts->input);
-
-	ads784x_hwmon_unregister(spi, ts);
-
-	regulator_put(ts->reg);
-
-	if (!ts->get_pendown_state) {
-		/*
-		 * If we are not using specialized pendown method we must
-		 * have been relying on gpio we set up ourselves.
-		 */
-		gpio_free(ts->gpio_pendown);
-	}
 
 	if (ts->filter_cleanup)
 		ts->filter_cleanup(ts->filter_data);
 
-	kfree(ts->packet);
-	kfree(ts);
-
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
 
 	return 0;
-- 
2.15.0
