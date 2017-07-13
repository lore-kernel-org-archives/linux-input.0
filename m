From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] input: serio: Fix multiline comments style in xilinx_ps2
Date: Thu, 13 Jul 2017 15:01:58 +0200
Message-ID: <bd4e538a597b0762b636176d83834490116d3f5e.1499950913.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Fix multiline comments style not to be reported by checkpatch.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/input/serio/xilinx_ps2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 14c40892ed82..474724296363 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -46,7 +46,8 @@
 #define XPS2_STATUS_TX_FULL	0x00000002 /* Transmit Full  */
 
 /* Bit definitions for ISR/IER registers. Both the registers have the same bit
- * definitions and are only defined once. */
+ * definitions and are only defined once.
+ */
 #define XPS2_IPIXR_WDT_TOUT	0x00000001 /* Watchdog Timeout Interrupt */
 #define XPS2_IPIXR_TX_NOACK	0x00000002 /* Transmit No ACK Interrupt */
 #define XPS2_IPIXR_TX_ACK	0x00000004 /* Transmit ACK (Data) Interrupt */
@@ -293,7 +294,8 @@ static int xps2_of_probe(struct platform_device *ofdev)
 	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0);
 
 	/* Reset the PS2 device and abort any current transaction, to make sure
-	 * we have the PS2 in a good state */
+	 * we have the PS2 in a good state
+	 */
 	out_be32(drvdata->base_address + XPS2_SRST_OFFSET, XPS2_SRST_RESET);
 
 	dev_info(dev, "Xilinx PS2 at 0x%08llX mapped to 0x%p, irq=%d\n",
-- 
1.9.1
