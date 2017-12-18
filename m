From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] input/touchscreen: fix hideep.c build errors
Date: Sun, 17 Dec 2017 17:09:52 -0800
Message-ID: <3cafbae1-1377-3e4f-173e-76ca2a3a1e17@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757194AbdLRBKC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Dec 2017 20:10:02 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>, Anthony Kim <anthony.kim@hideep.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors due to missing header file.

Fixes these build errors:
drivers/input//touchscreen/hideep.c: In function 'hideep_power_on':
drivers/input//touchscreen/hideep.c:670:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
    gpiod_set_value_cansleep(ts->reset_gpio, 0);
drivers/input//touchscreen/hideep.c: In function 'hideep_power_off':
drivers/input//touchscreen/hideep.c:688:3: error: implicit declaration of function 'gpiod_set_value'; did you mean 'gpio_set_value'? [-Werror=implicit-function-declaration]
    gpiod_set_value(ts->reset_gpio, 1);
drivers/input//touchscreen/hideep.c: In function 'hideep_probe':
drivers/input//touchscreen/hideep.c:1039:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
   ts->reset_gpio = devm_gpiod_get_optional(&client->dev,
drivers/input//touchscreen/hideep.c:1040:17: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
         "reset", GPIOD_OUT_HIGH);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Anthony Kim <anthony.kim@hideep.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/hideep.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-415-rc3.orig/drivers/input/touchscreen/hideep.c
+++ lnx-415-rc3/drivers/input/touchscreen/hideep.c
@@ -11,6 +11,7 @@
 #include <linux/firmware.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>


