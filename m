From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0220/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:50:48 +0800
Message-ID: <20160802105048.28419-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53717 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483AbcHBL23 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:28:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, thellstrom@vmware.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, alexander.deucher@amd.com, ville.syrjala@linux.intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/hid/hid-magicmouse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d6fa496..e39db27 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -23,14 +23,14 @@
 #include "hid-ids.h"
 
 static bool emulate_3button = true;
-module_param(emulate_3button, bool, 0644);
+module_param(emulate_3button, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(emulate_3button, "Emulate a middle button");
 
 static int middle_button_start = -350;
 static int middle_button_stop = +350;
 
 static bool emulate_scroll_wheel = true;
-module_param(emulate_scroll_wheel, bool, 0644);
+module_param(emulate_scroll_wheel, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(emulate_scroll_wheel, "Emulate a scroll wheel");
 
 static unsigned int scroll_speed = 32;
@@ -41,15 +41,15 @@ static int param_set_scroll_speed(const char *val, struct kernel_param *kp) {
 	scroll_speed = speed;
 	return 0;
 }
-module_param_call(scroll_speed, param_set_scroll_speed, param_get_uint, &scroll_speed, 0644);
+module_param_call(scroll_speed, param_set_scroll_speed, param_get_uint, &scroll_speed, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(scroll_speed, "Scroll speed, value from 0 (slow) to 63 (fast)");
 
 static bool scroll_acceleration = false;
-module_param(scroll_acceleration, bool, 0644);
+module_param(scroll_acceleration, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(scroll_acceleration, "Accelerate sequential scroll events");
 
 static bool report_undeciphered;
-module_param(report_undeciphered, bool, 0644);
+module_param(report_undeciphered, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
 
 #define TRACKPAD_REPORT_ID 0x28
-- 
2.9.2

