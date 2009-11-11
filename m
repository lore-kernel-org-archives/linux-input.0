From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [RFC PATCH 2/2] Input: gpio-keys: implemented support for enabling/disabling gpios
Date: Wed, 11 Nov 2009 12:36:08 +0200
Message-ID: <9b012ed801479acf5d4cbdf29292fdfc937d5e07.1257931659.git.ext-mika.1.westerberg@nokia.com>
References: <1257929573.21596.960.camel@localhost>
 <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
 <ac11b18d9fbb22ca88b61d73bc1e47e0068e9a86.1257931659.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20400 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853AbZKKKkX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 05:40:23 -0500
In-Reply-To: <ac11b18d9fbb22ca88b61d73bc1e47e0068e9a86.1257931659.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Add support for disabling and enabling gpio lines separately using
ioctl().

This patch is build using 2 new input event ioctl()s: EVIOCGSTATE
and EVIOCSSTATE so that patch is needed before applying this.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 drivers/input/keyboard/gpio_keys.c |   75 ++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8941a8b..d9b492e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,10 +30,12 @@ struct gpio_button_data {
 	struct input_dev *input;
 	struct timer_list timer;
 	struct work_struct work;
+	u8 state;	/* event state */
 };
 
 struct gpio_keys_drvdata {
 	struct input_dev *input;
+	struct gpio_keys_platform_data *pdata;
 	struct gpio_button_data data[0];
 };
 
@@ -73,6 +75,69 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int gpio_keys_get_event_state(struct input_dev *dev,
+				     struct input_event_state *st)
+{
+	const struct gpio_keys_drvdata *ddata = input_get_drvdata(dev);
+	const struct gpio_keys_platform_data *pdata = ddata->pdata;
+	int i;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		const struct gpio_keys_button *button = &pdata->buttons[i];
+		const struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (button->code == st->code && button->type == st->type) {
+			st->state = bdata->state;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+/*
+ * This function is used to enable/disable hardware interrupts from
+ * GPIO lines that are aggregated into single gpio-keys input device.
+ */
+static int gpio_keys_set_event_state(struct input_dev *dev,
+				     const struct input_event_state *st)
+{
+	struct gpio_keys_drvdata *ddata = input_get_drvdata(dev);
+	struct gpio_keys_platform_data *pdata = ddata->pdata;
+	int i;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (button->code == st->code && button->type == st->type) {
+			switch (st->state) {
+			case EVENT_STATE_DISABLE:
+				if (bdata->state == EVENT_STATE_ENABLE) {
+					bdata->state = EVENT_STATE_DISABLE;
+					/*
+					 * Disable physical irq line.  This is
+					 * enough also for keeping device from
+					 * waking up during sleep so no need
+					 * to change wakeup flags for this irq.
+					 */
+					disable_irq(gpio_to_irq(button->gpio));
+				}
+				break;
+			case EVENT_STATE_ENABLE:
+				if (bdata->state == EVENT_STATE_DISABLE) {
+					bdata->state = EVENT_STATE_ENABLE;
+					enable_irq(gpio_to_irq(button->gpio));
+				}
+				break;
+			default:
+				return -EINVAL;
+			}
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 static int __devinit gpio_keys_setup_key(struct device *dev,
 					 struct gpio_button_data *bdata,
 					 struct gpio_keys_button *button)
@@ -154,11 +219,19 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	/*
+	 * We support setting/getting event state ioctl.
+	 */
+	input->get_event_state = gpio_keys_get_event_state;
+	input->set_event_state = gpio_keys_set_event_state;
+	input_set_drvdata(input, ddata);
+
 	/* Enable auto repeat feature of Linux input subsystem */
 	if (pdata->rep)
 		__set_bit(EV_REP, input->evbit);
 
 	ddata->input = input;
+	ddata->pdata = pdata;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
@@ -167,6 +240,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 		bdata->input = input;
 		bdata->button = button;
+		bdata->state = EVENT_STATE_ENABLE;	/* enabled by default */
 
 		error = gpio_keys_setup_key(dev, bdata, button);
 		if (error)
@@ -200,6 +274,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
  fail1:
+	input_set_drvdata(input, NULL);
 	input_free_device(input);
 	kfree(ddata);
 
-- 
1.5.6.5

