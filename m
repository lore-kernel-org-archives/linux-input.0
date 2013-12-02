From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: ads7846 - Use IS_ENABLED() macro
Date: Mon,  2 Dec 2013 00:34:11 -0200
Message-ID: <1385951651-19605-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:49922 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3LBCeh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Dec 2013 21:34:37 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so10335193qee.38
        for <linux-input@vger.kernel.org>; Sun, 01 Dec 2013 18:34:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the IS_ENABLED() macro can make the code shorter and simpler

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/ads7846.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index ea19536..5695786 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -101,7 +101,7 @@ struct ads7846 {
 	struct spi_device	*spi;
 	struct regulator	*reg;
 
-#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
+#if IS_ENABLED(CONFIG_HWMON)
 	struct attribute_group	*attr_group;
 	struct device		*hwmon;
 #endif
@@ -421,7 +421,7 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
 	return status;
 }
 
-#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
+#if IS_ENABLED(CONFIG_HWMON)
 
 #define SHOW(name, var, adjust) static ssize_t \
 name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
-- 
1.8.1.2

