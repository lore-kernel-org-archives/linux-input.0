From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 26/31] input: serio: use parity8 in pcips2.c
Date: Sun, 27 Mar 2016 15:38:27 +0800
Message-ID: <56F78DF3.1050206@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34519 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbcC0Hiz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2016 03:38:55 -0400
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
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
2.5.5

