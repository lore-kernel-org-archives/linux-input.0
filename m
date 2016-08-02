From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0221/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:50:52 +0800
Message-ID: <20160802105053.28485-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25120 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbcHBL2f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:28:35 -0400
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
 drivers/hid/hid-ntrig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1b0084d..f04178e 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -25,30 +25,30 @@
 #define NTRIG_DUPLICATE_USAGES	0x001
 
 static unsigned int min_width;
-module_param(min_width, uint, 0644);
+module_param(min_width, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(min_width, "Minimum touch contact width to accept.");
 
 static unsigned int min_height;
-module_param(min_height, uint, 0644);
+module_param(min_height, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(min_height, "Minimum touch contact height to accept.");
 
 static unsigned int activate_slack = 1;
-module_param(activate_slack, uint, 0644);
+module_param(activate_slack, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(activate_slack, "Number of touch frames to ignore at "
 		 "the start of touch input.");
 
 static unsigned int deactivate_slack = 4;
-module_param(deactivate_slack, uint, 0644);
+module_param(deactivate_slack, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(deactivate_slack, "Number of empty frames to ignore before "
 		 "deactivating touch.");
 
 static unsigned int activation_width = 64;
-module_param(activation_width, uint, 0644);
+module_param(activation_width, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(activation_width, "Width threshold to immediately start "
 		 "processing touch events.");
 
 static unsigned int activation_height = 32;
-module_param(activation_height, uint, 0644);
+module_param(activation_height, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(activation_height, "Height threshold to immediately start "
 		 "processing touch events.");
 
-- 
2.9.2

