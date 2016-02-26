From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: gpio_keys_polled - keep button data constant
Date: Fri, 26 Feb 2016 10:50:31 -0800
Message-ID: <20160226185031.GA17815@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Commit 633a21d80b4a ("input: gpio_keys_polled: Add support for GPIO
descriptors") placed gpio descriptor into gpio_keys_button structure, which
is supposed to be part of platform data and not modifiable by the driver.
To keep the data constant, let's move the descriptor to
gpio_keys_button_data structure instead.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Compiled only, I do not have devices with polled keys...

 drivers/input/keyboard/gpio_keys_polled.c | 104 ++++++++++++++++--------------
 include/linux/gpio_keys.h                 |   4 +-
 2 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 62bdb1d..daef8ea 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -30,6 +30,7 @@
 #define DRV_NAME	"gpio-keys-polled"
 
 struct gpio_keys_button_data {
+	struct gpio_desc *gpiod;
 	int last_state;
 	int count;
 	int threshold;
@@ -46,7 +47,7 @@ struct gpio_keys_polled_dev {
 };
 
 static void gpio_keys_button_event(struct input_polled_dev *dev,
-				   struct gpio_keys_button *button,
+				   const struct gpio_keys_button *button,
 				   int state)
 {
 	struct gpio_keys_polled_dev *bdev = dev->private;
@@ -70,15 +71,15 @@ static void gpio_keys_button_event(struct input_polled_dev *dev,
 }
 
 static void gpio_keys_polled_check_state(struct input_polled_dev *dev,
-					 struct gpio_keys_button *button,
+					 const struct gpio_keys_button *button,
 					 struct gpio_keys_button_data *bdata)
 {
 	int state;
 
 	if (bdata->can_sleep)
-		state = !!gpiod_get_value_cansleep(button->gpiod);
+		state = !!gpiod_get_value_cansleep(bdata->gpiod);
 	else
-		state = !!gpiod_get_value(button->gpiod);
+		state = !!gpiod_get_value(bdata->gpiod);
 
 	gpio_keys_button_event(dev, button, state);
 
@@ -142,48 +143,35 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
 		pdata->disable(bdev->dev);
 }
 
-static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct device *dev)
+static struct gpio_keys_platform_data *
+gpio_keys_polled_get_devtree_pdata(struct device *dev)
 {
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
 	struct fwnode_handle *child;
-	int error;
 	int nbuttons;
 
 	nbuttons = device_get_child_node_count(dev);
 	if (nbuttons == 0)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata) + nbuttons * sizeof(*button),
 			     GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
+	button = (struct gpio_keys_button *)(pdata + 1);
+
+	pdata->buttons = button;
+	pdata->nbuttons = nbuttons;
 
 	pdata->rep = device_property_present(dev, "autorepeat");
 	device_property_read_u32(dev, "poll-interval", &pdata->poll_interval);
 
 	device_for_each_child_node(dev, child) {
-		struct gpio_desc *desc;
-
-		desc = devm_get_gpiod_from_child(dev, NULL, child);
-		if (IS_ERR(desc)) {
-			error = PTR_ERR(desc);
-			if (error != -EPROBE_DEFER)
-				dev_err(dev,
-					"Failed to get gpio flags, error: %d\n",
-					error);
-			fwnode_handle_put(child);
-			return ERR_PTR(error);
-		}
-
-		button = &pdata->buttons[pdata->nbuttons++];
-		button->gpiod = desc;
-
-		if (fwnode_property_read_u32(child, "linux,code", &button->code)) {
-			dev_err(dev, "Button without keycode: %d\n",
-				pdata->nbuttons - 1);
+		if (fwnode_property_read_u32(child, "linux,code",
+					     &button->code)) {
+			dev_err(dev, "button without keycode\n");
 			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
@@ -206,10 +194,9 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 		if (fwnode_property_read_u32(child, "debounce-interval",
 					     &button->debounce_interval))
 			button->debounce_interval = 5;
-	}
 
-	if (pdata->nbuttons == 0)
-		return ERR_PTR(-EINVAL);
+		button++;
+	}
 
 	return pdata;
 }
@@ -220,7 +207,7 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 	int i, min = 0, max = 0;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		struct gpio_keys_button *button = &pdata->buttons[i];
+		const struct gpio_keys_button *button = &pdata->buttons[i];
 
 		if (button->type != EV_ABS || button->code != code)
 			continue;
@@ -230,6 +217,7 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 		if (button->value > max)
 			max = button->value;
 	}
+
 	input_set_abs_params(input, code, min, max, 0, 0);
 }
 
