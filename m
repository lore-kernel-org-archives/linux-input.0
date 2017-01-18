From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 25/33] Input: atmel-wm97xx - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:46 -0800
Message-ID: <1484761614-12225-26-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

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
 drivers/input/touchscreen/atmel-wm97xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
index 7ec0421c0dd8..8cf0b2be2df4 100644
--- a/drivers/input/touchscreen/atmel-wm97xx.c
+++ b/drivers/input/touchscreen/atmel-wm97xx.c
@@ -339,10 +339,8 @@ static int __init atmel_wm97xx_probe(struct platform_device *pdev)
 	int ret;
 
 	atmel_wm97xx = kzalloc(sizeof(struct atmel_wm97xx), GFP_KERNEL);
-	if (!atmel_wm97xx) {
-		dev_dbg(&pdev->dev, "out of memory\n");
+	if (!atmel_wm97xx)
 		return -ENOMEM;
-	}
 
 	atmel_wm97xx->wm	= wm;
 	atmel_wm97xx->regs	= (void *)ATMEL_WM97XX_AC97C_IOMEM;
-- 
2.7.4
