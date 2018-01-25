From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: spear-keyboard: Delete an error message for a failed
 memory allocation in spear_kbd_probe()
Date: Thu, 25 Jan 2018 21:52:05 +0100
Message-ID: <57b7b09c-1f32-8f0b-cc1c-135e1ef211ed@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:58103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbeAYUwT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 15:52:19 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 21:49:13 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/spear-keyboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 7d25fa338ab4..1386440a870d 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -197,10 +197,8 @@ static int spear_kbd_probe(struct platform_device *pdev)
 	}
 
 	kbd = devm_kzalloc(&pdev->dev, sizeof(*kbd), GFP_KERNEL);
-	if (!kbd) {
-		dev_err(&pdev->dev, "not enough memory for driver data\n");
+	if (!kbd)
 		return -ENOMEM;
-	}
 
 	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev) {
-- 
2.16.1

