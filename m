From: zengzhaoxiu@163.com
Subject: [patch V4 24/31] input: use parity8 in pcips2
Date: Wed, 11 May 2016 17:22:30 +0800
Message-ID: <1462958552-25843-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
2.7.4
