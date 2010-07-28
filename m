From: Ian Campbell <ian.campbell@citrix.com>
Subject: [PATCH 2/4] ixp4xx-beeper: Use IRQF_NO_SUSPEND not IRQF_TIMER for non-timer interrupt
Date: Wed, 28 Jul 2010 11:54:25 +0100
Message-ID: <1280314467-5637-2-git-send-email-ian.campbell@citrix.com>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ian Campbell <ian.campbell@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

ixp4xx_spkr_interrupt is not a timer interrupt and therefore should
not use IRQF_TIMER. Use the recently introduced IRQF_NO_SUSPEND
instead since that is the actual desired behaviour.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/ixp4xx-beeper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 9946d73..5c5ea77 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -115,7 +115,7 @@ static int __devinit ixp4xx_spkr_probe(struct platform_device *dev)
 	input_dev->event = ixp4xx_spkr_event;
 
 	err = request_irq(IRQ_IXP4XX_TIMER2, &ixp4xx_spkr_interrupt,
-			  IRQF_DISABLED | IRQF_TIMER, "ixp4xx-beeper", (void *) dev->id);
+			  IRQF_DISABLED | IRQF_NO_SUSPEND, "ixp4xx-beeper", (void *) dev->id);
 	if (err)
 		goto err_free_device;
 
-- 
1.5.6.5
