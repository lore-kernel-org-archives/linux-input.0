From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 1/5] Input: ad7897 - use managed devm_kzalloc
Date: Thu,  2 Nov 2017 17:01:32 +0200
Message-ID: <20171102150136.1476-2-andi@etezian.org>
References: <20171102150136.1476-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102150136.1476-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Allocate the driver's structure by using devm_kzalloc instead of
simple kzalloc and remove all the related kfree calls.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 0381c7809d1b..68941b72ed8a 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -707,9 +707,9 @@ static int ad7877_probe(struct spi_device *spi)
 		return err;
 	}
 
-	ts = kzalloc(sizeof(struct ad7877), GFP_KERNEL);
+	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
 	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
+	if (!input_dev) {
 		err = -ENOMEM;
 		goto err_free_mem;
 	}
@@ -799,7 +799,6 @@ static int ad7877_probe(struct spi_device *spi)
 	free_irq(spi->irq, ts);
 err_free_mem:
 	input_free_device(input_dev);
-	kfree(ts);
 	return err;
 }
 
@@ -813,7 +812,6 @@ static int ad7877_remove(struct spi_device *spi)
 	free_irq(ts->spi->irq, ts);
 
 	input_unregister_device(ts->input);
-	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
 
-- 
2.15.0
