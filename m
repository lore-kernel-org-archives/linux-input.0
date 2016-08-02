From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0275/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:55:45 +0800
Message-ID: <20160802105545.32086-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38516 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070AbcHBLoC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:44:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, dledford@redhat.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, haggaie@mellanox.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/joystick/analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3d8ff09..e2c7102 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -45,7 +45,7 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 static bool use_ktime = true;
-module_param(use_ktime, bool, 0400);
+module_param(use_ktime, bool, S_IRUSR);
 MODULE_PARM_DESC(use_ktime, "Use ktime for measuring I/O speed");
 
 /*
-- 
2.9.2

