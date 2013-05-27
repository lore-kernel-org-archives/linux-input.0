From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 05/19] input: ti_am335x_tsc: Add variance filters
Date: Mon, 27 May 2013 21:11:52 +0200
Message-ID: <1369681926-22185-6-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Only fine tuning variance present in tslib utility
does not help in removing all the wanted ADC noise.

This logic of filtering is necessary to get this
touchscreen to work finely.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index be5cb67..b7d3c23 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -34,6 +34,8 @@
 #define ADCFSM_STEPID		0x10
 #define SEQ_SETTLE		275
 #define MAX_12BIT		((1 << 12) - 1)
+#define TSCADC_DELTA_X		15
+#define TSCADC_DELTA_Y		15
 
 /*
  * Refer to function regbit_map() to
@@ -53,6 +55,8 @@ struct titsc {
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
 	unsigned int		enable_bits;
+	unsigned int		bckup_x;
+	unsigned int		bckup_y;
 	bool			pen_down;
 	int			steps_to_configure;
 	int			config_inp[20];
@@ -310,11 +314,18 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int x = 0, y = 0;
 	unsigned int z1, z2, z;
 	unsigned int fsm;
+	unsigned int diffx = 0, diffy = 0;
+	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
 		titsc_read_coordinates(ts_dev, &x, &y);
 
+		diffx = abs(x - (ts_dev->bckup_x));
+		diffy = abs(y - (ts_dev->bckup_y));
+		ts_dev->bckup_x = x;
+		ts_dev->bckup_y = y;
+
 		z1 = titsc_readl(ts_dev, REG_FIFO0) & 0xfff;
 		z2 = titsc_readl(ts_dev, REG_FIFO1) & 0xfff;
 
@@ -330,7 +341,8 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			z /= z1;
 			z = (z + 2047) >> 12;
 
-			if (z <= MAX_12BIT) {
+			if ((diffx < TSCADC_DELTA_X) &&
+			(diffy < TSCADC_DELTA_Y) && (z <= MAX_12BIT)) {
 				input_report_abs(input_dev, ABS_X, x);
 				input_report_abs(input_dev, ABS_Y, y);
 				input_report_abs(input_dev, ABS_PRESSURE, z);
@@ -353,6 +365,8 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		fsm = titsc_readl(ts_dev, REG_ADCFSM);
 		if (fsm == ADCFSM_STEPID) {
 			ts_dev->pen_down = false;
+			ts_dev->bckup_x = 0;
+			ts_dev->bckup_y = 0;
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
-- 
1.7.10.4
