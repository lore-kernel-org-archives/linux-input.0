From: "Patil, Rachna" <rachna@ti.com>
Subject: [PATCH 4/4] input: TSC: ti_tscadc: Remove definition of End Of Interrupt register
Date: Wed, 22 Aug 2012 16:49:40 +0530
Message-ID: <1345634380-29928-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35484 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2HVLfo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 07:35:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, "Patil, Rachna" <rachna@ti.com>

The touchscreen IP uses level sensitive interrupts rather
than edge sensitive interrupts and therefore the is no need
to use the EOI register to have the module re-strobe the
interrupt line if there pending interrupts exist.

Signed-off-by: Patil, Rachna <rachna@ti.com>
---
 drivers/input/touchscreen/ti_tscadc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ti_tscadc.c b/drivers/input/touchscreen/ti_tscadc.c
index 2cc19b0..ec0a442 100644
--- a/drivers/input/touchscreen/ti_tscadc.c
+++ b/drivers/input/touchscreen/ti_tscadc.c
@@ -27,7 +27,6 @@
 #include <linux/input/ti_tscadc.h>
 #include <linux/delay.h>
 
-#define REG_IRQEOI		0x020
 #define REG_RAWIRQSTATUS	0x024
 #define REG_IRQSTATUS		0x028
 #define REG_IRQENABLE		0x02C
@@ -330,8 +329,6 @@ static irqreturn_t tscadc_irq(int irq, void *dev)
 	}
 
 	tscadc_writel(ts_dev, REG_IRQSTATUS, irqclr);
-	/* check pending interrupts */
-	tscadc_writel(ts_dev, REG_IRQEOI, 0x0);
 
 	tscadc_writel(ts_dev, REG_SE, STPENB_STEPENB);
 	return IRQ_HANDLED;
-- 
1.7.1

