From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/33] Input: adp5520-keys - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:22 -0800
Message-ID: <1484761614-12225-2-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56404 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdARRrR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:47:17 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <michael.hennerich@analog.com>

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
 drivers/input/keyboard/adp5520-keys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index db1004dad108..de69d415c2b5 100644
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
2.7.4

