From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0291/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:17 +0800
Message-ID: <20160802105717.772-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, broonie@kernel.org, afd@ti.com, javier@osg.samsung.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/touchscreen/eeti_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 09be6ce..054b815 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -36,11 +36,11 @@
 #include <linux/slab.h>
 
 static bool flip_x;
-module_param(flip_x, bool, 0644);
+module_param(flip_x, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(flip_x, "flip x coordinate");
 
 static bool flip_y;
-module_param(flip_y, bool, 0644);
+module_param(flip_y, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(flip_y, "flip y coordinate");
 
 struct eeti_ts_priv {
-- 
2.9.2
