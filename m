From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] Input: ad714x - add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Mon, 25 Mar 2013 19:02:53 +0900
Message-ID: <003b01ce293f$ea9a9200$bfcfb600$%han@samsung.com>
References: <003a01ce293f$c70c3eb0$5524bc10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15798 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab3CYKC7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Mar 2013 06:02:59 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK700EPDNWTH140@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Mon, 25 Mar 2013 19:02:53 +0900 (KST)
In-reply-to: <003a01ce293f$c70c3eb0$5524bc10$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/input/misc/ad714x-i2c.c:17:12: warning: 'ad714x_i2c_suspend' defined but not used [-Wunused-function]
drivers/input/misc/ad714x-i2c.c:22:12: warning: 'ad714x_i2c_resume' defined but not used [-Wunused-function]
drivers/input/misc/ad714x-spi.c:20:12: warning: 'ad714x_spi_suspend' defined but not used [-Wunused-function]
drivers/input/misc/ad714x-spi.c:25:12: warning: 'ad714x_spi_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/ad714x-i2c.c |    2 +-
 drivers/input/misc/ad714x-spi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 29d2064..e0f5225 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -13,7 +13,7 @@
 #include <linux/pm.h>
 #include "ad714x.h"
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ad714x_i2c_suspend(struct device *dev)
 {
 	return ad714x_disable(i2c_get_clientdata(to_i2c_client(dev)));
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index bdccca4..6189148 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -16,7 +16,7 @@
 #define AD714x_SPI_CMD_PREFIX      0xE000   /* bits 15:11 */
 #define AD714x_SPI_READ            BIT(10)
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ad714x_spi_suspend(struct device *dev)
 {
 	return ad714x_disable(spi_get_drvdata(to_spi_device(dev)));
-- 
1.7.2.5


