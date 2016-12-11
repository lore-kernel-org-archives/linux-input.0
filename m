From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: [PATCH] Input: imx6ul_tsc - generalize the averaging property
Date: Sun, 11 Dec 2016 09:06:43 +0200
Message-ID: <1481440003-27168-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, robh@kernel.org
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, Guy Shapiro <guy.shapiro@mobi-wize.com>, devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Make the avarage-samples property a general touchscreen property
rather than imx6ul device specific.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 .../bindings/input/touchscreen/imx6ul_tsc.txt      | 11 ++----
 .../bindings/input/touchscreen/touchscreen.txt     |  3 ++
 drivers/input/touchscreen/imx6ul_tsc.c             | 46 ++++++++++++++++------
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
index a66069f..d4927c2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
@@ -17,13 +17,8 @@ Optional properties:
   This value depends on the touch screen.
 - pre-charge-time: the touch screen need some time to precharge.
   This value depends on the touch screen.
-- average-samples: Number of data samples which are averaged for each read.
-	Valid values 0-4
-	0 =  1 sample
-	1 =  4 samples
-	2 =  8 samples
-	3 = 16 samples
-	4 = 32 samples
+- touchscreen-average-samples: Number of data samples which are averaged for
+  each read. Valid values are 1, 4, 8, 16 and 32.
 
 Example:
 	tsc: tsc@02040000 {
@@ -39,6 +34,6 @@ Example:
 		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		measure-delay-time = <0xfff>;
 		pre-charge-time = <0xffff>;
-		average-samples = <4>;
+		touchscreen-average-samples = <32>;
 		status = "okay";
 	};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
index bccaa4e..537643e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -14,6 +14,9 @@ Optional properties for Touchscreens:
  - touchscreen-fuzz-pressure	: pressure noise value of the absolute input
 				  device (arbitrary range dependent on the
 				  controller)
+ - touchscreen-average-samples : Number of data samples which are averaged
+				  for each read (valid values dependent on the
+				  controller)
  - touchscreen-inverted-x	: X axis is inverted (boolean)
  - touchscreen-inverted-y	: Y axis is inverted (boolean)
  - touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index d2a3912..58d1aa5 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -93,7 +93,8 @@ struct imx6ul_tsc {
 
 	u32 measure_delay_time;
 	u32 pre_charge_time;
-	u32 average_samples;
+	bool average_enable;
+	u32 average_select;
 
 	struct completion completion;
 };
@@ -117,9 +118,9 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 	adc_cfg |= ADC_12BIT_MODE | ADC_IPG_CLK;
 	adc_cfg &= ~(ADC_CLK_DIV_MASK | ADC_SAMPLE_MODE_MASK);
 	adc_cfg |= ADC_CLK_DIV_8 | ADC_SHORT_SAMPLE_MODE;
-	if (tsc->average_samples) {
+	if (tsc->average_enable) {
 		adc_cfg &= ~ADC_AVGS_MASK;
-		adc_cfg |= (tsc->average_samples - 1) << ADC_AVGS_SHIFT;
+		adc_cfg |= (tsc->average_select) << ADC_AVGS_SHIFT;
 	}
 	adc_cfg &= ~ADC_HARDWARE_TRIGGER;
 	writel(adc_cfg, tsc->adc_regs + REG_ADC_CFG);
@@ -132,7 +133,7 @@ static int imx6ul_adc_init(struct imx6ul_tsc *tsc)
 	/* start ADC calibration */
 	adc_gc = readl(tsc->adc_regs + REG_ADC_GC);
 	adc_gc |= ADC_CAL;
-	if (tsc->average_samples)
+	if (tsc->average_enable)
 		adc_gc |= ADC_AVGE;
 	writel(adc_gc, tsc->adc_regs + REG_ADC_GC);
 
@@ -362,6 +363,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	int err;
 	int tsc_irq;
 	int adc_irq;
+	u32 average_samples;
 
 	tsc = devm_kzalloc(&pdev->dev, sizeof(*tsc), GFP_KERNEL);
 	if (!tsc)
@@ -466,14 +468,36 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	if (err)
 		tsc->pre_charge_time = 0xfff;
 
-	err = of_property_read_u32(np, "average-samples",
-				   &tsc->average_samples);
+	err = of_property_read_u32(np, "touchscreen-average-samples",
+				   &average_samples);
 	if (err)
-		tsc->average_samples = 0;
-
-	if (tsc->average_samples > 4) {
-		dev_err(&pdev->dev, "average-samples (%u) must be [0-4]\n",
-			tsc->average_samples);
+		average_samples = 1;
+
+	switch (average_samples) {
+	case 1:
+		tsc->average_enable = false;
+		tsc->average_select = 0; /* value unused; initialize anyway */
+		break;
+	case 4:
+		tsc->average_enable = true;
+		tsc->average_select = 0;
+		break;
+	case 8:
+		tsc->average_enable = true;
+		tsc->average_select = 1;
+		break;
+	case 16:
+		tsc->average_enable = true;
+		tsc->average_select = 2;
+		break;
+	case 32:
+		tsc->average_enable = true;
+		tsc->average_select = 3;
+		break;
+	default:
+		dev_err(&pdev->dev,
+			"touchscreen-average-samples (%u) must be 1, 4, 8, 16 or 32\n",
+			average_samples);
 		return -EINVAL;
 	}
 
-- 
2.1.4
