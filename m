From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Mon, 23 Nov 2009 14:39:39 +0200
Message-ID: <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
References: <20091120084054.GC3009@core.coreip.homeip.net>
 <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19061 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184AbZKWMoK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 07:44:10 -0500
In-Reply-To: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Added new field to struct gpio_keys_button: irqflags which can
be used to specify exact irqflags the platform wants. If not specified,
it defaults to: IRQF_SHARED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 drivers/input/keyboard/gpio_keys.c |   13 +++++++++----
 include/linux/gpio_keys.h          |    7 +++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8941a8b..6ed5a18 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -78,6 +78,7 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 					 struct gpio_keys_button *button)
 {
 	char *desc = button->desc ? button->desc : "gpio_keys";
+	unsigned long irqflags;
 	int irq, error;
 
 	setup_timer(&bdata->timer, gpio_keys_timer, (unsigned long)bdata);
@@ -106,10 +107,14 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 		goto fail3;
 	}
 
-	error = request_irq(irq, gpio_keys_isr,
-			    IRQF_SHARED |
-			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			    desc, bdata);
+	if (button->irqflags == 0) {
+		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+			   IRQF_SHARED;
+	} else {
+		irqflags = button->irqflags;
+	}
+
+	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
 	if (error) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			irq, error);
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 1289fa7..387b980 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -10,6 +10,13 @@ struct gpio_keys_button {
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
+	/*
+	 * Exact irqflags this button wants.
+	 *
+	 * If left unset, defaults to:
+	 * IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_SHARED
+	 */
+	unsigned long irqflags;
 };
 
 struct gpio_keys_platform_data {
-- 
1.5.6.5

