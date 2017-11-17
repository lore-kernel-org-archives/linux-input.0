From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/10] Input: serio: Fix platform_get_irq's error checking
Date: Sat, 18 Nov 2017 00:45:26 +0530
Message-ID: <1510946132-13554-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42102 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935515AbdKQTQK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:16:10 -0500
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/serio/sun4i-ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/sun4i-ps2.c b/drivers/input/serio/sun4i-ps2.c
index 04b96fe..405c82f 100644
--- a/drivers/input/serio/sun4i-ps2.c
+++ b/drivers/input/serio/sun4i-ps2.c
@@ -264,7 +264,7 @@ static int sun4i_ps2_probe(struct platform_device *pdev)
 
 	/* Get IRQ for the device */
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq < 0) {
 		dev_err(dev, "no IRQ found\n");
 		error = -ENXIO;
 		goto err_disable_clk;
-- 
2.7.4

