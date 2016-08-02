From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0281/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:18 +0800
Message-ID: <20160802105618.32547-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43293 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965482AbcHBMwS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 08:52:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, chuansheng.liu@intel.com, baolex.ni@intel.com, haggaie@mellanox.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/mouse/bcm5974.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 30e3442..caa8bf9 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -174,7 +174,7 @@ MODULE_LICENSE("GPL");
 	{ if (debug >= level) printk(KERN_DEBUG format, ##a); }
 
 static int debug = 1;
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
 /* button data structure */
-- 
2.9.2

