From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] Input: atmel captouch depends on i2c
Date: Thu, 19 May 2016 15:52:24 +0200
Message-ID: <1463665954-3898044-2-git-send-email-arnd@arndb.de>
References: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Hung-yu Wu <hywu@google.com>
List-Id: linux-input@vger.kernel.org

The newly added Atmal captouch driver fails to build when CONFIG_I2C
is disabled:

drivers/input/misc/atmel_captouch.c: In function 'atmel_read':
drivers/input/misc/atmel_captouch.c:115:8: error: implicit declaration of function 'i2c_transfer' [-Werror=implicit-function-declaration]

This adds an explicit Kconfig dependency to prevent the broken
configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b06d43f7a3db ("Input: add Atmel Captouch Button driver")
---
 drivers/input/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9c3dfe79d4d4..27d6da0e354a 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -85,6 +85,7 @@ config INPUT_ARIZONA_HAPTICS
 config INPUT_ATMEL_CAPTOUCH
 	tristate "Atmel Capacitive Touch Button Driver"
 	depends on OF || COMPILE_TEST
+	depends on I2C
 	help
 	  Say Y here if an Atmel Capacitive Touch Button device which
 	  implements "captouch" protocol is connected to I2C bus. Typically
-- 
2.7.0
