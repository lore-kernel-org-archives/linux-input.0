From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0292/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:25 +0800
Message-ID: <20160802105725.838-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62470 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755793AbcHBLg1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pof@eslack.org, dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, broonie@kernel.org, afd@ti.com, javier@osg.samsung.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/touchscreen/htcpen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index 92e2243..b2e63f3 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -41,10 +41,10 @@ MODULE_LICENSE("GPL");
 #define Y_AXIS_MAX		2040
 
 static bool invert_x;
-module_param(invert_x, bool, 0644);
+module_param(invert_x, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(invert_x, "If set, X axis is inverted");
 static bool invert_y;
-module_param(invert_y, bool, 0644);
+module_param(invert_y, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(invert_y, "If set, Y axis is inverted");
 
 static irqreturn_t htcpen_interrupt(int irq, void *handle)
-- 
2.9.2

