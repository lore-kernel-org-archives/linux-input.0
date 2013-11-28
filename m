From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] Input: gpio_keys - add ack_irq callback for HW that needs ACK
Date: Thu, 28 Nov 2013 16:00:00 +0100
Message-ID: <1385650800-8908-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:58201 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025Ab3K1PAG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 10:00:06 -0500
Received: by mail-ea0-f173.google.com with SMTP id g15so5888036eak.32
        for <linux-input@vger.kernel.org>; Thu, 28 Nov 2013 07:00:05 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>

On bcm47xx arch we have GPIO keys with interrupts, but after every IRQ
we have to change GPIO interrupt polarity. This is necessary to stop
hardware from generating IRQs all the time and set it into state that
will generate another IRQ on button release.
This is not exactly an ACK, but I think it makes sense to use this more
generic name.
With this patch we can easily implement GPIO keys support for bcm47xx
just using gpio_keys.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
---
This change to gpio_keys was proposed as an alternative to
re-implementing most of the gpio_keys code in arch tree, see patch:
MIPS: BCM47XX: Prepare support for GPIO buttons
http://www.linux-mips.org/archives/linux-mips/2013-11/msg00160.html

Please let me know if this is acceptable change for you.
---
 drivers/input/keyboard/gpio_keys.c |    2 ++
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index b29ca65..c6e41be 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -362,6 +362,8 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void=
 *dev_id)
=20
 	BUG_ON(irq !=3D bdata->irq);
=20
+	if (bdata->button->ack_irq)
+		bdata->button->ack_irq(bdata->button);
 	if (bdata->button->wakeup)
 		pm_stay_awake(bdata->input->dev.parent);
 	if (bdata->timer_debounce)
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index a7e977f..3c4244e 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -15,6 +15,7 @@ struct gpio_keys_button {
 	bool can_disable;
 	int value;		/* axis value for EV_ABS */
 	unsigned int irq;	/* Irq number in case of interrupt keys */
+	void (*ack_irq)(const struct gpio_keys_button *button);
 };
=20
 struct gpio_keys_platform_data {
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
