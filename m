From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0274/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:55:39 +0800
Message-ID: <20160802105539.32018-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, dledford@redhat.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, alex.estrin@intel.com, nab@linux-iscsi.org, haggaie@mellanox.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/gameport/gameport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 4a2a9e3..c6767dd 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -32,7 +32,7 @@ MODULE_DESCRIPTION("Generic gameport layer");
 MODULE_LICENSE("GPL");
 
 static bool use_ktime = true;
-module_param(use_ktime, bool, 0400);
+module_param(use_ktime, bool, S_IRUSR);
 MODULE_PARM_DESC(use_ktime, "Use ktime for measuring I/O speed");
 
 /*
-- 
2.9.2
