From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: twl6040_vibra - remove unneeded check for CONFIG_OF
Date: Sat, 4 Jan 2014 00:11:43 -0800
Message-ID: <20140104081142.GA3987@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37960 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaADILr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 03:11:47 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org

Since the driver requires DT now we do not need to check if CONFIG_OF is
defined.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/twl6040-vibra.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 89bca76..77dc23b 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -258,17 +258,14 @@ static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
 static int twl6040_vibra_probe(struct platform_device *pdev)
 {
 	struct device *twl6040_core_dev = pdev->dev.parent;
-	struct device_node *twl6040_core_node = NULL;
+	struct device_node *twl6040_core_node;
 	struct vibra_info *info;
 	int vddvibl_uV = 0;
 	int vddvibr_uV = 0;
 	int ret;
 
-#ifdef CONFIG_OF
 	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
 						 "vibra");
-#endif
-
 	if (!twl6040_core_node) {
 		dev_err(&pdev->dev, "parent of node is missing?\n");
 		return -EINVAL;
-- 
1.8.4.2


-- 
Dmitry
