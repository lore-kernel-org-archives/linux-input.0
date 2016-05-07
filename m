From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 1/3] input: rmi4: Move IRQ handling to rmi_driver
Date: Fri,  6 May 2016 21:40:06 -0700
Message-ID: <1462596008-21381-2-git-send-email-bjorn.andersson@linaro.org>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The attn IRQ is related to the chip, rather than the transport, so move
all handling of interrupts to the core driver. This also makes sure that
there are no races between interrupts and availability of the resources
used by the core driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/input/rmi4/rmi_driver.c | 69 +++++++++++++++++++++++++++++++++++---
 drivers/input/rmi4/rmi_i2c.c    | 73 +++--------------------------------------
 drivers/input/rmi4/rmi_spi.c    | 72 +++-------------------------------------
 include/linux/rmi.h             |  7 ++--
 4 files changed, 79 insertions(+), 142 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index faa295ec4f31..48c7991c9898 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -17,6 +17,7 @@
 #include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/irq.h>
 #include <linux/kconfig.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -134,7 +135,7 @@ static void process_one_interrupt(struct rmi_driver_data *data,
 	}
 }
 
-int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
+static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct device *dev = &rmi_dev->dev;
@@ -179,7 +180,42 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rmi_process_interrupt_requests);
+
+static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
+{
+	struct rmi_device *rmi_dev = dev_id;
+	int ret;
+
+	ret = rmi_process_interrupt_requests(rmi_dev);
+	if (ret)
+		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
+			"Failed to process interrupt request: %d\n", ret);
+
+	return IRQ_HANDLED;
+}
+
+static int rmi_irq_init(struct rmi_device *rmi_dev)
+{
+	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	int irq_flags = irq_get_trigger_type(pdata->irq);
+	int ret;
+
+	if (!irq_flags)
+		irq_flags = IRQF_TRIGGER_LOW;
+
+	ret = devm_request_threaded_irq(&rmi_dev->dev, pdata->irq, NULL,
+				        rmi_irq_fn, irq_flags | IRQF_ONESHOT,
+					dev_name(rmi_dev->xport->dev),
+					rmi_dev);
+	if (ret < 0) {
+		dev_warn(&rmi_dev->dev, "Failed to register interrupt %d\n",
+			 pdata->irq);
+
+		return ret;
+	}
+
+	return 0;
+}
 
 static int suspend_one_function(struct rmi_function *fn)
 {
@@ -786,8 +822,10 @@ err_put_fn:
 	return error;
 }
 
-int rmi_driver_suspend(struct rmi_device *rmi_dev)
+int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake)
 {
+	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	int irq = pdata->irq;
 	int retval = 0;
 
 	retval = rmi_suspend_functions(rmi_dev);
@@ -795,14 +833,33 @@ int rmi_driver_suspend(struct rmi_device *rmi_dev)
 		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
 			retval);
 
+	disable_irq(irq);
+	if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
+		retval = enable_irq_wake(irq);
+		if (!retval)
+			dev_warn(&rmi_dev->dev,
+				 "Failed to enable irq for wake: %d\n",
+				 retval);
+	}
 	return retval;
 }
 EXPORT_SYMBOL_GPL(rmi_driver_suspend);
 
-int rmi_driver_resume(struct rmi_device *rmi_dev)
+int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake)
 {
+	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	int irq = pdata->irq;
 	int retval;
 
+	enable_irq(irq);
+	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
+		retval = disable_irq_wake(irq);
+		if (!retval)
+			dev_warn(&rmi_dev->dev,
+				 "Failed to disable irq for wake: %d\n",
+				 retval);
+	}
+
 	retval = rmi_resume_functions(rmi_dev);
 	if (retval)
 		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
@@ -1003,6 +1060,10 @@ static int rmi_driver_probe(struct device *dev)
 		}
 	}
 
+	retval = rmi_irq_init(rmi_dev);
+	if (retval < 0)
+		goto err_destroy_functions;
+
 	if (data->f01_container->dev.driver)
 		/* Driver already bound, so enable ATTN now. */
 		return enable_sensor(rmi_dev);
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index a96a326b53bd..18f6a9f4aeef 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -9,7 +9,6 @@
 
 #include <linux/i2c.h>
 #include <linux/rmi.h>
-#include <linux/irq.h>
 #include <linux/of.h>
 #include "rmi_driver.h"
 
@@ -33,8 +32,6 @@ struct rmi_i2c_xport {
 	struct mutex page_mutex;
 	int page;
 
-	int irq;
-
 	u8 *tx_buf;
 	size_t tx_buf_size;
 };
