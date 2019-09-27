From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RESEND] input: adp5589: Make keypad support optional
Date: Fri, 27 Sep 2019 15:38:36 +0300
Message-ID: <20190927123836.28047-1-alexandru.ardelean@analog.com>
References: <20190717122133.24333-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717122133.24333-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-Id: linux-input@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

On some platforms the adp5589 is used in GPIO only mode. On these platforms
we do not want to register a input device, so make that optional and only
create the input device if a keymap is supplied.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/input/keyboard/adp5589-keys.c | 197 +++++++++++++++-----------
 1 file changed, 111 insertions(+), 86 deletions(-)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 4f96a4a99e5b..08bfa8b213e8 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -495,10 +495,10 @@ static int adp5589_build_gpiomap(struct adp5589_kpad *kpad,
 	return n_unused;
 }
 
-static int adp5589_gpio_add(struct adp5589_kpad *kpad)
+static int adp5589_gpio_add(struct adp5589_kpad *kpad,
+	const struct adp5589_kpad_platform_data *pdata)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5589_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5589_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int i, error;
 
@@ -550,10 +550,10 @@ static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 	return 0;
 }
 
-static void adp5589_gpio_remove(struct adp5589_kpad *kpad)
+static void adp5589_gpio_remove(struct adp5589_kpad *kpad,
+	const struct adp5589_kpad_platform_data *pdata)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5589_kpad_platform_data *pdata = dev_get_platdata(dev);
 	const struct adp5589_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int error;
 
@@ -571,12 +571,14 @@ static void adp5589_gpio_remove(struct adp5589_kpad *kpad)
 	gpiochip_remove(&kpad->gc);
 }
 #else
-static inline int adp5589_gpio_add(struct adp5589_kpad *kpad)
+static inline int adp5589_gpio_add(struct adp5589_kpad *kpad,
+	struct const adp5589_kpad_platform_data *pdata)
 {
 	return 0;
 }
 
-static inline void adp5589_gpio_remove(struct adp5589_kpad *kpad)
+static inline void adp5589_gpio_remove(struct adp5589_kpad *kpad,
+	struct const adp5589_kpad_platform_data *pdata)
 {
 }
 #endif
@@ -652,11 +654,10 @@ static int adp5589_get_evcode(struct adp5589_kpad *kpad, unsigned short key)
 	return -EINVAL;
 }
 
-static int adp5589_setup(struct adp5589_kpad *kpad)
+static int adp5589_setup(struct adp5589_kpad *kpad, 
+	const struct adp5589_kpad_platform_data *pdata)
 {
 	struct i2c_client *client = kpad->client;
-	const struct adp5589_kpad_platform_data *pdata =
-		dev_get_platdata(&client->dev);
 	u8 (*reg) (u8) = kpad->var->reg;
 	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
 	unsigned char pull_mask = 0;
@@ -857,70 +858,37 @@ static void adp5589_report_switch_state(struct adp5589_kpad *kpad)
 	input_sync(kpad->input);
 }
 
