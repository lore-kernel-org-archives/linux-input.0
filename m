From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 6/6] fixup gpio_buttons : rename gpio-buttons / gpio_buttons to gpio-keys-polled / gpio_keys_polled
Date: Wed, 24 Nov 2010 16:01:40 -0500
Message-ID: <63087524a2badfeebc597925b45fcb6af9e7331f.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:53386 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:52 -0500
Received: by mail-gy0-f176.google.com with SMTP id 1so118030gyf.21
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:52 -0800 (PST)
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org


Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 drivers/input/keyboard/Kconfig                     |    4 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 .../{gpio_buttons.c => gpio_keys_polled.c}         |   68 ++++++++++----------
 .../linux/{gpio_buttons.h => gpio_keys_polled.h}   |    2 +-
 4 files changed, 38 insertions(+), 38 deletions(-)
 rename drivers/input/keyboard/{gpio_buttons.c => gpio_keys_polled.c} (71%)
 rename include/linux/{gpio_buttons.h => gpio_keys_polled.h} (94%)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4ab13fc..9648ff4 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -485,8 +485,8 @@ config KEYBOARD_W90P910
 	  To compile this driver as a module, choose M here: the
 	  module will be called w90p910_keypad.
 
-config INPUT_GPIO_BUTTONS
-	tristate "Polled GPIO buttons interface"
+config KEYBOARD_GPIO_POLLED
+	tristate "Polled GPIO buttons"
 	depends on GENERIC_GPIO
 	select INPUT_POLLDEV
 	help
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 2a52e0c..e6da817 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -44,5 +44,5 @@ obj-$(CONFIG_KEYBOARD_TNETV107X)	+= tnetv107x-keypad.o
 obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
-obj-$(CONFIG_INPUT_GPIO_BUTTONS)	+= gpio_buttons.o
+obj-$(CONFIG_KEYBOARD_GPIO_POLLED)	+= gpio_keys_polled.o
 
diff --git a/drivers/input/keyboard/gpio_buttons.c b/drivers/input/keyboard/gpio_keys_polled.c
similarity index 71%
rename from drivers/input/keyboard/gpio_buttons.c
rename to drivers/input/keyboard/gpio_keys_polled.c
index 0859b4d..390ed93 100644
--- a/drivers/input/keyboard/gpio_buttons.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -25,25 +25,25 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/gpio_buttons.h>
+#include <linux/gpio_keys_polled.h>
 
-#define DRV_NAME	"gpio-buttons"
+#define DRV_NAME	"gpio-keys-polled"
 
