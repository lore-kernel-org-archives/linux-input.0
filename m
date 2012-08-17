From: Estevam Fabio-R49496 <r49496@freescale.com>
Subject: RE: [PATCH] Input: gpio_keys - fix NULL pointer dereference for dt
 case
Date: Fri, 17 Aug 2012 00:01:38 +0000
Message-ID: <86D15885F63D1143A519F161FB828EAF11AF30@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1344001314-2250-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [213.199.154.139] ([213.199.154.139]:32056 "EHLO
	db3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751979Ab2HQACu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 20:02:50 -0400
In-Reply-To: <1344001314-2250-1-git-send-email-fabio.estevam@freescale.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "aletes.xgr@gmail.com" <aletes.xgr@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>

Dmitry,

Any comments about this patch? 
________________________________________
From: Estevam Fabio-R49496
Sent: Friday, August 03, 2012 8:41 AM
To: dmitry.torokhov@gmail.com
Cc: shawn.guo@linaro.org; kernel@pengutronix.de; aletes.xgr@gmail.com; rob.herring@calxeda.com; linux-input@vger.kernel.org; Estevam Fabio-R49496
Subject: [PATCH] Input: gpio_keys - fix NULL pointer dereference for dt case

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
-       int i;

        node = dev->of_node;
        if (!node) {
@@ -580,9 +579,11 @@ gpio_keys_get_devtree_pdata(struct device *dev)
                goto err_out;
        }

+       pdata->buttons = (struct gpio_keys_button *) (pdata + 1);
+       pdata->nbuttons = nbuttons;
+
        pdata->rep = !!of_get_property(node, "autorepeat", NULL);

-       i = 0;
        for_each_child_of_node(node, pp) {
                enum of_gpio_flags flags;

@@ -592,8 +593,13 @@ gpio_keys_get_devtree_pdata(struct device *dev)
                        continue;
                }

-               button = &pdata->buttons[i++];
-
+               button = pdata->buttons;
+
+               if (!button)    {
+                       error = -ENOMEM;
+                       goto err_free_pdata;
+               }
+
                button->gpio = of_get_gpio_flags(pp, 0, &flags);
                button->active_low = flags & OF_GPIO_ACTIVE_LOW;

@@ -614,6 +620,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
                if (of_property_read_u32(pp, "debounce-interval",
                                         &button->debounce_interval))
                        button->debounce_interval = 5;
+
+               button++;
        }

        if (pdata->nbuttons == 0) {
--
1.7.1


