From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0287/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:57 +0800
Message-ID: <20160802105657.503-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, tiwai@suse.de, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/serio/i8042.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 4541957..5177613 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -87,11 +87,11 @@ MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 #define DEBUG
 #ifdef DEBUG
 static bool i8042_debug;
-module_param_named(debug, i8042_debug, bool, 0600);
+module_param_named(debug, i8042_debug, bool, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 
 static bool i8042_unmask_kbd_data;
-module_param_named(unmask_kbd_data, i8042_unmask_kbd_data, bool, 0600);
+module_param_named(unmask_kbd_data, i8042_unmask_kbd_data, bool, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(unmask_kbd_data, "Unconditional enable (may reveal sensitive data) of normally sanitize-filtered kbd data traffic debug log [pre-condition: i8042.debug=1 enabled]");
 #endif
 
-- 
2.9.2
