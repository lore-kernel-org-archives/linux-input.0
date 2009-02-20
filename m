From: Darius <augulis.darius@gmail.com>
Subject: [PATCH] gpio keys single egde
Date: Fri, 20 Feb 2009 16:02:11 +0200
Message-ID: <gnmd97$g5d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020400010302060309080301"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35998 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbZBTOKE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2009 09:10:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LaW4p-0001Wz-FM
	for linux-input@vger.kernel.org; Fri, 20 Feb 2009 14:10:03 +0000
Received: from 217.147.39.138 ([217.147.39.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2009 14:10:03 +0000
Received: from augulis.darius by 217.147.39.138 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2009 14:10:03 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------020400010302060309080301
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit


--------------020400010302060309080301
Content-Type: text/plain;
 name="patch-gpio_keys-single_edge"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-gpio_keys-single_edge"

From: Darius Augulis <augulis.darius@gmail.com>

Support for such GPIO controllers, which can't trigger on both edges at once.

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>

Index: linux-2.6.29-rc5/drivers/input/keyboard/gpio_keys.c
===================================================================
--- linux-2.6.29-rc5.orig/drivers/input/keyboard/gpio_keys.c
+++ linux-2.6.29-rc5/drivers/input/keyboard/gpio_keys.c
@@ -43,8 +43,15 @@ static void gpio_keys_report_event(struc
 	unsigned int type = button->type ?: EV_KEY;
 	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
 
+	printk("GPIO=%d\n", state);
+
 	input_event(input, type, button->code, !!state);
 	input_sync(input);
+
+	if (button->single_edge) {
+		input_event(input, type, button->code, !state);
+		input_sync(input);
+	}
 }
 
 static void gpio_check_button(unsigned long _data)
@@ -77,6 +84,7 @@ static int __devinit gpio_keys_probe(str
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
+	unsigned long irq_flags;
 
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
@@ -141,9 +149,13 @@ static int __devinit gpio_keys_probe(str
 			goto fail2;
 		}
 
-		error = request_irq(irq, gpio_keys_isr,
-				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
+		irq_flags = IRQF_SAMPLE_RANDOM;
+		if (button->single_edge)
+			irq_flags |= (button->active_low ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING);
+		else
+			irq_flags |= IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+
+		error = request_irq(irq, gpio_keys_isr, irq_flags,
 				    button->desc ? button->desc : "gpio_keys",
 				    bdata);
 		if (error) {
Index: linux-2.6.29-rc5/include/linux/gpio_keys.h
===================================================================
--- linux-2.6.29-rc5.orig/include/linux/gpio_keys.h
+++ linux-2.6.29-rc5/include/linux/gpio_keys.h
@@ -6,6 +6,7 @@ struct gpio_keys_button {
 	int code;		/* input event code (KEY_*, SW_*) */
 	int gpio;
 	int active_low;
+	int single_edge;	/* Trigger only single egde (0-no, 1-yes) */
 	char *desc;
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */

--------------020400010302060309080301--

