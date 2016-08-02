From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0294/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:37 +0800
Message-ID: <20160802105737.977-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jkosina@suse.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/touchscreen/ucb1400_ts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index c1e23cf..c441acc 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -447,14 +447,14 @@ static struct platform_driver ucb1400_ts_driver = {
 };
 module_platform_driver(ucb1400_ts_driver);
 
-module_param(adcsync, bool, 0444);
+module_param(adcsync, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(adcsync, "Synchronize touch readings with ADCSYNC pin.");
 
-module_param(ts_delay, int, 0444);
+module_param(ts_delay, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ts_delay, "Delay between panel setup and"
 			    " position read. Default = 55us.");
 
-module_param(ts_delay_pressure, int, 0444);
+module_param(ts_delay_pressure, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ts_delay_pressure,
 		"delay between panel setup and pressure read."
 		"  Default = 0us.");
-- 
2.9.2
