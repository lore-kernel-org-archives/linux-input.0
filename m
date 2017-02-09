From: Hans Holmberg <hans@pixelmunchies.com>
Subject: [RFC PATCH v3] Input: gpio_keys - add dt abs/rel button support
Date: Thu, 9 Feb 2017 14:41:31 +0100
Message-ID: <20170209134128.GA3629@Gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This change adds support for specifying device tree buttons emitting
abs/rel events.

ABS events were previously supported, but only via platform data, so add
the missing device tree attribute to allow axis values to be emitted with
abs/rel events.

Also emit 0 on button releases for REL and ABS keys when all buttons of
the same type and axis are released. This is a must-have for supporting
digital joysticks.

Finally, report min/max values for abs axes to the input framework.

Signed-off-by: Hans Holmberg <hans@pixelmunchies.com>
---
Thanks for your comments, Rob, Dimitry.

Changes since v2:
* 0 is now only reported when no buttons on an axis is pressed. If several
  buttons on the same axis are pressed simultaneously, the value reported
  depends on the order the buttons are specified.
* joystick example removed from the dt binding doc
* rebased on top of next

Changes since v1:
* Corrected cc list - now the mailing lists are looped in.


I've updated the patch to report 0 only when there are no buttons
pressed on the same axis and removed the joystick dt binding example.

If there are more than one pressed button on a given axis, only one
value is reported, and that value is set depending on which order
the buttons have been specified in the device tree. My idea here is 
that the priority order is left to the dts-writer.

Note that gpio_keys_polled reports all pressed-button values on an axis
but this makes less sense to me, (what value is the user supposed to use?)

It would be nice to have the two drivers behave the same. Let me know
what you think.

gpio_keys_polled test: (as a reference)

Buttons defined(in this order)
Button A value = 1
Button B value = 2

Evtest:

[A down, B up]
Event: time 1486029549.621182, type 3 (EV_ABS), code 0 (ABS_X), value 1
Event: time 1486029549.621182, -------------- EV_SYN ------------

[A down, B down] 
Event: time 1486029558.201182, type 3 (EV_ABS), code 0 (ABS_X), value 2
Event: time 1486029558.201182, type 3 (EV_ABS), code 0 (ABS_X), value 1
Event: time 1486029558.201182, -------------- EV_SYN ------------
Event: time 1486029558.311190, type 3 (EV_ABS), code 0 (ABS_X), value 2
Event: time 1486029558.311190, type 3 (EV_ABS), code 0 (ABS_X), value 1
...

(this keeps on repeating)

[A down, B up]
<no events>

[A up, B up]
Event: time 1486029561.391175, type 3 (EV_ABS), code 0 (ABS_X), value 0
Event: time 1486029561.391175, -------------- EV_SYN ------------


Thanks, Hans

 .../devicetree/bindings/input/gpio-keys.txt        |  7 +++
 drivers/input/keyboard/gpio_keys.c                 | 55 +++++++++++++++++++---
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a949404..f496712 100644
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
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 9c92cdf..18b314c1 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -356,6 +356,26 @@ static DEVICE_ATTR(disabled_switches, S_IWUSR | S_IRUGO,
 	.attrs = gpio_keys_attrs,
 };
 
+static void gpio_keys_report_axis(struct input_dev *input, int type, int axis)
+{
+	int i;
+	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
+	int value = 0;
+
+	for (i = 0; i < ddata->pdata->nbuttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (bdata->gpiod &&
+		    !bdata->disabled &&
+		    bdata->key_pressed &&
+		    bdata->button->type == type &&
+		    *bdata->code == axis)
+			value = bdata->button->value;
+	}
+
+	input_event(input, type, axis, value);
+}
+
 static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 {
 	const struct gpio_keys_button *button = bdata->button;
@@ -370,12 +390,12 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 		return;
 	}
 
-	if (type == EV_ABS) {
-		if (state)
-			input_event(input, type, button->code, button->value);
-	} else {
+	bdata->key_pressed = state;
+	if (type == EV_ABS || type == EV_REL)
+		gpio_keys_report_axis(input, type, *bdata->code);
+	else
 		input_event(input, type, *bdata->code, state);
-	}
+
 	input_sync(input);
 }
 
@@ -584,6 +604,14 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	*bdata->code = button->code;
 	input_set_capability(input, button->type ?: EV_KEY, *bdata->code);
 
+	if (button->type == EV_ABS) {
+		if (input_abs_get_max(input, *bdata->code) < button->value)
+			input_abs_set_max(input, *bdata->code, button->value);
+
+		if (input_abs_get_min(input, *bdata->code) > button->value)
+			input_abs_set_min(input, *bdata->code, button->value);
+	}
+
 	/*
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
@@ -667,6 +695,7 @@ static void gpio_keys_close(struct input_dev *input)
 	struct gpio_keys_button *button;
 	struct fwnode_handle *child;
 	int nbuttons;
+	int error;
 
 	nbuttons = device_get_child_node_count(dev);
 	if (nbuttons == 0)
@@ -701,9 +730,21 @@ static void gpio_keys_close(struct input_dev *input)
 
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
