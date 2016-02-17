From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v2 2/3] input: syscon support in bcm_iproc_tsc driver
Date: Wed, 17 Feb 2016 15:13:45 +0530
Message-ID: <1455702226-20599-3-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
List-Id: linux-input@vger.kernel.org

In Cygnus SOC touch screen controller registers are shared
with ADC and flex timer. Using readl/writel could lead to
race condition. So touch screen driver is enhanced to support

1. If touchscreen register's are not shared. Register access
is handled through readl/writel if "brcm,iproc-touchscreen"
compatible is provided in touchscreen dt node. This will help
for future SOC's if comes with dedicated touchscreen IP register's.

2. If touchscreen register's are shared with other IP's, register
access is handled through syscon framework API's to take care of
mutually exclusive access. This feature can be enabled by selecting
"brcm,iproc-touchscreen-syscon" compatible string in the touchscreen
dt node.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/input/touchscreen/bcm_iproc_tsc.c | 152 ++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 40 deletions(-)

diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index ae460a5c..3ef80c6 100644
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
@@ -142,12 +144,18 @@ struct iproc_ts_priv {
 	struct input_dev *idev;
 
 	void __iomem *regs;
+	struct regmap *regmap;
 	struct clk *tsc_clk;
 
 	int  pen_status;
 	struct tsc_param cfg_params;
 };
 
+enum iproc_ts_reg_type {
+	IPROC_TS_REG,
+	IPROC_TS_SYSCON,
+};
+
 /*
  * Set default values the same as hardware reset values
  * except for fifo_threshold with is set to 1.
@@ -163,6 +171,41 @@ static const struct tsc_param iproc_default_config = {
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
@@ -196,22 +239,22 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
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
@@ -221,7 +264,7 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 	/* coordinates in FIFO exceed the theshold */
 	if (intr_status & TS_FIFO_INTR_MASK) {
 		for (i = 0; i < priv->cfg_params.fifo_threshold; i++) {
-			raw_coordinate = readl(priv->regs + FIFO_DATA);
+			raw_coordinate = iproc_reg_read(priv, FIFO_DATA);
 			if (raw_coordinate == INVALID_COORD)
 				continue;
 
@@ -239,7 +282,7 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 			x = (x >> 4) & 0x0FFF;
 			y = (y >> 4) & 0x0FFF;
 
-			/* adjust x y according to lcd tsc mount angle */
+			/* Adjust x y according to LCD tsc mount angle. */
 			if (priv->cfg_params.invert_x)
 				x = priv->cfg_params.max_x - x;
 
@@ -262,9 +305,10 @@ static irqreturn_t iproc_touchscreen_interrupt(int irq, void *data)
 
 static int iproc_ts_start(struct input_dev *idev)
 {
-	struct iproc_ts_priv *priv = input_get_drvdata(idev);
 	u32 val;
+	u32 mask;
 	int error;
+	struct iproc_ts_priv *priv = input_get_drvdata(idev);
 
 	/* Enable clock */
 	error = clk_prepare_enable(priv->tsc_clk);
@@ -279,9 +323,10 @@ static int iproc_ts_start(struct input_dev *idev)
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
@@ -289,26 +334,23 @@ static int iproc_ts_start(struct input_dev *idev)
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
 
@@ -320,12 +362,17 @@ static void iproc_ts_stop(struct input_dev *dev)
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
@@ -410,25 +457,56 @@ static int iproc_get_tsc_config(struct device *dev, struct iproc_ts_priv *priv)
 	return 0;
 }
 
+static const struct of_device_id iproc_ts_of_match[] = {
+	{.compatible = "brcm,iproc-touchscreen",
+	 .data = (void *) IPROC_TS_REG },
+	{.compatible = "brcm,iproc-touchscreen-syscon",
+	 .data = (void *) IPROC_TS_SYSCON },
+	{},
+};
+MODULE_DEVICE_TABLE(of, iproc_ts_of_match);
+
 static int iproc_ts_probe(struct platform_device *pdev)
 {
 	struct iproc_ts_priv *priv;
 	struct input_dev *idev;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	int irq;
 	int error;
+	enum iproc_ts_reg_type reg_access;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	/* touchscreen controller memory mapped regs */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->regs)) {
-		error = PTR_ERR(priv->regs);
-		dev_err(&pdev->dev, "unable to map I/O memory: %d\n", error);
-		return error;
+	of_id = of_match_node(iproc_ts_of_match, pdev->dev.of_node);
+	if (of_id)
+		reg_access = (enum iproc_ts_reg_type)of_id->data;
+	else
+		return -ENODEV;
+
+	if (reg_access == IPROC_TS_SYSCON) {
+		/* touchscreen controller memory mapped regs via syscon */
+		priv->regmap = syscon_regmap_lookup_by_phandle(
+						pdev->dev.of_node,
+						"ts_syscon");
+		if (IS_ERR(priv->regmap)) {
+			error = PTR_ERR(priv->regs);
+			dev_err(&pdev->dev, "unable to map I/O memory:%d\n",
+				error);
+			return error;
+		}
+	} else {
+		/* touchscreen controller memory mapped regs */
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		priv->regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->regs)) {
+			error = PTR_ERR(priv->regs);
+			dev_err(&pdev->dev, "unable to map I/O memory:%d\n",
+				error);
+			return error;
+		}
 	}
 
 	priv->tsc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
@@ -501,12 +579,6 @@ static int iproc_ts_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id iproc_ts_of_match[] = {
-	{.compatible = "brcm,iproc-touchscreen", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, iproc_ts_of_match);
-
 static struct platform_driver iproc_ts_driver = {
 	.probe = iproc_ts_probe,
 	.driver = {
-- 
1.9.1
