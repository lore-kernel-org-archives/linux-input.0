From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: htcpen - add #ifdef CONFIG_PNP guard for pnp_ids
Date: Thu, 10 Nov 2011 12:24:51 +0800
Message-ID: <1320899091.6118.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Pau Oliva Fora <pof@eslack.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Fix below build warning if CONFIG_PNP is disabled.

  CC      drivers/input/touchscreen/htcpen.o
drivers/input/touchscreen/htcpen.c:50: warning: 'pnp_ids' defined but not used

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/htcpen.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index 62811de..7acc928 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -47,11 +47,13 @@ static int invert_y;
 module_param(invert_y, bool, 0644);
 MODULE_PARM_DESC(invert_y, "If set, Y axis is inverted");
 
+#ifdef CONFIG_PNP
 static struct pnp_device_id pnp_ids[] = {
 	{ .id = "PNP0cc0" },
 	{ .id = "" }
 };
 MODULE_DEVICE_TABLE(pnp, pnp_ids);
+#endif
 
 static irqreturn_t htcpen_interrupt(int irq, void *handle)
 {
-- 
1.7.5.4
