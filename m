From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] Input: use dev_get_platdata()
Date: Tue, 03 Dec 2013 15:40:23 +0900
Message-ID: <000e01ceeff2$8b6f62e0$a24e28a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14211 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab3LCGk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Dec 2013 01:40:28 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MX700KK6X7CW3A0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Tue, 03 Dec 2013 15:40:24 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Fugang Duan' <B38611@freescale.com>, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Wan ZongShun' <mcuos.com@gmail.com>, 'Josh Wu' <josh.wu@atmel.com>, 'Ferruh Yigit' <fery@cypress.com>

Use the wrapper function for retrieving the platform data instead
of accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Fugang Duan <B38611@freescale.com>
---
 drivers/input/keyboard/adp5520-keys.c       |    2 +-
 drivers/input/keyboard/adp5588-keys.c       |   10 ++++++----
 drivers/input/keyboard/adp5589-keys.c       |    8 ++++----
 drivers/input/keyboard/bf54x-keys.c         |    4 ++--
 drivers/input/keyboard/davinci_keyscan.c    |    2 +-
 drivers/input/keyboard/ep93xx_keypad.c      |    2 +-
 drivers/input/keyboard/imx_keypad.c         |    3 ++-
 drivers/input/keyboard/lm8323.c             |    2 +-
 drivers/input/keyboard/lm8333.c             |    3 ++-
 drivers/input/keyboard/max7359_keypad.c     |    3 ++-
 drivers/input/keyboard/mcs_touchkey.c       |    2 +-
 drivers/input/keyboard/mpr121_touchkey.c    |    3 ++-
 drivers/input/keyboard/nomadik-ske-keypad.c |    3 ++-
 drivers/input/keyboard/omap-keypad.c        |    2 +-
 drivers/input/keyboard/pxa930_rotary.c      |    3 ++-
 drivers/input/keyboard/samsung-keypad.c     |    2 +-
 drivers/input/keyboard/sh_keysc.c           |    4 ++--
 drivers/input/keyboard/tca6416-keypad.c     |    2 +-
 drivers/input/keyboard/tnetv107x-keypad.c   |    2 +-
 drivers/input/keyboard/twl4030_keypad.c     |    2 +-
 drivers/input/keyboard/w90p910_keypad.c     |    2 +-
 drivers/input/leds.c                        |    2 +-
 drivers/input/misc/ad714x.c                 |    4 ++--
 drivers/input/misc/adxl34x.c                |    2 +-
 drivers/input/misc/bfin_rotary.c            |    2 +-
 drivers/input/misc/bma150.c                 |    3 ++-
 drivers/input/misc/cma3000_d0x.c            |    2 +-
 drivers/input/misc/gp2ap002a00f.c           |    2 +-
 drivers/input/misc/gpio_tilt_polled.c       |    3 ++-
 drivers/input/misc/kxtj9.c                  |    3 ++-
 drivers/input/misc/pwm-beeper.c             |    2 +-
 drivers/input/misc/twl4030-vibra.c          |    2 +-
 drivers/input/mouse/gpio_mouse.c            |    2 +-
 drivers/input/mouse/pxa930_trkball.c        |    2 +-
 drivers/input/touchscreen/88pm860x-ts.c     |    2 +-
 drivers/input/touchscreen/ad7877.c          |    2 +-
 drivers/input/touchscreen/ad7879.c          |    4 ++--
 drivers/input/touchscreen/atmel_mxt_ts.c    |    2 +-
 drivers/input/touchscreen/atmel_tsadcc.c    |    2 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c   |    2 +-
 drivers/input/touchscreen/cyttsp_core.c     |    4 ++--
 drivers/input/touchscreen/da9034-ts.c       |    2 +-
 drivers/input/touchscreen/edt-ft5x06.c      |    2 +-
 drivers/input/touchscreen/eeti_ts.c         |    2 +-
 drivers/input/touchscreen/ili210x.c         |    2 +-
 drivers/input/touchscreen/mcs5000_ts.c      |    4 ++--
 drivers/input/touchscreen/pixcir_i2c_ts.c   |    3 ++-
 drivers/input/touchscreen/s3c2410_ts.c      |    4 ++--
 drivers/input/touchscreen/st1232.c          |    2 +-
 drivers/input/touchscreen/tsc2005.c         |    2 +-
 drivers/input/touchscreen/ucb1400_ts.c      |    8 ++++----
 drivers/input/touchscreen/wm97xx-core.c     |    2 +-
 52 files changed, 80 insertions(+), 68 deletions(-)

diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index ef26b17..0dc1151 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -71,7 +71,7 @@ static int adp5520_keys_notifier(struct notifier_block *nb,
 
 static int adp5520_keys_probe(struct platform_device *pdev)
 {
-	struct adp5520_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct adp5520_keys_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct input_dev *input;
 	struct adp5520_keys *dev;
 	int ret, i;
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 3ed2351..a8f5f92 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -173,7 +173,7 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int i, error;
 
@@ -227,7 +227,7 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 static void adp5588_gpio_remove(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int error;
 
@@ -321,7 +321,8 @@ static irqreturn_t adp5588_irq(int irq, void *handle)
 
 static int adp5588_setup(struct i2c_client *client)
 {
-	const struct adp5588_kpad_platform_data *pdata = client->dev.platform_data;
+	const struct adp5588_kpad_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int i, ret;
 	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
@@ -424,7 +425,8 @@ static int adp5588_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct adp5588_kpad *kpad;
-	const struct adp5588_kpad_platform_data *pdata = client->dev.platform_data;
+	const struct adp5588_kpad_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	struct input_dev *input;
 	unsigned int revid;
 	int ret, i;
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 60dafd4..ff7725a 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -499,7 +499,7 @@ static int adp5589_build_gpiomap(struct adp5589_kpad *kpad,
 static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5589_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5589_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5589_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int i, error;
 
@@ -553,7 +553,7 @@ static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 static void adp5589_gpio_remove(struct adp5589_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5589_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5589_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5589_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int error;
 
@@ -658,7 +658,7 @@ static int adp5589_setup(struct adp5589_kpad *kpad)
 {
 	struct i2c_client *client = kpad->client;
 	const struct adp5589_kpad_platform_data *pdata =
-		client->dev.platform_data;
+		dev_get_platdata(&client->dev);
 	u8 (*reg) (u8) = kpad->var->reg;
 	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
 	unsigned char pull_mask = 0;
@@ -864,7 +864,7 @@ static int adp5589_probe(struct i2c_client *client,
 {
 	struct adp5589_kpad *kpad;
 	const struct adp5589_kpad_platform_data *pdata =
-		client->dev.platform_data;
+		dev_get_platdata(&client->dev);
 	struct input_dev *input;
 	unsigned int revid;
 	int ret, i;
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 09b91d0..16223f4 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -180,7 +180,7 @@ static irqreturn_t bfin_kpad_isr(int irq, void *dev_id)
 static int bfin_kpad_probe(struct platform_device *pdev)
 {
 	struct bf54x_kpad *bf54x_kpad;
-	struct bfin_kpad_platform_data *pdata = pdev->dev.platform_data;
+	struct bfin_kpad_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct input_dev *input;
 	int i, error;
 
@@ -333,7 +333,7 @@ out:
 
 static int bfin_kpad_remove(struct platform_device *pdev)
 {
-	struct bfin_kpad_platform_data *pdata = pdev->dev.platform_data;
+	struct bfin_kpad_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
 
 	del_timer_sync(&bf54x_kpad->timer);
diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index d15977a..1559dc1 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -172,7 +172,7 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 	struct input_dev *key_dev;
 	struct resource *res, *mem;
 	struct device *dev = &pdev->dev;
-	struct davinci_ks_platform_data *pdata = pdev->dev.platform_data;
+	struct davinci_ks_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int error, i;
 
 	if (pdata->device_enable) {
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 47206bd..e598762 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -244,7 +244,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (!keypad)
 		return -ENOMEM;
 
-	keypad->pdata = pdev->dev.platform_data;
+	keypad->pdata = dev_get_platdata(&pdev->dev);
 	if (!keypad->pdata) {
 		err = -EINVAL;
 		goto failed_free;
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 328cfc1..34bb358 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -425,7 +425,8 @@ MODULE_DEVICE_TABLE(of, imx_keypad_of_match);
 
 static int imx_keypad_probe(struct platform_device *pdev)
 {
-	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
+	const struct matrix_keymap_data *keymap_data =
+			dev_get_platdata(&pdev->dev);
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 0de23f4..0b42118 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -627,7 +627,7 @@ static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 static int lm8323_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	struct lm8323_platform_data *pdata = client->dev.platform_data;
+	struct lm8323_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct input_dev *idev;
 	struct lm8323_chip *lm;
 	int pwm;
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 5a8ca35..9081cbe 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -131,7 +131,8 @@ static irqreturn_t lm8333_irq_thread(int irq, void *data)
 static int lm8333_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	const struct lm8333_platform_data *pdata = client->dev.platform_data;
+	const struct lm8333_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	struct lm8333 *lm8333;
 	struct input_dev *input;
 	int err, active_time;
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index bc2cdaf..430b545 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -182,7 +182,8 @@ static void max7359_initialize(struct i2c_client *client)
 static int max7359_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
-	const struct matrix_keymap_data *keymap_data = client->dev.platform_data;
+	const struct matrix_keymap_data *keymap_data =
+			dev_get_platdata(&client->dev);
 	struct max7359_keypad *keypad;
 	struct input_dev *input_dev;
 	int ret;
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 7c236f9..5ec77523 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -108,7 +108,7 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 	int error;
 	int i;
 
-	pdata = client->dev.platform_data;
+	pdata = dev_get_platdata(&client->dev);
 	if (!pdata) {
 		dev_err(&client->dev, "no platform data defined\n");
 		return -EINVAL;
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index f7f3e9a..98b8467 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -188,7 +188,8 @@ err_i2c_write:
 static int mpr_touchkey_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
-	const struct mpr121_platform_data *pdata = client->dev.platform_data;
+	const struct mpr121_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	struct mpr121_touchkey *mpr121;
 	struct input_dev *input_dev;
 	int error;
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index c7d505c..63332e2 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -222,7 +222,8 @@ static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
 
 static int __init ske_keypad_probe(struct platform_device *pdev)
 {
-	const struct ske_keypad_platform_data *plat = pdev->dev.platform_data;
+	const struct ske_keypad_platform_data *plat =
+			dev_get_platdata(&pdev->dev);
 	struct ske_keypad *keypad;
 	struct input_dev *input;
 	struct resource *res;
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index d0d5226..e80bb97 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -248,7 +248,7 @@ static int omap_kp_probe(struct platform_device *pdev)
 {
 	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
-	struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
+	struct omap_kp_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int i, col_idx, row_idx, ret;
 	unsigned int row_shift, keycodemax;
 
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index 248cdcf..367b03a 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -84,7 +84,8 @@ static void pxa930_rotary_close(struct input_dev *dev)
 
 static int pxa930_rotary_probe(struct platform_device *pdev)
 {
-	struct pxa930_rotary_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa930_rotary_platform_data *pdata =
+			dev_get_platdata(&pdev->dev);
 	struct pxa930_rotary *r;
 	struct input_dev *input_dev;
 	struct resource *res;
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index ac43a48..9ac8a1e 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -321,7 +321,7 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		pdata = samsung_keypad_parse_dt(&pdev->dev);
 	else
-		pdata = pdev->dev.platform_data;
+		pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		return -EINVAL;
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index fe0e498..d65a98b 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -171,7 +171,7 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	int i;
 	int irq, error;
 
-	if (!pdev->dev.platform_data) {
+	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		error = -EINVAL;
 		goto err0;
@@ -198,7 +198,7 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, priv);
-	memcpy(&priv->pdata, pdev->dev.platform_data, sizeof(priv->pdata));
+	memcpy(&priv->pdata, dev_get_platdata(&pdev->dev), sizeof(priv->pdata));
 	pdata = &priv->pdata;
 
 	priv->iomem_base = ioremap_nocache(res->start, resource_size(res));
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index bfc832c..dc983ab 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -213,7 +213,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	pdata = client->dev.platform_data;
+	pdata = dev_get_platdata(&client->dev);
 	if (!pdata) {
 		dev_dbg(&client->dev, "no platform data\n");
 		return -EINVAL;
diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index 8bd24d5..086511c 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -162,7 +162,7 @@ static int keypad_probe(struct platform_device *pdev)
 	int error = 0, sz, row_shift;
 	u32 rev = 0;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		dev_err(dev, "cannot find device data\n");
 		return -EINVAL;
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index d2d178c..8bc2879 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -330,7 +330,7 @@ static int twl4030_kp_program(struct twl4030_keypad *kp)
  */
 static int twl4030_kp_probe(struct platform_device *pdev)
 {
-	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
+	struct twl4030_keypad_data *pdata = dev_get_platdata(&pdev->dev);
 	const struct matrix_keymap_data *keymap_data;
 	struct twl4030_keypad *kp;
 	struct input_dev *input;
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index 7b03916..e03614f 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -121,7 +121,7 @@ static void w90p910_keypad_close(struct input_dev *dev)
 static int w90p910_keypad_probe(struct platform_device *pdev)
 {
 	const struct w90p910_keypad_platform_data *pdata =
-						pdev->dev.platform_data;
+						dev_get_platdata(&pdev->dev);
 	const struct matrix_keymap_data *keymap_data;
 	struct w90p910_keypad *keypad;
 	struct input_dev *input_dev;
diff --git a/drivers/input/leds.c b/drivers/input/leds.c
index 6bdb51d..99bb05e 100644
--- a/drivers/input/leds.c
+++ b/drivers/input/leds.c
@@ -117,7 +117,7 @@ static void perdevice_input_led_set(struct led_classdev *cdev,
 	struct led_classdev *leds;
 	int led;
 
-	dev = cdev->dev->platform_data;
+	dev = dev_get_platdata(cdev->dev);
 	if (!dev)
 		/* Still initializing */
 		return;
diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 2e5d5e1..6deecdd 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -969,7 +969,7 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	int error;
 	struct input_dev *input[MAX_DEVICE_NUM];
 
-	struct ad714x_platform_data *plat_data = dev->platform_data;
+	struct ad714x_platform_data *plat_data = dev_get_platdata(dev);
 	struct ad714x_chip *ad714x;
 	void *drv_mem;
 	unsigned long irqflags;
@@ -986,7 +986,7 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 		goto err_out;
 	}
 
-	if (dev->platform_data == NULL) {
+	if (dev_get_platdata(dev) == NULL) {
 		dev_err(dev, "platform data for ad714x doesn't exist\n");
 		error = -EINVAL;
 		goto err_out;
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 0735de3..d204997 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -714,7 +714,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 
 	ac->fifo_delay = fifo_delay_default;
 
-	pdata = dev->platform_data;
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
 		dev_dbg(dev,
 			"No platform data: Using default initialization\n");
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index cd139cb..7703447 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -92,7 +92,7 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 
 static int bfin_rotary_probe(struct platform_device *pdev)
 {
-	struct bfin_rotary_platform_data *pdata = pdev->dev.platform_data;
+	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary;
 	struct input_dev *input;
 	int error;
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 865c2f9..52d3a9b 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -526,7 +526,8 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	const struct bma150_platform_data *pdata = client->dev.platform_data;
+	const struct bma150_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	const struct bma150_cfg *cfg;
 	struct bma150_data *bma150;
 	int chip_id;
diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index df9b756..c7d0074 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL(cma3000_resume);
 struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 				       const struct cma3000_bus_ops *bops)
 {
-	const struct cma3000_platform_data *pdata = dev->platform_data;
+	const struct cma3000_platform_data *pdata = dev_get_platdata(dev);
 	struct cma3000_accl_data *data;
 	struct input_dev *input_dev;
 	int rev;
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index fe30bd0..de21e31 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -125,7 +125,7 @@ static int gp2a_initialize(struct gp2a_data *dt)
 static int gp2a_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
-	const struct gp2a_platform_data *pdata = client->dev.platform_data;
+	const struct gp2a_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct gp2a_data *dt;
 	int error;
 
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index 714c683..38b3c11 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -98,7 +98,8 @@ static void gpio_tilt_polled_close(struct input_polled_dev *dev)
 
 static int gpio_tilt_polled_probe(struct platform_device *pdev)
 {
-	const struct gpio_tilt_platform_data *pdata = pdev->dev.platform_data;
+	const struct gpio_tilt_platform_data *pdata =
+			dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct gpio_tilt_polled_dev *tdev;
 	struct input_polled_dev *poll_dev;
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index a993b67..d708478 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -509,7 +509,8 @@ out:
 static int kxtj9_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
-	const struct kxtj9_platform_data *pdata = client->dev.platform_data;
+	const struct kxtj9_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	struct kxtj9_data *tj9;
 	int err;
 
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 940566e..8ef288e 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -68,7 +68,7 @@ static int pwm_beeper_event(struct input_dev *input,
 
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
-	unsigned long pwm_id = (unsigned long)pdev->dev.platform_data;
+	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
 	struct pwm_beeper *beeper;
 	int error;
 
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 68a5f33..d993775 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -193,7 +193,7 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
 
 static int twl4030_vibra_probe(struct platform_device *pdev)
 {
-	struct twl4030_vibra_data *pdata = pdev->dev.platform_data;
+	struct twl4030_vibra_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *twl4030_core_node = pdev->dev.parent->of_node;
 	struct vibra_info *info;
 	int ret;
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 6b44413..6810a46 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -48,7 +48,7 @@ static void gpio_mouse_scan(struct input_polled_dev *dev)
 
 static int gpio_mouse_probe(struct platform_device *pdev)
 {
-	struct gpio_mouse_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_mouse_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct input_polled_dev *input_poll;
 	struct input_dev *input;
 	int pin, i;
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index 0ecb9e7..d20d2ae 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -166,7 +166,7 @@ static int pxa930_trkball_probe(struct platform_device *pdev)
 	if (!trkball)
 		return -ENOMEM;
 
-	trkball->pdata = pdev->dev.platform_data;
+	trkball->pdata = dev_get_platdata(&pdev->dev);
 	if (!trkball->pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		error = -EINVAL;
diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index f7de14a..544e20c 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -172,7 +172,7 @@ static int pm860x_touch_dt_init(struct platform_device *pdev,
 static int pm860x_touch_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm860x_touch_pdata *pdata = pdev->dev.platform_data;
+	struct pm860x_touch_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct pm860x_touch *touch;
 	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
 				 : chip->companion;
diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 69834dd..b9f9bcb 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -686,7 +686,7 @@ static int ad7877_probe(struct spi_device *spi)
 {
 	struct ad7877			*ts;
 	struct input_dev		*input_dev;
-	struct ad7877_platform_data	*pdata = spi->dev.platform_data;
+	struct ad7877_platform_data	*pdata = dev_get_platdata(&spi->dev);
 	int				err;
 	u16				verify;
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index facd305..a0364d8 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -470,7 +470,7 @@ static int ad7879_gpio_add(struct ad7879 *ts,
 
 static void ad7879_gpio_remove(struct ad7879 *ts)
 {
-	const struct ad7879_platform_data *pdata = ts->dev->platform_data;
+	const struct ad7879_platform_data *pdata = dev_get_platdata(ts->dev);
 	int ret;
 
 	if (pdata->gpio_export) {
@@ -495,7 +495,7 @@ static inline void ad7879_gpio_remove(struct ad7879 *ts)
 struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 			    const struct ad7879_bus_ops *bops)
 {
-	struct ad7879_platform_data *pdata = dev->platform_data;
+	struct ad7879_platform_data *pdata = dev_get_platdata(dev);
 	struct ad7879 *ts;
 	struct input_dev *input_dev;
 	int err;
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 59aa240..37ea057 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1130,7 +1130,7 @@ static void mxt_input_close(struct input_dev *dev)
 static int mxt_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	const struct mxt_platform_data *pdata = client->dev.platform_data;
+	const struct mxt_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct mxt_data *data;
 	struct input_dev *input_dev;
 	int error;
diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index bddabc5..f7d1ea5 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -182,7 +182,7 @@ static int atmel_tsadcc_probe(struct platform_device *pdev)
 	struct atmel_tsadcc	*ts_dev;
 	struct input_dev	*input_dev;
 	struct resource		*res;
-	struct at91_tsadcc_data *pdata = pdev->dev.platform_data;
+	struct at91_tsadcc_data *pdata = dev_get_platdata(&pdev->dev);
 	int		err;
 	unsigned int	prsc;
 	unsigned int	reg;
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 8c65198..5bf1aee 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -178,7 +178,7 @@ static irqreturn_t cy8ctmg110_irq_thread(int irq, void *dev_id)
 static int cy8ctmg110_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
-	const struct cy8ctmg110_pdata *pdata = client->dev.platform_data;
+	const struct cy8ctmg110_pdata *pdata = dev_get_platdata(&client->dev);
 	struct cy8ctmg110 *ts;
 	struct input_dev *input_dev;
 	int err;
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 4204841..eee656f 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -534,7 +534,7 @@ static void cyttsp_close(struct input_dev *dev)
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size)
 {
-	const struct cyttsp_platform_data *pdata = dev->platform_data;
+	const struct cyttsp_platform_data *pdata = dev_get_platdata(dev);
 	struct cyttsp *ts;
 	struct input_dev *input_dev;
 	int error;
@@ -553,7 +553,7 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	ts->dev = dev;
 	ts->input = input_dev;
-	ts->pdata = dev->platform_data;
+	ts->pdata = dev_get_platdata(dev);
 	ts->bus_ops = bus_ops;
 	ts->irq = irq;
 
diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 34ad841..ea0f764 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -299,7 +299,7 @@ static void da9034_touch_close(struct input_dev *dev)
 
 static int da9034_touch_probe(struct platform_device *pdev)
 {
-	struct da9034_touch_pdata *pdata = pdev->dev.platform_data;
+	struct da9034_touch_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct da9034_touch *touch;
 	struct input_dev *input_dev;
 	int ret;
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 83fa1b1..af0d68b 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -705,7 +705,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
 	const struct edt_ft5x06_platform_data *pdata =
-						client->dev.platform_data;
+						dev_get_platdata(&client->dev);
 	struct edt_ft5x06_ts_data *tsdata;
 	struct input_dev *input;
 	int error;
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 1ce3d29..b1884dd 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -157,7 +157,7 @@ static void eeti_ts_close(struct input_dev *dev)
 static int eeti_ts_probe(struct i2c_client *client,
 				   const struct i2c_device_id *idp)
 {
-	struct eeti_ts_platform_data *pdata = client->dev.platform_data;
+	struct eeti_ts_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct eeti_ts_priv *priv;
 	struct input_dev *input;
 	unsigned int irq_flags;
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 1418bdd..2a50891 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -184,7 +184,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	const struct ili210x_platform_data *pdata = dev->platform_data;
+	const struct ili210x_platform_data *pdata = dev_get_platdata(dev);
 	struct ili210x *priv;
 	struct input_dev *input;
 	struct panel_info panel;
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index f9f4e0c..58486f1 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -194,7 +194,7 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 	struct input_dev *input_dev;
 	int ret;
 
-	if (!client->dev.platform_data)
+	if (!dev_get_platdata(&client->dev))
 		return -EINVAL;
 
 	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
@@ -207,7 +207,7 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 
 	data->client = client;
 	data->input_dev = input_dev;
-	data->platform_data = client->dev.platform_data;
+	data->platform_data = dev_get_platdata(&client->dev);
 
 	input_dev->name = "MELPAS MCS-5000 Touchscreen";
 	input_dev->id.bustype = BUS_I2C;
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 6cc6b36..02392d2 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -128,7 +128,8 @@ static SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
 static int pixcir_i2c_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
-	const struct pixcir_ts_platform_data *pdata = client->dev.platform_data;
+	const struct pixcir_ts_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	struct pixcir_i2c_ts_data *tsdata;
 	struct input_dev *input;
 	int error;
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index b061af2..d32bd9e 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -251,7 +251,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 
 	ts.dev = dev;
 
-	info = pdev->dev.platform_data;
+	info = dev_get_platdata(&pdev->dev);
 	if (!info) {
 		dev_err(dev, "no platform data, cannot attach\n");
 		return -EINVAL;
@@ -392,7 +392,7 @@ static int s3c2410ts_suspend(struct device *dev)
 static int s3c2410ts_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
+	struct s3c2410_ts_mach_info *info = dev_get_platdata(&pdev->dev);
 
 	clk_enable(ts.clock);
 	enable_irq(ts.irq_tc);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 2f03b2f..5c342b3 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -154,7 +154,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct st1232_ts_data *ts;
-	struct st1232_pdata *pdata = client->dev.platform_data;
+	struct st1232_pdata *pdata = dev_get_platdata(&client->dev);
 	struct input_dev *input_dev;
 	int error;
 
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 8113533..550adcb 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -571,7 +571,7 @@ static void tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 
 static int tsc2005_probe(struct spi_device *spi)
 {
-	const struct tsc2005_platform_data *pdata = spi->dev.platform_data;
+	const struct tsc2005_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct tsc2005 *ts;
 	struct input_dev *input_dev;
 	unsigned int max_x, max_y, max_p;
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 1271f97..5b3ca80 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -320,7 +320,7 @@ static int ucb1400_ts_detect_irq(struct ucb1400_ts *ucb,
 
 static int ucb1400_ts_probe(struct platform_device *pdev)
 {
-	struct ucb1400_ts *ucb = pdev->dev.platform_data;
+	struct ucb1400_ts *ucb = dev_get_platdata(&pdev->dev);
 	int error, x_res, y_res;
 	u16 fcsr;
 
@@ -399,7 +399,7 @@ err:
 
 static int ucb1400_ts_remove(struct platform_device *pdev)
 {
-	struct ucb1400_ts *ucb = pdev->dev.platform_data;
+	struct ucb1400_ts *ucb = dev_get_platdata(&pdev->dev);
 
 	free_irq(ucb->irq, ucb);
 	input_unregister_device(ucb->ts_idev);
@@ -410,7 +410,7 @@ static int ucb1400_ts_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int ucb1400_ts_suspend(struct device *dev)
 {
-	struct ucb1400_ts *ucb = dev->platform_data;
+	struct ucb1400_ts *ucb = dev_get_platdata(dev);
 	struct input_dev *idev = ucb->ts_idev;
 
 	mutex_lock(&idev->mutex);
@@ -424,7 +424,7 @@ static int ucb1400_ts_suspend(struct device *dev)
 
 static int ucb1400_ts_resume(struct device *dev)
 {
-	struct ucb1400_ts *ucb = dev->platform_data;
+	struct ucb1400_ts *ucb = dev_get_platdata(dev);
 	struct input_dev *idev = ucb->ts_idev;
 
 	mutex_lock(&idev->mutex);
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 7e45c9f..d0ef91f 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -584,7 +584,7 @@ static void wm97xx_ts_input_close(struct input_dev *idev)
 static int wm97xx_probe(struct device *dev)
 {
 	struct wm97xx *wm;
-	struct wm97xx_pdata *pdata = dev->platform_data;
+	struct wm97xx_pdata *pdata = dev_get_platdata(dev);
 	int ret = 0, id = 0;
 
 	wm = kzalloc(sizeof(struct wm97xx), GFP_KERNEL);
-- 
1.7.10.4


