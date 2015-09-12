From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ad714x: Convert to using managed resources
Date: Sat, 12 Sep 2015 11:22:28 -0700
Message-ID: <20150912182228.GA11354@dtor-ws>
References: <20150912145618.GA2214@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35164 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbILSWb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Sep 2015 14:22:31 -0400
Content-Disposition: inline
In-Reply-To: <20150912145618.GA2214@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Sep 12, 2015 at 08:26:18PM +0530, Vaishali Thakkar wrote:
> Use managed resource functions devm_request_threaded_irq,
> devm_inpute_allocate_device and devm_kzalloc to simplify
> error handling. Also, remove use of input_unregister_device
> as input_register_device itself handles it and works as
> resource managed function.
> 
> To be compatible with the change, various gotos are replaced
> with direct returns, and unneeded labels are dropped. With
> these changes remove ad714x_remove and corresponding calls of
> it as they are now redundant.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
> Please note that this patch is having three lines over 80
> characters as limiting them to 80 characters makes code
> less readable.

You can actually remove input[input_alloc] and that will allow you to
stay witing 80 columnts. Does the following version still work for you?

Thanks.

Input: ad714x - convert to using managed resources

From: Vaishali Thakkar <vthakkar1994@gmail.com>

Use managed resource functions devm_request_threaded_irq,
devm_inpute_allocate_device and devm_kzalloc to simplify error handling.
Also, remove use of input_unregister_device as input_register_device itself
handles it and works as resource managed function.

To be compatible with the change, various gotos are replaced with direct
returns, and unneeded labels are dropped. With these changes remove
ad714x_remove and corresponding calls of it as they are now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ad714x-i2c.c |   10 --
 drivers/input/misc/ad714x-spi.c |   10 --
 drivers/input/misc/ad714x.c     |  214 +++++++++++++++------------------------
 drivers/input/misc/ad714x.h     |    1 
 4 files changed, 82 insertions(+), 153 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 189bdc8..2f04773 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -85,15 +85,6 @@ static int ad714x_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int ad714x_i2c_remove(struct i2c_client *client)
