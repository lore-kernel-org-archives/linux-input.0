From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0222/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:50:58 +0800
Message-ID: <20160802105058.28551-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51452 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298AbcHBL2k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:28:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bonbons@linux-vserver.org, jikos@kernel.org, benjamin.tissoires@redhat.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, alexander.deucher@amd.com, ville.syrjala@linux.intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/hid/hid-picolcd_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index c1b29a9..894d884 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -306,7 +306,7 @@ static ssize_t picolcd_operation_mode_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(operation_mode, 0644, picolcd_operation_mode_show,
+static DEVICE_ATTR(operation_mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, picolcd_operation_mode_show,
 		picolcd_operation_mode_store);
 
 /*
@@ -334,7 +334,7 @@ static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(operation_mode_delay, 0644, picolcd_operation_mode_delay_show,
+static DEVICE_ATTR(operation_mode_delay, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, picolcd_operation_mode_delay_show,
 		picolcd_operation_mode_delay_store);
 
 /*
-- 
2.9.2

