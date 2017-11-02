From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 3/5] Input: ad7897 - use managed devm_request_threaded_irq
Date: Thu,  2 Nov 2017 17:01:34 +0200
Message-ID: <20171102150136.1476-4-andi@etezian.org>
References: <20171102150136.1476-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102150136.1476-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Request the interrupt by using its related managed
devm_request_threaded_irq function, remove the cleanup function
calls and adjust the goto error handlings accordingly.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index ec88e3e0020b..3a4230219b23 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -772,7 +772,7 @@ static int ad7877_probe(struct spi_device *spi)
 
 	/* Request AD7877 /DAV GPIO interrupt */
 
-	err = request_threaded_irq(spi->irq, NULL, ad7877_irq,
+	err = devm_request_threaded_irq(&spi->dev, spi->irq, NULL, ad7877_irq,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   spi->dev.driver->name, ts);
 	if (err) {
@@ -782,7 +782,7 @@ static int ad7877_probe(struct spi_device *spi)
 
 	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
 	if (err)
-		goto err_free_irq;
+		return err;
 
 	err = input_register_device(input_dev);
 	if (err)
@@ -792,8 +792,6 @@ static int ad7877_probe(struct spi_device *spi)
 
 err_remove_attr_group:
 	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-err_free_irq:
-	free_irq(spi->irq, ts);
 
 	return err;
 }
@@ -805,7 +803,6 @@ static int ad7877_remove(struct spi_device *spi)
 	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
 
 	ad7877_disable(ts);
-	free_irq(ts->spi->irq, ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
 
-- 
2.15.0
