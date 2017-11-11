From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Sat, 11 Nov 2017 16:43:37 +0100
Message-ID: <20171111154339.16875-1-johan@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:52598 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdKKPnu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Nov 2017 10:43:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Marek Belisko <marek@goldelico.com>

A helper purported to look up a child node based on its name was using
the wrong of-helper and ended up prematurely freeing the parent of-node
while searching the whole device tree depth-first starting at the parent
node.

Fixes: 64b9e4d803b1 ("input: twl4030-vibra: Support for DT booted kernel")
Fixes: e661d0a04462 ("Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning")
Cc: stable <stable@vger.kernel.org>     # 3.7
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Marek Belisko <marek@goldelico.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/misc/twl4030-vibra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 6c51d404874b..c37aea9ac272 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -178,12 +178,14 @@ static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
 			 twl4030_vibra_suspend, twl4030_vibra_resume);
 
 static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
-			      struct device_node *node)
+			      struct device_node *parent)
 {
+	struct device_node *node;
+
 	if (pdata && pdata->coexist)
 		return true;
 
-	node = of_find_node_by_name(node, "codec");
+	node = of_get_child_by_name(parent, "codec");
 	if (node) {
 		of_node_put(node);
 		return true;
-- 
2.15.0

