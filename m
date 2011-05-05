From: y@vger.kernel.org
Subject: [PATCH V2 2/3] input: pmic8xxx-keypad: Add row and column gpio configuration
Date: Thu,  5 May 2011 10:59:24 +0530
Message-ID: <22281.0854939327$1304573400@news.gmane.org>
References: <1304573365-21427-1-git-send-email-y>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:56659 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab1EEF3t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 01:29:49 -0400
In-Reply-To: <1304573365-21427-1-git-send-email-y>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Anirudh Ghayal <aghayal@codeaurora.org>

From: Anirudh Ghayal <aghayal@codeaurora.org>

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Anirudh Ghayal <aghayal@codeaurora.org>
---
 drivers/input/keyboard/pmic8xxx-keypad.c |   74 ++++++++++++++++++++++++++++++
 include/linux/input/pmic8xxx-keypad.h    |    2 +
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 0229325..cad09d7 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 
 #include <linux/mfd/pm8xxx/core.h>
+#include <linux/mfd/pm8xxx/gpio.h>
 #include <linux/input/pmic8xxx-keypad.h>
 
 #define PM8XXX_MAX_ROWS		18
@@ -446,6 +447,64 @@ static int __devinit pmic8xxx_kpd_init(struct pmic8xxx_kp *kp)
 
 }
 
+static int __devinit pmic8xxx_kp_config_drv(int gpio_start, int num_gpios)
+{
+	int	rc;
+	struct pm_gpio kypd_drv = {
+		.direction	= PM_GPIO_DIR_OUT,
+		.output_buffer	= PM_GPIO_OUT_BUF_OPEN_DRAIN,
+		.output_value	= 0,
+		.pull		= PM_GPIO_PULL_NO,
+		.vin_sel	= PM_GPIO_VIN_S3,
+		.out_strength	= PM_GPIO_STRENGTH_LOW,
+		.function	= PM_GPIO_FUNC_1,
+		.inv_int_pol	= 1,
+	};
+
+	if (gpio_start < 0 || num_gpios < 0 ||
+		num_gpios > (PM8XXX_MAX_ROWS + gpio_start))
+		return -EINVAL;
+
+	while (num_gpios--) {
+		rc = pm8xxx_gpio_config(gpio_start++, &kypd_drv);
+		if (rc) {
+			pr_err("%s: FAIL pm8xxx_gpio_config(): rc=%d.\n",
+				__func__, rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static int __devinit pmic8xxx_kp_config_sns(int gpio_start, int num_gpios)
+{
+	int	rc;
+	struct pm_gpio kypd_sns = {
+		.direction	= PM_GPIO_DIR_IN,
+		.pull		= PM_GPIO_PULL_UP_31P5,
+		.vin_sel	= PM_GPIO_VIN_S3,
+		.out_strength	= PM_GPIO_STRENGTH_NO,
+		.function	= PM_GPIO_FUNC_NORMAL,
+		.inv_int_pol	= 1,
+	};
+
+	if (gpio_start < 0 || num_gpios < 0 ||
+		num_gpios > (PM8XXX_MAX_COLS + gpio_start))
+		return -EINVAL;
+
+	while (num_gpios--) {
+		rc = pm8xxx_gpio_config(gpio_start++, &kypd_sns);
+		if (rc) {
+			pr_err("%s: FAIL pm8xxx_gpio_config(): rc=%d.\n",
+				__func__, rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
 static int pmic8xxx_kp_enable(struct pmic8xxx_kp *kp)
 {
 	int rc;
@@ -609,6 +668,20 @@ static int __devinit pmic8xxx_kp_probe(struct platform_device *pdev)
 		goto err_get_irq;
 	}
 
+	rc = pmic8xxx_kp_config_sns(pdata->cols_gpio_start,
+					pdata->num_cols);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "unable to configure keypad sense lines\n");
+		goto err_gpio_config;
+	}
+
+	rc = pmic8xxx_kp_config_drv(pdata->rows_gpio_start,
+					pdata->num_rows);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "unable to configure keypad drive lines\n");
+		goto err_gpio_config;
+	}
+
 	rc = request_any_context_irq(kp->key_sense_irq, pmic8xxx_kp_irq,
 				 IRQF_TRIGGER_RISING, "pmic-keypad", kp);
 	if (rc < 0) {
@@ -645,6 +718,7 @@ err_pmic_reg_read:
 	free_irq(kp->key_stuck_irq, NULL);
 err_req_stuck_irq:
 	free_irq(kp->key_sense_irq, NULL);
+err_gpio_config:
 err_get_irq:
 	input_free_device(kp->input);
 err_alloc_device:
diff --git a/include/linux/input/pmic8xxx-keypad.h b/include/linux/input/pmic8xxx-keypad.h
index fc2ac4c..5f1e2f9 100644
--- a/include/linux/input/pmic8xxx-keypad.h
+++ b/include/linux/input/pmic8xxx-keypad.h
@@ -38,6 +38,8 @@ struct pm8xxx_keypad_platform_data {
 
 	unsigned int num_cols;
 	unsigned int num_rows;
+	unsigned int rows_gpio_start;
+	unsigned int cols_gpio_start;
 
 	unsigned int debounce_ms;
 	unsigned int scan_delay_ms;
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.\nThe Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

