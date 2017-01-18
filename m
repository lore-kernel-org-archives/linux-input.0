From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/33] Input: imx_keypad - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:26 -0800
Message-ID: <1484761614-12225-6-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57222 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbdARRrb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:47:31 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Error messages after memory allocation failures are unnecessary and
can be dropped.

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/imx_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 2165f3dd328b..eb273ade822f 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -447,10 +447,8 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
-	if (!keypad) {
-		dev_err(&pdev->dev, "not enough memory for driver data\n");
+	if (!keypad)
 		return -ENOMEM;
-	}
 
 	keypad->input_dev = input_dev;
 	keypad->irq = irq;
-- 
2.7.4

