From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.24-rc6-git] gpio_keys minor irq cleanup
Date: Thu, 27 Dec 2007 11:24:54 -0800
Message-ID: <200712271124.55041.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:20085 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752000AbXL0UJr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Dec 2007 15:09:47 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Phil Blundell <pb@handhelds.org>, linux-input@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Cleanup IRQ handling in gpio_keys:  bail after handling the IRQ, and
report IRQ_NONE if we never handle it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Phil Blundell <pb@handhelds.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
grr, not sure why that blank line got removed ... feel free to
restore it.

--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -40,13 +40,13 @@ static irqreturn_t gpio_keys_isr(int irq
 		if (irq == gpio_to_irq(gpio)) {
 			unsigned int type = button->type ?: EV_KEY;
 			int state = (gpio_get_value(gpio) ? 1 : 0) ^ button->active_low;
-
 			input_event(input, type, button->code, !!state);
 			input_sync(input);
+			return IRQ_HANDLED;
 		}
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
