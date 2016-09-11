From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH resend 1/5] input: touchscreen: Add generic touchscreen softbutton handling code
Date: Sun, 11 Sep 2016 20:44:04 +0200
Message-ID: <20160911184408.11657-2-hdegoede@redhat.com>
References: <20160911184408.11657-1-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160911184408.11657-1-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Some touchscreens extend over the display they cover and have a number
of capacative softbuttons outside of the display the cover.

With some hardware these softbuttons simply report touches with
coordinates outside of the normal coordinate space for touches on the
display.

This commit adds a devicetree binding for describing such buttons in
devicetree and a bunch of helper functions to easily add support for
these to existing touchscreen drivers.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/input/touchscreen/softbuttons.txt     |  58 +++++++++
 drivers/input/touchscreen/Makefile                 |   2 +-
 drivers/input/touchscreen/softbuttons.c            | 145 +++++++++++++++++++++
 include/linux/input/touchscreen.h                  |   9 ++
 4 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
 create mode 100644 drivers/input/touchscreen/softbuttons.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
new file mode 100644
index 0000000..3eb6f4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
@@ -0,0 +1,58 @@
+General Touchscreen Softbutton Properties:
+
+Some touchscreens extend over the display they cover and have a number
+of capacative softbuttons outside of the display the cover.
+
+Some of these softbuttons simply report touches with coordinates outside of
+the normal coordinate space for touches on the display. This binding is for
+describing such buttons in devicetree.
+
+Each softkey is represented as a sub-node of the touchscreen node.
+
+Required subnode-properties:
+ - label			: Descriptive name of the key.
+ - linux,code			: Keycode to emit.
+ - softbutton-min-x		: X start of the area the softbutton area covers
+ - softbutton-max-x		: X end of the area the softbutton area covers
+ - softbutton-min-y		: Y start of the area the softbutton area covers
+ - softbutton-max-y		: Y end of the area the softbutton area covers
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+&i2c2 {
+	ft5406ee8: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <768>;
+
+		button@0 {
+			label = "Esc";
+			linux,code = <KEY_ESC>;
+			softbutton-min-x = <1084>;
+			softbutton-max-x = <1098>;
+			softbutton-min-y = <0>;
+			softbutton-max-y = <49>;
+		};
+
+		button@1 {
+			label = "Home";
+			linux,code = <KEY_HOMEPAGE>;
+			softbutton-min-x = <1084>;
+			softbutton-max-x = <1098>;
+			softbutton-min-y = <50>;
+			softbutton-max-y = <99>;
+		};
+
+		button@2 {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			softbutton-min-x = <1084>;
+			softbutton-max-x = <1098>;
+			softbutton-min-y = <100>;
+			softbutton-max-y = <149>;
+		};
+	};
+};
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 57a1c09..33b2eb8 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -6,7 +6,7 @@
 
 wm97xx-ts-y := wm97xx-core.o
 
-obj-$(CONFIG_TOUCHSCREEN_PROPERTIES)	+= of_touchscreen.o
+obj-$(CONFIG_TOUCHSCREEN_PROPERTIES)	+= of_touchscreen.o softbuttons.o
 obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
