From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 17/33] Input: retu-pwrbutton - Simplify error return and other changes
Date: Wed, 18 Jan 2017 09:46:38 -0800
Message-ID: <1484761614-12225-18-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Simplify error return if the code returns anyway.
Other relevant changes:
  Drop empty remove function

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop empty remove function
- Replace 'if (e) return e; return 0;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/retu-pwrbutton.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 30b459b6b344..97d39a965a65 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -69,21 +69,11 @@ static int retu_pwrbutton_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = input_register_device(idev);
-	if (error)
-		return error;
-
-	return 0;
-}
-
-static int retu_pwrbutton_remove(struct platform_device *pdev)
-{
-	return 0;
+	return input_register_device(idev);
 }
 
 static struct platform_driver retu_pwrbutton_driver = {
 	.probe		= retu_pwrbutton_probe,
-	.remove		= retu_pwrbutton_remove,
 	.driver		= {
 		.name	= "retu-pwrbutton",
 	},
-- 
2.7.4
