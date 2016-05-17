From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] Input: migor-ts - allow driver to build if COMPILE_TEST is enabled
Date: Tue, 17 May 2016 12:32:37 -0400
Message-ID: <1463502759-14393-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

The driver only has runtime but no build time dependency with SH_MIGOR, so
it can be built for testing purposes if the COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that drivers are
not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 8ecdc38fd489..9f6f001ccf07 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -632,7 +632,7 @@ config TOUCHSCREEN_EDT_FT5X06
 
 config TOUCHSCREEN_MIGOR
 	tristate "Renesas MIGO-R touchscreen"
-	depends on SH_MIGOR && I2C
+	depends on (SH_MIGOR || COMPILE_TEST) && I2C
 	help
 	  Say Y here to enable MIGO-R touchscreen support.
 
-- 
2.5.5
