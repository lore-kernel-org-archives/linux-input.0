From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] input: touchscreen: Add LED trigger support to the softbutton code
Date: Sun, 31 Jul 2016 17:23:08 +0200
Message-ID: <1469978590-14081-3-git-send-email-hdegoede@redhat.com>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469978590-14081-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

In some hardware there are 1 or more LEDs behind the touchscreen
softbuttons, which are intended to provide visual feedback to the
user that the softbutton has been pressed, this commit adds support
for this.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/input/touchscreen/softbuttons.txt     |  4 ++
 drivers/input/touchscreen/softbuttons.c            | 49 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
index 3eb6f4c..b425b95 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
@@ -17,6 +17,10 @@ Required subnode-properties:
  - softbutton-min-y		: Y start of the area the softbutton area covers
  - softbutton-max-y		: Y end of the area the softbutton area covers
 
+Optional subnode-properties:
+- linux,led-trigger		: String for a LED trigger for providing visual
+				  feedback that the softbutton has been pressed
+
 Example:
 
 #include <dt-bindings/input/input.h>
diff --git a/drivers/input/touchscreen/softbuttons.c b/drivers/input/touchscreen/softbuttons.c
index 47aea18..9a3fbfa 100644
--- a/drivers/input/touchscreen/softbuttons.c
+++ b/drivers/input/touchscreen/softbuttons.c
@@ -11,6 +11,7 @@
 
 #include <linux/input.h>
 #include <linux/input/touchscreen.h>
+#include <linux/leds.h>
 #include <linux/of.h>
 
 struct touchscreen_softbutton {
@@ -19,6 +20,8 @@ struct touchscreen_softbutton {
 	u32 min_y;
 	u32 max_y;
 	u32 keycode;
+	const char *ledtrigger_name;
+	struct led_trigger *ledtrigger;
 };
 
 struct touchscreen_softbutton_info {
@@ -48,7 +51,7 @@ struct touchscreen_softbutton_info *devm_touchscreen_alloc_softbuttons(
 	struct device *dev = input->dev.parent;
 	struct device_node *np, *pp;
 	struct touchscreen_softbutton_info *info;
-	int i, err, button_count;
+	int i, j, err, button_count;
 
 	np = dev->of_node;
 	if (!np)
@@ -103,6 +106,36 @@ struct touchscreen_softbutton_info *devm_touchscreen_alloc_softbuttons(
 			dev_err(dev, "%s: Inval max-y prop\n", pp->name);
 			return ERR_PTR(-EINVAL);
 		}
+
+		err = of_property_read_string(pp, "linux,led-trigger",
+					      &btn->ledtrigger_name);
+		if (err)
+			continue; /* The LED trigger is optional */
+
+		/* Check if another softbutton uses the same trigger */
+		for (j = 0; j < i; j++) {
+			if (info->buttons[j].ledtrigger_name &&
+			    strcmp(info->buttons[j].ledtrigger_name,
+				   btn->ledtrigger_name) == 0) {
+				btn->ledtrigger = info->buttons[j].ledtrigger;
+				break;
+			}
+		}
+		if (!btn->ledtrigger) {
+			btn->ledtrigger =
+				devm_kzalloc(dev, sizeof(*btn->ledtrigger),
+					     GFP_KERNEL);
+			if (!btn->ledtrigger)
+				return ERR_PTR(-ENOMEM);
+
+			btn->ledtrigger->name = btn->ledtrigger_name;
+			err = devm_led_trigger_register(dev, btn->ledtrigger);
+			if (err) {
+				dev_err(dev, "%s: Ledtrigger register error\n",
+					pp->name);
+				return ERR_PTR(err);
+			}
+		}
 	}
 
 	__set_bit(EV_KEY, input->evbit);
@@ -126,6 +159,7 @@ bool touchscreen_handle_softbuttons(struct touchscreen_softbutton_info *info,
 				    unsigned int x, unsigned int y, bool down)
 {
 	int i;
+	unsigned long led_delay = 1000; /* Keep the led on 1s after release */
 
 	if (info == NULL)
 		return false;
@@ -137,6 +171,19 @@ bool touchscreen_handle_softbuttons(struct touchscreen_softbutton_info *info,
 		    y <= info->buttons[i].max_y) {
 			input_report_key(info->input,
 					 info->buttons[i].keycode, down);
+
+			if (info->buttons[i].ledtrigger && down) {
+				led_trigger_event(info->buttons[i].ledtrigger,
+						  LED_FULL);
+			} else if (info->buttons[i].ledtrigger && !down) {
+				/* Led must be off before calling blink */
+				led_trigger_event(info->buttons[i].ledtrigger,
+						  LED_OFF);
+				led_trigger_blink_oneshot(
+					info->buttons[i].ledtrigger,
+					&led_delay, &led_delay, 0);
+			}
+
 			return true;
 		}
 	}
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
