From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] input: ixp4xx-beeper: include linux/io.h
Date: Wed,  2 Oct 2019 11:57:21 +0200
Message-ID: <20191002095736.1297224-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

asm/io.h may not be included implicitly, causing a rare
randconfig build error:

drivers/input/misc/ixp4xx-beeper.c:48:3: error: implicit declaration of function '__raw_writel' [-Werror,-Wimplicit-function-declaration]
                __raw_writel((count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE,

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/ixp4xx-beeper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 764cf21c0aaf..456325f0ea59 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("ixp4xx beeper driver");
-- 
2.20.0
