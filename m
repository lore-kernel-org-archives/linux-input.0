From: Andi Shyti <andi@etezian.org>
Subject: [PATCH v3 1/3] Input: ad7897 - use managed allocated resources
Date: Wed,  8 Nov 2017 17:50:18 +0200
Message-ID: <20171108155020.3851-2-andi@etezian.org>
References: <20171108155020.3851-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108155020.3851-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Use managed allocated resources to simplify error handling during
probing failure and module exiting.

With this all the goto labels in the probe function together with
the cleanups in the remove function are unnecessary, therefore
removed.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 42 +++++++++-----------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 0381c7809d1b..dd59e4a5eb7d 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -707,12 +707,10 @@ static int ad7877_probe(struct spi_device *spi)
 		return err;
 	}
 
-	ts = kzalloc(sizeof(struct ad7877), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&spi->dev);
+	if (!ts || !input_dev)
+		return -ENOMEM;
 
 	spi_set_drvdata(spi, ts);
 	ts->spi = spi;
@@ -764,8 +762,7 @@ static int ad7877_probe(struct spi_device *spi)
 	if (verify != AD7877_MM_SEQUENCE){
 		dev_err(&spi->dev, "%s: Failed to probe %s\n",
 			dev_name(&spi->dev), input_dev->name);
-		err = -ENODEV;
-		goto err_free_mem;
+		return -ENODEV;
 	}
 
 	if (gpio3)
@@ -775,45 +772,26 @@ static int ad7877_probe(struct spi_device *spi)
 
 	/* Request AD7877 /DAV GPIO interrupt */
 
-	err = request_threaded_irq(spi->irq, NULL, ad7877_irq,
+	err = devm_request_threaded_irq(&spi->dev, spi->irq, NULL, ad7877_irq,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   spi->dev.driver->name, ts);
 	if (err) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-		goto err_free_mem;
+		return err;
 	}
 
-	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
-	if (err)
-		goto err_free_irq;
-
-	err = input_register_device(input_dev);
+	err = devm_device_add_group(&spi->dev, &ad7877_attr_group);
 	if (err)
-		goto err_remove_attr_group;
-
-	return 0;
+		return err;
 
-err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-err_free_irq:
-	free_irq(spi->irq, ts);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(ts);
-	return err;
+	return input_register_device(input_dev);
 }
 
 static int ad7877_remove(struct spi_device *spi)
 {
 	struct ad7877 *ts = spi_get_drvdata(spi);
 
-	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-
 	ad7877_disable(ts);
-	free_irq(ts->spi->irq, ts);
-
-	input_unregister_device(ts->input);
-	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
 
-- 
2.15.0
