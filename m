From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 22/35] Input: keyboard: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:14:15 +0900
Message-ID: <005101ce8cfc$c8021530$58063f90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44799 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924Ab3G3IOR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 04:14:17 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ005AFPJOUVU0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Jul 2013 17:14:16 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
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
 21 files changed, 37 insertions(+), 29 deletions(-)

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
index dbd2047..e3874d3 100644
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
index 67d12b3..e43efa0 100644
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
index fc88fb4..16fa340 100644
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
 
@@ -332,7 +332,7 @@ out:
 
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
index 03c8cc5..68596ab 100644
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
index 7c7af2b..20fa5ca 100644
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
index 5f7b427..9a3887a 100644
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
-- 
1.7.10.4


