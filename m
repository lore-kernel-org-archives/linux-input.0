From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 21/33] Input: arc_ps2 - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:42 -0800
Message-ID: <1484761614-12225-22-git-send-email-linux@roeck-us.net>
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
 drivers/input/serio/arc_ps2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 99e57a418753..9860b1c1e67a 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -197,10 +197,8 @@ static int arc_ps2_probe(struct platform_device *pdev)
 
 	arc_ps2 = devm_kzalloc(&pdev->dev, sizeof(struct arc_ps2_data),
 				GFP_KERNEL);
-	if (!arc_ps2) {
-		dev_err(&pdev->dev, "out of memory\n");
+	if (!arc_ps2)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	arc_ps2->addr = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4
