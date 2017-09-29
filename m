From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 03/12] Input: ads7846 - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:30 +0900
Message-ID: <20170929203839.7010-4-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:33372 "EHLO
        1.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbdI2Ur3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:47:29 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 2F1FF10E010
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:39:38 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the relative sysfs_remove_group and goto label.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ads7846.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a2f45aefce08..597f4a2cca42 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1416,13 +1416,13 @@ static int ads7846_probe(struct spi_device *spi)
 	else
 		(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
 
-	err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
+	err = devm_device_add_group(&spi->dev, &ads784x_attr_group);
 	if (err)
 		goto err_remove_hwmon;
 
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr_group;
+		goto err_remove_hwmon;
 
 	device_init_wakeup(&spi->dev, pdata->wakeup);
 
@@ -1435,8 +1435,6 @@ static int ads7846_probe(struct spi_device *spi)
 
 	return 0;
 
- err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
  err_remove_hwmon:
 	ads784x_hwmon_unregister(spi, ts);
  err_free_irq:
@@ -1462,8 +1460,6 @@ static int ads7846_remove(struct spi_device *spi)
 {
 	struct ads7846 *ts = spi_get_drvdata(spi);
 
-	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
-
 	ads7846_disable(ts);
 	free_irq(ts->spi->irq, ts);
 
-- 
2.14.2

