From: Juergen Beisert <jbe@pengutronix.de>
Subject: [PATCH 3/9] Staging/iio/adc/touchscreen/MXS: separate i.MX28 specific
 register bits
Date: Mon, 23 Sep 2013 16:36:32 +0200
Message-ID: <1379946998-23041-4-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

In order to support i.MX23 and i.MX28 within one driver we need to separate the
register definitions which differ in both SoC variants.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-input@vger.kernel.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/mxs-lradc.c | 61 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 3abc91f..f2fb10a 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -182,24 +182,29 @@ struct mxs_lradc {
 };
 
 #define	LRADC_CTRL0				0x00
-#define	LRADC_CTRL0_TOUCH_DETECT_ENABLE		(1 << 23)
-#define	LRADC_CTRL0_TOUCH_SCREEN_TYPE		(1 << 22)
-#define	LRADC_CTRL0_YNNSW	/* YM */	(1 << 21)
-#define	LRADC_CTRL0_YPNSW	/* YP */	(1 << 20)
-#define	LRADC_CTRL0_YPPSW	/* YP */	(1 << 19)
-#define	LRADC_CTRL0_XNNSW	/* XM */	(1 << 18)
-#define	LRADC_CTRL0_XNPSW	/* XM */	(1 << 17)
-#define	LRADC_CTRL0_XPPSW	/* XP */	(1 << 16)
-#define	LRADC_CTRL0_PLATE_MASK			(0x3f << 16)
+# define LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE	(1 << 23)
+# define LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE	(1 << 22)
+# define LRADC_CTRL0_MX28_YNNSW	/* YM */	(1 << 21)
+# define LRADC_CTRL0_MX28_YPNSW	/* YP */	(1 << 20)
+# define LRADC_CTRL0_MX28_YPPSW	/* YP */	(1 << 19)
+# define LRADC_CTRL0_MX28_XNNSW	/* XM */	(1 << 18)
+# define LRADC_CTRL0_MX28_XNPSW	/* XM */	(1 << 17)
+# define LRADC_CTRL0_MX28_XPPSW	/* XP */	(1 << 16)
+
+# define LRADC_CTRL0_MX28_PLATE_MASK \
+		(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE | \
+		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
+		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
+		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW)
 
 #define	LRADC_CTRL1				0x10
 #define	LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		(1 << 24)
 #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
-#define	LRADC_CTRL1_LRADC_IRQ_EN_MASK		(0x1fff << 16)
+#define	LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
 #define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
 #define	LRADC_CTRL1_TOUCH_DETECT_IRQ		(1 << 8)
 #define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
-#define	LRADC_CTRL1_LRADC_IRQ_MASK		0x1fff
+#define	LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
 #define	LRADC_CTRL1_LRADC_IRQ_OFFSET		0
 
 #define	LRADC_CTRL2				0x20
@@ -267,7 +272,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	 * Virtual channel 0 is always used here as the others are always not
 	 * used if doing raw sampling.
 	 */
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
+	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
@@ -322,9 +327,9 @@ static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
 	uint32_t reg;
 
 	/* Enable touch detection. */
-	writel(LRADC_CTRL0_PLATE_MASK,
+	writel(LRADC_CTRL0_MX28_PLATE_MASK,
 		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
 		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 
 	msleep(LRADC_TS_SAMPLE_DELAY_MS);
@@ -370,21 +375,21 @@ static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
 	 */
 	switch (plate) {
 	case LRADC_SAMPLE_X:
-		ctrl0 = LRADC_CTRL0_XPPSW | LRADC_CTRL0_XNNSW;
+		ctrl0 = LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
 		chan = 3;
 		break;
 	case LRADC_SAMPLE_Y:
-		ctrl0 = LRADC_CTRL0_YPPSW | LRADC_CTRL0_YNNSW;
+		ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
 		chan = 4;
 		break;
 	case LRADC_SAMPLE_PRESSURE:
-		ctrl0 = LRADC_CTRL0_YPPSW | LRADC_CTRL0_XNNSW;
+		ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
 		chan = 5;
 		break;
 	}
 
 	if (change) {
-		writel(LRADC_CTRL0_PLATE_MASK,
+		writel(LRADC_CTRL0_MX28_PLATE_MASK,
 			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 		writel(ctrl0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 
@@ -445,7 +450,7 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
 
 	while (mxs_lradc_ts_touched(lradc)) {
 		/* Disable touch detector so we can sample the touchscreen. */
-		writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
 			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
 		if (likely(valid)) {
@@ -494,7 +499,7 @@ static int mxs_lradc_ts_open(struct input_dev *dev)
 	lradc->stop_touchscreen = false;
 
 	/* Enable the touch-detect circuitry. */
-	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
 		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 
 	/* Enable the touch-detect IRQ. */
@@ -520,7 +525,7 @@ static void mxs_lradc_ts_close(struct input_dev *dev)
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	/* Power-down touchscreen touch-detect circuitry. */
-	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
 		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 }
 
@@ -584,7 +589,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 		LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
 		LRADC_CTRL1_TOUCH_DETECT_IRQ;
 
-	if (!(reg & LRADC_CTRL1_LRADC_IRQ_MASK))
+	if (!(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK))
 		return IRQ_NONE;
 
 	/*
@@ -604,7 +609,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
 		complete(&lradc->completion);
 
-	writel(reg & LRADC_CTRL1_LRADC_IRQ_MASK,
+	writel(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK,
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	return IRQ_HANDLED;
@@ -725,7 +730,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 	if (ret < 0)
 		goto err_buf;
 
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
+	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
@@ -766,7 +771,7 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
 		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
 
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
+	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	kfree(lradc->buffer);
@@ -870,11 +875,11 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 	writel(0, lradc->base + LRADC_DELAY(3));
 
 	/* Configure the touchscreen type */
-	writel(LRADC_CTRL0_TOUCH_SCREEN_TYPE,
+	writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
 		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
 	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE) {
-		writel(LRADC_CTRL0_TOUCH_SCREEN_TYPE,
+		writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
 			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 	}
 
@@ -888,7 +893,7 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
 {
 	int i;
 
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
+	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
-- 
1.8.4.rc3
