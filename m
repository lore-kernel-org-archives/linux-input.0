From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] input: ixp4xx-beeper: Pass correct pointer to free_irq()
Date: Mon, 20 May 2013 16:51:24 +0200
Message-ID: <1369061486-28226-5-git-send-email-lars@metafoo.de>
References: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Alessandro Zummo <alessandro.zummo@towertech.it>
List-Id: linux-input@vger.kernel.org

free_irq() expects the same pointer that was passed to request_irq(), otherwise
the IRQ is not freed.

The issue was found using the following coccinelle script:

<smpl>
@r1@
type T;
T devid;
@@
request_irq(..., devid)

@r2@
type r1.T;
T devid;
position p;
@@
free_irq@p(..., devid)

@@
position p != r2.p;
@@
*free_irq@p(...)
</smpl>

Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/input/misc/ixp4xx-beeper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 6ab3dec..deab4a11 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -125,7 +125,7 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	return 0;
 
  err_free_irq:
-	free_irq(IRQ_IXP4XX_TIMER2, dev);
+	free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
  err_free_device:
 	input_free_device(input_dev);
 
@@ -144,7 +144,7 @@ static int ixp4xx_spkr_remove(struct platform_device *dev)
 	disable_irq(IRQ_IXP4XX_TIMER2);
 	ixp4xx_spkr_control(pin, 0);
 
-	free_irq(IRQ_IXP4XX_TIMER2, dev);
+	free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
 
 	return 0;
 }
-- 
1.8.0
