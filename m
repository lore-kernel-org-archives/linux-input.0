From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: adp5520-keys: Delete an error message for a failed
 memory allocation in adp5520_keys_probe()
Date: Sat, 27 Jan 2018 15:20:25 +0100
Message-ID: <9d0729d2-59ab-f116-aa12-0457ebde0041@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:60109 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbeA0OUc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 27 Jan 2018 09:20:32 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 15:15:52 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/adp5520-keys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index f0b9b37bde58..72e01cb77881 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -91,10 +91,8 @@ static int adp5520_keys_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&pdev->dev, "failed to alloc memory\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!input)
-- 
2.16.1

