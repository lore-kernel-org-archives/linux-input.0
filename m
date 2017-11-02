From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 2/5] Input: ad7897 - use managed devm_input_allocate_device
Date: Thu,  2 Nov 2017 17:01:33 +0200
Message-ID: <20171102150136.1476-3-andi@etezian.org>
References: <20171102150136.1476-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102150136.1476-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Allocate the input device by using the devm_input_allocate_device
function and remove all the related cleanup function and adjust
the goto error handlings accordingly.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 68941b72ed8a..ec88e3e0020b 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -708,11 +708,9 @@ static int ad7877_probe(struct spi_device *spi)
 	}
 
 	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	input_dev = devm_input_allocate_device(&spi->dev);
+	if (!input_dev)
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
@@ -780,7 +777,7 @@ static int ad7877_probe(struct spi_device *spi)
 				   spi->dev.driver->name, ts);
 	if (err) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-		goto err_free_mem;
+		return err;
 	}
 
 	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
@@ -797,8 +794,7 @@ static int ad7877_probe(struct spi_device *spi)
 	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
 err_free_irq:
 	free_irq(spi->irq, ts);
-err_free_mem:
-	input_free_device(input_dev);
+
 	return err;
 }
 
@@ -811,8 +807,6 @@ static int ad7877_remove(struct spi_device *spi)
 	ad7877_disable(ts);
 	free_irq(ts->spi->irq, ts);
 
-	input_unregister_device(ts->input);
-
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
 
 	return 0;
-- 
2.15.0
