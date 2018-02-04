From: Zhang Bo <zbsdta@126.com>
Subject: [PATCH v3] Input: matrix_keypad - fix keypad does not response
Date: Sun,  4 Feb 2018 08:19:22 +0800
Message-ID: <20180204001922.32084-1-zbsdta@126.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-110.126.com ([123.125.50.110]:42085 "EHLO m50-110.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbeBDAUF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 19:20:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: zbsdta@126.com, DRivshin@allworx.com, robh@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhang.bo19@zte.com.cn

If matrix_keypad_stop() is calling and the keypad interrupt is triggered,
disable_row_irqs() is called by both matrix_keypad_interrupt() and
matrix_keypad_stop() at the same time. then disable_row_irqs() is called
twice, and the device enter suspend state before keypad->work is executed.
At this condition the device will start keypad and enable irq once after
resume. and then irqs are disabled yet because irqs are disabled twice and
only enable once.

Take lock around keypad->stopped to ensure irqs operation is in atomic
operation.

Signed-off-by: Zhang Bo <zbsdta@126.com>
---
Changes in v3:
  - delete no needed lock protection, only add lock in matrix_keypad_stop().
Changes in v2:
  - Change commit message and full name in the signed-off-by tag.

 drivers/input/keyboard/matrix_keypad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 1f316d66e6f7..41614c185918 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -218,8 +218,10 @@ static void matrix_keypad_stop(struct input_dev *dev)
 {
 	struct matrix_keypad *keypad = input_get_drvdata(dev);
 
+	spin_lock_irq(&keypad->lock);
 	keypad->stopped = true;
-	mb();
+	spin_unlock_irq(&keypad->lock);
+
 	flush_work(&keypad->work.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
-- 
2.14.3


