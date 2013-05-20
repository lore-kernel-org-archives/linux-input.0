From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] input: twl4030_keypad: Pass correct pointer to free_irq()
Date: Mon, 20 May 2013 16:51:22 +0200
Message-ID: <1369061486-28226-3-git-send-email-lars@metafoo.de>
References: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-input@vger.kernel.org

free_irq() expects the same pointer that was passed to request_threaded_irq(),
otherwise the IRQ is not freed.

The issue was found using the following coccinelle script:

<smpl>
@r1@
type T;
T devid;
@@
request_threaded_irq(..., devid)

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

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/input/keyboard/twl4030_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index f05ee1db..d2d178c 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -422,7 +422,7 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 err3:
 	/* mask all events - we don't care about the result */
 	(void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
-	free_irq(kp->irq, NULL);
+	free_irq(kp->irq, kp);
 err2:
 	input_unregister_device(input);
 	input = NULL;
-- 
1.8.0
