From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] Input: sparcspkr add of_node_put()
Date: Wed, 21 Nov 2018 08:28:06 -0500
Message-ID: <20181121132806.22521-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-input@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/input/misc/sparcspkr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 4a5afc7fe96e..dc121fbbd3e1 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -205,11 +205,11 @@ static int bbc_beep_probe(struct platform_device *op)
 	info = &state->u.bbc;
 	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
 	if (!info->clock_freq)
-		goto out_free;
+		goto out_put_node;
 
 	info->regs = of_ioremap(&op->resource[0], 0, 6, "bbc beep");
 	if (!info->regs)
-		goto out_free;
+		goto out_put_node;
 
 	platform_set_drvdata(op, state);
 
@@ -217,11 +217,14 @@ static int bbc_beep_probe(struct platform_device *op)
 	if (err)
 		goto out_clear_drvdata;
 
+	of_node_put(dp);
+
 	return 0;
 
 out_clear_drvdata:
 	of_iounmap(&op->resource[0], info->regs, 6);
-
+out_put_node:
+	of_node_put(dp);
 out_free:
 	kfree(state);
 out_err:
-- 
2.17.0
