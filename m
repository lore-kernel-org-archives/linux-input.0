From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0218/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:50:39 +0800
Message-ID: <20160802105039.28287-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1129 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbcHBL2v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:28:51 -0400
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
 drivers/hid/hid-corsair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 717704e..5353847 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -370,8 +370,8 @@ static ssize_t k90_store_current_profile(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(macro_mode, 0644, k90_show_macro_mode, k90_store_macro_mode);
-static DEVICE_ATTR(current_profile, 0644, k90_show_current_profile,
+static DEVICE_ATTR(macro_mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, k90_show_macro_mode, k90_store_macro_mode);
+static DEVICE_ATTR(current_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, k90_show_current_profile,
 		   k90_store_current_profile);
 
 static struct attribute *k90_attrs[] = {
-- 
2.9.2

