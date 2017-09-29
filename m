From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 01/12] Input: ad7897 - use managed devm_device_add_group
Date: Sat, 30 Sep 2017 05:38:28 +0900
Message-ID: <20170929203839.7010-2-andi@etezian.org>
References: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:36152 "EHLO
        1.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdI2Urb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:47:31 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 66B35112902
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:39:14 +0200 (CEST)
In-Reply-To: <20170929203839.7010-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Michael Hennerich <michael.hennerich@analog.com>

Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
and friends") has added the the managed version for creating
sysfs group files.

Use devm_device_add_group instead of sysfs_create_group and
remove the relative sysfs_remove_group and goto label.

CC: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ad7877.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 9c250ae780d9..677ba38b4d1c 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -783,18 +783,16 @@ static int ad7877_probe(struct spi_device *spi)
 		goto err_free_mem;
 	}
 
-	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
+	err = devm_device_add_group(&spi->dev, &ad7877_attr_group);
 	if (err)
 		goto err_free_irq;
 
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr_group;
+		goto err_free_irq;
 
 	return 0;
 
-err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
 err_free_irq:
 	free_irq(spi->irq, ts);
 err_free_mem:
@@ -807,8 +805,6 @@ static int ad7877_remove(struct spi_device *spi)
 {
 	struct ad7877 *ts = spi_get_drvdata(spi);
 
-	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
-
 	ad7877_disable(ts);
 	free_irq(ts->spi->irq, ts);
 
-- 
2.14.2

