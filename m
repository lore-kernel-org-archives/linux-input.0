From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] Input: ads7846 - use spi_get_drvdata() and
 spi_set_drvdata()
Date: Sat, 06 Apr 2013 15:46:23 +0900
Message-ID: <001d01ce3292$746da5c0$5d48f140$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:51926 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab3DFGqZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Apr 2013 02:46:25 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKT00DW4MT2J6E0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Sat, 06 Apr 2013 15:46:24 +0900 (KST)
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
 drivers/input/touchscreen/ads7846.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 434c3df..84ccf14 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1245,7 +1245,7 @@ static int ads7846_probe(struct spi_device *spi)
 		goto err_free_mem;
 	}
 
-	dev_set_drvdata(&spi->dev, ts);
+	spi_set_drvdata(spi, ts);
 
 	ts->packet = packet;
 	ts->spi = spi;
@@ -1397,7 +1397,7 @@ static int ads7846_probe(struct spi_device *spi)
 
 static int ads7846_remove(struct spi_device *spi)
 {
-	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
+	struct ads7846 *ts = spi_get_drvdata(spi);
 
 	device_init_wakeup(&spi->dev, false);
 
-- 
1.7.2.5


