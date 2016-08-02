From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0282/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:24 +0800
Message-ID: <20160802105624.32615-1-baolex.ni@intel.com>
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
 drivers/input/mouse/hgpk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 62be888..6e89405 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -44,41 +44,41 @@
 #define ILLEGAL_XY 999999
 
 static bool tpdebug;
-module_param(tpdebug, bool, 0644);
+module_param(tpdebug, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(tpdebug, "enable debugging, dumping packets to KERN_DEBUG.");
 
 static int recalib_delta = 100;
-module_param(recalib_delta, int, 0644);
+module_param(recalib_delta, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(recalib_delta,
 	"packets containing a delta this large will be discarded, and a "
 	"recalibration may be scheduled.");
 
 static int jumpy_delay = 20;
-module_param(jumpy_delay, int, 0644);
+module_param(jumpy_delay, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(jumpy_delay,
 	"delay (ms) before recal after jumpiness detected");
 
 static int spew_delay = 1;
-module_param(spew_delay, int, 0644);
+module_param(spew_delay, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(spew_delay,
 	"delay (ms) before recal after packet spew detected");
 
 static int recal_guard_time;
-module_param(recal_guard_time, int, 0644);
+module_param(recal_guard_time, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(recal_guard_time,
 	"interval (ms) during which recal will be restarted if packet received");
 
 static int post_interrupt_delay = 40;
-module_param(post_interrupt_delay, int, 0644);
+module_param(post_interrupt_delay, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(post_interrupt_delay,
 	"delay (ms) before recal after recal interrupt detected");
 
 static bool autorecal = true;
-module_param(autorecal, bool, 0644);
+module_param(autorecal, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(autorecal, "enable recalibration in the driver");
 
 static char hgpk_mode_name[16];
-module_param_string(hgpk_mode, hgpk_mode_name, sizeof(hgpk_mode_name), 0644);
+module_param_string(hgpk_mode, hgpk_mode_name, sizeof(hgpk_mode_name), S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(hgpk_mode,
 	"default hgpk mode: mouse, glidesensor or pentablet");
 
-- 
2.9.2
