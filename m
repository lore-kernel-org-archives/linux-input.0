From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0280/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:12 +0800
Message-ID: <20160802105612.32479-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19145 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933074AbcHBMAo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 08:00:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, haggaie@mellanox.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/mouse/appletouch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index ef234c9..149fa74 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -257,13 +257,13 @@ MODULE_LICENSE("GPL");
  * Make the threshold a module parameter
  */
 static int threshold = ATP_THRESHOLD;
-module_param(threshold, int, 0644);
+module_param(threshold, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(threshold, "Discard any change in data from a sensor"
 			    " (the trackpad has many of these sensors)"
 			    " less than this value.");
 
 static int debug;
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
 /*
-- 
2.9.2

