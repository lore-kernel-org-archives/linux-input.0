From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 27/31] input: serio: use parity8 in sa1111ps2.c
Date: Sun, 27 Mar 2016 15:40:07 +0800
Message-ID: <56F78E57.6030504@gmail.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36659 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbcC0Hkg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2016 03:40:36 -0400
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
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
2.5.5

