From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0285/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:41 +0800
Message-ID: <20160802105641.361-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25432 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886AbcHBLgZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, chris@diamand.org, sassmann@kpanic.de, pospeselr@gmail.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/mousedev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index b604564..625c1f4 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -39,15 +39,15 @@ MODULE_LICENSE("GPL");
 #endif
 
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
-module_param(xres, uint, 0644);
+module_param(xres, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
 
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
-module_param(yres, uint, 0644);
+module_param(yres, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
 static unsigned tap_time = 200;
-module_param(tap_time, uint, 0644);
+module_param(tap_time, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
 
 struct mousedev_hw_data {
-- 
2.9.2

