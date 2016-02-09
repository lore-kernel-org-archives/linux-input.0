From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH 2/3] input: syscon support in bcm_iproc_tsc driver
Date: Tue,  9 Feb 2016 14:27:56 +0530
Message-ID: <1455008277-8312-3-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Touch screen controller registers are shared with ADC and flex timer.
Using readl/writel could lead to race condition. So in such cases
we need to support register access using syscon framework based API's.

In the platform's where touchscreen register's are not shared normal
readl/writel could be used.

Based on the dt entry "reg" or "ts_syscon" register accesses are handled.
if "reg" is provided normal readl/writel API's are used to access
register's else if "ts_syscon" is provided then syscon API's are used.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/input/touchscreen/bcm_iproc_tsc.c | 122 ++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 33 deletions(-)

diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index ae460a5c..56c7c08 100644
--- a/drivers/input/touchscreen/bcm_iproc_tsc.c
+++ b/drivers/input/touchscreen/bcm_iproc_tsc.c
@@ -23,6 +23,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/serio.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #define IPROC_TS_NAME "iproc-ts"
 
@@ -88,7 +90,7 @@
 #define TS_WIRE_MODE_BIT        BIT(1)
 
 #define dbg_reg(dev, priv, reg) \
-	dev_dbg(dev, "%20s= 0x%08x\n", #reg, readl((priv)->regs + reg))
+	dev_dbg(dev, "%20s= 0x%08x\n", #reg, iproc_reg_read(priv, reg))
 
 struct tsc_param {
 	/* Each step is 1024 us.  Valid 1-256 */
@@ -142,6 +144,7 @@ struct iproc_ts_priv {
 	struct input_dev *idev;
 
 	void __iomem *regs;
+	struct regmap *regmap;
 	struct clk *tsc_clk;
 
 	int  pen_status;
@@ -163,6 +166,41 @@ static const struct tsc_param iproc_default_config = {
 	.max_y            = Y_MAX,
 };
 
+static int iproc_reg_update_bits(struct iproc_ts_priv *priv, u32 reg,
+			   u32 mask, u32 val)
+{
+	int ret = 0;
+	u32 tmp, orig;
+
+	if (priv->regs) {
+		orig = readl(priv->regs);
+		tmp = orig & ~mask;
+		tmp |= val & mask;
+		writel(tmp, priv->regs + reg);
+	} else
+		ret = regmap_update_bits(priv->regmap, reg, mask, val);
+	return ret;
+}
+
+static void iproc_reg_write(struct iproc_ts_priv *priv, u32 reg, u32 val)
+{
+	if (priv->regs)
+		writel(val, priv->regs + reg);
+	else
+		regmap_write(priv->regmap, reg, val);
+}
+
+static u32 iproc_reg_read(struct iproc_ts_priv *priv, u32 reg)
+{
+	u32 val;
+
+	if (priv->regs)
+		val = readl(priv->regs + reg);
+	else
+		regmap_read(priv->regmap, reg, &val);
+	return val;
+}
+
 static void ts_reg_dump(struct iproc_ts_priv *priv)
 {
 	struct device *dev = &priv->pdev->dev;
@@ -196,22 +234,22 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 	int i;
 	bool needs_sync = false;
 
-	intr_status = readl(priv->regs + INTERRUPT_STATUS);
-	intr_status &= TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK;
+	intr_status = iproc_reg_read(priv, INTERRUPT_STATUS);
+	intr_status &= (TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK);
 	if (intr_status == 0)
 		return IRQ_NONE;
 
 	/* Clear all interrupt status bits, write-1-clear */
-	writel(intr_status, priv->regs + INTERRUPT_STATUS);
-
+	iproc_reg_write(priv, INTERRUPT_STATUS, intr_status);
 	/* Pen up/down */
 	if (intr_status & TS_PEN_INTR_MASK) {
-		if (readl(priv->regs + CONTROLLER_STATUS) & TS_PEN_DOWN)
+		priv->pen_status = iproc_reg_read(priv, CONTROLLER_STATUS);
+		if (priv->pen_status & TS_PEN_DOWN)
 			priv->pen_status = PEN_DOWN_STATUS;
 		else
 			priv->pen_status = PEN_UP_STATUS;
 
-		input_report_key(priv->idev, BTN_TOUCH, priv->pen_status);
+		input_report_key(priv->idev, BTN_TOUCH,	priv->pen_status);
 		needs_sync = true;
 
 		dev_dbg(&priv->pdev->dev,
@@ -221,7 +259,7 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 	/* coordinates in FIFO exceed the theshold */
 	if (intr_status & TS_FIFO_INTR_MASK) {
 		for (i = 0; i < priv->cfg_params.fifo_threshold; i++) {
-			raw_coordinate = readl(priv->regs + FIFO_DATA);
+			raw_coordinate = iproc_reg_read(priv, FIFO_DATA);
 			if (raw_coordinate == INVALID_COORD)
 				continue;
 
@@ -239,7 +277,7 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 			x = (x >> 4) & 0x0FFF;
 			y = (y >> 4) & 0x0FFF;
 
-			/* adjust x y according to lcd tsc mount angle */
+			/* Adjust x y according to LCD tsc mount angle. */
 			if (priv->cfg_params.invert_x)
 				x = priv->cfg_params.max_x - x;
 
@@ -262,9 +300,10 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 
 static int iproc_ts_start(struct input_dev *idev)
 {
-	struct iproc_ts_priv *priv = input_get_drvdata(idev);
 	u32 val;
+	u32 mask;
 	int error;
+	struct iproc_ts_priv *priv = input_get_drvdata(idev);
 
 	/* Enable clock */
 	error = clk_prepare_enable(priv->tsc_clk);
@@ -279,9 +318,10 @@ static int iproc_ts_start(struct input_dev *idev)
 	 *  FIFO reaches the int_th value, and pen event(up/down)
 	 */
 	val = TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK;
-	writel(val, priv->regs + INTERRUPT_MASK);
+	iproc_reg_update_bits(priv, INTERRUPT_MASK, val, val);
 
-	writel(priv->cfg_params.fifo_threshold, priv->regs + INTERRUPT_THRES);
+	val = priv->cfg_params.fifo_threshold;
+	iproc_reg_write(priv, INTERRUPT_THRES, val);
 
 	/* Initialize control reg1 */
 	val = 0;
@@ -289,26 +329,23 @@ static int iproc_ts_start(struct input_dev *idev)
 	val |= priv->cfg_params.debounce_timeout << DEBOUNCE_TIMEOUT_SHIFT;
 	val |= priv->cfg_params.settling_timeout << SETTLING_TIMEOUT_SHIFT;
 	val |= priv->cfg_params.touch_timeout << TOUCH_TIMEOUT_SHIFT;
-	writel(val, priv->regs + REGCTL1);
+	iproc_reg_write(priv, REGCTL1, val);
 
 	/* Try to clear all interrupt status */
-	val = readl(priv->regs + INTERRUPT_STATUS);
-	val |= TS_FIFO_INTR_MASK | TS_PEN_INTR_MASK;
-	writel(val, priv->regs + INTERRUPT_STATUS);
+	val = TS_FIFO_INTR_MASK | TS_PEN_INTR_MASK;
+	iproc_reg_update_bits(priv, INTERRUPT_STATUS, val, val);
 
 	/* Initialize control reg2 */
-	val = readl(priv->regs + REGCTL2);
-	val |= TS_CONTROLLER_EN_BIT | TS_WIRE_MODE_BIT;
-
-	val &= ~TS_CONTROLLER_AVGDATA_MASK;
+	val = TS_CONTROLLER_EN_BIT | TS_WIRE_MODE_BIT;
 	val |= priv->cfg_params.average_data << TS_CONTROLLER_AVGDATA_SHIFT;
 
-	val &= ~(TS_CONTROLLER_PWR_LDO |	/* PWR up LDO */
+	mask = (TS_CONTROLLER_AVGDATA_MASK);
+	mask |= (TS_CONTROLLER_PWR_LDO |	/* PWR up LDO */
 		   TS_CONTROLLER_PWR_ADC |	/* PWR up ADC */
 		   TS_CONTROLLER_PWR_BGP |	/* PWR up BGP */
 		   TS_CONTROLLER_PWR_TS);	/* PWR up TS */
-
-	writel(val, priv->regs + REGCTL2);
+	mask |= val;
+	iproc_reg_update_bits(priv, REGCTL2, mask, val);
 
 	ts_reg_dump(priv);
 
@@ -320,12 +357,17 @@ static void iproc_ts_stop(struct input_dev *dev)
 	u32 val;
 	struct iproc_ts_priv *priv = input_get_drvdata(dev);
 
-	writel(0, priv->regs + INTERRUPT_MASK); /* Disable all interrupts */
+	/*
+	 * Disable FIFO int_th and pen event(up/down)Interrupts only
+	 * as the interrupt mask register is shared between ADC, TS and
+	 * flextimer.
+	 */
+	val = TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK;
+	iproc_reg_update_bits(priv, INTERRUPT_MASK, val, 0);
 
 	/* Only power down touch screen controller */
-	val = readl(priv->regs + REGCTL2);
-	val |= TS_CONTROLLER_PWR_TS;
-	writel(val, priv->regs + REGCTL2);
+	val = TS_CONTROLLER_PWR_TS;
+	iproc_reg_update_bits(priv, REGCTL2, val, val);
 
 	clk_disable(priv->tsc_clk);
 }
@@ -422,13 +464,27 @@ static int iproc_ts_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	/* touchscreen controller memory mapped regs */
+	/* touchscreen controller memory mapped regs if provided */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->regs)) {
-		error = PTR_ERR(priv->regs);
-		dev_err(&pdev->dev, "unable to map I/O memory: %d\n", error);
-		return error;
+	if (res) {
+		priv->regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->regs)) {
+			error = PTR_ERR(priv->regs);
+			dev_err(&pdev->dev, "unable to map I/O memory:%d\n",
+				error);
+			return error;
+		}
+	} else {
+		/* touchscreen controller memory mapped regs */
+		priv->regmap = syscon_regmap_lookup_by_phandle(
+							pdev->dev.of_node,
+							"ts_syscon");
+		if (IS_ERR(priv->regmap)) {
+			error = PTR_ERR(priv->regs);
+			dev_err(&pdev->dev, "unable to map I/O memory:%d\n",
+				error);
+			return error;
+		}
 	}
 
 	priv->tsc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
-- 
1.9.1
