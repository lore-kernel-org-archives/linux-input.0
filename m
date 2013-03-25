From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] Input: adxl34x - add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Mon, 25 Mar 2013 19:01:53 +0900
Message-ID: <003a01ce293f$c70c3eb0$5524bc10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62328 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab3CYKBz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Mar 2013 06:01:55 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK700HFUNUMRR21@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 25 Mar 2013 19:01:54 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/input/misc/adxl34x-spi.c:98:12: warning: 'adxl34x_spi_suspend' defined but not used [-Wunused-function]
drivers/input/misc/adxl34x-spi.c:108:12: warning: 'adxl34x_spi_resume' defined but not used [-Wunused-function]
drivers/input/misc/adxl34x-i2c.c:109:12: warning: 'adxl34x_i2c_suspend' defined but not used [-Wunused-function]
drivers/input/misc/adxl34x-i2c.c:119:12: warning: 'adxl34x_i2c_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/adxl34x-i2c.c |    2 +-
 drivers/input/misc/adxl34x-spi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 535dda4..416f47d 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -105,7 +105,7 @@ static int adxl34x_i2c_remove(struct i2c_client *client)
 	return adxl34x_remove(ac);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int adxl34x_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index ad5f40d..990b49e 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -94,7 +94,7 @@ static int adxl34x_spi_remove(struct spi_device *spi)
 	return adxl34x_remove(ac);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int adxl34x_spi_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
-- 
1.7.2.5


