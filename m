From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Input: xilinx_ps2 - Use resource_size
Date: Fri, 22 Jan 2010 08:25:55 +0100
Message-ID: <1264145155-5383-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.zhaw.ch ([160.85.104.51]:52690 "EHLO mx2.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab0AVHfR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2010 02:35:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, John Linn <john.linn@xilinx.com>
Cc: Tobias Klauser <tklauser@distanz.ch>

Use the resource_size inline function instead of manually calculating
the resource size.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/serio/xilinx_ps2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index ebb22f8..4d835e9 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -270,7 +270,7 @@ static int __devinit xps2_of_probe(struct of_device *ofdev,
 	drvdata->irq = r_irq.start;
 
 	phys_addr = r_mem.start;
-	remap_size = r_mem.end - r_mem.start + 1;
+	remap_size = resource_size(r_mem);
 	if (!request_mem_region(phys_addr, remap_size, DRIVER_NAME)) {
 		dev_err(dev, "Couldn't lock memory region at 0x%08llX\n",
 			(unsigned long long)phys_addr);
@@ -344,7 +344,7 @@ static int __devexit xps2_of_remove(struct of_device *of_dev)
 	if (of_address_to_resource(of_dev->node, 0, &r_mem))
 		dev_err(dev, "invalid address\n");
 	else
-		release_mem_region(r_mem.start, r_mem.end - r_mem.start + 1);
+		release_mem_region(r_mem.start, resource_size(r_mem));
 
 	kfree(drvdata);
 
-- 
1.6.3.3

