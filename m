From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 1/3] Input: altera_ps2 - write to correct register when disabling interrupts
Date: Fri, 31 Oct 2014 13:41:29 +0100
Message-ID: <1414759291-23164-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:33024 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758818AbaJaMlg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 08:41:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

In altera_ps2_close, the data register (offset 0) is written instead of
the control register (offset 4), leading to the RX interrupt not being
disabled. Fix this by calling writel() with the offset for the proper
register.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/serio/altera_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index cce69d6..e0371e1 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -74,7 +74,7 @@ static void altera_ps2_close(struct serio *io)
 {
 	struct ps2if *ps2if = io->port_data;
 
-	writel(0, ps2if->base); /* disable rx irq */
+	writel(0, ps2if->base + 4); /* disable rx irq */
 }
 
 /*
-- 
2.0.1


