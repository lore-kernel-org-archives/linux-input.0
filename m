From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: sis-i2c: select CONFIG_CRC_ITU_T
Date: Thu,  4 Aug 2016 15:07:06 +0200
Message-ID: <20160804130758.1253722-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62034 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbcHDNKO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2016 09:10:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Tammy Tseng <tammy_tseng@sis.com>, Yuger Yu <yuger_yu@sis.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The newly added sis_i2c driver fails to link without the CRC_ITU_T
driver enabled:

drivers/input/touchscreen/sis_i2c.o: In function `sis_ts_irq_handler':
sis_i2c.c:(.text+0xc0): undefined reference to `crc_itu_t'

This adds a Kconfig select statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a485cb037fe6 ("Input: add driver for SiS 9200 family I2C touchscreen controllers")
---
 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 8d893cefb0e3..2fb1f430a431 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1074,6 +1074,7 @@ config TOUCHSCREEN_SILEAD
 config TOUCHSCREEN_SIS_I2C
 	tristate "SiS 9200 family I2C touchscreen"
 	depends on I2C
+	select CRC_ITU_T
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  This enables support for SiS 9200 family over I2C based touchscreens.
-- 
2.9.0

