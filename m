From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/3] Input: altera_ps2 - use correct type for irq return value
Date: Fri, 31 Oct 2014 13:41:30 +0100
Message-ID: <1414759291-23164-2-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:33023 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758615AbaJaMlg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 08:41:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

The irq function altera_ps2_rxint returns an irqreturn_t, so use the
same type for variable storing the return value.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/serio/altera_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index e0371e1..58781c8 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -37,7 +37,7 @@ static irqreturn_t altera_ps2_rxint(int irq, void *dev_id)
 {
 	struct ps2if *ps2if = dev_id;
 	unsigned int status;
-	int handled = IRQ_NONE;
+	irqreturn_t handled = IRQ_NONE;
 
 	while ((status = readl(ps2if->base)) & 0xffff0000) {
 		serio_interrupt(ps2if->io, status & 0xff, 0);
-- 
2.0.1


