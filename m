From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] Input: ad7877 - use spi_get_drvdata() and spi_set_drvdata()
Date: Sat, 06 Apr 2013 15:46:55 +0900
Message-ID: <001e01ce3292$8768f620$963ae260$%han@samsung.com>
References: <001d01ce3292$746da5c0$5d48f140$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61272 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab3DFGq5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Apr 2013 02:46:57 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKT00DYGMU786D0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Sat, 06 Apr 2013 15:46:56 +0900 (KST)
In-reply-to: <001d01ce3292$746da5c0$5d48f140$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
can directly pass a struct spi_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/ad7877.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 23fa829b8..f3a174a 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -273,7 +273,7 @@ static int ad7877_write(struct spi_device *spi, u16 reg, u16 val)
 
 static int ad7877_read_adc(struct spi_device *spi, unsigned command)
 {
-	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
+	struct ad7877 *ts = spi_get_drvdata(spi);
 	struct ser_req *req;
 	int status;
 	int sample;
@@ -720,7 +720,7 @@ static int ad7877_probe(struct spi_device *spi)
 		goto err_free_mem;
 	}
 
-	dev_set_drvdata(&spi->dev, ts);
+	spi_set_drvdata(spi, ts);
 	ts->spi = spi;
 	ts->input = input_dev;
 
@@ -806,13 +806,13 @@ err_free_irq:
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(ts);
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 	return err;
 }
 
 static int ad7877_remove(struct spi_device *spi)
 {
-	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
+	struct ad7877 *ts = spi_get_drvdata(spi);
 
 	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
 
@@ -823,7 +823,7 @@ static int ad7877_remove(struct spi_device *spi)
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 
 	return 0;
 }
-- 
1.7.2.5


