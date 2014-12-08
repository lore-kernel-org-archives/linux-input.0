From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] Input: gpio_keys - initialize the 'irq' variable
Date: Mon,  8 Dec 2014 10:09:44 -0200
Message-ID: <1418040584-5670-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:50894 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaLHMKC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 07:10:02 -0500
Received: by mail-qa0-f48.google.com with SMTP id v10so3265459qac.35
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 04:10:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: alexander.stein@systec-electronic.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit f2d347ff70be453e ("Input: gpio_keys - add device tree support for
interrupt only keys") caused the following build warning:

drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_probe':
drivers/input/keyboard/gpio_keys.c:647:15: warning: 'irq' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/input/keyboard/gpio_keys.c:622:7: note: 'irq' was declared here

To fix this warning, do the 'irq' assignment inside the 'if' block that it is
actually used.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Change since v1:
- Do the 'irq' assignment inside the 'if' block that it is actually used.

 drivers/input/keyboard/gpio_keys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index aa13055..6c33849 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -619,11 +619,12 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	i = 0;
 	for_each_child_of_node(node, pp) {
 		int gpio = -1;
-		int irq;
 		enum of_gpio_flags flags;
 
 		if (!of_find_property(pp, "gpios", NULL)) {
-			irq = irq_of_parse_and_map(pp, 0);
+			int irq = irq_of_parse_and_map(pp, 0);
+
+			button->irq = irq;
 			if (irq == 0) {
 				pdata->nbuttons--;
 				dev_warn(dev, "Found button without gpios or irqs\n");
@@ -644,7 +645,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		button = &pdata->buttons[i++];
 
 		button->gpio = gpio;
-		button->irq = irq;
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
-- 
1.9.1

