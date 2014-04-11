From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH] Input: ads7846: Fix device usage within attribute show
Date: Fri, 11 Apr 2014 22:03:33 +0200
Message-ID: <1397246613-26538-1-git-send-email-alexanders83@web.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:62153 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985AbaDKUDt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2014 16:03:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Stein <alexanders83@web.de>, linux-input@vger.kernel.org

With commit e585c40ba (Input: ads7846 - convert to
hwmon_device_register_with_groups()) the device passed to the attribute's
show function isn't the spi device as before.
So fixup the passed device to ads7846_read12_ser.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 180ff7a..3824369 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -425,7 +425,7 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
 name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct ads7846 *ts = dev_get_drvdata(dev); \
-	ssize_t v = ads7846_read12_ser(dev, \
+	ssize_t v = ads7846_read12_ser(&ts->spi->dev, \
 			READ_12BIT_SER(var)); \
 	if (v < 0) \
 		return v; \
-- 
1.9.2

