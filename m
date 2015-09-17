From: Qipeng Zha <qipeng.zha@intel.com>
Subject: [PATCH] input:gpio-key: set IRQF_NO_SUSPEND for wake capable key
Date: Fri, 18 Sep 2015 00:06:59 +0800
Message-ID: <1442506019-13687-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53226 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbbIQIDG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 04:03:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, qipeng.zha@intel.com, Qi Zheng <qi.zheng@intel.com>, Aubrey Li <aubrey.li@intel.com>

When wakeup attribute is set, GPIO key is supposed to wake up
the system from system sleep state, So set IRQF_NO_SUSPEND
flag to keep IRQ enabled during suspend.

Signed-off-by: Qi Zheng <qi.zheng@intel.com>
Signed-off-by: Aubrey Li <aubrey.li@intel.com>
Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
---
 drivers/input/keyboard/gpio_keys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ddf4045..9744ad9 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -528,6 +528,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	 */
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
+	if (button->wakeup)
+		irqflags |= IRQF_NO_SUSPEND;
 
 	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
 					     isr, irqflags, desc, bdata);
-- 
1.8.3.2