-{
-	struct ad714x_chip *chip = i2c_get_clientdata(client);
-
-	ad714x_remove(chip);
-
-	return 0;
-}
-
 static const struct i2c_device_id ad714x_id[] = {
 	{ "ad7142_captouch", 0 },
 	{ "ad7143_captouch", 0 },
@@ -110,7 +101,6 @@ static struct i2c_driver ad714x_i2c_driver = {
 		.pm   = &ad714x_i2c_pm,
 	},
 	.probe    = ad714x_i2c_probe,
-	.remove   = ad714x_i2c_remove,
 	.id_table = ad714x_id,
 };
 
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index a79e50b..c8170f0 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -101,15 +101,6 @@ static int ad714x_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad714x_spi_remove(struct spi_device *spi)
-{
-	struct ad714x_chip *chip = spi_get_drvdata(spi);
-
-	ad714x_remove(chip);
-
-	return 0;
-}
-
 static struct spi_driver ad714x_spi_driver = {
 	.driver = {
 		.name	= "ad714x_captouch",
@@ -117,7 +108,6 @@ static struct spi_driver ad714x_spi_driver = {
 		.pm	= &ad714x_spi_pm,
 	},
 	.probe		= ad714x_spi_probe,
-	.remove		= ad714x_spi_remove,
 };
 
 module_spi_driver(ad714x_spi_driver);
diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 7a61e9e..84b51dd 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -960,13 +960,12 @@ static irqreturn_t ad714x_interrupt_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#define MAX_DEVICE_NUM 8
 struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 				 ad714x_read_t read, ad714x_write_t write)
 {
-	int i, alloc_idx;
+	int i;
 	int error;
-	struct input_dev *input[MAX_DEVICE_NUM];
+	struct input_dev *input;
 
 	struct ad714x_platform_data *plat_data = dev_get_platdata(dev);
 	struct ad714x_chip *ad714x;
@@ -982,25 +981,25 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	if (irq <= 0) {
 		dev_err(dev, "IRQ not configured!\n");
 		error = -EINVAL;
-		goto err_out;
+		return ERR_PTR(error);
 	}
 
 	if (dev_get_platdata(dev) == NULL) {
 		dev_err(dev, "platform data for ad714x doesn't exist\n");
 		error = -EINVAL;
-		goto err_out;
+		return ERR_PTR(error);
 	}
 
-	ad714x = kzalloc(sizeof(*ad714x) + sizeof(*ad714x->sw) +
-			 sizeof(*sd_drv) * plat_data->slider_num +
-			 sizeof(*wl_drv) * plat_data->wheel_num +
-			 sizeof(*tp_drv) * plat_data->touchpad_num +
-			 sizeof(*bt_drv) * plat_data->button_num, GFP_KERNEL);
+	ad714x = devm_kzalloc(dev, sizeof(*ad714x) + sizeof(*ad714x->sw) +
+				   sizeof(*sd_drv) * plat_data->slider_num +
+				   sizeof(*wl_drv) * plat_data->wheel_num +
+				   sizeof(*tp_drv) * plat_data->touchpad_num +
+				   sizeof(*bt_drv) * plat_data->button_num,
+			      GFP_KERNEL);
 	if (!ad714x) {
 		error = -ENOMEM;
-		goto err_out;
+		return ERR_PTR(error);
 	}
-
 	ad714x->hw = plat_data;
 
 	drv_mem = ad714x + 1;
@@ -1022,47 +1021,40 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 
 	error = ad714x_hw_detect(ad714x);
 	if (error)
-		goto err_free_mem;
+		return ERR_PTR(error);
 
 	/* initialize and request sw/hw resources */
 
 	ad714x_hw_init(ad714x);
 	mutex_init(&ad714x->mutex);
 
-	/*
-	 * Allocate and register AD714X input device
-	 */
-	alloc_idx = 0;
-
 	/* a slider uses one input_dev instance */
 	if (ad714x->hw->slider_num > 0) {
 		struct ad714x_slider_plat *sd_plat = ad714x->hw->slider;
 
 		for (i = 0; i < ad714x->hw->slider_num; i++) {
-			sd_drv[i].input = input[alloc_idx] = input_allocate_device();
-			if (!input[alloc_idx]) {
-				error = -ENOMEM;
-				goto err_free_dev;
-			}
-
-			__set_bit(EV_ABS, input[alloc_idx]->evbit);
-			__set_bit(EV_KEY, input[alloc_idx]->evbit);
-			__set_bit(ABS_X, input[alloc_idx]->absbit);
-			__set_bit(BTN_TOUCH, input[alloc_idx]->keybit);
-			input_set_abs_params(input[alloc_idx],
+			input = devm_input_allocate_device(dev);
+			if (!input)
+				return ERR_PTR(-ENOMEM);
+
+			__set_bit(EV_ABS, input->evbit);
+			__set_bit(EV_KEY, input->evbit);
+			__set_bit(ABS_X, input->absbit);
+			__set_bit(BTN_TOUCH, input->keybit);
+			input_set_abs_params(input,
 				ABS_X, 0, sd_plat->max_coord, 0, 0);
 
-			input[alloc_idx]->id.bustype = bus_type;
-			input[alloc_idx]->id.product = ad714x->product;
-			input[alloc_idx]->id.version = ad714x->version;
-			input[alloc_idx]->name = "ad714x_captouch_slider";
-			input[alloc_idx]->dev.parent = dev;
+			input->id.bustype = bus_type;
+			input->id.product = ad714x->product;
+			input->id.version = ad714x->version;
+			input->name = "ad714x_captouch_slider";
+			input->dev.parent = dev;
 
-			error = input_register_device(input[alloc_idx]);
+			error = input_register_device(input);
 			if (error)
-				goto err_free_dev;
+				return ERR_PTR(error);
 
-			alloc_idx++;
+			sd_drv[i].input = input;
 		}
 	}
 
@@ -1071,30 +1063,28 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 		struct ad714x_wheel_plat *wl_plat = ad714x->hw->wheel;
 
 		for (i = 0; i < ad714x->hw->wheel_num; i++) {
-			wl_drv[i].input = input[alloc_idx] = input_allocate_device();
-			if (!input[alloc_idx]) {
-				error = -ENOMEM;
-				goto err_free_dev;
-			}
-
-			__set_bit(EV_KEY, input[alloc_idx]->evbit);
-			__set_bit(EV_ABS, input[alloc_idx]->evbit);
-			__set_bit(ABS_WHEEL, input[alloc_idx]->absbit);
-			__set_bit(BTN_TOUCH, input[alloc_idx]->keybit);
-			input_set_abs_params(input[alloc_idx],
+			input = devm_input_allocate_device(dev);
+			if (!input)
+				return ERR_PTR(-ENOMEM);
+
+			__set_bit(EV_KEY, input->evbit);
+			__set_bit(EV_ABS, input->evbit);
+			__set_bit(ABS_WHEEL, input->absbit);
+			__set_bit(BTN_TOUCH, input->keybit);
+			input_set_abs_params(input,
 				ABS_WHEEL, 0, wl_plat->max_coord, 0, 0);
 
-			input[alloc_idx]->id.bustype = bus_type;
-			input[alloc_idx]->id.product = ad714x->product;
-			input[alloc_idx]->id.version = ad714x->version;
-			input[alloc_idx]->name = "ad714x_captouch_wheel";
-			input[alloc_idx]->dev.parent = dev;
+			input->id.bustype = bus_type;
+			input->id.product = ad714x->product;
+			input->id.version = ad714x->version;
+			input->name = "ad714x_captouch_wheel";
+			input->dev.parent = dev;
 
-			error = input_register_device(input[alloc_idx]);
+			error = input_register_device(input);
 			if (error)
-				goto err_free_dev;
+				return ERR_PTR(error);
 
-			alloc_idx++;
+			wl_drv[i].input = input;
 		}
 	}
 
@@ -1103,33 +1093,31 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 		struct ad714x_touchpad_plat *tp_plat = ad714x->hw->touchpad;
 
 		for (i = 0; i < ad714x->hw->touchpad_num; i++) {
-			tp_drv[i].input = input[alloc_idx] = input_allocate_device();
-			if (!input[alloc_idx]) {
-				error = -ENOMEM;
-				goto err_free_dev;
-			}
-
-			__set_bit(EV_ABS, input[alloc_idx]->evbit);
-			__set_bit(EV_KEY, input[alloc_idx]->evbit);
-			__set_bit(ABS_X, input[alloc_idx]->absbit);
-			__set_bit(ABS_Y, input[alloc_idx]->absbit);
-			__set_bit(BTN_TOUCH, input[alloc_idx]->keybit);
-			input_set_abs_params(input[alloc_idx],
+			input = devm_input_allocate_device(dev);
+			if (!input)
+				return ERR_PTR(-ENOMEM);
+
+			__set_bit(EV_ABS, input->evbit);
+			__set_bit(EV_KEY, input->evbit);
+			__set_bit(ABS_X, input->absbit);
+			__set_bit(ABS_Y, input->absbit);
+			__set_bit(BTN_TOUCH, input->keybit);
+			input_set_abs_params(input,
 				ABS_X, 0, tp_plat->x_max_coord, 0, 0);
-			input_set_abs_params(input[alloc_idx],
+			input_set_abs_params(input,
 				ABS_Y, 0, tp_plat->y_max_coord, 0, 0);
 
-			input[alloc_idx]->id.bustype = bus_type;
-			input[alloc_idx]->id.product = ad714x->product;
-			input[alloc_idx]->id.version = ad714x->version;
-			input[alloc_idx]->name = "ad714x_captouch_pad";
-			input[alloc_idx]->dev.parent = dev;
+			input->id.bustype = bus_type;
+			input->id.product = ad714x->product;
+			input->id.version = ad714x->version;
+			input->name = "ad714x_captouch_pad";
+			input->dev.parent = dev;
 
-			error = input_register_device(input[alloc_idx]);
+			error = input_register_device(input);
 			if (error)
-				goto err_free_dev;
+				return ERR_PTR(error);
 
-			alloc_idx++;
+			tp_drv[i].input = input;
 		}
 	}
 
@@ -1137,82 +1125,44 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	if (ad714x->hw->button_num > 0) {
 		struct ad714x_button_plat *bt_plat = ad714x->hw->button;
 
-		input[alloc_idx] = input_allocate_device();
-		if (!input[alloc_idx]) {
+		input = devm_input_allocate_device(dev);
+		if (!input) {
 			error = -ENOMEM;
-			goto err_free_dev;
+			return ERR_PTR(error);
 		}
 
-		__set_bit(EV_KEY, input[alloc_idx]->evbit);
+		__set_bit(EV_KEY, input->evbit);
 		for (i = 0; i < ad714x->hw->button_num; i++) {
-			bt_drv[i].input = input[alloc_idx];
-			__set_bit(bt_plat[i].keycode, input[alloc_idx]->keybit);
+			bt_drv[i].input = input;
+			__set_bit(bt_plat[i].keycode, input->keybit);
 		}
 
-		input[alloc_idx]->id.bustype = bus_type;
-		input[alloc_idx]->id.product = ad714x->product;
-		input[alloc_idx]->id.version = ad714x->version;
-		input[alloc_idx]->name = "ad714x_captouch_button";
-		input[alloc_idx]->dev.parent = dev;
+		input->id.bustype = bus_type;
+		input->id.product = ad714x->product;
+		input->id.version = ad714x->version;
+		input->name = "ad714x_captouch_button";
+		input->dev.parent = dev;
 
-		error = input_register_device(input[alloc_idx]);
+		error = input_register_device(input);
 		if (error)
-			goto err_free_dev;
-
-		alloc_idx++;
+			return ERR_PTR(error);
 	}
 
 	irqflags = plat_data->irqflags ?: IRQF_TRIGGER_FALLING;
 	irqflags |= IRQF_ONESHOT;
 
-	error = request_threaded_irq(ad714x->irq, NULL, ad714x_interrupt_thread,
-				     irqflags, "ad714x_captouch", ad714x);
+	error = devm_request_threaded_irq(dev, ad714x->irq, NULL,
+					  ad714x_interrupt_thread,
+					  irqflags, "ad714x_captouch", ad714x);
 	if (error) {
 		dev_err(dev, "can't allocate irq %d\n", ad714x->irq);
-		goto err_unreg_dev;
+		return ERR_PTR(error);
 	}
 
 	return ad714x;
-
- err_free_dev:
-	dev_err(dev, "failed to setup AD714x input device %i\n", alloc_idx);
-	input_free_device(input[alloc_idx]);
- err_unreg_dev:
-	while (--alloc_idx >= 0)
-		input_unregister_device(input[alloc_idx]);
- err_free_mem:
-	kfree(ad714x);
- err_out:
-	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(ad714x_probe);
 
-void ad714x_remove(struct ad714x_chip *ad714x)
-{
-	struct ad714x_platform_data *hw = ad714x->hw;
-	struct ad714x_driver_data *sw = ad714x->sw;
-	int i;
-
-	free_irq(ad714x->irq, ad714x);
-
-	/* unregister and free all input devices */
-
-	for (i = 0; i < hw->slider_num; i++)
-		input_unregister_device(sw->slider[i].input);
-
-	for (i = 0; i < hw->wheel_num; i++)
-		input_unregister_device(sw->wheel[i].input);
-
-	for (i = 0; i < hw->touchpad_num; i++)
-		input_unregister_device(sw->touchpad[i].input);
-
-	if (hw->button_num)
-		input_unregister_device(sw->button[0].input);
-
-	kfree(ad714x);
-}
-EXPORT_SYMBOL(ad714x_remove);
-
 #ifdef CONFIG_PM
 int ad714x_disable(struct ad714x_chip *ad714x)
 {
diff --git a/drivers/input/misc/ad714x.h b/drivers/input/misc/ad714x.h
index 3c85455..5d65d30 100644
--- a/drivers/input/misc/ad714x.h
+++ b/drivers/input/misc/ad714x.h
@@ -50,6 +50,5 @@ int ad714x_disable(struct ad714x_chip *ad714x);
 int ad714x_enable(struct ad714x_chip *ad714x);
 struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 				 ad714x_read_t read, ad714x_write_t write);
-void ad714x_remove(struct ad714x_chip *ad714x);
 
 #endif

-- 
Dmitry
