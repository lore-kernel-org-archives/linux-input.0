From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/4] input: mcs: move header file out of I2C realm
Date: Sun, 21 May 2017 22:40:10 +0200
Message-ID: <20170521204013.6623-3-wsa@the-dreams.de>
References: <20170521204013.6623-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170521204013.6623-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/input/keyboard/mcs_touchkey.c  | 2 +-
 drivers/input/touchscreen/mcs5000_ts.c | 2 +-
 include/linux/{i2c => input}/mcs.h     | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => input}/mcs.h (100%)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 31090d71a685d1..7781ca28c54190 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -13,7 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/i2c/mcs.h>
+#include <linux/input/mcs.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/irq.h>
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 90fc07dc98a6bb..53f45ea161192b 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -15,7 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/i2c/mcs.h>
+#include <linux/input/mcs.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/irq.h>
diff --git a/include/linux/i2c/mcs.h b/include/linux/input/mcs.h
similarity index 100%
rename from include/linux/i2c/mcs.h
rename to include/linux/input/mcs.h
-- 
2.11.0
