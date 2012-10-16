From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RESEND 2/8] input: TSC: ti_tscadc: Add Step configuration as platform data
Date: Tue, 16 Oct 2012 12:55:39 +0530
Message-ID: <1350372345-27108-3-git-send-email-rachna@ti.com>
References: <1350372345-27108-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350372345-27108-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

There are 16 programmable Step Configuration
registers which are used by the sequencer.
Program the Steps in order to configure a channel
input to be sampled. If the same step is applied
several times, the coordinate values read are more
accurate.
Hence we provide the user an option of how many steps
should be configured.

For ex: If this value is assigned as 4, This means that
4 steps are applied to read x co-ordinate and 4 steps to read
y co-ordinate. Furtheron the interrupt handler already
holds code to use delta filter and report the best value
out of these values to the input sub-system.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
---
 drivers/input/touchscreen/ti_tscadc.c |   25 +++++++++++++------------
 include/linux/input/ti_tscadc.h       |    6 ++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/ti_tscadc.c b/drivers/input/touchscreen/ti_tscadc.c
index d198cab..c1bd8e5 100644
--- a/drivers/input/touchscreen/ti_tscadc.c
+++ b/drivers/input/touchscreen/ti_tscadc.c
@@ -41,10 +41,6 @@
 #define REG_CHARGEDELAY		0x060
 #define REG_STEPCONFIG(n)	(0x64 + ((n - 1) * 8))
 #define REG_STEPDELAY(n)	(0x68 + ((n - 1) * 8))
-#define REG_STEPCONFIG13	0x0C4
-#define REG_STEPDELAY13		0x0C8
-#define REG_STEPCONFIG14	0x0CC
-#define REG_STEPDELAY14		0x0D0
 #define REG_FIFO0CNT		0xE4
 #define REG_FIFO1THR		0xF4
 #define REG_FIFO0		0x100
@@ -134,6 +130,7 @@ struct tscadc {
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
 	bool			pen_down;
+	int			steps_to_configure;
 };
 
 static unsigned int tscadc_readl(struct tscadc *ts, unsigned int reg)
@@ -150,9 +147,10 @@ static void tscadc_writel(struct tscadc *tsc, unsigned int reg,
 static void tscadc_step_config(struct tscadc *ts_dev)
 {
 	unsigned int	config;
-	int i;
+	int i, total_steps;
 
 	/* Configure the Step registers */
+	total_steps = 2 * ts_dev->steps_to_configure;
 
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | STEPCONFIG_XPP;
@@ -170,7 +168,7 @@ static void tscadc_step_config(struct tscadc *ts_dev)
 		break;
 	}
 
-	for (i = 1; i < 7; i++) {
+	for (i = 1; i <= ts_dev->steps_to_configure; i++) {
 		tscadc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		tscadc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
@@ -192,7 +190,7 @@ static void tscadc_step_config(struct tscadc *ts_dev)
 		break;
 	}
 
-	for (i = 7; i < 13; i++) {
+	for (i = (ts_dev->steps_to_configure + 1); i <= total_steps; i++) {
 		tscadc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		tscadc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
@@ -211,12 +209,14 @@ static void tscadc_step_config(struct tscadc *ts_dev)
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | STEPCONFIG_YPP |
 			STEPCONFIG_XNN | STEPCONFIG_INM_ADCREFM;
-	tscadc_writel(ts_dev, REG_STEPCONFIG13, config);
-	tscadc_writel(ts_dev, REG_STEPDELAY13, STEPCONFIG_OPENDLY);
+	tscadc_writel(ts_dev, REG_STEPCONFIG(total_steps + 1), config);
+	tscadc_writel(ts_dev, REG_STEPDELAY(total_steps + 1),
+			STEPCONFIG_OPENDLY);
 
 	config |= STEPCONFIG_INP_AN3 | STEPCONFIG_FIFO1;
-	tscadc_writel(ts_dev, REG_STEPCONFIG14, config);
-	tscadc_writel(ts_dev, REG_STEPDELAY14, STEPCONFIG_OPENDLY);
+	tscadc_writel(ts_dev, REG_STEPCONFIG(total_steps + 2), config);
+	tscadc_writel(ts_dev, REG_STEPDELAY(total_steps + 2),
+			STEPCONFIG_OPENDLY);
 
 	tscadc_writel(ts_dev, REG_SE, STPENB_STEPENB);
 }
@@ -379,6 +379,7 @@ static int __devinit tscadc_probe(struct platform_device *pdev)
 	ts_dev->irq = irq;
 	ts_dev->wires = pdata->wires;
 	ts_dev->x_plate_resistance = pdata->x_plate_resistance;
+	ts_dev->steps_to_configure = pdata->steps_to_configure;
 
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (!res) {
@@ -447,7 +448,7 @@ static int __devinit tscadc_probe(struct platform_device *pdev)
 	tscadc_idle_config(ts_dev);
 	tscadc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO1THRES);
 	tscadc_step_config(ts_dev);
-	tscadc_writel(ts_dev, REG_FIFO1THR, 6);
+	tscadc_writel(ts_dev, REG_FIFO1THR, ts_dev->steps_to_configure);
 
 	ctrl |= CNTRLREG_TSCSSENB;
 	tscadc_writel(ts_dev, REG_CTRL, ctrl);
diff --git a/include/linux/input/ti_tscadc.h b/include/linux/input/ti_tscadc.h
index b10a527..ad442a3 100644
--- a/include/linux/input/ti_tscadc.h
+++ b/include/linux/input/ti_tscadc.h
@@ -7,11 +7,17 @@
  *			i.e. 4/5/8 wire touchscreen support
  *			on the platform.
  * @x_plate_resistance:	X plate resistance.
+ * @steps_to_configure:	The sequencer supports a total of
+ *			16 programmable steps.
+ *			A step configured to read a single
+ *			co-ordinate value, can be applied
+ *			more number of times for better results.
  */
 
 struct tsc_data {
 	int wires;
 	int x_plate_resistance;
+	int steps_to_configure;
 };
 
 #endif
-- 
1.7.0.4
