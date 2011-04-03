From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: rpckbd - fix a leak of the IRQ during init failure
Date: Sun, 03 Apr 2011 09:41:06 +0800
Message-ID: <1301794866.3657.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36045 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab1DCBlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Apr 2011 21:41:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

In rpckbd_open prror path, free_irq() was using NULL rather than the
driver data as the data pointer so free_irq() wouldn't have matched.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/serio/rpckbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index 9da6fbc..7ec3c97 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -90,7 +90,7 @@ static int rpckbd_open(struct serio *port)
 
 	if (request_irq(IRQ_KEYBOARDTX, rpckbd_tx, 0, "rpckbd", port) != 0) {
 		printk(KERN_ERR "rpckbd.c: Could not allocate keyboard transmit IRQ\n");
-		free_irq(IRQ_KEYBOARDRX, NULL);
+		free_irq(IRQ_KEYBOARDRX, port);
 		return -EBUSY;
 	}
 
-- 
1.7.1



