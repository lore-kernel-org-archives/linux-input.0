From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: [PATCH 2/2] input: touchscreen: sample averaging for imx6ul_tsc
Date: Sun, 27 Nov 2016 09:44:58 +0200
Message-ID: <1480232698-23075-2-git-send-email-guy.shapiro@mobi-wize.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, Guy Shapiro <guy.shapiro@mobi-wize.com>, devicetree@vger.kernel.org, haibo.chen@freescale.com, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

The i.MX6UL internal touchscreen controller contains an option to
average upon samples. This feature reduces noise from the produced
touch locations.

This patch adds sample averaging support to the imx6ul_tsc device
driver.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 8275267..31724d9 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -25,6 +25,7 @@
 /* ADC configuration registers field define */
 #define ADC_AIEN		(0x1 << 7)
 #define ADC_CONV_DISABLE	0x1F
+#define ADC_AVGE		(0x1 << 5)
 #define ADC_CAL			(0x1 << 7)
 #define ADC_CALF		0x2
 #define ADC_12BIT_MODE		(0x2 << 2)
@@ -32,6 +33,7 @@
 #define ADC_CLK_DIV_8		(0x03 << 5)
 #define ADC_SHORT_SAMPLE_MODE	(0x0 << 4)
 #define ADC_HARDWARE_TRIGGER	(0x1 << 13)
+#define ADC_AVGS_SHIFT		14
 #define SELECT_CHANNEL_4	0x04
 #define SELECT_CHANNEL_1	0x01
 #define DISABLE_CONVERSION_INT	(0x0 << 7)
@@ -86,6 +88,7 @@ struct imx6ul_tsc {
 
 	int measure_delay_time;
 	int pre_charge_time;
+	int average_samples;
 
 	struct completion completion;
 };
@@ -107,6 +110,8 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 	adc_cfg = readl(tsc->adc_regs + REG_ADC_CFG);
 	adc_cfg |= ADC_12BIT_MODE | ADC_IPG_CLK;
 	adc_cfg |= ADC_CLK_DIV_8 | ADC_SHORT_SAMPLE_MODE;
+	if (tsc->average_samples)
+		adc_cfg |= (tsc->average_samples - 1) << ADC_AVGS_SHIFT;
 	adc_cfg &= ~ADC_HARDWARE_TRIGGER;
 	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
 
@@ -118,6 +123,8 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 	/* start ADC calibration */
 	adc_gc = readl(tsc->adc_regs + REG_ADC_GC);
 	adc_gc |= ADC_CAL;
+	if (tsc->average_samples)
+		adc_gc |= ADC_AVGE;
 	writel(adc_gc, tsc->adc_regs + REG_ADC_GC);
 
 	timeout = wait_for_completion_timeout
@@ -450,6 +457,16 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	if (err)
 		tsc->pre_charge_time = 0xfff;
 
+	err = of_property_read_u32(np, "average-samples",
+				   &tsc->average_samples);
+	if (err)
+		tsc->average_samples = 0;
+	if (tsc->average_samples > 4) {
+		dev_err(&pdev->dev, "average-samples (%u) must be [0-4]\n",
+			tsc->average_samples);
+		return -EINVAL;
+	}
+
 	err = input_register_device(tsc->input);
 	if (err) {
 		dev_err(&pdev->dev,
-- 
2.1.4