@@ -242,6 +230,7 @@ MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
 static int gpio_keys_polled_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct fwnode_handle *child = NULL;
 	const struct gpio_keys_platform_data *pdata = dev_get_platdata(dev);
 	struct gpio_keys_polled_dev *bdev;
 	struct input_polled_dev *poll_dev;
@@ -254,10 +243,6 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		pdata = gpio_keys_polled_get_devtree_pdata(dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		if (!pdata) {
-			dev_err(dev, "missing platform data\n");
-			return -EINVAL;
-		}
 	}
 
 	if (!pdata->poll_interval) {
@@ -300,7 +285,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		__set_bit(EV_REP, input->evbit);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		struct gpio_keys_button *button = &pdata->buttons[i];
+		const struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_keys_button_data *bdata = &bdev->data[i];
 		unsigned int type = button->type ?: EV_KEY;
 
@@ -309,11 +294,30 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		/*
-		 * Legacy GPIO number so request the GPIO here and
-		 * convert it to descriptor.
-		 */
-		if (!button->gpiod && gpio_is_valid(button->gpio)) {
+		if (!dev_get_platdata(dev)) {
+			/* No legacy static platform data */
+			child = device_get_next_child_node(dev, child);
+			if (!child) {
+				dev_err(dev, "missing child device node\n");
+				return -EINVAL;
+			}
+
+			bdata->gpiod = devm_get_gpiod_from_child(dev, NULL,
+								 child);
+			if (IS_ERR(bdata->gpiod)) {
+				error = PTR_ERR(bdata->gpiod);
+				if (error != -EPROBE_DEFER)
+					dev_err(dev,
+						"failed to get gpio: %d\n",
+						error);
+				fwnode_handle_put(child);
+				return error;
+			}
+		} else if (gpio_is_valid(button->gpio)) {
+			/*
+			 * Legacy GPIO number so request the GPIO here and
+			 * convert it to descriptor.
+			 */
 			unsigned flags = GPIOF_IN;
 
 			if (button->active_low)
@@ -322,18 +326,22 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 			error = devm_gpio_request_one(&pdev->dev, button->gpio,
 					flags, button->desc ? : DRV_NAME);
 			if (error) {
-				dev_err(dev, "unable to claim gpio %u, err=%d\n",
+				dev_err(dev,
+					"unable to claim gpio %u, err=%d\n",
 					button->gpio, error);
 				return error;
 			}
 
-			button->gpiod = gpio_to_desc(button->gpio);
+			bdata->gpiod = gpio_to_desc(button->gpio);
+			if (!bdata->gpiod) {
+				dev_err(dev,
+					"unable to convert gpio %u to descriptor\n",
+					button->gpio);
+				return -EINVAL;
+			}
 		}
 
-		if (IS_ERR(button->gpiod))
-			return PTR_ERR(button->gpiod);
-
-		bdata->can_sleep = gpiod_cansleep(button->gpiod);
+		bdata->can_sleep = gpiod_cansleep(bdata->gpiod);
 		bdata->last_state = -1;
 		bdata->threshold = DIV_ROUND_UP(button->debounce_interval,
 						pdata->poll_interval);
@@ -344,6 +352,8 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 							button->code);
 	}
 
+	fwnode_handle_put(child);
+
 	bdev->poll_dev = poll_dev;
 	bdev->dev = dev;
 	bdev->pdata = pdata;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ee2d8c6..d1250ad 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -2,7 +2,6 @@
 #define _GPIO_KEYS_H
 
 struct device;
-struct gpio_desc;
 
 /**
  * struct gpio_keys_button - configuration parameters
@@ -31,7 +30,6 @@ struct gpio_keys_button {
 	bool can_disable;
 	int value;
 	unsigned int irq;
-	struct gpio_desc *gpiod;
 };
 
 /**
@@ -46,7 +44,7 @@ struct gpio_keys_button {
  * @name:		input device name
  */
 struct gpio_keys_platform_data {
-	struct gpio_keys_button *buttons;
+	const struct gpio_keys_button *buttons;
 	int nbuttons;
 	unsigned int poll_interval;
 	unsigned int rep:1;
-- 
2.7.0.rc3.207.g0ac5344


-- 
Dmitry
