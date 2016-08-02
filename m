From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0283/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:30 +0800
Message-ID: <20160802105630.32684-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, pali.rohar@gmail.com, chris@diamand.org, sassmann@kpanic.de, pospeselr@gmail.com, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/mouse/psmouse-base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 5784e20..fccd10d 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -53,27 +53,27 @@ static const struct kernel_param_ops param_ops_proto_abbrev = {
 	.get = psmouse_get_maxproto,
 };
 #define param_check_proto_abbrev(name, p)	__param_check(name, p, unsigned int)
-module_param_named(proto, psmouse_max_proto, proto_abbrev, 0644);
+module_param_named(proto, psmouse_max_proto, proto_abbrev, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps, any). Useful for KVM switches.");
 
 static unsigned int psmouse_resolution = 200;
-module_param_named(resolution, psmouse_resolution, uint, 0644);
+module_param_named(resolution, psmouse_resolution, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(resolution, "Resolution, in dpi.");
 
 static unsigned int psmouse_rate = 100;
-module_param_named(rate, psmouse_rate, uint, 0644);
+module_param_named(rate, psmouse_rate, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(rate, "Report rate, in reports per second.");
 
 static bool psmouse_smartscroll = true;
-module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
+module_param_named(smartscroll, psmouse_smartscroll, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
 static unsigned int psmouse_resetafter = 5;
-module_param_named(resetafter, psmouse_resetafter, uint, 0644);
+module_param_named(resetafter, psmouse_resetafter, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
 static unsigned int psmouse_resync_time;
-module_param_named(resync_time, psmouse_resync_time, uint, 0644);
+module_param_named(resync_time, psmouse_resync_time, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(resync_time, "How long can mouse stay idle before forcing resync (in seconds, 0 = never).");
 
 PSMOUSE_DEFINE_ATTR(protocol, S_IWUSR | S_IRUGO,
-- 
2.9.2
