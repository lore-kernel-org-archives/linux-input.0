From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 03/19] input: touchscreen: am335x: remove unwanted fifo flush
Date: Mon, 27 May 2013 21:11:50 +0200
Message-ID: <1369681926-22185-4-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

When touchscreen and ADC are used together, this
unwanted fifo flush leads to loss of ADC data.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 0c460f9..064d2b2 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -308,8 +308,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int x = 0, y = 0;
 	unsigned int z1, z2, z;
 	unsigned int fsm;
-	unsigned int fifo1count, fifo0count;
-	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
@@ -318,14 +316,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		z1 = titsc_readl(ts_dev, REG_FIFO0) & 0xfff;
 		z2 = titsc_readl(ts_dev, REG_FIFO1) & 0xfff;
 
-		fifo1count = titsc_readl(ts_dev, REG_FIFO1CNT);
-		for (i = 0; i < fifo1count; i++)
-			titsc_readl(ts_dev, REG_FIFO1);
-
-		fifo0count = titsc_readl(ts_dev, REG_FIFO0CNT);
-		for (i = 0; i < fifo0count; i++)
-			titsc_readl(ts_dev, REG_FIFO0);
-
 		if (ts_dev->pen_down && z1 != 0 && z2 != 0) {
 			/*
 			 * Calculate pressure using formula
-- 
1.7.10.4
