From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Thu,  1 Mar 2018 15:36:18 +0800
Message-ID: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: gregkh@linuxfoundation.org, lumotuwe@gmail.com, arvind.yadav.cs@gmail.com, josephl@nvidia.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de, baolin.wang@linaro.org
List-Id: linux-input@vger.kernel.org

On some platforms (such as Spreadtrum platform), the GPIO keys can only
be triggered by level type. So this patch introduces one trigger_type to
indicate if the button's interrupt type is level trigger or edge trigger.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v3:
 - Remove the reserse level logic into gpio irqchip.
 - Add one trigger_type to indicate teh button's trigger type.

Changes since v2:
 - Use 'interrupt' property to indicate the irq type.

Changes since v1:
 - Diable the GPIO irq until reversing the GPIO level type.
---
 drivers/input/keyboard/gpio_keys.c |   12 ++++++++++--
 include/linux/gpio_keys.h          |    2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613d..614ee29 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -566,7 +566,10 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
 
 		isr = gpio_keys_gpio_isr;
-		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		if (button->trigger_type)
+			irqflags = button->trigger_type;
+		else
+			irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
 	} else {
 		if (!button->irq) {
@@ -696,10 +699,15 @@ static void gpio_keys_close(struct input_dev *input)
 	device_property_read_string(dev, "label", &pdata->name);
 
 	device_for_each_child_node(dev, child) {
-		if (is_of_node(child))
+		if (is_of_node(child)) {
 			button->irq =
 				irq_of_parse_and_map(to_of_node(child), 0);
 
+			if (button->irq)
+				button->trigger_type =
+					irq_get_trigger_type(button->irq);
+		}
+
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button->code)) {
 			dev_err(dev, "Button without keycode\n");
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77..eae87e2 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -18,6 +18,7 @@
  *			disable button via sysfs
  * @value:		axis value for %EV_ABS
  * @irq:		Irq number in case of interrupt keys
+ * @trigger_type:	indicate the button's interrupt type
  */
 struct gpio_keys_button {
 	unsigned int code;
@@ -30,6 +31,7 @@ struct gpio_keys_button {
 	bool can_disable;
 	int value;
 	unsigned int irq;
+	unsigned int trigger_type;
 };
 
 /**
-- 
1.7.9.5
