From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] Input: gpio-keys: add device tree probe support
Date: Tue, 19 Jul 2011 00:45:08 +0800
Message-ID: <1311007508-8096-3-git-send-email-shawn.guo@linaro.org>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33349 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab1GRQeX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 12:34:23 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so3245474iyb.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 09:34:23 -0700 (PDT)
In-Reply-To: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Phil Blundell <pb@handhelds.org>, Dmitry Torokhov <dtor@mail.ru>

It adds device tree probe support for gpio-keys driver.

One thing to note is that .enable/.disable hooks becomes unsupported
when the driver gets probed from device tree.  The reason why the
patch does not address that is primarily because there are only 2
out of over 120 boards using the hooks for the gpio-keys device.

board-4430sdp pulls up/down a gpio, while board-mop500 enables/disables
a regulator in that pair of hooks.  There is no common pattern at all,
so the patch leaves the hooks outside the device tree support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Phil Blundell <pb@handhelds.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 Documentation/devicetree/bindings/gpio/key.txt |   57 ++++++++++++++++
 drivers/input/keyboard/gpio_keys.c             |   83 +++++++++++++++++++++++-
 2 files changed, 139 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/key.txt

diff --git a/Documentation/devicetree/bindings/gpio/key.txt b/Documentation/devicetree/bindings/gpio/key.txt
new file mode 100644
index 0000000..36296c1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/key.txt
@@ -0,0 +1,57 @@
+* Keys connected to GPIO lines
+
+Required properties:
+- compatible : Should be "gpio-keys"
+
+Optional properties:
+- keys-auto-repeat : Indicates the support of Auto-Repeat
+
+Each key is represented as a sub-node of the gpio-keys device.  Each
+node's name represents the name of the corresponding key.
+
+Key sub-node properties:
+
+Required properties:
+- gpios : Should specify the key's GPIO.  Active low key should be
+  indicated using flags in the GPIO specifier.
+- linux,key-code : Should specify the key code defined by linux in
+  include/linux/input.h
+
+Optional properties:
+- label : Contains the label for this key
+- key-debounce-internal : Specifies debounce interval in milliseconds
+- key-axis-value : Specifies axis value for an absolute change event
+- key-is-switch : Indicates the key is used as a switch event
+- key-is-active-low : Indicates the key is active low
+- key-can-wakeup-system : Indicates the key is a wake-up source
+- key-can-be-disabled : Indicates the key can be disabled
+
+Examples:
+
+gpio-keys {
+	compatible = "gpio-keys";
+
+	power {
+		label = "Power Button";
+		gpios = <&gpio0 8 0>;
+		linux,key-code = <116>; /* KEY_POWER */
+		key-is-active-low;
+		key-can-wakeup-system;
+	};
+
+	volume-up {
+		label = "Volume Up";
+		gpios = <&gpio1 14 0>;
+		linux,key-code = <115>; /* KEY_VOLUMEUP */
+		key-is-active-low;
+		key-can-wakeup-system;
+	};
+
+	volume-down {
+		label = "Volume Down";
+		gpios = <&gpio1 15 0>;
+		linux,key-code = <114>; /* KEY_VOLUMEDOWN */
+		key-is-active-low;
+		key-can-wakeup-system;
+	};
+};
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 85b5685..2a79d40 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -25,6 +25,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 struct gpio_button_data {
 	struct gpio_keys_button button;
@@ -445,15 +447,93 @@ static void gpio_keys_close(struct input_dev *input)
 		ddata->disable(input->dev.parent);
 }
 
+#ifdef CONFIG_OF_GPIO
+static const struct of_device_id gpio_keys_dt_ids[] = {
+	{ .compatible = "gpio-keys", },
+	{ /* sentinel */ }
+};
+
+static struct gpio_keys_platform_data * __devinit gpio_keys_probe_pdata_dt(
+						struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node, *child;
+	struct gpio_keys_platform_data *pdata;
+	struct gpio_keys_button *button;
+	int count = 0;
+
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	/* count keys in this device, so we know how much to allocate */
+	for_each_child_of_node(np, child)
+		count++;
+	if (!count)
+		return ERR_PTR(-ENODEV);
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata) +
+			     sizeof(*button) * count, GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->buttons = (struct gpio_keys_button *) (pdata + 1);
+	pdata->nbuttons = count;
+
+	if (of_get_property(np, "keys-auto-repeat", NULL))
+		pdata->rep = 1;
+
+	button = pdata->buttons;
+	for_each_child_of_node(np, child) {
+		enum of_gpio_flags flags;
+
+		button->gpio = of_get_gpio_flags(child, 0, &flags);
+		of_property_read_string(child, "label", &button->desc);
+		of_property_read_u32(child, "linux,key-code", &button->code);
+		of_property_read_u32(child, "key-debounce-internal",
+				     &button->debounce_interval);
+		if (!of_property_read_u32(child, "key-axis-value",
+					  &button->value))
+			button->type = EV_ABS;
+		if (of_get_property(np, "key-is-switch", NULL))
+			button->type = EV_SW;
+		if (of_get_property(np, "key-is-active-low", NULL))
+			button->active_low = 1;
+		if (of_get_property(np, "key-can-wakeup-system", NULL))
+			button->wakeup = 1;
+		if (of_get_property(np, "key-can-be-disabled", NULL))
+			button->can_disable = 1;
+
+		button++;
+	}
+
+	return pdata;
+}
+#else /* CONFIG_OF_GPIO */
+#define of_gpio_keys_match NULL
+static inline struct gpio_keys_platform_data *gpio_keys_probe_pdata_dt(
+						struct platform_device *pdev)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_OF_GPIO */
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_drvdata *ddata;
 	struct device *dev = &pdev->dev;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
 
+	pdata = gpio_keys_probe_pdata_dt(pdev);
+	if (IS_ERR(pdata))
+		pdata = pdev->dev.platform_data;
+
+	if (IS_ERR_OR_NULL(pdata)) {
+		dev_err(dev, "failed to get platform data\n");
+		return PTR_ERR(pdata);
+	}
+
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
@@ -631,6 +711,7 @@ static struct platform_driver gpio_keys_device_driver = {
 #ifdef CONFIG_PM
 		.pm	= &gpio_keys_pm_ops,
 #endif
+		.of_match_table = gpio_keys_dt_ids,
 	}
 };
 
-- 
1.7.4.1

