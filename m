From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0284/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:37 +0800
Message-ID: <20160802105637.32752-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17046 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881AbcHBLgZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
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
 drivers/input/mouse/synaptics_i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index aa7c5da..99dd971 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -186,17 +186,17 @@
 
 /* Control touchpad's No Deceleration option */
 static bool no_decel = true;
-module_param(no_decel, bool, 0644);
+module_param(no_decel, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(no_decel, "No Deceleration. Default = 1 (on)");
 
 /* Control touchpad's Reduced Reporting option */
 static bool reduce_report;
-module_param(reduce_report, bool, 0644);
+module_param(reduce_report, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(reduce_report, "Reduced Reporting. Default = 0 (off)");
 
 /* Control touchpad's No Filter option */
 static bool no_filter;
-module_param(no_filter, bool, 0644);
+module_param(no_filter, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(no_filter, "No Filter. Default = 0 (off)");
 
 /*
@@ -206,12 +206,12 @@ MODULE_PARM_DESC(no_filter, "No Filter. Default = 0 (off)");
  */
 /* Control IRQ / Polling option */
 static bool polling_req;
-module_param(polling_req, bool, 0444);
+module_param(polling_req, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(polling_req, "Request Polling. Default = 0 (use irq)");
 
 /* Control Polling Rate */
 static int scan_rate = 80;
-module_param(scan_rate, int, 0644);
+module_param(scan_rate, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(scan_rate, "Polling rate in times/sec. Default = 80");
 
 /* The main device structure */
-- 
2.9.2

