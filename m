From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH 3/3 RFC] Input: gpio-keys - add polling support
Date: Thu, 31 Jul 2008 21:04:23 +0200
Message-ID: <1217531063-2472-4-git-send-email-Uwe.Kleine-Koenig@digi.com>
References: <1217531063-2472-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
 <1217531063-2472-2-git-send-email-Uwe.Kleine-Koenig@digi.com>
 <1217531063-2472-3-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail161.messagelabs.com ([216.82.253.115]:14807 "EHLO
	mail161.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758034AbYGaTEb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2008 15:04:31 -0400
In-Reply-To: <1217531063-2472-3-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

One thing that is new for gpio's that trigger can trigger on both edges
is that an irq results in an event even if the gpio could not be read
fast enough to see the effect.  I don't assume this is an issue in a
normal scenario though.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
Hello,

This adds a depends on INPUT_POLLDEV which might not be nice for the on=
e
or the other machine.  The alternative is to spread some #ifdefs over
the code.  Not that nice either.

Comments?

Best regards
Uwe

 drivers/input/keyboard/Kconfig     |    1 +
 drivers/input/keyboard/gpio_keys.c |  171 ++++++++++++++++++++++++++--=
-------
 include/linux/gpio_keys.h          |    3 +
 3 files changed, 131 insertions(+), 44 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
index efd70a9..afc562d 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -283,6 +283,7 @@ config KEYBOARD_AAED2000
 config KEYBOARD_GPIO
 	tristate "GPIO Buttons"
 	depends on GENERIC_GPIO
+	depends on INPUT_POLLDEV
 	help
 	  This driver implements support for buttons connected
 	  to GPIO pins of various CPUs (and some other chips).
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index 0394b6d..cc85456 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -21,38 +21,70 @@
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/input.h>
+#include <linux/input-polldev.h>
 #include <linux/gpio_keys.h>
+#include <linux/spinlock.h>
=20
 #include <asm/gpio.h>
=20
+#define IRQF_TRIGGER_EDGE (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)
+
 struct gpio_button_data {
 	struct gpio_keys_button *button;
-	struct input_dev *input;
+	struct input_polled_dev *input_polled;
 	struct timer_list timer;
+	int last_state;
+	/* protects last_state and synchronizes input_event()
+	 * + input_sync() in gpio_keys_report_event() */
+	spinlock_t lock;
 };
=20
 struct gpio_keys_drvdata {
-	struct input_dev *input;
+	struct input_polled_dev *input_polled;
 	struct gpio_button_data data[0];
 };
=20
-static void gpio_keys_report_event(struct gpio_button_data *bdata)
+static inline int gpio_keys_get_state(struct gpio_button_data *bdata)
+{
+	struct gpio_keys_button *button =3D bdata->button;
+
+	return !gpio_get_value(button->gpio) ^ !button->active_low;
+}
+
+static void gpio_keys_report_event(struct gpio_button_data *bdata, int=
 irq)
 {
 	struct gpio_keys_button *button =3D bdata->button;
-	struct input_dev *input =3D bdata->input;
+	struct input_dev *input =3D bdata->input_polled->input;
 	unsigned int type =3D button->type ?: EV_KEY;
-	int state =3D (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active=
_low;
+	int state =3D gpio_keys_get_state(bdata);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bdata->lock, flags);
+
+	/*
+	 * If the event was triggered by an irq assume that there was an even=
t
+	 * even with state =3D=3D last_state.  Probably we only checked too s=
low.
+	 */
+	if (irq) {
+		bdata->last_state =3D !bdata->last_state;
+		input_event(input, type, button->code, bdata->last_state);
+		input_sync(input);
+	}
=20
-	input_event(input, type, button->code, !!state);
-	input_sync(input);
+	if (state !=3D bdata->last_state) {
+		input_event(input, type, button->code, state);
+		input_sync(input);
+		bdata->last_state =3D state;
+	}
+
+	spin_unlock_irqrestore(&bdata->lock, flags);
 }
=20
 static void gpio_check_button(unsigned long _data)
 {
 	struct gpio_button_data *data =3D (struct gpio_button_data *)_data;
=20
-	gpio_keys_report_event(data);
+	gpio_keys_report_event(data, 1);
 }
=20
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
@@ -67,28 +99,49 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev=
_id)
 				jiffies +
 				msecs_to_jiffies(button->debounce_interval));
 	else
-		gpio_keys_report_event(bdata);
+		gpio_keys_report_event(bdata, 1);
=20
 	return IRQ_HANDLED;
 }
=20
+static void gpio_keys_poll(struct input_polled_dev *dev)
+{
+	struct platform_device *pdev =3D dev->private;
+	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata =3D platform_get_drvdata(pdev);
+	int i;
+
+	for (i =3D 0; i < pdata->nbuttons; ++i) {
+		struct gpio_button_data *bdata =3D &ddata->data[i];
+
+		gpio_keys_report_event(bdata, 0);
+	}
+}
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
+	struct input_polled_dev *input_polled;
 	struct input_dev *input;
 	int i, error;
 	int wakeup =3D 0;
+	int polled =3D 0;
=20
 	ddata =3D kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
