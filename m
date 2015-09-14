From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 1/4] Input: imx6ul_tsc - Propagate the errors
Date: Mon, 14 Sep 2015 14:00:00 -0300
Message-ID: <1442250003-4040-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0105.outbound.protection.outlook.com ([65.55.169.105]:35040
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752409AbbINRAM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 13:00:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

imx6ul_adc_init() may fail in two cases, so we should better
propagate the errors and make sure that the callers of 
this function also check and propagate the errors accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Pass 'imx6ul_tsc' in the Subject

 drivers/input/touchscreen/imx6ul_tsc.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index ff0b758..0a96b76 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -94,7 +94,7 @@ struct imx6ul_tsc {
  * TSC module need ADC to get the measure value. So
  * before config TSC, we should initialize ADC module.
  */
-static void imx6ul_adc_init(struct imx6ul_tsc *tsc)
+static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 {
 	int adc_hc = 0;
 	int adc_gc;
@@ -122,17 +122,23 @@ static void imx6ul_adc_init(struct imx6ul_tsc *tsc)
 
 	timeout = wait_for_completion_timeout
 			(&tsc->completion, ADC_TIMEOUT);
-	if (timeout == 0)
+	if (timeout == 0) {
 		dev_err(tsc->dev, "Timeout for adc calibration\n");
+		return -ETIMEDOUT;
+	}
 
 	adc_gs = readl(tsc->adc_regs + REG_ADC_GS);
-	if (adc_gs & ADC_CALF)
+	if (adc_gs & ADC_CALF) {
 		dev_err(tsc->dev, "ADC calibration failed\n");
+		return -EINVAL;
+	}
 
 	/* TSC need the ADC work in hardware trigger */
 	adc_cfg = readl(tsc->adc_regs + REG_ADC_CFG);
 	adc_cfg |= ADC_HARDWARE_TRIGGER;
 	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
+
+	return 0;
 }
 
 /*
@@ -188,11 +194,17 @@ static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 	writel(start, tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
 }
 
-static void imx6ul_tsc_init(struct imx6ul_tsc *tsc)
+static int imx6ul_tsc_init(struct imx6ul_tsc *tsc)
 {
-	imx6ul_adc_init(tsc);
+	int err;
+
+	err = imx6ul_adc_init(tsc);
+	if (err)
+		return err;
 	imx6ul_tsc_channel_config(tsc);
 	imx6ul_tsc_set(tsc);
+
+	return 0;
 }
 
 static void imx6ul_tsc_disable(struct imx6ul_tsc *tsc)
@@ -311,9 +323,7 @@ static int imx6ul_tsc_open(struct input_dev *input_dev)
 		return err;
 	}
 
-	imx6ul_tsc_init(tsc);
-
-	return 0;
+	return imx6ul_tsc_init(tsc);
 }
 
 static void imx6ul_tsc_close(struct input_dev *input_dev)
@@ -491,7 +501,7 @@ static int __maybe_unused imx6ul_tsc_resume(struct device *dev)
 			goto out;
 		}
 
-		imx6ul_tsc_init(tsc);
+		retval = imx6ul_tsc_init(tsc);
 	}
 
 out:
-- 
1.9.1

