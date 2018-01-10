From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] input: snvs_pwrkey: add clock support
Date: Wed, 10 Jan 2018 17:10:22 +0800
Message-ID: <1515575422-8843-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com ([104.47.32.65]:51488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965331AbeAJJ1t (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Jan 2018 04:27:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, keescook@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Add optional clock enable/disable support for the SNVS pwrkey,
which is required for accessing SNVS block on some i.MX SoCs
like i.MX7D.

If SNVS clock is required, it needs to be passed from dtb file
and SNVS pwrkey driver will enable it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 53c768b..51642aa 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
@@ -43,6 +44,7 @@ struct pwrkey_drv_data {
 	int wakeup;
 	struct timer_list check_timer;
 	struct input_dev *input;
+	struct clk *clk;
 };
 
 static void imx_imx_snvs_check_for_events(struct timer_list *t)
@@ -129,6 +131,18 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	pdata->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pdata->clk)) {
+		pdata->clk = NULL;
+	} else {
+		error = clk_prepare_enable(pdata->clk);
+		if (error) {
+			dev_err(&pdev->dev,
+				"Could not prepare or enable the snvs clock\n");
+			return error;
+		}
+	}
+
 	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN, SNVS_LPCR_DEP_EN);
 
 	/* clear the unexpected interrupt before driver ready */
@@ -139,7 +153,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {
 		dev_err(&pdev->dev, "failed to allocate the input device\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto error_snvs_pwrkey_device_register;
 	}
 
 	input->name = pdev->name;
@@ -152,7 +167,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register remove action\n");
-		return error;
+		goto error_snvs_pwrkey_device_register;
 	}
 
 	error = devm_request_irq(&pdev->dev, pdata->irq,
@@ -161,13 +176,13 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	if (error) {
 		dev_err(&pdev->dev, "interrupt not available.\n");
-		return error;
+		goto error_snvs_pwrkey_device_register;
 	}
 
 	error = input_register_device(input);
 	if (error < 0) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		return error;
+		goto error_snvs_pwrkey_device_register;
 	}
 
 	pdata->input = input;
@@ -176,6 +191,13 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
 	return 0;
+
+error_snvs_pwrkey_device_register:
+	if (pdata->clk)
+		clk_disable_unprepare(pdata->clk);
+
+	return error;
+
 }
 
 static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
-- 
1.9.1

