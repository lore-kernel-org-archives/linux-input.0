From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0231/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:42 +0800
Message-ID: <20160802105142.29147-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dtor@chromium.org, bleung@chromium.org, mika.westerberg@linux.intel.com, aduggan@synaptics.com, dianders@chromium.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 2e021ba..316d995 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -51,7 +51,7 @@
 
 /* debug option */
 static bool debug;
-module_param(debug, bool, 0444);
+module_param(debug, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "print a lot of debug information");
 
 #define i2c_hid_dbg(ihid, fmt, arg...)					  \
-- 
2.9.2
