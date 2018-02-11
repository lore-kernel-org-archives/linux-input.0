From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Sun, 11 Feb 2018 14:55:04 +0800
Message-ID: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lumotuwe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

On some platforms (such as Spreadtrum platform), the GPIO keys can only
be triggered by level type. So this patch introduces one property to
indicate if the GPIO trigger type is level trigger or edge trigger.

Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
Changes since v1:
 - Diable the GPIO irq until reversing the GPIO level type.
---
 .../devicetree/bindings/input/gpio-keys.txt        |    2 ++
 drivers/input/keyboard/gpio_keys.c                 |   26 +++++++++++++++++++-
 include/linux/gpio_keys.h                          |    1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a949404..e3104bd 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -29,6 +29,8 @@ Optional subnode-properties:
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
+	- gpio-key,level-trigger: Boolean, indicates that button's interrupt
+	  type is level trigger. Otherwise it is edge trigger as default.
 
 Example nodes:
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613d..218698a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -385,6 +385,20 @@ static void gpio_keys_gpio_work_func(struct work_struct *work)
 	struct gpio_button_data *bdata =
 		container_of(work, struct gpio_button_data, work.work);
 
+	if (bdata->button->level_trigger) {
+		unsigned int trigger =
+			irq_get_trigger_type(bdata->irq) & ~IRQF_TRIGGER_MASK;
+		int state = gpiod_get_raw_value_cansleep(bdata->gpiod);
+
+		if (state)
+			trigger |= IRQF_TRIGGER_LOW;
+		else
+			trigger |= IRQF_TRIGGER_HIGH;
+
+		irq_set_irq_type(bdata->irq, trigger);
+		enable_irq(bdata->irq);
+	}
+
 	gpio_keys_gpio_report_event(bdata);
 
 	if (bdata->button->wakeup)
@@ -397,6 +411,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != bdata->irq);
 
+	if (bdata->button->level_trigger)
+		disable_irq_nosync(bdata->irq);
+
 	if (bdata->button->wakeup) {
 		const struct gpio_keys_button *button = bdata->button;
 
@@ -566,7 +583,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
 
 		isr = gpio_keys_gpio_isr;
-		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		if (button->level_trigger)
+			irqflags = gpiod_is_active_low(bdata->gpiod) ?
+				IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
+		else
+			irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
 	} else {
 		if (!button->irq) {
@@ -721,6 +742,9 @@ static void gpio_keys_close(struct input_dev *input)
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
+		button->level_trigger =
+			fwnode_property_read_bool(child, "gpio-key,level-trigger");
+
 		if (fwnode_property_read_u32(child, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77..5095645 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -28,6 +28,7 @@ struct gpio_keys_button {
 	int wakeup;
 	int debounce_interval;
 	bool can_disable;
+	bool level_trigger;
 	int value;
 	unsigned int irq;
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
