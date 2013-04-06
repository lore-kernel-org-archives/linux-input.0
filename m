From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] Input: adxl34x - use spi_get_drvdata()
Date: Sat, 06 Apr 2013 15:47:12 +0900
Message-ID: <001f01ce3292$91a72f30$b4f58d90$%han@samsung.com>
References: <001d01ce3292$746da5c0$5d48f140$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27639 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab3DFGrO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Apr 2013 02:47:14 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKT005XNMUP95D0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Sat, 06 Apr 2013 15:47:13 +0900 (KST)
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
 drivers/input/misc/adxl34x-spi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 990b49e..76dc067 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -89,7 +89,7 @@ static int adxl34x_spi_probe(struct spi_device *spi)
 
 static int adxl34x_spi_remove(struct spi_device *spi)
 {
-	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
+	struct adxl34x *ac = spi_get_drvdata(spi);
 
 	return adxl34x_remove(ac);
 }
@@ -98,7 +98,7 @@ static int adxl34x_spi_remove(struct spi_device *spi)
 static int adxl34x_spi_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
+	struct adxl34x *ac = spi_get_drvdata(spi);
 
 	adxl34x_suspend(ac);
 
@@ -108,7 +108,7 @@ static int adxl34x_spi_suspend(struct device *dev)
 static int adxl34x_spi_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
+	struct adxl34x *ac = spi_get_drvdata(spi);
 
 	adxl34x_resume(ac);
 
-- 
1.7.2.5


