From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4 trivial: rmi_f01.c tidy-up
Date: Mon, 30 Dec 2013 19:10:56 -0800
Message-ID: <1388459456-7247-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:24204 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3LaDLA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 22:11:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This has two trivial changes:

1) make sure spacing around operators is correct.

2) capitalize Synaptics appropriately.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_f01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 840a8d0..628b082 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -156,7 +156,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
 	}
 
 	f01->device_control.interrupt_enable = devm_kzalloc(&fn->dev,
-			sizeof(u8)*(num_of_irq_regs),
+			sizeof(u8) * (num_of_irq_regs),
 			GFP_KERNEL);
 	if (!f01->device_control.interrupt_enable) {
 		dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
@@ -280,7 +280,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 
 	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s\n",
 		 data->properties.manufacturer_id == 1 ?
-							"synaptics" : "unknown",
+							"Synaptics" : "unknown",
 		 data->properties.product_id);
 
 	/* read control register */
