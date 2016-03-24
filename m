From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v5 2/3] input: syscon support in bcm_iproc_tsc driver
Date: Thu, 24 Mar 2016 11:17:14 +0530
Message-ID: <1458798435-20222-3-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1458798435-20222-1-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1458798435-20222-1-git-send-email-raveendra.padasalagi@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

In Cygnus SOC touch screen controller registers are shared
with ADC and flex timer. Using readl/writel could lead to
race condition. So touch screen driver is enhanced to support
register access using syscon framework API's to take care of
mutually exclusive access.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/bcm_iproc_tsc.c | 79 +++++++++++++++++--------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index ae460a5c..0fd5f35 100644
--- a/drivers/input/touchscreen/bcm_iproc_tsc.c
+++ b/drivers/input/touchscreen/bcm_iproc_tsc.c
@@ -23,6 +23,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/serio.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #define IPROC_TS_NAME "iproc-ts"
 
@@ -88,7 +90,11 @@
 #define TS_WIRE_MODE_BIT        BIT(1)
 
 #define dbg_reg(dev, priv, reg) \
-	dev_dbg(dev, "%20s= 0x%08x\n", #reg, readl((priv)->regs + reg))
+do { \
+	u32 val; \
+	regmap_read(priv->regmap, reg, &val); \
+	dev_dbg(dev, "%20s= 0x%08x\n", #reg, val); \
+} while (0)
 
 struct tsc_param {
 	/* Each step is 1024 us.  Valid 1-256 */
@@ -141,7 +147,7 @@ struct iproc_ts_priv {
 	struct platform_device *pdev;
 	struct input_dev *idev;
 
-	void __iomem *regs;
+	struct regmap *regmap;
 	struct clk *tsc_clk;
 
 	int  pen_status;
@@ -196,22 +202,22 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 	int i;
 	bool needs_sync = false;
 
-	intr_status = readl(priv->regs + INTERRUPT_STATUS);
-	intr_status &= TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK;
+	regmap_read(priv->regmap, INTERRUPT_STATUS, &intr_status);
+	intr_status &= (TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK);
 	if (intr_status == 0)
 		return IRQ_NONE;
 
 	/* Clear all interrupt status bits, write-1-clear */
-	writel(intr_status, priv->regs + INTERRUPT_STATUS);
-
+	regmap_write(priv->regmap, INTERRUPT_STATUS, intr_status);
 	/* Pen up/down */
 	if (intr_status & TS_PEN_INTR_MASK) {
-		if (readl(priv->regs + CONTROLLER_STATUS) & TS_PEN_DOWN)
+		regmap_read(priv->regmap, CONTROLLER_STATUS, &priv->pen_status);
+		if (priv->pen_status & TS_PEN_DOWN)
 			priv->pen_status = PEN_DOWN_STATUS;
 		else
 			priv->pen_status = PEN_UP_STATUS;
 
-		input_report_key(priv->idev, BTN_TOUCH, priv->pen_status);
+		input_report_key(priv->idev, BTN_TOUCH,	priv->pen_status);
 		needs_sync = true;
 
 		dev_dbg(&priv->pdev->dev,
@@ -221,7 +227,7 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 	/* coordinates in FIFO exceed the theshold */
 	if (intr_status & TS_FIFO_INTR_MASK) {
 		for (i = 0; i < priv->cfg_params.fifo_threshold; i++) {
-			raw_coordinate = readl(priv->regs + FIFO_DATA);
+			regmap_read(priv->regmap, FIFO_DATA, &raw_coordinate);
 			if (raw_coordinate == INVALID_COORD)
 				continue;
 
@@ -239,7 +245,7 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 			x = (x >> 4) & 0x0FFF;
 			y = (y >> 4) & 0x0FFF;
 
-			/* adjust x y according to lcd tsc mount angle */
+			/* Adjust x y according to LCD tsc mount angle. */
 			if (priv->cfg_params.invert_x)
 				x = priv->cfg_params.max_x - x;
 
@@ -262,9 +268,10 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 
 static int iproc_ts_start(struct input_dev *idev)
 {
-	struct iproc_ts_priv *priv = input_get_drvdata(idev);
 	u32 val;
+	u32 mask;
 	int error;
+	struct iproc_ts_priv *priv = input_get_drvdata(idev);
 
 	/* Enable clock */
 	error = clk_prepare_enable(priv->tsc_clk);
@@ -279,9 +286,10 @@ static int iproc_ts_start(struct input_dev *idev)
 	 *  FIFO reaches the int_th value, and pen event(up/down)
 	 */
 	val = TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK;
-	writel(val, priv->regs + INTERRUPT_MASK);
+	regmap_update_bits(priv->regmap, INTERRUPT_MASK, val, val);
 
-	writel(priv->cfg_params.fifo_threshold, priv->regs + INTERRUPT_THRES);
+	val = priv->cfg_params.fifo_threshold;
+	regmap_write(priv->regmap, INTERRUPT_THRES, val);
 
 	/* Initialize control reg1 */
 	val = 0;
@@ -289,26 +297,23 @@ static int iproc_ts_start(struct input_dev *idev)
 	val |= priv->cfg_params.debounce_timeout << DEBOUNCE_TIMEOUT_SHIFT;
 	val |= priv->cfg_params.settling_timeout << SETTLING_TIMEOUT_SHIFT;
 	val |= priv->cfg_params.touch_timeout << TOUCH_TIMEOUT_SHIFT;
-	writel(val, priv->regs + REGCTL1);
+	regmap_write(priv->regmap, REGCTL1, val);
 
 	/* Try to clear all interrupt status */
-	val = readl(priv->regs + INTERRUPT_STATUS);
-	val |= TS_FIFO_INTR_MASK | TS_PEN_INTR_MASK;
-	writel(val, priv->regs + INTERRUPT_STATUS);
+	val = TS_FIFO_INTR_MASK | TS_PEN_INTR_MASK;
+	regmap_update_bits(priv->regmap, INTERRUPT_STATUS, val, val);
 
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
+	regmap_update_bits(priv->regmap, REGCTL2, mask, val);
 
 	ts_reg_dump(priv);
 
@@ -320,12 +325,17 @@ static void iproc_ts_stop(struct input_dev *dev)
 	u32 val;
 	struct iproc_ts_priv *priv = input_get_drvdata(dev);
 
-	writel(0, priv->regs + INTERRUPT_MASK); /* Disable all interrupts */
+	/*
+	 * Disable FIFO int_th and pen event(up/down)Interrupts only
+	 * as the interrupt mask register is shared between ADC, TS and
+	 * flextimer.
+	 */
+	val = TS_PEN_INTR_MASK | TS_FIFO_INTR_MASK;
+	regmap_update_bits(priv->regmap, INTERRUPT_MASK, val, 0);
 
 	/* Only power down touch screen controller */
-	val = readl(priv->regs + REGCTL2);
-	val |= TS_CONTROLLER_PWR_TS;
-	writel(val, priv->regs + REGCTL2);
+	val = TS_CONTROLLER_PWR_TS;
+	regmap_update_bits(priv->regmap, REGCTL2, val, val);
 
 	clk_disable(priv->tsc_clk);
 }
@@ -414,7 +424,6 @@ static int iproc_ts_probe(struct platform_device *pdev)
 {
 	struct iproc_ts_priv *priv;
 	struct input_dev *idev;
-	struct resource *res;
 	int irq;
 	int error;
 
@@ -422,12 +431,12 @@ static int iproc_ts_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	/* touchscreen controller memory mapped regs */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->regs)) {
-		error = PTR_ERR(priv->regs);
-		dev_err(&pdev->dev, "unable to map I/O memory: %d\n", error);
+	/* touchscreen controller memory mapped regs via syscon*/
+	priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							"ts_syscon");
+	error = PTR_ERR_OR_ZERO(priv->regmap);
+	if (error) {
+		dev_err(&pdev->dev, "unable to map I/O memory:%d\n", error);
 		return error;
 	}
 
-- 
1.9.1
