From: zengzhaoxiu@163.com
Subject: [PATCH v2 26/30] input: use parity8 in sa1111ps2
Date: Wed,  6 Apr 2016 18:15:08 +0800
Message-ID: <1459937708-8368-1-git-send-email-zengzhaoxiu@163.com>
References: <57031D9D.801@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57031D9D.801@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
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
2.5.0
