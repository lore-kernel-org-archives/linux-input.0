From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] input: touchscreen: imx6ul_tsc: add mask when set REG_ADC_CFG
Date: Mon, 28 Nov 2016 16:42:23 +0800
Message-ID: <1480322543-8518-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-he1eur01on0086.outbound.protection.outlook.com ([104.47.0.86]:21120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754227AbcK1Iwj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 03:52:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: haibo.chen@nxp.com, guy.shapiro@mobi-wize.com, fabio.estevam@nxp.com

Add mask of each function bits of REG_ADC_CFG, and clear these
function bits first, otherwise use '|=' operation may get the
wrong setting which depends on the original value of REG_ADC_CFG.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 31724d9..96358fb 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -29,11 +29,16 @@
 #define ADC_CAL			(0x1 << 7)
 #define ADC_CALF		0x2
 #define ADC_12BIT_MODE		(0x2 << 2)
+#define ADC_CONV_MODE_MASK	(0x3 << 2)
 #define ADC_IPG_CLK		0x00
+#define ADC_INPUT_CLK_MASK	0x3
 #define ADC_CLK_DIV_8		(0x03 << 5)
+#define ADC_CLK_DIV_MASK	(0x3 << 5)
 #define ADC_SHORT_SAMPLE_MODE	(0x0 << 4)
+#define ADC_SAMPLE_MODE_MASK	(0x1 << 4)
 #define ADC_HARDWARE_TRIGGER	(0x1 << 13)
 #define ADC_AVGS_SHIFT		14
+#define ADC_AVGS_MASK		(0x3 << 14)
 #define SELECT_CHANNEL_4	0x04
 #define SELECT_CHANNEL_1	0x01
 #define DISABLE_CONVERSION_INT	(0x0 << 7)
@@ -108,10 +113,14 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 	reinit_completion(&tsc->completion);
 
 	adc_cfg = readl(tsc->adc_regs + REG_ADC_CFG);
+	adc_cfg &= ~(ADC_CONV_MODE_MASK | ADC_INPUT_CLK_MASK);
 	adc_cfg |= ADC_12BIT_MODE | ADC_IPG_CLK;
+	adc_cfg &= ~(ADC_CLK_DIV_MASK | ADC_SAMPLE_MODE_MASK);
 	adc_cfg |= ADC_CLK_DIV_8 | ADC_SHORT_SAMPLE_MODE;
-	if (tsc->average_samples)
+	if (tsc->average_samples) {
+		adc_cfg &= ~ADC_AVGS_MASK;
 		adc_cfg |= (tsc->average_samples - 1) << ADC_AVGS_SHIFT;
+	}
 	adc_cfg &= ~ADC_HARDWARE_TRIGGER;
 	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
 
-- 
1.9.1