diff --git a/drivers/input/touchscreen/softbuttons.c b/drivers/input/touchscreen/softbuttons.c
new file mode 100644
index 0000000..47aea18
--- /dev/null
+++ b/drivers/input/touchscreen/softbuttons.c
@@ -0,0 +1,145 @@
+/*
+ * touchscreen softbutton helper functions
+ *
+ * Copyright (c) 2016 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/of.h>
+
+struct touchscreen_softbutton {
+	u32 min_x;
+	u32 max_x;
+	u32 min_y;
+	u32 max_y;
+	u32 keycode;
+};
+
+struct touchscreen_softbutton_info {
+	struct input_dev *input;
+	struct touchscreen_softbutton *buttons;
+	int button_count;
+};
+
+/**
+ * devm_touchscreen_alloc_softbuttons - allocate softbuttons
+ * @input: touchscreen input device for which softbuttons should be allocated
+ *
+ * This function parses touschcreen softbutton DT properties for touchscreens
+ * and allocates and fill a touchscreen_softbutton_info struct if any
+ * softbuttons are found.
+ *
+ * Returns prepared struct touchscreen_softbutton_info on success,
+ * %NULL if no softbuttons were found (this is not an error) or a ERR_PTR
+ * in case of an error.
+ *
+ * Note as this is a devm function the returned pointer does not need to
+ * be freed.
+ */
+struct touchscreen_softbutton_info *devm_touchscreen_alloc_softbuttons(
+					struct input_dev *input)
+{
+	struct device *dev = input->dev.parent;
+	struct device_node *np, *pp;
+	struct touchscreen_softbutton_info *info;
+	int i, err, button_count;
+
+	np = dev->of_node;
+	if (!np)
+		return NULL;
+
+	button_count = of_get_child_count(np);
+	if (button_count == 0)
+		return NULL;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->input = input;
+	info->button_count = button_count;
+	info->buttons = devm_kzalloc(dev, button_count * sizeof(*info->buttons),
+				     GFP_KERNEL);
+	if (!info->buttons)
+		return ERR_PTR(-ENOMEM);
+
+	for (pp = of_get_next_child(np, NULL), i = 0;
+	     pp != NULL;
+	     pp = of_get_next_child(np, pp), i++) {
+		struct touchscreen_softbutton *btn = &info->buttons[i];
+
+		err = of_property_read_u32(pp, "linux,code", &btn->keycode);
+		if (err) {
+			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
+			return ERR_PTR(-EINVAL);
+		}
+
+		err = of_property_read_u32(pp, "softbutton-min-x", &btn->min_x);
+		if (err) {
+			dev_err(dev, "%s: Inval min-x prop\n", pp->name);
+			return ERR_PTR(-EINVAL);
+		}
+
+		err = of_property_read_u32(pp, "softbutton-max-x", &btn->max_x);
+		if (err) {
+			dev_err(dev, "%s: Inval max-x prop\n", pp->name);
+			return ERR_PTR(-EINVAL);
+		}
+
+		err = of_property_read_u32(pp, "softbutton-min-y", &btn->min_y);
+		if (err) {
+			dev_err(dev, "%s: Inval min-y prop\n", pp->name);
+			return ERR_PTR(-EINVAL);
+		}
+
+		err = of_property_read_u32(pp, "softbutton-max-y", &btn->max_y);
+		if (err) {
+			dev_err(dev, "%s: Inval max-y prop\n", pp->name);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	__set_bit(EV_KEY, input->evbit);
+	for (i = 0; i < info->button_count; i++)
+		__set_bit(info->buttons[i].keycode, input->keybit);
+
+	return info;
+}
+
+/**
+ * touchscreen_handle_softbuttons - check for softbutton press
+ * @info: softbutton info retured by devm_touchscreen_alloc_softbuttons.
+ *
+ * This function checks if the passed in coordinates match any softbutton,
+ * and when they do reports a key press / release for the softbutton.
+ *
+ * Returns true if the coordinates match a softbutton and a key press / release
+ * was reported, false otherwise.
+ */
+bool touchscreen_handle_softbuttons(struct touchscreen_softbutton_info *info,
+				    unsigned int x, unsigned int y, bool down)
+{
+	int i;
+
+	if (info == NULL)
+		return false;
+
+	for (i = 0; i < info->button_count; i++) {
+		if (x >= info->buttons[i].min_x &&
+		    x <= info->buttons[i].max_x &&
+		    y >= info->buttons[i].min_y &&
+		    y <= info->buttons[i].max_y) {
+			input_report_key(info->input,
+					 info->buttons[i].keycode, down);
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/include/linux/input/touchscreen.h b/include/linux/input/touchscreen.h
index 09d22cc..0b9d4ee 100644
--- a/include/linux/input/touchscreen.h
+++ b/include/linux/input/touchscreen.h
@@ -9,8 +9,11 @@
 #ifndef _TOUCHSCREEN_H
 #define _TOUCHSCREEN_H
 
+#include <linux/types.h>
+
 struct input_dev;
 struct input_mt_pos;
+struct touchscreen_softbutton_info;
 
 struct touchscreen_properties {
 	unsigned int max_x;
@@ -32,4 +35,10 @@ void touchscreen_report_pos(struct input_dev *input,
 			    unsigned int x, unsigned int y,
 			    bool multitouch);
 
+struct touchscreen_softbutton_info *devm_touchscreen_alloc_softbuttons(
+					struct input_dev *input);
+
+bool touchscreen_handle_softbuttons(struct touchscreen_softbutton_info *info,
+				    unsigned int x, unsigned int y, bool down);
+
 #endif
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
