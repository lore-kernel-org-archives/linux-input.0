From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] Input: bf54x-keys - fix system hang when pressing a key
Date: Tue,  9 Mar 2010 10:00:53 -0500
Message-ID: <1268146853-15802-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49601 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab0CIO5h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 09:57:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org

We need to use the nosync version of disable_irq so that we don't hang in
the IRQ handler as we don't ACK the interrupt until later.  This used to
work regardless, but at some point, the IRQ behavior changed.  Not sure
when exactly.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/keyboard/bf54x-keys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index fe376a2..593c052 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -162,7 +162,7 @@ static irqreturn_t bfin_kpad_isr(int irq, void *dev_id)
 	input_sync(input);
 
 	if (bfin_kpad_get_keypressed(bf54x_kpad)) {
-		disable_irq(bf54x_kpad->irq);
+		disable_irq_nosync(bf54x_kpad->irq);
 		bf54x_kpad->lastkey = key;
 		mod_timer(&bf54x_kpad->timer,
 			  jiffies + bf54x_kpad->keyup_test_jiffies);
-- 
1.7.0.2

