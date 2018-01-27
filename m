From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: imx_keypad: Delete an error message for a failed
 memory allocation in imx_keypad_probe()
Date: Sat, 27 Jan 2018 14:23:49 +0100
Message-ID: <41ac3033-4588-20de-c5e6-c4fd463e6c3a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:61315 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeA0NXx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 27 Jan 2018 08:23:53 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 14:14:04 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/imx_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 25d61d8d4fc4..859f9c9f3aae 100644
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
2.16.1

