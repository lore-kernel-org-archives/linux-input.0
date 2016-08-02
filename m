From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0279/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:06 +0800
Message-ID: <20160802105607.32411-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, haggaie@mellanox.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/misc/keyspan_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index a3fe4a9..897ff3a 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -24,7 +24,7 @@
 
 /* Parameters that can be passed to the driver. */
 static int debug;
-module_param(debug, int, 0444);
+module_param(debug, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Enable extra debug messages and information");
 
 /* Vendor and product ids */
-- 
2.9.2
