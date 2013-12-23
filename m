From: Anson Huang <b20788@freescale.com>
Subject: [PATCH] Input: gpio_keys: support wakeup system from freeze mode
Date: Mon, 23 Dec 2013 13:21:20 -0500
Message-ID: <1387822880-30382-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:1672
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730Ab3LWGX2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 01:23:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org
Cc: linux-input@vger.kernel.org

For "freeze" mode of suspend, cpu will go into idle and
those wakeup sources' irq should NOT be disabled during
devices suspend, so we need to add IRQF_NO_SUSPEND flag
for those wakeup sources.

Steps to test this patch:

1. echo freeze > /sys/power/state;
2. press gpio key which has wakeup function, then system
   will resume.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/input/keyboard/gpio_keys.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2db1324..aadb1db 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -473,6 +473,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		isr = gpio_keys_gpio_isr;
 		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		if (bdata->button->wakeup)
+			irqflags |= IRQF_NO_SUSPEND;
 
 	} else {
 		if (!button->irq) {
-- 
1.7.9.5


