From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Input: st1232 - include gpio/consumer.h header for gpiod_set_value_cansleep()
Date: Wed, 13 Feb 2019 12:19:58 +0100
Message-ID: <20190213111958.9031-1-martink@posteo.de>
References: <201902131841.xHSZ8Cvm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201902131841.xHSZ8Cvm%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, kuninori.morimoto.gx@renesas.com, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

gpiod_set_value_cansleep() needs it's declaration in the corresponding
header. This fixes build errors like

   drivers/input/touchscreen/st1232.c: In function 'st1232_ts_power':
>> drivers/input/touchscreen/st1232.c:146:3: error: implicit declaration of
   function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'?
   [-Werror=implicit-function-declaration]
      gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
      ^~~~~~~~~~~~~~~~~~~~~~~~
      gpio_set_value_cansleep

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

 drivers/input/touchscreen/st1232.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 1fbc0847416b..f4b7a4f1c366 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-- 
2.20.1
