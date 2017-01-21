From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/13] Input: keyboard - Drop calls to platform_set_drvdata and i2c_set_clientdata
Date: Sat, 21 Jan 2017 10:45:53 -0800
Message-ID: <1485024365-3368-2-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48619 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdAUSqf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:46:35 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org

There is no call to i2c_get_clientdata(), platform_get_drvdata(),
or dev_get_drvdata() in any of the drivers in this patch.
Drop the unnecessary calls to to i2c_set_clientdata() and
platform_set_drvdata().

This conversion was done automatically with coccinelle. The semantic patch
is available at
https://github.com/groeck/coccinelle-patches/blob/master/common/pdev.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/adc-keys.c         | 2 --
 drivers/input/keyboard/cap11xx.c          | 1 -
 drivers/input/keyboard/gpio_keys_polled.c | 1 -
 drivers/input/keyboard/jornada680_kbd.c   | 2 --
 drivers/input/keyboard/max7359_keypad.c   | 1 -
 drivers/input/keyboard/nspire-keypad.c    | 2 --
 drivers/input/keyboard/opencores-kbd.c    | 2 --
 drivers/input/keyboard/sun4i-lradc-keys.c | 1 -
 8 files changed, 12 deletions(-)

diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index f8cf2ccacefd..c255af21e71a 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -148,8 +148,6 @@ static int adc_keys_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	platform_set_drvdata(pdev, st);
-
 	poll_dev = devm_input_allocate_polled_device(dev);
 	if (!poll_dev) {
 		dev_err(dev, "failed to allocate input device\n");
diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 4401be225d64..1a1eacae3ea1 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -392,7 +392,6 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 		return error;
 
 	dev_info(dev, "CAP11XX detected, revision 0x%02x\n", rev);
-	i2c_set_clientdata(i2c_client, priv);
 	node = dev->of_node;
 
 	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index bed4f2086158..cc193e665358 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -365,7 +365,6 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	bdev->poll_dev = poll_dev;
 	bdev->dev = dev;
 	bdev->pdata = pdata;
-	platform_set_drvdata(pdev, bdev);
 
 	error = input_register_polled_device(poll_dev);
 	if (error) {
diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
index 80c81278ad2c..0116ac99f44c 100644
--- a/drivers/input/keyboard/jornada680_kbd.c
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -197,8 +197,6 @@ static int jornada680kbd_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, jornadakbd);
-
 	jornadakbd->poll_dev = poll_dev;
 
 	memcpy(jornadakbd->keymap, jornada_scancodes,
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 5091133b7b8e..cd44d22d8770 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -241,7 +241,6 @@ static int max7359_probe(struct i2c_client *client,
 	/* Initialize MAX7359 */
 	max7359_initialize(client);
 
-	i2c_set_clientdata(client, keypad);
 	device_init_wakeup(&client->dev, 1);
 
 	return 0;
diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index 7abfd34eb87e..c7f26fa3034c 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -249,8 +249,6 @@ static int nspire_keypad_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	platform_set_drvdata(pdev, keypad);
-
 	dev_dbg(&pdev->dev,
 		"TI-NSPIRE keypad at %pR (scan_interval=%uus, row_delay=%uus%s)\n",
 		res, keypad->row_delay, keypad->scan_interval,
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index f8502bb29176..98ea6190f5f5 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -112,8 +112,6 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	platform_set_drvdata(pdev, opencores_kbd);
-
 	return 0;
 }
 
diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index cc8f7ddcee53..a37c172452e6 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -261,7 +261,6 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	platform_set_drvdata(pdev, lradc);
 	return 0;
 }
 
-- 
2.7.4

