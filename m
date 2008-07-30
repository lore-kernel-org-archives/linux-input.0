From: akpm@linux-foundation.org
Subject: [patch 1/8] drivers/input/serio/xilinx_ps2.c: fix warning
Date: Wed, 30 Jul 2008 12:31:35 -0700
Message-ID: <200807301931.m6UJVa8G012045@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57397 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753506AbYG3TcC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 15:32:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

From: Andrew Morton <akpm@linux-foundation.org>

drivers/input/serio/xilinx_ps2.c:272: warning: cast from pointer to integer of different size

Also, it is fishy that phys_addr has a 32-bit type.

Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/xilinx_ps2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/input/serio/xilinx_ps2.c~drivers-input-serio-xilinx_ps2c-fix-warning drivers/input/serio/xilinx_ps2.c
--- a/drivers/input/serio/xilinx_ps2.c~drivers-input-serio-xilinx_ps2c-fix-warning
+++ a/drivers/input/serio/xilinx_ps2.c
@@ -269,8 +269,8 @@ static int xps2_setup(struct device *dev
 	 * we have the PS2 in a good state */
 	out_be32(drvdata->base_address + XPS2_SRST_OFFSET, XPS2_SRST_RESET);
 
-	dev_info(dev, "Xilinx PS2 at 0x%08X mapped to 0x%08X, irq=%d\n",
-		drvdata->phys_addr, (u32)drvdata->base_address, drvdata->irq);
+	dev_info(dev, "Xilinx PS2 at 0x%08X mapped to 0x%p, irq=%d\n",
+		drvdata->phys_addr, drvdata->base_address, drvdata->irq);
 
 	serio = &drvdata->serio;
 	serio->id.type = SERIO_8042;
_
