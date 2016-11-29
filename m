From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: [PATCH] input: touchscreen: imx6ul_tsc: convert int to u32
Date: Tue, 29 Nov 2016 14:40:49 +0200
Message-ID: <1480423249-2933-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.47]:39230 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756906AbcK2NFT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 08:05:19 -0500
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 6424D32069F2C
        for <linux-input@vger.kernel.org>; Tue, 29 Nov 2016 06:41:34 -0600 (CST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: haibo.chen@nxp.com, fabio.estevam@nxp.com, bjorn.forsman@gmail.com, Guy Shapiro <guy.shapiro@mobi-wize.com>

The code uses of_property_read_u32 and expects positive values.
However, the values are stored in signed int variables.
Additionally, the registers values are also stored in signed
variables without a good reason (readl/writel expect u32).

The only time this caused a real bug was in the new average-samples
property, in which the property is numerically compared and
implicitly expected to be positive.
I believe it's better to change all the properties and registers to
u32, for consistency and warnings reduction.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
Reported-by: Bjørn Forsman <bjorn.forsman@gmail.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 31724d9..71ea2d8 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -86,9 +86,9 @@ struct imx6ul_tsc {
 	struct clk *adc_clk;
 	struct gpio_desc *xnur_gpio;
 
-	int measure_delay_time;
-	int pre_charge_time;
-	int average_samples;
+	u32 measure_delay_time;
+	u32 pre_charge_time;
+	u32 average_samples;
 
 	struct completion completion;
 };
@@ -99,10 +99,10 @@ struct imx6ul_tsc {
  */
 static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 {
-	int adc_hc = 0;
-	int adc_gc;
-	int adc_gs;
-	int adc_cfg;
+	u32 adc_hc = 0;
+	u32 adc_gc;
+	u32 adc_gs;
+	u32 adc_cfg;
 	int timeout;
 
 	reinit_completion(&tsc->completion);
@@ -155,7 +155,7 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
  */
 static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
 {
-	int adc_hc0, adc_hc1, adc_hc2, adc_hc3, adc_hc4;
+	u32 adc_hc0, adc_hc1, adc_hc2, adc_hc3, adc_hc4;
 
 	adc_hc0 = DISABLE_CONVERSION_INT;
 	writel(adc_hc0, tsc->adc_regs + REG_ADC_HC0);
@@ -180,8 +180,8 @@ static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
  */
 static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 {
-	int basic_setting = 0;
-	int start;
+	u32 basic_setting = 0;
+	u32 start;
 
 	basic_setting |= tsc->measure_delay_time << 8;
 	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE;
@@ -216,8 +216,8 @@ static int imx6ul_tsc_init(struct imx6ul_tsc *tsc)
 
 static void imx6ul_tsc_disable(struct imx6ul_tsc *tsc)
 {
-	int tsc_flow;
-	int adc_cfg;
+	u32 tsc_flow;
+	u32 adc_cfg;
 
 	/* TSC controller enters to idle status */
 	tsc_flow = readl(tsc->tsc_regs + REG_TSC_FLOW_CONTROL);
@@ -234,8 +234,8 @@ static void imx6ul_tsc_disable(struct imx6ul_tsc *tsc)
 static bool tsc_wait_detect_mode(struct imx6ul_tsc *tsc)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(2);
-	int state_machine;
-	int debug_mode2;
+	u32 state_machine;
+	u32 debug_mode2;
 
 	do {
 		if (time_after(jiffies, timeout))
@@ -253,10 +253,10 @@ static bool tsc_wait_detect_mode(struct imx6ul_tsc *tsc)
 static irqreturn_t tsc_irq_fn(int irq, void *dev_id)
 {
 	struct imx6ul_tsc *tsc = dev_id;
-	int status;
-	int value;
+	u32 status;
+	u32 value;
 	int x, y;
-	int start;
+	u32 start;
 
 	status = readl(tsc->tsc_regs + REG_TSC_INT_STATUS);
 
@@ -296,8 +296,8 @@ static irqreturn_t tsc_irq_fn(int irq, void *dev_id)
 static irqreturn_t adc_irq_fn(int irq, void *dev_id)
 {
 	struct imx6ul_tsc *tsc = dev_id;
-	int coco;
-	int value;
+	u32 coco;
+	u32 value;
 
 	coco = readl(tsc->adc_regs + REG_ADC_HS);
 	if (coco & 0x01) {
-- 
2.1.4

