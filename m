From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/4] input: mms114: move header file out of I2C realm
Date: Sun, 21 May 2017 22:40:11 +0200
Message-ID: <20170521204013.6623-4-wsa@the-dreams.de>
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
 drivers/input/touchscreen/mms114.c    | 2 +-
 include/linux/{i2c => input}/mms114.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => input}/mms114.h (100%)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 1fafc9f57af6c7..0a0425e9c29c3d 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/i2c.h>
-#include <linux/i2c/mms114.h>
+#include <linux/input/mms114.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
diff --git a/include/linux/i2c/mms114.h b/include/linux/input/mms114.h
similarity index 100%
rename from include/linux/i2c/mms114.h
rename to include/linux/input/mms114.h
-- 
2.11.0
