From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/33] Input: ab8500-ponkey - Drop unnecessary call to platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 09:46:32 -0800
Message-ID: <1484761614-12225-12-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58897 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbdARRst (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 12:48:49 -0500
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

There is no call to platform_get_drvdata() or dev_get_drvdata().
Drop the unnecessary call to platform_set_drvdata().

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop platform_set_drvdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/ab8500-ponkey.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 4f5ef5bb535b..a33ed5710b15 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -109,7 +109,6 @@ static int ab8500_ponkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	platform_set_drvdata(pdev, ponkey);
 	return 0;
 }
 
-- 
2.7.4