-struct gpio_button_data {
+struct gpio_keys_button_data {
 	int last_state;
 	int count;
 	int can_sleep;
 };
 
-struct gpio_buttons_dev {
+struct gpio_keys_polled_dev {
 	struct input_polled_dev *poll_dev;
-	struct gpio_buttons_platform_data *pdata;
-	struct gpio_button_data *data;
+	struct gpio_keys_polled_platform_data *pdata;
+	struct gpio_keys_button_data *data;
 };
 
-static void gpio_buttons_check_state(struct input_dev *input,
+static void gpio_keys_polled_check_state(struct input_dev *input,
 				      struct gpio_keys_button *button,
-				      struct gpio_button_data *bdata)
+				      struct gpio_keys_button_data *bdata)
 {
 	int state;
 
@@ -63,16 +63,16 @@ static void gpio_buttons_check_state(struct input_dev *input,
 	}
 }
 
-static void gpio_buttons_poll(struct input_polled_dev *dev)
+static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 {
-	struct gpio_buttons_dev *bdev = dev->private;
-	struct gpio_buttons_platform_data *pdata = bdev->pdata;
+	struct gpio_keys_polled_dev *bdev = dev->private;
+	struct gpio_keys_polled_platform_data *pdata = bdev->pdata;
 	struct input_dev *input = dev->input;
 	int i, threshold;
 
 	for (i = 0; i < bdev->pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
-		struct gpio_button_data *bdata = &bdev->data[i];
+		struct gpio_keys_button_data *bdata = &bdev->data[i];
 
 		threshold = round_up(button->debounce_interval,
 				pdata->poll_interval) /
@@ -80,16 +80,16 @@ static void gpio_buttons_poll(struct input_polled_dev *dev)
 		if (bdata->count < threshold)
 			bdata->count++;
 		else
-			gpio_buttons_check_state(input, button, bdata);
+			gpio_keys_polled_check_state(input, button, bdata);
 
 	}
 }
 
-static int __devinit gpio_buttons_probe(struct platform_device *pdev)
+static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 {
-	struct gpio_buttons_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_polled_platform_data *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
-	struct gpio_buttons_dev *bdev;
+	struct gpio_keys_polled_dev *bdev;
 	struct input_polled_dev *poll_dev;
 	struct input_dev *input;
 	int error;
@@ -98,15 +98,15 @@ static int __devinit gpio_buttons_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENXIO;
 
-	bdev = kzalloc(sizeof(struct gpio_buttons_dev) +
-		       pdata->nbuttons * sizeof(struct gpio_button_data),
+	bdev = kzalloc(sizeof(struct gpio_keys_polled_dev) +
+		       pdata->nbuttons * sizeof(struct gpio_keys_button_data),
 		       GFP_KERNEL);
 	if (!bdev) {
 		dev_err(dev, "no memory for private data\n");
 		return -ENOMEM;
 	}
 
-	bdev->data = (struct gpio_button_data *) &bdev[1];
+	bdev->data = (struct gpio_keys_button_data *) &bdev[1];
 
 	poll_dev = input_allocate_polled_device();
 	if (!poll_dev) {
@@ -116,14 +116,14 @@ static int __devinit gpio_buttons_probe(struct platform_device *pdev)
 	}
 
 	poll_dev->private = bdev;
-	poll_dev->poll = gpio_buttons_poll;
+	poll_dev->poll = gpio_keys_polled_poll;
 	poll_dev->poll_interval = pdata->poll_interval;
 
 	input = poll_dev->input;
 
 	input->evbit[0] = BIT(EV_KEY);
 	input->name = pdev->name;
-	input->phys = "gpio-buttons/input0";
+	input->phys = DRV_NAME"/input0";
 	input->dev.parent = &pdev->dev;
 
 	input->id.bustype = BUS_HOST;
@@ -176,7 +176,7 @@ static int __devinit gpio_buttons_probe(struct platform_device *pdev)
 
 	/* report initial state of the buttons */
 	for (i = 0; i < pdata->nbuttons; i++)
-		gpio_buttons_check_state(input, &pdata->buttons[i],
+		gpio_keys_polled_check_state(input, &pdata->buttons[i],
 					 &bdev->data[i]);
 
 	return 0;
@@ -194,10 +194,10 @@ err_free_bdev:
 	return error;
 }
 
-static int __devexit gpio_buttons_remove(struct platform_device *pdev)
+static int __devexit gpio_keys_polled_remove(struct platform_device *pdev)
 {
-	struct gpio_buttons_dev *bdev = platform_get_drvdata(pdev);
-	struct gpio_buttons_platform_data *pdata = bdev->pdata;
+	struct gpio_keys_polled_dev *bdev = platform_get_drvdata(pdev);
+	struct gpio_keys_polled_platform_data *pdata = bdev->pdata;
 	int i;
 
 	input_unregister_polled_device(bdev->poll_dev);
@@ -213,27 +213,27 @@ static int __devexit gpio_buttons_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver gpio_buttons_driver = {
-	.probe	= gpio_buttons_probe,
-	.remove	= __devexit_p(gpio_buttons_remove),
+static struct platform_driver gpio_keys_polled_driver = {
+	.probe	= gpio_keys_polled_probe,
+	.remove	= __devexit_p(gpio_keys_polled_remove),
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
 	},
 };
 
-static int __init gpio_buttons_init(void)
+static int __init gpio_keys_polled_init(void)
 {
-	return platform_driver_register(&gpio_buttons_driver);
+	return platform_driver_register(&gpio_keys_polled_driver);
 }
 
-static void __exit gpio_buttons_exit(void)
+static void __exit gpio_keys_polled_exit(void)
 {
-	platform_driver_unregister(&gpio_buttons_driver);
+	platform_driver_unregister(&gpio_keys_polled_driver);
 }
 
-module_init(gpio_buttons_init);
-module_exit(gpio_buttons_exit);
+module_init(gpio_keys_polled_init);
+module_exit(gpio_keys_polled_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_keys_polled.h
similarity index 94%
rename from include/linux/gpio_buttons.h
rename to include/linux/gpio_keys_polled.h
index f7f1467..bf7f94a 100644
--- a/include/linux/gpio_buttons.h
+++ b/include/linux/gpio_keys_polled.h
@@ -17,7 +17,7 @@
 
 #include <linux/gpio_keys.h>
 
-struct gpio_buttons_platform_data {
+struct gpio_keys_polled_platform_data {
 	struct gpio_keys_button *buttons;
 	int	nbuttons;		/* number of buttons */
 	int	poll_interval;		/* polling interval in msecs*/
-- 
1.7.0.4

