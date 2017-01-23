From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/5] Input: keyboard - drop unnecessary calls to input_set_drvdata
Date: Sun, 22 Jan 2017 16:48:20 -0800
Message-ID: <1485132505-14562-2-git-send-email-linux@roeck-us.net>
References: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

If there is no call to dev_get_drvdata() or input_get_drvdata(),
the call to input_set_drvdata() is unnecessary and can be dropped.

The conversion was done automatically using the following coccinelle
script.

@used@
@@

(
input_get_drvdata(...)
|
dev_get_drvdata(...)
)

@depends on !used@
@@

- input_set_drvdata(...);

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/adp5520-keys.c   | 2 --
 drivers/input/keyboard/bf54x-keys.c     | 2 --
 drivers/input/keyboard/maple_keyb.c     | 1 -
 drivers/input/keyboard/opencores-kbd.c  | 2 --
 drivers/input/keyboard/tca8418_keypad.c | 2 --
 drivers/input/keyboard/tm2-touchkey.c   | 2 --
 6 files changed, 11 deletions(-)

diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index db1004dad108..f0b9b37bde58 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -107,8 +107,6 @@ static int adp5520_keys_probe(struct platform_device *pdev)
 	input->phys = "adp5520-keys/input0";
 	input->dev.parent = &pdev->dev;
 
-	input_set_drvdata(input, dev);
-
 	input->id.bustype = BUS_I2C;
 	input->id.vendor = 0x0001;
 	input->id.product = 0x5520;
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 81b07dddae86..39bcbc38997f 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -268,8 +268,6 @@ static int bfin_kpad_probe(struct platform_device *pdev)
 	input->phys = "bf54x-keys/input0";
 	input->dev.parent = &pdev->dev;
 
-	input_set_drvdata(input, bf54x_kpad);
-
 	input->id.bustype = BUS_HOST;
 	input->id.vendor = 0x0001;
 	input->id.product = 0x0001;
diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 5aa2361aef95..78e3567ec18c 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -196,7 +196,6 @@ static int probe_maple_kbd(struct device *dev)
 	__clear_bit(KEY_RESERVED, idev->keybit);
 
 	input_set_capability(idev, EV_MSC, MSC_SCAN);
-	input_set_drvdata(idev, kbd);
 
 	error = input_register_device(idev);
 	if (error)
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index 98ea6190f5f5..d62b4068c077 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -75,8 +75,6 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 	input->name = pdev->name;
 	input->phys = "opencores-kbd/input0";
 
-	input_set_drvdata(input, opencores_kbd);
-
 	input->id.bustype = BUS_HOST;
 	input->id.vendor = 0x0001;
 	input->id.product = 0x0001;
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 11d5c76d9fb4..9f6308fac0b4 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -358,8 +358,6 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		__set_bit(EV_REP, input->evbit);
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 
-	input_set_drvdata(input, keypad_data);
-
 	irq = client->irq;
 	if (irq_is_gpio)
 		irq = gpio_to_irq(irq);
diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 916e2f3a9bbb..485900f953e0 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -193,8 +193,6 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	input_set_capability(touchkey->input_dev, EV_KEY, KEY_PHONE);
 	input_set_capability(touchkey->input_dev, EV_KEY, KEY_BACK);
 
-	input_set_drvdata(touchkey->input_dev, touchkey);
-
 	error = input_register_device(touchkey->input_dev);
 	if (error) {
 		dev_err(&client->dev,
-- 
2.7.4
