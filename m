From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Wed, 28 Feb 2018 20:44:36 +0800
Message-ID: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: gregkh@linuxfoundation.org, lumotuwe@gmail.com, arvind.yadav.cs@gmail.com, josephl@nvidia.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de, baolin.wang@linaro.org
List-Id: linux-input@vger.kernel.org

On some platforms (such as Spreadtrum platform), the GPIO keys can only
be triggered by level type. So this patch introduces one property to
indicate if the GPIO trigger type is level trigger or edge trigger.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v2:
 - Use 'interrupt' property to indicate the irq type.

Changes since v1:
 - Diable the GPIO irq until reversing the GPIO level type.
---
 drivers/input/keyboard/gpio_keys.c |   32 ++++++++++++++++++++++++++++++--
 include/linux/gpio_keys.h          |    3 +++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613d..9e05c80 100644
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
@@ -696,10 +717,17 @@ static void gpio_keys_close(struct input_dev *input)
 	device_property_read_string(dev, "label", &pdata->name);
 
 	device_for_each_child_node(dev, child) {
-		if (is_of_node(child))
+		if (is_of_node(child)) {
 			button->irq =
 				irq_of_parse_and_map(to_of_node(child), 0);
 
+			if (button->irq)
+				button->level_trigger =
+					irq_get_trigger_type(button->irq) &
+					(IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW) ?
+					true : false;
+		}
+
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button->code)) {
 			dev_err(dev, "Button without keycode\n");
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77..1286136 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -16,6 +16,8 @@
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
+ * @level_trigger:	indicate if the button's interrupt type is
+ *			level trigger or not
  * @value:		axis value for %EV_ABS
  * @irq:		Irq number in case of interrupt keys
  */
@@ -28,6 +30,7 @@ struct gpio_keys_button {
 	int wakeup;
 	int debounce_interval;
 	bool can_disable;
+	bool level_trigger;
 	int value;
 	unsigned int irq;
 };
-- 
1.7.9.5
