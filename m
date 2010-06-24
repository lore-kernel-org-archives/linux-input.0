From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH 4/6] mfd/stmpexxx: change touchscreen irq
Date: Thu, 24 Jun 2010 13:13:39 +0200
Message-ID: <1277378021-16802-5-git-send-email-l.fu@pengutronix.de>
References: <20100622135635.GA30720@bnru02.bnr.st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100622135635.GA30720@bnru02.bnr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Luotao Fu <l.fu@pengutronix.de>
List-Id: linux-input@vger.kernel.org

the stmpe touchscreen driver uses fifo threshold irq to trigger data fetching.
The touch_det irq bit is only used while polling for release. Change the
platform resource and the irq definition in the variant block.
---
 drivers/mfd/stmpe-devices.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/stmpe-devices.c b/drivers/mfd/stmpe-devices.c
index fa6934d..3e21c26 100644
--- a/drivers/mfd/stmpe-devices.c
+++ b/drivers/mfd/stmpe-devices.c
@@ -59,17 +59,11 @@ static struct mfd_cell stmpe_keypad_cell = {
 
 static struct resource stmpe_ts_resources[] = {
 	{
-		.name	= "TOUCH_DET",
+		.name	= "FIFO_TH",
 		.start	= 0,
 		.end	= 0,
 		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "FIFO_TH",
-		.start	= 1,
-		.end	= 1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	}
 };
 
 static struct mfd_cell stmpe_ts_cell = {
@@ -107,7 +101,7 @@ static struct stmpe_variant_block stmpe811_blocks[] = {
 	},
 	{
 		.cell	= &stmpe_ts_cell,
-		.irq	= STMPE811_IRQ_TOUCH_DET,
+		.irq	= STMPE811_IRQ_FIFO_TH,
 		.block	= STMPE_BLOCK_TOUCHSCREEN,
 	},
 };
-- 
1.7.1
