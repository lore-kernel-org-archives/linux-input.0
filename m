From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/13] Input: keyboard - drop unnecessary calls to device_init_wakeup
Date: Sat, 21 Jan 2017 10:46:01 -0800
Message-ID: <1485024365-3368-10-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-input@vger.kernel.org

Calling device_init_wakeup in the remove function is unnecessary since the
device is going away, and thus won't be able to cause any wakeups under any
circumstances. Besides, the driver cleanup code already handles the
necessary cleanup.

Similar, disabling wakeup in the probe error path is unnecessary, as is
disabling wakeup in the probe function in the first place.

Changes were done automatically using the following coccinelle script.

@probe@
identifier p, probefn;
declarer name module_platform_driver_probe;
position pos;
@@
(
  module_platform_driver_probe(p, probefn@pos);
|
  struct platform_driver p = {
    .probe = probefn@pos,
  };
|
  struct i2c_driver p = {
    .probe = probefn@pos,
  };
|
  struct spi_driver p = {
    .probe = probefn@pos,
  };
)

@remove@
identifier p, removefn;
@@

  struct
(
  platform_driver
|
  i2c_driver
|
  spi_driver
|
  hv_driver
)
  p = {
    .remove = \(__exit_p(removefn)\|removefn\),
  };

@depends on remove@
identifier remove.removefn;
@@

removefn(...) {
<+...
- device_init_wakeup(...);
...+>
}

@depends on probe@
identifier probe.probefn;
expression dev;
@@

probefn(...) {
<+...
- device_init_wakeup(..., \(false\|0\));
  ...+>
}

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/gpio_keys.c      | 2 --
 drivers/input/keyboard/matrix_keypad.c  | 2 --
 drivers/input/keyboard/omap4-keypad.c   | 3 ---
 drivers/input/keyboard/samsung-keypad.c | 2 --
 drivers/input/keyboard/spear-keyboard.c | 2 --
 5 files changed, 11 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 0da10ab34368..e5bc04e90601 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -829,8 +829,6 @@ static int gpio_keys_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
 
-	device_init_wakeup(&pdev->dev, 0);
-
 	return 0;
 }
 
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 7f12b6579f82..18839cd5f76e 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -545,8 +545,6 @@ static int matrix_keypad_remove(struct platform_device *pdev)
 {
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 
-	device_init_wakeup(&pdev->dev, 0);
-
 	matrix_keypad_free_gpio(keypad);
 	input_unregister_device(keypad->input_dev);
 	kfree(keypad);
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 6639b2b8528a..9ecb16701b13 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -375,7 +375,6 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
 	free_irq(keypad_data->irq, keypad_data);
 err_free_keymap:
 	kfree(keypad_data->keymap);
@@ -401,8 +400,6 @@ static int omap4_keypad_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	device_init_wakeup(&pdev->dev, false);
-
 	input_unregister_device(keypad_data->input);
 
 	iounmap(keypad_data->base);
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 4e319eb9e19d..316414465c77 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -445,7 +445,6 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
-	device_init_wakeup(&pdev->dev, 0);
 err_unprepare_clk:
 	clk_unprepare(keypad->clk);
 	return error;
@@ -456,7 +455,6 @@ static int samsung_keypad_remove(struct platform_device *pdev)
 	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	device_init_wakeup(&pdev->dev, 0);
 
 	input_unregister_device(keypad->input_dev);
 
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 8083eaa0524a..7d25fa338ab4 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -283,8 +283,6 @@ static int spear_kbd_remove(struct platform_device *pdev)
 	input_unregister_device(kbd->input);
 	clk_unprepare(kbd->clk);
 
-	device_init_wakeup(&pdev->dev, 0);
-
 	return 0;
 }
 
-- 
2.7.4
