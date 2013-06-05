From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/22] input/ti_am33x_tsc: remove unwanted fifo flush
Date: Wed,  5 Jun 2013 18:24:38 +0200
Message-ID: <1370449495-29981-6-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35142 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab3FEQZL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:25:11 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, "Patil, Rachna" <rachna@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: "Patil, Rachna" <rachna@ti.com>

When touchscreen and ADC are used together, this
unwanted fifo flush leads to loss of ADC data.

Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 56c6220..b2f8a46 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -252,8 +252,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int x = 0, y = 0;
 	unsigned int z1, z2, z;
 	unsigned int fsm;
-	unsigned int fifo1count, fifo0count;
-	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
@@ -262,14 +260,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
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

