From: Guennadi Liakhovetski <lg@denx.de>
Subject: [PATCH] gpio-keys: support buttons with only one interrupt trigger
 type
Date: Wed, 26 Nov 2008 18:11:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811261804480.4749@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753202AbYKZRL0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2008 12:11:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org

Some systems (e.g., i.MX31) do not support interrupts on both falling and 
rising GPIO edge. Modify the gpio-keys input driver to support such 
buttons, in which case, of course, no auto repeat can be provided.

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---
 drivers/input/keyboard/gpio_keys.c |   18 ++++++++++++++++--
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ad67d76..d9b4434 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -44,6 +44,14 @@ static void gpio_keys_report_event(struct gpio_button_data *bdata)
 	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
 
 	input_event(input, type, button->code, !!state);
+	/*
+	 * If the button only supports press events, simulate release
+	 * immediately
+	 */
+	if (button->irq_trigger != (IRQF_TRIGGER_RISING |
+				    IRQF_TRIGGER_FALLING))
+		input_event(input, type, button->code, !state);
+
 	input_sync(input);
 }
 
@@ -141,9 +149,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			goto fail2;
 		}
 
+		button->irq_trigger &= IRQF_TRIGGER_RISING |
+			IRQF_TRIGGER_FALLING;
+
+		if (!button->irq_trigger)
+			button->irq_trigger = IRQF_TRIGGER_RISING |
+				IRQF_TRIGGER_FALLING;
+
 		error = request_irq(irq, gpio_keys_isr,
-				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
+				    IRQF_SAMPLE_RANDOM | button->irq_trigger,
 				    button->desc ? button->desc : "gpio_keys",
 				    bdata);
 		if (error) {
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 1289fa7..d0bd8e2 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -10,6 +10,7 @@ struct gpio_keys_button {
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
+	unsigned long irq_trigger; /* IRQF_TRIGGER_{RISING,FALLING} */
 };
 
 struct gpio_keys_platform_data {
