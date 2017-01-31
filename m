From: Hans Holmberg <hans@pixelmunchies.com>
Subject: [RFC PATCH v2] Input: gpio_keys - add dt abs/rel button support
Date: Tue, 31 Jan 2017 08:55:19 +0100
Message-ID: <20170131075516.GA4462@Gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sub5.mail.dreamhost.com ([208.113.200.129]:40562 "EHLO
        homiemail-a44.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750790AbdAaHzY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 02:55:24 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

This change adds support for specifying device tree buttons emitting
abs/rel events.

ABS events were previously supported, but only via platform data, so add
the missing device tree property to allow axis values to be emitted with
abs/rel events.

Also emit 0 on button releases for REL and ABS keys. This is a must-have
for supporting digital joysticks, and aligns the driver whith
gpio-keys-polled.

Finally, report min/max values for abs axes to the input framework.

Signed-off-by: Hans Holmberg <hans@pixelmunchies.com>
---

RFC because it alters the behaviour of abs-buttons making them
un-sticky, reporting 0 on button releases - just like gpio-keys-polled.

FWIW, i've looked through the in-tree board files and not found a
single occurence of abs gpio-buttons.

Changes since v1:
* Corrected cc list - now the mailing lists are looped in.

 .../devicetree/bindings/input/gpio-keys.txt        | 50 +++++++++++++++++++++-
 drivers/input/keyboard/gpio_keys.c                 | 29 +++++++++++--
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a949404..1b53eed 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -22,6 +22,13 @@ both at the same time. Specifying both properties is allowed.
 Optional subnode-properties:
 	- linux,input-type: Specify event type this button/key generates.
 	  If not specified defaults to <1> == EV_KEY.
+	- linux,input-value: If linux,input-type is EV_ABS or EV_REL then this
+	  value is sent for events this button generates when pressed.
+	  EV_ABS/EV_REL axis will generate an event with a value of 0 when
+	  all buttons with linux,input-type == type and linux,code == axis
+	  are released. This value is interpreted as a signed 32 bit value,
+	  e.g. to make a button generate a value of -1 use:
+	  linux,input-value = <0xffffffff>; /* -1 */
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
@@ -47,4 +54,45 @@ Example nodes:
 				linux,code = <108>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
-			...
+	...
+
+	gpio-joystick: {
+			compatible = "gpio-keys";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&my_pins>;
+
+			up {
+				gpios = <&gpio 26 1>;
+				linux,input-type = <EV_ABS>;
+				linux,code = <ABS_Y>;
+				linux,input-value = <0xffffffff>;
+			};
+
+			down {
+				gpios = <&gpio 13 1>;
+				linux,input-type = <EV_ABS>;
+				linux,code = <ABS_Y>;
+				linux,input-value = <1>;
+			};
+
+			left {
+				gpios = <&gpio 6 1>;
+				linux,input-type = <EV_ABS>;
+				linux,code = <ABS_X>;
+				linux,input-value = <0xffffffff>;
+			};
+
+			right {
+				gpios = <&gpio 5 1>;
+				linux,input-type = <EV_ABS>;
+				linux,code = <ABS_X>;
+				linux,input-value = <0x1>;
+			};
+
+			trigger_button {
+				gpios = <&gpio 12 1>;
+				linux,code = <BTN_TRIGGER>;
+			};
+	};
+	...
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 9c92cdf..06d6902 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -370,9 +370,11 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 		return;
 	}
 
-	if (type == EV_ABS) {
+	if (type == EV_ABS || type == EV_REL) {
 		if (state)
 			input_event(input, type, button->code, button->value);
+		else
+			input_event(input, type, button->code, 0);
 	} else {
 		input_event(input, type, *bdata->code, state);
 	}
@@ -584,6 +586,14 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	*bdata->code = button->code;
 	input_set_capability(input, button->type ?: EV_KEY, *bdata->code);
 
+	if (button->type == EV_ABS) {
+		if (input_abs_get_max(input, button->code) < button->value)
+			input_abs_set_max(input, button->code, button->value);
+
+		if (input_abs_get_min(input, button->code) > button->value)
+			input_abs_set_min(input, button->code, button->value);
+	}
+
 	/*
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
@@ -667,6 +677,7 @@ static void gpio_keys_close(struct input_dev *input)
 	struct gpio_keys_button *button;
 	struct fwnode_handle *child;
 	int nbuttons;
+	int error;
 
 	nbuttons = device_get_child_node_count(dev);
 	if (nbuttons == 0)
@@ -701,9 +712,21 @@ static void gpio_keys_close(struct input_dev *input)
 
 		fwnode_property_read_string(child, "label", &button->desc);
 
-		if (fwnode_property_read_u32(child, "linux,input-type",
-					     &button->type))
+		error = fwnode_property_read_u32(child, "linux,input-type",
+					     &button->type);
+		if (error) {
 			button->type = EV_KEY;
+		} else {
+			error = fwnode_property_read_u32(child,
+						     "linux,input-value",
+						     &button->value);
+			if ((button->type == EV_ABS || button->type == EV_REL)
+			    && error) {
+				dev_err(dev,
+					"EV_ABS/EV_REL button without value\n");
+				return ERR_PTR(-EINVAL);
+			}
+		}
 
 		button->wakeup =
 			fwnode_property_read_bool(child, "wakeup-source") ||
-- 
1.9.1

