From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 4/8] IR: fix keys beeing stuck down forever.
Date: Tue,  7 Sep 2010 00:26:09 +0300
Message-ID: <1283808373-27876-5-git-send-email-maximlevitsky@gmail.com>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: lirc-list@lists.sourceforge.net
Cc: Jarod Wilson <jarod@wilsonet.com>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-input@vger.kernel.org

The logic in ir_timer_keyup was inverted.

In case that values aren't equal,
the meaning of the time_is_after_eq_jiffies(ir->keyup_jiffies) is that
ir->keyup_jiffies is after the the jiffies or equally that
that jiffies are before the the ir->keyup_jiffies which is
exactly the situation we want to avoid (that the timeout is in the future)
Confusing Eh?

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 drivers/media/IR/ir-keytable.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/IR/ir-keytable.c b/drivers/media/IR/ir-keytable.c
index 0917535..a8fd777 100644
--- a/drivers/media/IR/ir-keytable.c
+++ b/drivers/media/IR/ir-keytable.c
@@ -319,7 +319,7 @@ static void ir_timer_keyup(unsigned long cookie)
 	 * a keyup event might follow immediately after the keydown.
 	 */
 	spin_lock_irqsave(&ir->keylock, flags);
-	if (time_is_after_eq_jiffies(ir->keyup_jiffies))
+	if (time_is_before_eq_jiffies(ir->keyup_jiffies))
 		ir_keyup(ir);
 	spin_unlock_irqrestore(&ir->keylock, flags);
 }
-- 
1.7.0.4
