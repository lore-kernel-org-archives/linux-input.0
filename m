From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH v2] input: add support for TI Touchscreen controller
Date: Thu, 5 Jan 2012 05:50:36 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B93201B947@DBDE01.ent.ti.com>
References: <1323430182-27626-1-git-send-email-rachna@ti.com>
 <20111230035521.GD17850@core.coreip.homeip.net>
 <4CE347531D4CA947960AF71FF095B93201B58E@DBDE01.ent.ti.com>
 <4CE347531D4CA947960AF71FF095B93201B5E3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36510 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab2AEFuk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 00:50:40 -0500
In-Reply-To: <4CE347531D4CA947960AF71FF095B93201B5E3@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

<SNIP>
> > > -
> > > -		if (ts_dev->pen == 0) {
> > > -			if ((z1 != 0) && (z2 != 0)) {
> > > -				/* cal pressure using formula
> > > -				 * Resistance(touch) = x plate resistance *
> > > -				 * x postion/4096 * ((z2 / z1) - 1)
> > > -				 */
> > > -				z = z2 - z1;
> > > -				z *= val_x;
> > > -				z *= ts_dev->x_plate_resistance;
> > > -				z /= z1;
> > > -				z = (z + 2047) >> 12;
> > > -
> > > -				if ((diffx < 15) && (diffy < 15)
> > > -						&& (z <= MAX_12BIT)) {
> > 
> > Using defuzz alone does not solve the problem. I am trying to filter out odd random values from the ADC that are incorrect (Not only noise). Hence as explained I am using delta algorithm.
> > As a part of this algorithm I am checking for value being less than 15.
> 
> I will apply your patch on top of the driver and also submit an incremental patch that will include changes for touchscreen to work as expected on my setup.
> This way we can come to a conclusion on the driver. 
> 

Can you try the patch below on top of your patch and
let me know if this is good?


From: Patil, Rachna <rachna@ti.com>
Subject: Input: ti_tscadc.c

Changes made to add delta difference to get touchscreen
working accordingly

Signed-off-by: Patil, Rachna <rachna@ti.com>---
 drivers/input/touchscreen/ti_tscadc.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ti_tscadc.c b/drivers/input/touchscreen/ti_tscadc.c
index 8d23f5f..8887c76 100644
--- a/drivers/input/touchscreen/ti_tscadc.c
+++ b/drivers/input/touchscreen/ti_tscadc.c
@@ -87,8 +87,8 @@
 #define SEQ_SETTLE		275
 #define ADC_CLK			3000000
 #define MAX_12BIT		((1 << 12) - 1)
-#define TSCADC_FUZZ_X		15
-#define TSCADC_FUZZ_Y		15
+#define TSCADC_DELTA_X		15
+#define TSCADC_DELTA_Y		15
 
 struct tscadc {
 	struct input_dev	*input;
@@ -97,6 +97,8 @@ struct tscadc {
 	unsigned int		irq;
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
+	unsigned int		bckup_x;
+	unsigned int		bckup_y;
 	bool			pen_down;
 };
 
@@ -239,6 +241,7 @@ static irqreturn_t tscadc_irq(int irq, void *dev)
 	struct input_dev *input_dev = ts_dev->input;
 	unsigned int status, irqclr = 0;
 	unsigned int x = 0, y = 0;
+	unsigned int diffx, diffy;
 	unsigned int z1, z2, z;
 	unsigned int fsm;
 
@@ -246,6 +249,11 @@ static irqreturn_t tscadc_irq(int irq, void *dev)
 	if (status & IRQENB_FIFO1THRES) {
 		tscadc_read_coordinates(ts_dev, &x, &y);
 
+		diffx = abs(x - (ts_dev->bckup_x));
+		diffy = abs(y - (ts_dev->bckup_y));
+		ts_dev->bckup_x = x;
+		ts_dev->bckup_y = y;
+
 		z1 = tscadc_readl(ts_dev, REG_FIFO0) & 0xfff;
 		z2 = tscadc_readl(ts_dev, REG_FIFO1) & 0xfff;
 
@@ -261,7 +269,8 @@ static irqreturn_t tscadc_irq(int irq, void *dev)
 			z /= z1;
 			z = (z + 2047) >> 12;
 
-			if (z <= MAX_12BIT) {
+			if ((z <= MAX_12BIT) && (diffx < TSCADC_DELTA_X) &&
+					(diffy < TSCADC_DELTA_Y)){
 				input_report_abs(input_dev, ABS_X, x);
 				input_report_abs(input_dev, ABS_Y, y);
 				input_report_abs(input_dev, ABS_PRESSURE, z);
@@ -430,8 +439,8 @@ static int __devinit tscadc_probe(struct platform_device *pdev)
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, TSCADC_FUZZ_X, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, TSCADC_FUZZ_Y, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
 
 	/* register to the input system */
-- 
1.7.1


Regards,
Rachna.

