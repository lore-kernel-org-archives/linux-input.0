From: Vasiliy Kulikov <segooon@gmail.com>
Subject: [PATCH] keyboard: tnetv107x: fix input_device leak
Date: Sun, 26 Sep 2010 12:59:44 +0400
Message-ID: <1285491584-32664-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cyril Chemparathy <cyril@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

keypad_probe() calls input_free_device() on error, but keypad_remove()
doesn't.
---
 Compile tested.

 drivers/input/keyboard/tnetv107x-keypad.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index b4a81eb..1ea20e1 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -305,6 +305,7 @@ static int __devexit keypad_remove(struct platform_device *pdev)
 	free_irq(kp->irq_press, kp);
 	free_irq(kp->irq_release, kp);
 	input_unregister_device(kp->input_dev);
+	input_free_device(kp->input_dev);
 	clk_put(kp->clk);
 	iounmap(kp->regs);
 	release_mem_region(kp->res->start, resource_size(kp->res));
-- 
1.7.0.4
