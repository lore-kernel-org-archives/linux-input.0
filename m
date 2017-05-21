From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/4] input: lm8323: move header file out of I2C realm
Date: Sun, 21 May 2017 22:40:09 +0200
Message-ID: <20170521204013.6623-2-wsa@the-dreams.de>
References: <20170521204013.6623-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521204013.6623-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/input/keyboard/lm8323.c       | 2 +-
 include/linux/{i2c => input}/lm8323.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => input}/lm8323.h (100%)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 21bea52d436579..53fc226e589048 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -31,7 +31,7 @@
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/pm.h>
-#include <linux/i2c/lm8323.h>
+#include <linux/input/lm8323.h>
 #include <linux/slab.h>
 
 /* Commands to send to the chip. */
diff --git a/include/linux/i2c/lm8323.h b/include/linux/input/lm8323.h
similarity index 100%
rename from include/linux/i2c/lm8323.h
rename to include/linux/input/lm8323.h
-- 
2.11.0
