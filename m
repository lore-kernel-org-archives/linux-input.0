From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] input: of_touchscreen: add MODULE_LICENSE
Date: Wed, 10 Jan 2018 17:31:26 +0100
Message-ID: <20180110163137.543730-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The lack of the MODULE_LICENSE tag can lead to a warning here:

WARNING: modpost: missing MODULE_LICENSE() in drivers/input/touchscreen/of_touchscreen.o

I'm adding a license and description tag, but no MODULE_AUTHOR()
as this file is a collection of standalone helper functions that
were all added by different developers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/of_touchscreen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index 8d7f9c8f2771..9642f103b726 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -13,6 +13,7 @@
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
+#include <linux/module.h>
 
 static bool touchscreen_get_prop_u32(struct device *dev,
 				     const char *property,
@@ -185,3 +186,6 @@ void touchscreen_report_pos(struct input_dev *input,
 	input_report_abs(input, multitouch ? ABS_MT_POSITION_Y : ABS_Y, y);
 }
 EXPORT_SYMBOL(touchscreen_report_pos);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Device-tree helpers functions for touchscreen devices");
-- 
2.9.0
