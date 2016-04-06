From: zengzhaoxiu@163.com
Subject: [PATCH v2 25/30] input: use parity8 in pcips2
Date: Wed,  6 Apr 2016 18:14:32 +0800
Message-ID: <1459937672-8311-1-git-send-email-zengzhaoxiu@163.com>
References: <57031D9D.801@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-135.163.com ([123.125.50.135]:56346 "EHLO m50-135.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881AbcDFKOr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Apr 2016 06:14:47 -0400
In-Reply-To: <57031D9D.801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 drivers/input/serio/pcips2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index e862c6e..a51e7f0 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -77,7 +77,7 @@ static irqreturn_t pcips2_interrupt(int irq, void *devid)
 
 		flag = (status & PS2_STAT_PARITY) ? 0 : SERIO_PARITY;
 
-		if (hweight8(scancode) & 1)
+		if (parity8(scancode))
 			flag ^= SERIO_PARITY;
 
 		serio_interrupt(ps2if->io, scancode, flag);
-- 
2.5.0


