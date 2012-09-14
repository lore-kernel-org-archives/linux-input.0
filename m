From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 20/24] input: rpcmouse: use __iomem pointers for MMIO
Date: Fri, 14 Sep 2012 23:34:48 +0200
Message-ID: <1347658492-11608-21-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/mouse/rpcmouse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
index 272dedd..21c60fe 100644
--- a/drivers/input/mouse/rpcmouse.c
+++ b/drivers/input/mouse/rpcmouse.c
@@ -42,7 +42,7 @@ static irqreturn_t rpcmouse_irq(int irq, void *dev_id)
 
 	x = (short) iomd_readl(IOMD_MOUSEX);
 	y = (short) iomd_readl(IOMD_MOUSEY);
-	b = (short) (__raw_readl(0xe0310000) ^ 0x70);
+	b = (short) (__raw_readl(IOMEM(0xe0310000)) ^ 0x70);
 
 	dx = x - rpcmouse_lastx;
 	dy = y - rpcmouse_lasty;
-- 
1.7.10