@@ -172,42 +169,6 @@ static const struct rmi_transport_ops rmi_i2c_ops = {
 	.read_block	= rmi_i2c_read_block,
 };
 
-static irqreturn_t rmi_i2c_irq(int irq, void *dev_id)
-{
-	struct rmi_i2c_xport *rmi_i2c = dev_id;
-	struct rmi_device *rmi_dev = rmi_i2c->xport.rmi_dev;
-	int ret;
-
-	ret = rmi_process_interrupt_requests(rmi_dev);
-	if (ret)
-		rmi_dbg(RMI_DEBUG_XPORT, &rmi_dev->dev,
-			"Failed to process interrupt request: %d\n", ret);
-
-	return IRQ_HANDLED;
-}
-
-static int rmi_i2c_init_irq(struct i2c_client *client)
-{
-	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
-	int irq_flags = irqd_get_trigger_type(irq_get_irq_data(rmi_i2c->irq));
-	int ret;
-
-	if (!irq_flags)
-		irq_flags = IRQF_TRIGGER_LOW;
-
-	ret = devm_request_threaded_irq(&client->dev, rmi_i2c->irq, NULL,
-			rmi_i2c_irq, irq_flags | IRQF_ONESHOT, client->name,
-			rmi_i2c);
-	if (ret < 0) {
-		dev_warn(&client->dev, "Failed to register interrupt %d\n",
-			rmi_i2c->irq);
-
-		return ret;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id rmi_i2c_of_match[] = {
 	{ .compatible = "syna,rmi4-i2c" },
@@ -235,8 +196,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	if (!client->dev.of_node && client_pdata)
 		*pdata = *client_pdata;
 
-	if (client->irq > 0)
-		rmi_i2c->irq = client->irq;
+	pdata->irq = client->irq;
 
 	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Probing %s.\n",
 			dev_name(&client->dev));
@@ -272,10 +232,6 @@ static int rmi_i2c_probe(struct i2c_client *client,
 		return retval;
 	}
 
-	retval = rmi_i2c_init_irq(client);
-	if (retval < 0)
-		return retval;
-
 	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
 			client->addr);
 	return 0;
@@ -297,17 +253,10 @@ static int rmi_i2c_suspend(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
-	ret = rmi_driver_suspend(rmi_i2c->xport.rmi_dev);
+	ret = rmi_driver_suspend(rmi_i2c->xport.rmi_dev, true);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	disable_irq(rmi_i2c->irq);
-	if (device_may_wakeup(&client->dev)) {
-		ret = enable_irq_wake(rmi_i2c->irq);
-		if (!ret)
-			dev_warn(dev, "Failed to enable irq for wake: %d\n",
-				ret);
-	}
 	return ret;
 }
 
@@ -317,15 +266,7 @@ static int rmi_i2c_resume(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
-	enable_irq(rmi_i2c->irq);
-	if (device_may_wakeup(&client->dev)) {
-		ret = disable_irq_wake(rmi_i2c->irq);
-		if (!ret)
-			dev_warn(dev, "Failed to disable irq for wake: %d\n",
-				ret);
-	}
-
-	ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev);
+	ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev, true);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
@@ -340,12 +281,10 @@ static int rmi_i2c_runtime_suspend(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
-	ret = rmi_driver_suspend(rmi_i2c->xport.rmi_dev);
+	ret = rmi_driver_suspend(rmi_i2c->xport.rmi_dev, false);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	disable_irq(rmi_i2c->irq);
-
 	return 0;
 }
 
@@ -355,9 +294,7 @@ static int rmi_i2c_runtime_resume(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
-	enable_irq(rmi_i2c->irq);
-
-	ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev);
+	ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev, false);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 55bd1b34970c..f3e9e488635c 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -12,7 +12,6 @@
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/irq.h>
 #include <linux/of.h>
 #include "rmi_driver.h"
 
