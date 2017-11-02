From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 4/5] Input: ad7897 - use managed devm_device_add_group
Date: Thu,  2 Nov 2017 17:01:35 +0200
Message-ID: <20171102150136.1476-5-andi@etezian.org>
References: <20171102150136.1476-1-andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102150136.1476-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the relative sysfs_remove_group and goto label.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 3a4230219b23..c8a143db8681 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -780,28 +780,17 @@ static int ad7877_probe(struct spi_device *spi)
 		return err;
 	}
 
-	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
+	err = devm_device_add_group(&spi->dev, &ad7877_attr_group);
 	if (err)
 		return err;
 
-	err = input_register_device(input_dev);
-	if (err)
-		goto err_remove_attr_group;
-
-	return 0;
-
-err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-
-	return err;
+	return input_register_device(input_dev);
 }
 
 static int ad7877_remove(struct spi_device *spi)
 {
 	struct ad7877 *ts = spi_get_drvdata(spi);
 
-	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-
 	ad7877_disable(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
-- 
2.15.0
