From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0226/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:17 +0800
Message-ID: <20160802105117.28815-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46777 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142AbcHBL3D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:29:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: erazor_de@users.sourceforge.net, jikos@kernel.org, benjamin.tissoires@redhat.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, alexander.deucher@amd.com, ville.syrjala@linux.intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/hid/hid-roccat-isku.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 02db537..566e265 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -109,7 +109,7 @@ static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
 
 	return size;
 }
-static DEVICE_ATTR(actual_profile, 0660, isku_sysfs_show_actual_profile,
+static DEVICE_ATTR(actual_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP, isku_sysfs_show_actual_profile,
 		   isku_sysfs_set_actual_profile);
 
 static struct attribute *isku_attrs[] = {
-- 
2.9.2