@@ -44,8 +43,6 @@ struct rmi_spi_xport {
 	struct mutex page_mutex;
 	int page;
 
-	int irq;
-
 	u8 *rx_buf;
 	u8 *tx_buf;
 	int xfer_buf_size;
@@ -326,41 +323,6 @@ static const struct rmi_transport_ops rmi_spi_ops = {
 	.read_block	= rmi_spi_read_block,
 };
 
-static irqreturn_t rmi_spi_irq(int irq, void *dev_id)
-{
-	struct rmi_spi_xport *rmi_spi = dev_id;
-	struct rmi_device *rmi_dev = rmi_spi->xport.rmi_dev;
-	int ret;
-
-	ret = rmi_process_interrupt_requests(rmi_dev);
-	if (ret)
-		rmi_dbg(RMI_DEBUG_XPORT, &rmi_dev->dev,
-			"Failed to process interrupt request: %d\n", ret);
-
-	return IRQ_HANDLED;
-}
-
-static int rmi_spi_init_irq(struct spi_device *spi)
-{
-	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
-	int irq_flags = irqd_get_trigger_type(irq_get_irq_data(rmi_spi->irq));
-	int ret;
-
-	if (!irq_flags)
-		irq_flags = IRQF_TRIGGER_LOW;
-
-	ret = devm_request_threaded_irq(&spi->dev, rmi_spi->irq, NULL,
-			rmi_spi_irq, irq_flags | IRQF_ONESHOT,
-			dev_name(&spi->dev), rmi_spi);
-	if (ret < 0) {
-		dev_warn(&spi->dev, "Failed to register interrupt %d\n",
-			rmi_spi->irq);
-		return ret;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static int rmi_spi_of_probe(struct spi_device *spi,
 			struct rmi_device_platform_data *pdata)
@@ -433,8 +395,7 @@ static int rmi_spi_probe(struct spi_device *spi)
 		return retval;
 	}
 
-	if (spi->irq > 0)
-		rmi_spi->irq = spi->irq;
+	pdata->irq = spi->irq;
 
 	rmi_spi->spi = spi;
 	mutex_init(&rmi_spi->page_mutex);
@@ -465,10 +426,6 @@ static int rmi_spi_probe(struct spi_device *spi)
 		return retval;
 	}
 
-	retval = rmi_spi_init_irq(spi);
-	if (retval < 0)
-		return retval;
-
 	dev_info(&spi->dev, "registered RMI SPI driver\n");
 	return 0;
 }
@@ -489,17 +446,10 @@ static int rmi_spi_suspend(struct device *dev)
 	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
 	int ret;
 
-	ret = rmi_driver_suspend(rmi_spi->xport.rmi_dev);
+	ret = rmi_driver_suspend(rmi_spi->xport.rmi_dev, true);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	disable_irq(rmi_spi->irq);
-	if (device_may_wakeup(&spi->dev)) {
-		ret = enable_irq_wake(rmi_spi->irq);
-		if (!ret)
-			dev_warn(dev, "Failed to enable irq for wake: %d\n",
-				ret);
-	}
 	return ret;
 }
 
@@ -509,15 +459,7 @@ static int rmi_spi_resume(struct device *dev)
 	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
 	int ret;
 
-	enable_irq(rmi_spi->irq);
-	if (device_may_wakeup(&spi->dev)) {
-		ret = disable_irq_wake(rmi_spi->irq);
-		if (!ret)
-			dev_warn(dev, "Failed to disable irq for wake: %d\n",
-				ret);
-	}
-
-	ret = rmi_driver_resume(rmi_spi->xport.rmi_dev);
+	ret = rmi_driver_resume(rmi_spi->xport.rmi_dev, true);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
@@ -532,12 +474,10 @@ static int rmi_spi_runtime_suspend(struct device *dev)
 	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
 	int ret;
 
-	ret = rmi_driver_suspend(rmi_spi->xport.rmi_dev);
+	ret = rmi_driver_suspend(rmi_spi->xport.rmi_dev, false);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	disable_irq(rmi_spi->irq);
-
 	return 0;
 }
 
@@ -547,9 +487,7 @@ static int rmi_spi_runtime_resume(struct device *dev)
 	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
 	int ret;
 
-	enable_irq(rmi_spi->irq);
-
-	ret = rmi_driver_resume(rmi_spi->xport.rmi_dev);
+	ret = rmi_driver_resume(rmi_spi->xport.rmi_dev, false);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index e0aca1476001..5944e6c2470d 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -204,9 +204,11 @@ struct rmi_device_platform_data_spi {
  * @reset_delay_ms - after issuing a reset command to the touch sensor, the
  * driver waits a few milliseconds to give the firmware a chance to
  * to re-initialize.  You can override the default wait period here.
+ * @irq: irq associated with the attn gpio line, or negative
  */
 struct rmi_device_platform_data {
 	int reset_delay_ms;
+	int irq;
 
 	struct rmi_device_platform_data_spi spi_data;
 
@@ -352,8 +354,7 @@ struct rmi_driver_data {
 
 int rmi_register_transport_device(struct rmi_transport_dev *xport);
 void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
-int rmi_process_interrupt_requests(struct rmi_device *rmi_dev);
 
-int rmi_driver_suspend(struct rmi_device *rmi_dev);
-int rmi_driver_resume(struct rmi_device *rmi_dev);
+int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake);
+int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake);
 #endif
-- 
2.5.0
