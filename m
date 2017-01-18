From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/33] Input: spear-keyboard - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:29 -0800
Message-ID: <1484761614-12225-9-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58889 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdARRsu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:48:50 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>

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
 drivers/input/keyboard/spear-keyboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 8083eaa0524a..21357ee854c9 100644
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
2.7.4

