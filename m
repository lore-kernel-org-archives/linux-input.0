From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: msm-vibrator: use correct gpio header
Date: Mon,  4 Mar 2019 20:56:59 +0100
Message-ID: <20190304195734.1070109-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Masney <masneyb@onstation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When CONFIG_GPIOLIB is not set, we get a couple of build
errors during test building:

drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_start':
drivers/input/misc/msm-vibrator.c:79:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
   gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
   ^~~~~~~~~~~~~~~~~~~~~~~~
   gpio_set_value_cansleep
drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_probe':
drivers/input/misc/msm-vibrator.c:176:26: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
  vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
                          ^~~~~~~~~~~~~~
                          devm_gpio_free
drivers/input/misc/msm-vibrator.c:177:13: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
             GPIOD_OUT_LOW);
             ^~~~~~~~~~~~~
             GPIOF_INIT_LOW
drivers/input/misc/msm-vibrator.c:177:13: note: each undeclared identifier is reported only once for each function it appears in

This is easy to avoid when we use gpio/consumer.h as the documented interface.

Fixes: 0f681d09e66e ("Input: add new vibrator driver for various MSM SOCs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/msm-vibrator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/msm-vibrator.c b/drivers/input/misc/msm-vibrator.c
index 69f2579c4ec2..b60f1aaee705 100644
--- a/drivers/input/misc/msm-vibrator.c
+++ b/drivers/input/misc/msm-vibrator.c
@@ -13,7 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.20.0
