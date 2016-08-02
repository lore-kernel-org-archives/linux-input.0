From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0295/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:43 +0800
Message-ID: <20160802105743.1054-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45444 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756047AbcHBLgk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jkosina@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/touchscreen/usbtouchscreen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 2c41107..08216fd 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -61,11 +61,11 @@
 #define DRIVER_DESC		"USB Touchscreen Driver"
 
 static bool swap_xy;
-module_param(swap_xy, bool, 0644);
+module_param(swap_xy, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
 
 static bool hwcalib_xy;
-module_param(hwcalib_xy, bool, 0644);
+module_param(hwcalib_xy, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
 
 /* device specifc data/functions */
-- 
2.9.2

