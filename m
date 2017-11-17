From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/10 v2] Input: cpcap-pwrbutton: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 02:36:53 +0530
Message-ID: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43715 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762079AbdKQVHG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 16:07:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              return irq instead of -ENODEV.

 drivers/input/misc/cpcap-pwrbutton.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
index 0abef63..3a0626b 100644
--- a/drivers/input/misc/cpcap-pwrbutton.c
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -57,6 +57,9 @@ static int cpcap_power_button_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	int err;
 
+	if (irq < 0)
+		return irq;
+
 	button = devm_kmalloc(&pdev->dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-- 
2.7.4

