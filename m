From: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 1/4] Input: cyttsp - use devres managed resource allocations
Date: Thu, 21 Jan 2016 23:21:29 +0100
Message-ID: <8e468206b9148c7a0a369b78e2091abe2507f7d5.1453414661.git.oreste.salerno@tomtom.com>
References: <cover.1453414661.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1453414661.git.oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Use devm_() functions for allocating memory, input device and IRQ.

Signed-off-by: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/touchscreen/cyttsp_core.c | 65 ++++++++++++++-------------------
 drivers/input/touchscreen/cyttsp_core.h |  1 -
 drivers/input/touchscreen/cyttsp_i2c.c  | 10 -----
 drivers/input/touchscreen/cyttsp_spi.c  | 10 -----
 4 files changed, 27 insertions(+), 59 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 5b74e8b..e6437f2 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -528,6 +528,14 @@ static void cyttsp_close(struct input_dev *dev)
 		cyttsp_disable(ts);
 }
 
+static void cyttsp_platform_exit(void *data)
+{
+	struct cyttsp *ts = data;
+
+	if (ts->pdata->exit)
+		ts->pdata->exit();
+}
+
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size)
 {
@@ -536,17 +544,13 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 	struct input_dev *input_dev;
 	int error;
 
-	if (!pdata || !pdata->name || irq <= 0) {
-		error = -EINVAL;
-		goto err_out;
-	}
+	if (!pdata || !pdata->name || irq <= 0)
+		return ERR_PTR(-EINVAL);
 
-	ts = kzalloc(sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	ts = devm_kzalloc(dev, sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
+	input_dev = devm_input_allocate_device(dev);
+	if (!ts || !input_dev)
+		return ERR_PTR(-ENOMEM);
 
 	ts->dev = dev;
 	ts->input = input_dev;
@@ -557,12 +561,18 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 	init_completion(&ts->bl_ready);
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
+	error = devm_add_action(dev, cyttsp_platform_exit, ts);
+	if (error) {
+		dev_err(dev, "failed to install exit action: %d\n", error);
+		return ERR_PTR(error);
+	}
+
 	if (pdata->init) {
 		error = pdata->init();
 		if (error) {
 			dev_err(ts->dev, "platform init failed, err: %d\n",
 				error);
-			goto err_free_mem;
+			return ERR_PTR(error);
 		}
 	}
 
@@ -586,53 +596,32 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	input_mt_init_slots(input_dev, CY_MAX_ID, 0);
 
-	error = request_threaded_irq(ts->irq, NULL, cyttsp_irq,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     pdata->name, ts);
+	error = devm_request_threaded_irq(dev, ts->irq, NULL, cyttsp_irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  pdata->name, ts);
 	if (error) {
 		dev_err(ts->dev, "failed to request IRQ %d, err: %d\n",
 			ts->irq, error);
-		goto err_platform_exit;
+		return ERR_PTR(error);
 	}
 
 	disable_irq(ts->irq);
 
 	error = cyttsp_power_on(ts);
 	if (error)
-		goto err_free_irq;
+		return ERR_PTR(error);
 
 	error = input_register_device(input_dev);
 	if (error) {
 		dev_err(ts->dev, "failed to register input device: %d\n",
 			error);
-		goto err_free_irq;
+		return ERR_PTR(error);
 	}
 
 	return ts;
-
-err_free_irq:
-	free_irq(ts->irq, ts);
-err_platform_exit:
-	if (pdata->exit)
-		pdata->exit();
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(ts);
-err_out:
-	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(cyttsp_probe);
 
-void cyttsp_remove(struct cyttsp *ts)
-{
-	free_irq(ts->irq, ts);
-	input_unregister_device(ts->input);
-	if (ts->pdata->exit)
-		ts->pdata->exit();
-	kfree(ts);
-}
-EXPORT_SYMBOL_GPL(cyttsp_remove);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard touchscreen driver core");
 MODULE_AUTHOR("Cypress");
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 0707411..c5e7afc 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -143,7 +143,6 @@ struct cyttsp {
 
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size);
-void cyttsp_remove(struct cyttsp *ts);
 
 int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf, u16 addr,
 		u8 length, const void *values);
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index eee51b3..1edfdba 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -56,15 +56,6 @@ static int cyttsp_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int cyttsp_i2c_remove(struct i2c_client *client)
-{
-	struct cyttsp *ts = i2c_get_clientdata(client);
-
-	cyttsp_remove(ts);
-
-	return 0;
-}
-
 static const struct i2c_device_id cyttsp_i2c_id[] = {
 	{ CY_I2C_NAME, 0 },
 	{ }
@@ -77,7 +68,6 @@ static struct i2c_driver cyttsp_i2c_driver = {
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe		= cyttsp_i2c_probe,
-	.remove		= cyttsp_i2c_remove,
 	.id_table	= cyttsp_i2c_id,
 };
 
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index bbeeb24..3c9d18b 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -170,22 +170,12 @@ static int cyttsp_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int cyttsp_spi_remove(struct spi_device *spi)
-{
-	struct cyttsp *ts = spi_get_drvdata(spi);
-
-	cyttsp_remove(ts);
-
-	return 0;
-}
-
 static struct spi_driver cyttsp_spi_driver = {
 	.driver = {
 		.name	= CY_SPI_NAME,
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe  = cyttsp_spi_probe,
-	.remove = cyttsp_spi_remove,
 };
 
 module_spi_driver(cyttsp_spi_driver);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
