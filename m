From: zengzhaoxiu@163.com
Subject: [patch V4 25/31] input: use parity8 in sa1111ps2
Date: Wed, 11 May 2016 17:22:42 +0800
Message-ID: <1462958564-25892-1-git-send-email-zengzhaoxiu@163.com>
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
 drivers/input/serio/sa1111ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index b3e6889..324b193 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -74,7 +74,7 @@ static irqreturn_t ps2_rxint(int irq, void *dev_id)
 
 		scancode = sa1111_readl(ps2if->base + PS2DATA) & 0xff;
 
-		if (hweight8(scancode) & 1)
+		if (parity8(scancode))
 			flag ^= SERIO_PARITY;
 
 		serio_interrupt(ps2if->io, scancode, flag);
-- 
2.7.4
