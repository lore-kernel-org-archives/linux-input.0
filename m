From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] Input: gpio_keys - fix NULL pointer dereference for dt case
Date: Fri, 3 Aug 2012 10:41:54 -0300
Message-ID: <1344001314-2250-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:31154
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303Ab2HCNmD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Aug 2012 09:42:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, aletes.xgr@gmail.com, rob.herring@calxeda.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Commit 30161f6b2e7d1 (Input: gpio_keys - clean up device tree parser) 
introduced the following kernel crash for a dt based kernel:
..
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80004000
[00000004] *pgd=00000000
Internal error: Oops: 805 [#1] ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.0-next-20120802+ #1366)
PC is at gpio_keys_probe+0x154/0x8c0
LR is at of_gpiochip_find_and_xlate+0x54/0x70
pc : [<803ddbac>]    lr : [<801ed2f4>]    psr: 60000013
sp : 9f851df8  ip : 00000002  fp : 9f851e5c
r10: 9f873d00  r9 : 00000001  r8 : 9fa2f900
r7 : 809c0920  r6 : 9f873d08  r5 : 00000000  r4 : 809c09d4
r3 : 805af10c  r2 : 000000c0  r1 : 9f851db4  r0 : 000000d5
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 90004019  DAC: 00000015
Process swapper (pid: 1, stack limit = 0x9f8502e8)
Stack: (0x9f851df8 to 0x9f852000)
....

The reason for the crash was due to 'button = &pdata->buttons[i++];' 
returning a NULL pointer, and then 'button' was accessed afterwards 
without checking for NULL.

Fix this by correctly assigning 'pdata->buttons' and also add a NULL 
pointer check for 'button' pointer.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6ee68ec..620ef24 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -559,7 +559,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	struct gpio_keys_button *button;
 	int error;
 	int nbuttons;
-	int i;
 
 	node = dev->of_node;
 	if (!node) {
@@ -580,9 +579,11 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		goto err_out;
 	}
 
+	pdata->buttons = (struct gpio_keys_button *) (pdata + 1);
+	pdata->nbuttons = nbuttons;
+
 	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
-	i = 0;
 	for_each_child_of_node(node, pp) {
 		enum of_gpio_flags flags;
 
@@ -592,8 +593,13 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			continue;
 		}
 
-		button = &pdata->buttons[i++];
-
+		button = pdata->buttons;
+
+		if (!button)	{
+			error = -ENOMEM;
+			goto err_free_pdata;
+		}
+
 		button->gpio = of_get_gpio_flags(pp, 0, &flags);
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
@@ -614,6 +620,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		if (of_property_read_u32(pp, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
+
+		button++;
 	}
 
 	if (pdata->nbuttons == 0) {
-- 
1.7.1


