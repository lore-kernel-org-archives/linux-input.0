From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0217/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:50:34 +0800
Message-ID: <20160802105034.28221-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9297 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053AbcHBL2a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:28:30 -0400
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
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ea3a26..ad11fb2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -46,12 +46,12 @@
 #define DRIVER_LICENSE "GPL"
 
 int hid_debug = 0;
-module_param_named(debug, hid_debug, int, 0600);
+module_param_named(debug, hid_debug, int, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(debug, "toggle HID debugging messages");
 EXPORT_SYMBOL_GPL(hid_debug);
 
 static int hid_ignore_special_drivers = 0;
-module_param_named(ignore_special_drivers, hid_ignore_special_drivers, int, 0600);
+module_param_named(ignore_special_drivers, hid_ignore_special_drivers, int, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(ignore_special_drivers, "Ignore any special drivers and handle all devices by generic driver");
 
 /*
-- 
2.9.2

