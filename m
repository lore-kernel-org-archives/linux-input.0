From: "Liang, Dan" <Dan.Liang@atmel.com>
Subject: [PATCH] Atmel Touchscreen Driver improved
Date: Wed, 13 Aug 2008 10:22:38 +0200
Message-ID: <0F5F73E36031FD46AD3F2E6948F0C0A02C8371@frimb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:65475 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbYHMIXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2008 04:23:20 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Justin Waters <justin.waters@timesys.com>

Discard the last sample just before pen is up.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Dan Liang <dan.liang@atmel.com>
---
 drivers/input/touchscreen/atmel_tsadcc.c |   37 +++++++++++++++++++----------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index eee126b..a89a6a8 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -91,6 +91,9 @@ struct atmel_tsadcc {
 	char			phys[32];
 	struct clk		*clk;
 	int			irq;
+	unsigned int		prev_absx;
+	unsigned int		prev_absy;
+	unsigned char		bufferedmeasure;
 };
 
 static void __iomem		*tsc_base;
@@ -100,10 +103,9 @@ static void __iomem		*tsc_base;
 
 static irqreturn_t atmel_tsadcc_interrupt(int irq, void *dev)
 {
-	struct input_dev *input_dev = ((struct atmel_tsadcc *)dev)->input;
+	struct atmel_tsadcc	*ts_dev = (struct atmel_tsadcc *)dev;
+	struct input_dev	*input_dev = ts_dev->input;
 
-	unsigned int absx;
-	unsigned int absy;
 	unsigned int status;
 	unsigned int reg;
 
@@ -121,6 +123,7 @@ static irqreturn_t atmel_tsadcc_interrupt(int irq, void *dev)
 		atmel_tsadcc_write(ATMEL_TSADCC_IER, ATMEL_TSADCC_PENCNT);
 
 		input_report_key(input_dev, BTN_TOUCH, 0);
+		ts_dev->bufferedmeasure = 0;
 		input_sync(input_dev);
 
 	} else if (status & ATMEL_TSADCC_PENCNT) {
@@ -138,16 +141,23 @@ static irqreturn_t atmel_tsadcc_interrupt(int irq, void *dev)
 	} else if (status & ATMEL_TSADCC_EOC(3)) {
 		/* Conversion finished */
 
-		absx = atmel_tsadcc_read(ATMEL_TSADCC_CDR3) << 10;
-		absx /= atmel_tsadcc_read(ATMEL_TSADCC_CDR2);
-
-		absy = atmel_tsadcc_read(ATMEL_TSADCC_CDR1) << 10;
-		absy /= atmel_tsadcc_read(ATMEL_TSADCC_CDR0);
-
-		input_report_abs(input_dev, ABS_X, absx);
-		input_report_abs(input_dev, ABS_Y, absy);
-		input_report_key(input_dev, BTN_TOUCH, 1);
-		input_sync(input_dev);
+		if (ts_dev->bufferedmeasure) {
+			/* Last measurement is always discarded, since it can
+			 * be erroneous.
+			 * Always report previous measurement */
+			input_report_abs(input_dev, ABS_X, ts_dev->prev_absx);
+			input_report_abs(input_dev, ABS_Y, ts_dev->prev_absy);
+			input_report_key(input_dev, BTN_TOUCH, 1);
+			input_sync(input_dev);
+		} else
+			ts_dev->bufferedmeasure = 1;
+
+		/* Now make new measurement */
+		ts_dev->prev_absx = atmel_tsadcc_read(ATMEL_TSADCC_CDR3) << 10;
+		ts_dev->prev_absx /= atmel_tsadcc_read(ATMEL_TSADCC_CDR2);
+
+		ts_dev->prev_absy = atmel_tsadcc_read(ATMEL_TSADCC_CDR1) << 10;
+		ts_dev->prev_absy /= atmel_tsadcc_read(ATMEL_TSADCC_CDR0);
 	}
 
 	return IRQ_HANDLED;
@@ -223,6 +233,7 @@ static int __devinit atmel_tsadcc_probe(struct platform_device *pdev)
 	}
 
 	ts_dev->input = input_dev;
+	ts_dev->bufferedmeasure = 0;
 
 	snprintf(ts_dev->phys, sizeof(ts_dev->phys),
 		 "%s/input0", pdev->dev.bus_id);
-- 
1.5.2.2

Best Regards
Dan Liang