-static int adp5589_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int adp5589_keypad_add(struct adp5589_kpad *kpad, unsigned int revid,
+	const struct adp5589_kpad_platform_data *pdata)
 {
-	struct adp5589_kpad *kpad;
-	const struct adp5589_kpad_platform_data *pdata =
-		dev_get_platdata(&client->dev);
+	struct i2c_client *client = kpad->client;
 	struct input_dev *input;
-	unsigned int revid;
-	int ret, i;
+	unsigned int i;
 	int error;
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
-		return -EIO;
-	}
-
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data?\n");
-		return -EINVAL;
-	}
-
-	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
-	if (!kpad)
-		return -ENOMEM;
-
-	switch (id->driver_data) {
-	case ADP5585_02:
-		kpad->support_row5 = true;
-		/* fall through */
-	case ADP5585_01:
-		kpad->is_adp5585 = true;
-		kpad->var = &const_adp5585;
-		break;
-	case ADP5589:
-		kpad->support_row5 = true;
-		kpad->var = &const_adp5589;
-		break;
-	}
+	if (pdata->keymapsize == 0)
+		return 0;
 
 	if (!((pdata->keypad_en_mask & kpad->var->row_mask) &&
 			(pdata->keypad_en_mask >> kpad->var->col_shift)) ||
 			!pdata->keymap) {
 		dev_err(&client->dev, "no rows, cols or keymap from pdata\n");
-		error = -EINVAL;
-		goto err_free_mem;
+		return -EINVAL;
 	}
 
 	if (pdata->keymapsize != kpad->var->keymapsize) {
 		dev_err(&client->dev, "invalid keymapsize\n");
-		error = -EINVAL;
-		goto err_free_mem;
+		return -EINVAL;
 	}
 
 	if (!pdata->gpimap && pdata->gpimapsize) {
 		dev_err(&client->dev, "invalid gpimap from pdata\n");
-		error = -EINVAL;
-		goto err_free_mem;
+		return -EINVAL;
 	}
 
 	if (pdata->gpimapsize > kpad->var->gpimapsize_max) {
 		dev_err(&client->dev, "invalid gpimapsize\n");
-		error = -EINVAL;
-		goto err_free_mem;
+		return -EINVAL;
 	}
 
 	for (i = 0; i < pdata->gpimapsize; i++) {
@@ -929,41 +897,27 @@ static int adp5589_probe(struct i2c_client *client,
 		if (pin < kpad->var->gpi_pin_base ||
 				pin > kpad->var->gpi_pin_end) {
 			dev_err(&client->dev, "invalid gpi pin data\n");
-			error = -EINVAL;
-			goto err_free_mem;
+			return -EINVAL;
 		}
 
 		if ((1 << (pin - kpad->var->gpi_pin_row_base)) &
 				pdata->keypad_en_mask) {
 			dev_err(&client->dev, "invalid gpi row/col data\n");
-			error = -EINVAL;
-			goto err_free_mem;
+			return -EINVAL;
 		}
 	}
 
 	if (!client->irq) {
 		dev_err(&client->dev, "no IRQ?\n");
-		error = -EINVAL;
-		goto err_free_mem;
+		return -EINVAL;
 	}
 
 	input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	if (!input)
+		return -ENOMEM;
 
-	kpad->client = client;
 	kpad->input = input;
 
-	ret = adp5589_read(client, ADP5589_5_ID);
-	if (ret < 0) {
-		error = ret;
-		goto err_free_input;
-	}
-
-	revid = (u8) ret & ADP5589_5_DEVICE_ID_MASK;
-
 	input->name = client->name;
 	input->phys = "adp5589-keys/input0";
 	input->dev.parent = &client->dev;
@@ -1015,30 +969,94 @@ static int adp5589_probe(struct i2c_client *client,
 		goto err_unreg_dev;
 	}
 
-	error = adp5589_setup(kpad);
+	device_init_wakeup(&client->dev, 1);
+
+	return 0;
+
+err_unreg_dev:
+	input_unregister_device(input);
+	input = NULL;
+err_free_input:
+	input_free_device(input);
+
+	return error;
+}
+
+static void adp5589_keypad_remove(struct adp5589_kpad *kpad,
+	const struct adp5589_kpad_platform_data *pdata)
+{
+	if (!kpad->input)
+		return;
+
+	free_irq(kpad->client->irq, kpad);
+	input_unregister_device(kpad->input);
+}
+
+static int adp5589_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct adp5589_kpad *kpad;
+	const struct adp5589_kpad_platform_data *pdata =
+		dev_get_platdata(&client->dev);
+	unsigned int revid;
+	int error, ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
+		return -EIO;
+	}
+
+
+	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
+	if (!kpad)
+		return -ENOMEM;
+
+	kpad->client = client;
+
+	switch (id->driver_data) {
+	case ADP5585_02:
+		kpad->support_row5 = true;
+	case ADP5585_01:
+		kpad->is_adp5585 = true;
+		kpad->var = &const_adp5585;
+		break;
+	case ADP5589:
+		kpad->support_row5 = true;
+		kpad->var = &const_adp5589;
+		break;
+	}
+
+	ret = adp5589_read(client, ADP5589_5_ID);
+	if (ret < 0) {
+		error = ret;
+		goto err_free_mem;
+	}
+
+	revid = (u8) ret & ADP5589_5_DEVICE_ID_MASK;
+
+	error = adp5589_keypad_add(kpad, revid, pdata);
 	if (error)
-		goto err_free_irq;
+		goto err_free_mem;
+
+	error = adp5589_setup(kpad, pdata);
+	if (error)
+		goto err_keypad_remove;
 
 	if (kpad->gpimapsize)
 		adp5589_report_switch_state(kpad);
 
-	error = adp5589_gpio_add(kpad);
+	error = adp5589_gpio_add(kpad, pdata);
 	if (error)
-		goto err_free_irq;
+		goto err_keypad_remove;
 
-	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);
 
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
 
-err_free_irq:
-	free_irq(client->irq, kpad);
-err_unreg_dev:
-	input_unregister_device(input);
-	input = NULL;
-err_free_input:
-	input_free_device(input);
+err_keypad_remove:
+	adp5589_keypad_remove(kpad, pdata);
 err_free_mem:
 	kfree(kpad);
 
@@ -1048,11 +1066,12 @@ static int adp5589_probe(struct i2c_client *client,
 static int adp5589_remove(struct i2c_client *client)
 {
 	struct adp5589_kpad *kpad = i2c_get_clientdata(client);
+	const struct adp5589_kpad_platform_data *pdata =
+		dev_get_platdata(&client->dev);
 
 	adp5589_write(client, kpad->var->reg(ADP5589_GENERAL_CFG), 0);
-	free_irq(client->irq, kpad);
-	input_unregister_device(kpad->input);
-	adp5589_gpio_remove(kpad);
+	adp5589_keypad_remove(kpad, pdata);
+	adp5589_gpio_remove(kpad, pdata);
 	kfree(kpad);
 
 	return 0;
@@ -1064,6 +1083,9 @@ static int adp5589_suspend(struct device *dev)
 	struct adp5589_kpad *kpad = dev_get_drvdata(dev);
 	struct i2c_client *client = kpad->client;
 
+	if (!kpad->input)
+		return 0;
+
 	disable_irq(client->irq);
 
 	if (device_may_wakeup(&client->dev))
@@ -1077,6 +1099,9 @@ static int adp5589_resume(struct device *dev)
 	struct adp5589_kpad *kpad = dev_get_drvdata(dev);
 	struct i2c_client *client = kpad->client;
 
+	if (!kpad->input)
+		return 0;
+
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
 
-- 
2.20.1
