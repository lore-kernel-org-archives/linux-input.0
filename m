From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] Input: eeti_ts: Mark as CONFIG_BROKEN
Date: Fri,  6 Apr 2012 22:40:07 -0700
Message-ID: <1333777207-4151-1-git-send-email-olof@lixom.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-input@vger.kernel.org

This seems to have been broken since 2010, so obviously noone actually
cares about the driver:

make[4]: *** [drivers/input/touchscreen/eeti_ts.o] Error 1
drivers/input/touchscreen/eeti_ts.c: In function 'eeti_ts_irq_active':
drivers/input/touchscreen/eeti_ts.c:65:2: error: implicit declaration of function 'irq_to_gpio' [-Werror=implicit-function-declaration]

irq_to_gpio isn't available on most platforms today, so the driver
will need some rework by someone who has hardware access and can test
(to make sure that, for example, switching to level interrupts and just
keep taking them while there's more to process works).

I guess it could just be scheduled for removal, but let's start with
marking it CONFIG_BROKEN.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2a21419..b8f153e 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -213,7 +213,7 @@ config TOUCHSCREEN_HAMPSHIRE
 
 config TOUCHSCREEN_EETI
 	tristate "EETI touchscreen panel support"
-	depends on I2C
+	depends on I2C && BROKEN
 	help
 	  Say Y here to enable support for I2C connected EETI touch panels.
 
-- 
1.7.9.2.359.gebfc2
