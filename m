From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] touchscreen: ad7879: include linux/property.h
Date: Mon, 27 Feb 2017 21:39:40 +0100
Message-ID: <20170227203954.3489470-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

I ran into this build failure during randconfig testing:

drivers/input/touchscreen/ad7879.c: In function 'ad7879_parse_dt':
drivers/input/touchscreen/ad7879.c:505:8: error: implicit declaration of function 'device_property_read_u32'
drivers/input/touchscreen/ad7879.c:512:2: error: implicit declaration of function 'device_property_read_u8'
drivers/input/touchscreen/ad7879.c:521:16: error: implicit declaration of function 'device_property_read_bool'

I could not figure out when this was introduced, as the code doesn't
appear to have changed recently, but the fix of including the header
with the declaration is obvious.

The calls that require the extra header were introduced a year ago in
commit fa6e3ca27442 ("Input: ad7879 - add device tree support").

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/ad7879.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 53ab689305ac..1bd870277e1a 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
-- 
2.9.0
