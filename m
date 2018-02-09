From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 1/3] Input: gpio-keys - add support for wakeup interrupt trigger type
Date: Fri,  9 Feb 2018 19:55:08 +0800
Message-ID: <20180209115510.11868-2-jeffy.chen@rock-chips.com>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, dtor@google.com, dianders@google.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Add support for specifying a different interrupt trigger type for wakeup
when using the gpio-keys input device as a wakeup source.

This would allow the device to configure when to wakeup the system. For
example a gpio-keys input device for pen insert, may only want to wakeup
the system when ejecting the pen.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/input/keyboard/gpio_keys.c | 20 ++++++++++++++++++--
 include/linux/gpio_keys.h          |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..5e5c93b75a71 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -45,6 +45,7 @@ struct gpio_button_data {
 	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
 
 	unsigned int irq;
+	unsigned int irq_trigger_type;
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
@@ -618,6 +619,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		return error;
 	}
 
+	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);
+
 	return 0;
 }
 
@@ -718,6 +721,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			/* legacy name */
 			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
+		fwnode_property_read_u32(child, "wakeup-trigger-type",
+					 &button->wakeup_trigger_type);
+
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
@@ -854,7 +860,12 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
+			const struct gpio_keys_button *button = bdata->button;
+
+			if (button->wakeup && button->wakeup_trigger_type)
+				irq_set_irq_type(bdata->irq,
+						 button->wakeup_trigger_type);
+			if (button->wakeup)
 				enable_irq_wake(bdata->irq);
 			bdata->suspended = true;
 		}
@@ -878,7 +889,12 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
+			const struct gpio_keys_button *button = bdata->button;
+
+			if (button->wakeup && button->wakeup_trigger_type)
+				irq_set_irq_type(bdata->irq,
+						 bdata->irq_trigger_type);
+			if (button->wakeup)
 				disable_irq_wake(bdata->irq);
 			bdata->suspended = false;
 		}
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77400f1..9b7e7137f768 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -13,6 +13,7 @@ struct device;
  * @desc:		label that will be attached to button's gpio
  * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
  * @wakeup:		configure the button as a wake-up source
+ * @wakeup_trigger_type:	wakeup interrupt trigger type
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
@@ -26,6 +27,7 @@ struct gpio_keys_button {
 	const char *desc;
 	unsigned int type;
 	int wakeup;
+	int wakeup_trigger_type;
 	int debounce_interval;
 	bool can_disable;
 	int value;
-- 
2.11.0
