From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0286/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:49 +0800
Message-ID: <20160802105649.432-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aduggan@synaptics.com, cheiny@synaptics.com, robh@kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/rmi4/rmi_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index b368b05..818e6bf 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -20,7 +20,7 @@
 #include "rmi_driver.h"
 
 static int debug_flags;
-module_param(debug_flags, int, 0644);
+module_param(debug_flags, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug_flags, "control debugging information");
 
 void rmi_dbg(int flags, struct device *dev, const char *fmt, ...)
-- 
2.9.2
