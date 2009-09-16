From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Wed, 16 Sep 2009 19:03:18 +0400
Message-ID: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:38126 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759170AbZIPPDt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 11:03:49 -0400
Received: by ewy2 with SMTP id 2so1500658ewy.17
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 08:03:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

There is nothing that disallows gpio-keys to share it's IRQ line
w/ other drivers. Make it use IRQF_SHARED in request_irq().

An example of other driver with which I'd like to share IRQ line
for GPIO buttons is ledtrig-gpio.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index efed0c9..9fc2fab 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		}
 
 		error = request_irq(irq, gpio_keys_isr,
+				    IRQF_SHARED |
 				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				    button->desc ? button->desc : "gpio_keys",
 				    bdata);
-- 
1.6.3.3

