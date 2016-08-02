From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0232/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:47 +0800
Message-ID: <20160802105147.29214-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43608 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbcHBL32 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:29:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aduggan@synaptics.com, dianders@chromium.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/hid/usbhid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ae83af6..4491aa0 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -50,16 +50,16 @@
  */
 
 static unsigned int hid_mousepoll_interval;
-module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
+module_param_named(mousepoll, hid_mousepoll_interval, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
 
 static unsigned int ignoreled;
-module_param_named(ignoreled, ignoreled, uint, 0644);
+module_param_named(ignoreled, ignoreled, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
 
 /* Quirks specified at module load time */
 static char *quirks_param[MAX_USBHID_BOOT_QUIRKS];
-module_param_array_named(quirks, quirks_param, charp, NULL, 0444);
+module_param_array_named(quirks, quirks_param, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
 		" quirks=vendorID:productID:quirks"
 		" where vendorID, productID, and quirks are all in"
-- 
2.9.2

