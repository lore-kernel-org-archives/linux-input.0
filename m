From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend] Input: tegra-kbc- Convert to devm_ioremap_resource()
Date: Mon, 25 Feb 2013 09:17:00 +0530
Message-ID: <1361764020-28728-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:43622 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759689Ab3BYD5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Feb 2013 22:57:25 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so1266322dae.3
        for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 19:57:25 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, thierry.reding@avionic-design.de

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Rebased on the latest Linus' tree (v3.8+).
---
 drivers/input/keyboard/tegra-kbc.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 0e138eb..68b2b65 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/clk/tegra.h>
+#include <linux/err.h>
 
 #define KBC_MAX_GPIO	24
 #define KBC_MAX_KPENT	8
@@ -608,11 +609,9 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 
 	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigned long)kbc);
 
-	kbc->mmio = devm_request_and_ioremap(&pdev->dev, res);
-	if (!kbc->mmio) {
-		dev_err(&pdev->dev, "Cannot request memregion/iomap address\n");
-		return -EBUSY;
-	}
+	kbc->mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(kbc->mmio))
+		return PTR_ERR(kbc->mmio);
 
 	kbc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(kbc->clk)) {
-- 
1.7.4.1

