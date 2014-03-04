From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v5 1/9] Input: pmic8xxx-keypad - Fix build by removing gpio
 configuration
Date: Tue,  4 Mar 2014 10:34:40 -0800
Message-ID: <1393958088-1456-2-git-send-email-sboyd@codeaurora.org>
References: <1393958088-1456-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393958088-1456-1-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Josh Cartwright <joshc@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The gpio configuration in this driver doesn't work because the
gpio.h include doesn't exist. Remove the configuration as it
isn't strictly necessary, allowing us to actually compile this
driver. If it's needed in the future, it should be done via a
pinctrl driver.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 58 --------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 2c9f19ac35ea..c4aa882c8fb9 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -21,7 +21,6 @@
 #include <linux/mutex.h>
 
 #include <linux/mfd/pm8xxx/core.h>
-#include <linux/mfd/pm8xxx/gpio.h>
 #include <linux/input/pmic8xxx-keypad.h>
 
 #define PM8XXX_MAX_ROWS		18
@@ -447,27 +446,6 @@ static int pmic8xxx_kpd_init(struct pmic8xxx_kp *kp)
 
 }
 
-static int  pmic8xxx_kp_config_gpio(int gpio_start, int num_gpios,
-			struct pmic8xxx_kp *kp, struct pm_gpio *gpio_config)
-{
-	int	rc, i;
-
-	if (gpio_start < 0 || num_gpios < 0)
-		return -EINVAL;
-
-	for (i = 0; i < num_gpios; i++) {
-		rc = pm8xxx_gpio_config(gpio_start + i, gpio_config);
-		if (rc) {
-			dev_err(kp->dev, "%s: FAIL pm8xxx_gpio_config():"
-					"for PM GPIO [%d] rc=%d.\n",
-					__func__, gpio_start + i, rc);
-			return rc;
-		}
-	 }
-
-	return 0;
-}
-
 static int pmic8xxx_kp_enable(struct pmic8xxx_kp *kp)
 {
 	int rc;
@@ -527,27 +505,6 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
 	int rc;
 	u8 ctrl_val;
 
-	struct pm_gpio kypd_drv = {
-		.direction	= PM_GPIO_DIR_OUT,
-		.output_buffer	= PM_GPIO_OUT_BUF_OPEN_DRAIN,
-		.output_value	= 0,
-		.pull		= PM_GPIO_PULL_NO,
-		.vin_sel	= PM_GPIO_VIN_S3,
-		.out_strength	= PM_GPIO_STRENGTH_LOW,
-		.function	= PM_GPIO_FUNC_1,
-		.inv_int_pol	= 1,
-	};
-
-	struct pm_gpio kypd_sns = {
-		.direction	= PM_GPIO_DIR_IN,
-		.pull		= PM_GPIO_PULL_UP_31P5,
-		.vin_sel	= PM_GPIO_VIN_S3,
-		.out_strength	= PM_GPIO_STRENGTH_NO,
-		.function	= PM_GPIO_FUNC_NORMAL,
-		.inv_int_pol	= 1,
-	};
-
-
 	if (!pdata || !pdata->num_cols || !pdata->num_rows ||
 		pdata->num_cols > PM8XXX_MAX_COLS ||
 		pdata->num_rows > PM8XXX_MAX_ROWS ||
@@ -653,20 +610,6 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
 		goto err_get_irq;
 	}
 
-	rc = pmic8xxx_kp_config_gpio(pdata->cols_gpio_start,
-					pdata->num_cols, kp, &kypd_sns);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "unable to configure keypad sense lines\n");
-		goto err_gpio_config;
-	}
-
-	rc = pmic8xxx_kp_config_gpio(pdata->rows_gpio_start,
-					pdata->num_rows, kp, &kypd_drv);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "unable to configure keypad drive lines\n");
-		goto err_gpio_config;
-	}
-
 	rc = request_any_context_irq(kp->key_sense_irq, pmic8xxx_kp_irq,
 				 IRQF_TRIGGER_RISING, "pmic-keypad", kp);
 	if (rc < 0) {
@@ -703,7 +646,6 @@ err_pmic_reg_read:
 	free_irq(kp->key_stuck_irq, kp);
 err_req_stuck_irq:
 	free_irq(kp->key_sense_irq, kp);
-err_gpio_config:
 err_get_irq:
 	input_free_device(kp->input);
 err_alloc_device:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
