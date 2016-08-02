From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0223/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:03 +0800
Message-ID: <20160802105103.28617-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52244 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445AbcHBL3R (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:29:17 -0400
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
 drivers/hid/hid-picolcd_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 7f965e2..b12c277 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -501,7 +501,7 @@ static ssize_t picolcd_fb_update_rate_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fb_update_rate, 0664, picolcd_fb_update_rate_show,
+static DEVICE_ATTR(fb_update_rate, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, picolcd_fb_update_rate_show,
 		picolcd_fb_update_rate_store);
 
 /* initialize Framebuffer device */
-- 
2.9.2

