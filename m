From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 1/2] Input: gpio-keys: allow drivers to specify whether IRQ can be shared
Date: Thu, 19 Nov 2009 09:23:45 +0200
Message-ID: <dacbc701ebdd15c48ebb32920bf70fd42aa14baa.1258614931.git.ext-mika.1.westerberg@nokia.com>
References: <1257935192.21596.1004.camel@localhost>
 <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53370 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbZKSH2X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 02:28:23 -0500
In-Reply-To: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Added new field to struct gpio_keys_button: exclusive_irq which can
be used to specify whether driver wants to have exclusive access to
IRQ or can it be shared. By default IRQs for gpio-keys are shareable.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 drivers/input/keyboard/gpio_keys.c |   14 ++++++++++----
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8941a8b..113d187 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -78,6 +78,7 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 					 struct gpio_keys_button *button)
 {
 	char *desc = button->desc ? button->desc : "gpio_keys";
+	unsigned long irqflags;
 	int irq, error;
 
 	setup_timer(&bdata->timer, gpio_keys_timer, (unsigned long)bdata);
@@ -106,10 +107,15 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 		goto fail3;
 	}
 
-	error = request_irq(irq, gpio_keys_isr,
-			    IRQF_SHARED |
-			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			    desc, bdata);
+	irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+	/*
+	 * If not explicitly specified in platform data, we allow
+	 * IRQs to be shared with some other device.
+	 */
+	if (!button->exclusive_irq)
+		irqflags |= IRQF_SHARED;
+
+	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
 	if (error) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			irq, error);
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 1289fa7..82639c7 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -10,6 +10,7 @@ struct gpio_keys_button {
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
+	int exclusive_irq;	/* don't share the irq */
 };
 
 struct gpio_keys_platform_data {
-- 
1.5.6.5

