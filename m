From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/3 v2] Input: twl4030_keypad: Fix platform_get_irq's error checking
Date: Sat, 18 Nov 2017 02:28:49 +0530
Message-ID: <d5ca46d63a41f47411b94c6035d3b8c46bbe8503.1510951446.git.arvind.yadav.cs@gmail.com>
References: <f317ec56b23b11b79284c29d12a7004575aa35db.1510951446.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39612 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761915AbdKQU70 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 15:59:26 -0500
In-Reply-To: <f317ec56b23b11b79284c29d12a7004575aa35db.1510951446.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <f317ec56b23b11b79284c29d12a7004575aa35db.1510951446.git.arvind.yadav.cs@gmail.com>
References: <f317ec56b23b11b79284c29d12a7004575aa35db.1510951446.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              kp->irq is unsigned. use temporary int variable irq.

 drivers/input/keyboard/twl4030_keypad.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index f9f98ef..d921238 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -341,6 +341,7 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	u8 reg;
 	int error;
+	int irq;
 
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (!kp)
@@ -388,11 +389,12 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	kp->irq = platform_get_irq(pdev, 0);
-	if (!kp->irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no keyboard irq assigned\n");
-		return -EINVAL;
+		return irq;
 	}
+	kp->irq = irq;
 
 	error = matrix_keypad_build_keymap(keymap_data, NULL,
 					   TWL4030_MAX_ROWS,
-- 
2.7.4