-	input =3D input_allocate_device();
-	if (!ddata || !input) {
+	input_polled =3D input_allocate_polled_device();
+	if (!ddata || !input_polled) {
 		error =3D -ENOMEM;
 		goto fail1;
 	}
=20
+	input_polled->poll =3D gpio_keys_poll;
+	input_polled->private =3D pdev;
+
+	input =3D input_polled->input;
+
 	platform_set_drvdata(pdev, ddata);
=20
 	input->name =3D pdev->name;
@@ -100,7 +153,7 @@ static int __devinit gpio_keys_probe(struct platfor=
m_device *pdev)
 	input->id.product =3D 0x0001;
 	input->id.version =3D 0x0100;
=20
-	ddata->input =3D input;
+	ddata->input_polled =3D input_polled;
=20
 	for (i =3D 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button =3D &pdata->buttons[i];
@@ -108,8 +161,11 @@ static int __devinit gpio_keys_probe(struct platfo=
rm_device *pdev)
 		int irq;
 		unsigned int type =3D button->type ?: EV_KEY;
=20
-		bdata->input =3D input;
+		bdata->input_polled =3D input_polled;
 		bdata->button =3D button;
+		bdata->last_state =3D gpio_keys_get_state(bdata);
+		spin_lock_init(&bdata->lock);
+
 		setup_timer(&bdata->timer,
 			    gpio_check_button, (unsigned long)bdata);
=20
@@ -129,35 +185,47 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
 			goto fail2;
 		}
=20
-		irq =3D gpio_to_irq(button->gpio);
-		if (irq < 0) {
-			error =3D irq;
-			pr_err("gpio-keys: Unable to get irq number"
-				" for GPIO %d, error %d\n",
-				button->gpio, error);
-			gpio_free(button->gpio);
-			goto fail2;
-		}
+		if (button->polledge !=3D IRQF_TRIGGER_EDGE) {
+			irq =3D gpio_to_irq(button->gpio);
+			if (irq < 0) {
+				error =3D irq;
+				pr_warning("gpio-keys: Unable to get irq number"
+						" for GPIO %d, error %d"
+						" will poll\n",
+						button->gpio, error);
+				button->polledge =3D IRQF_TRIGGER_EDGE;
+				goto do_polling;
+			}
=20
-		error =3D request_irq(irq, gpio_keys_isr,
-				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
-				    button->desc ? button->desc : "gpio_keys",
-				    bdata);
-		if (error) {
-			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
-				irq, error);
-			gpio_free(button->gpio);
-			goto fail2;
+			error =3D request_irq(irq, gpio_keys_isr,
+					IRQF_SAMPLE_RANDOM |
+					(IRQF_TRIGGER_EDGE & ~button->polledge),
+					button->desc ?: "gpio_keys",
+					bdata);
+			if (error) {
+				pr_warning("gpio-keys: Unable to claim irq %d;"
+						" error %d, will poll\n",
+						irq, error);
+				gpio_free(button->gpio);
+				goto do_polling;
+			}
+
+			if (button->wakeup)
+				wakeup =3D 1;
 		}
=20
-		if (button->wakeup)
-			wakeup =3D 1;
+do_polling:
+		if (button->polledge)
+			polled =3D 1;
=20
 		input_set_capability(input, type, button->code);
 	}
=20
-	error =3D input_register_device(input);
+	if (polled)
+		error =3D input_register_polled_device(input_polled);
+	else
+		error =3D input_register_device(input);
+
 	if (error) {
 		pr_err("gpio-keys: Unable to register input device, "
 			"error: %d\n", error);
@@ -170,15 +238,17 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
=20
  fail2:
 	while (--i >=3D 0) {
-		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
+		if (pdata->buttons[i].polledge !=3D IRQF_TRIGGER_EDGE)
+			free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
+
 		gpio_free(pdata->buttons[i].gpio);
 	}
=20
 	platform_set_drvdata(pdev, NULL);
  fail1:
-	input_free_device(input);
+	input_free_polled_device(input_polled);
 	kfree(ddata);
=20
 	return error;
@@ -188,20 +258,33 @@ static int __devexit gpio_keys_remove(struct plat=
form_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata =3D platform_get_drvdata(pdev);
-	struct input_dev *input =3D ddata->input;
-	int i;
+	struct input_polled_dev *input_polled =3D ddata->input_polled;
+	struct input_dev *input =3D input_polled->input;
+	int i, polled =3D 0;
=20
 	device_init_wakeup(&pdev->dev, 0);
=20
 	for (i =3D 0; i < pdata->nbuttons; i++) {
-		int irq =3D gpio_to_irq(pdata->buttons[i].gpio);
-		free_irq(irq, &ddata->data[i]);
+		if (pdata->buttons[i].polledge !=3D IRQF_TRIGGER_EDGE) {
+			int irq =3D gpio_to_irq(pdata->buttons[i].gpio);
+			free_irq(irq, &ddata->data[i]);
+		}
+
+		if (pdata->buttons[i].polledge)
+			polled =3D 1;
+
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
-		gpio_free(pdata->buttons[i].gpio);
+
 	}
=20
-	input_unregister_device(input);
+	if (polled)
+		input_unregister_polled_device(input_polled);
+	else
+		input_unregister_device(input);
+
+	for (i =3D 0; i < pdata->nbuttons; i++)
+		gpio_free(pdata->buttons[i].gpio);
=20
 	return 0;
 }
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ec6ecd7..a0acf29 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -10,6 +10,9 @@ struct gpio_keys_button {
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
+	unsigned long polledge;	/* bitwise OR of zero or more of
+				 * IRQF_TRIGGER_FALLING and IRQF_TRIGGER_RISING
+				 */
 };
=20
 struct gpio_keys_platform_data {
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
