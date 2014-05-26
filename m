From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] input: gpio_keys: Add IRQF_NO_SUSPEND flag to wake-up from
 freeze state
Date: Mon, 26 May 2014 13:57:14 +0900
Message-ID: <1401080234-31174-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20896 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaEZE5S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 00:57:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org

This patch add IRQF_NO_SUSPEND flag before requesting interrupt handler
if button->wakeup is true. If ther interrupt of gpio-keys hasn't included
IRQF_NO_SUSPEND, wouldn't wake-up from freeze state when pressing button.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/input/keyboard/gpio_keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2db1324..40f3963 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -503,6 +503,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
+	if (button->wakeup)
+		irqflags |= IRQF_NO_SUSPEND;
+
 	error = request_any_context_irq(bdata->irq, isr, irqflags, desc, bdata);
 	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
-- 
1.8.0

