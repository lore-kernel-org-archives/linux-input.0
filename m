From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: gpio_keys - initialize the 'irq' variable
Date: Sat,  6 Dec 2014 13:43:52 -0200
Message-ID: <1417880632-13559-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:51861 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaLFPoG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Dec 2014 10:44:06 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so1864338qcq.11
        for <linux-input@vger.kernel.org>; Sat, 06 Dec 2014 07:44:04 -0800 (PST)
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

Initialize 'irq' with a default value to fix it.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index aa13055..70e89d1 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -619,7 +619,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	i = 0;
 	for_each_child_of_node(node, pp) {
 		int gpio = -1;
-		int irq;
+		int irq = -EINVAL;
 		enum of_gpio_flags flags;
 
 		if (!of_find_property(pp, "gpios", NULL)) {
-- 
1.9.1

