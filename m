From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0293/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:31 +0800
Message-ID: <20160802105731.907-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43413 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615AbcHBLg2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org, standby24x7@gmail.com, jkosina@suse.com, chuansheng.liu@intel.com, baolex.ni@intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/touchscreen/ili210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index ddf694b..a8a7089 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -169,7 +169,7 @@ static ssize_t ili210x_calibrate(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(calibrate, 0644, NULL, ili210x_calibrate);
+static DEVICE_ATTR(calibrate, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, NULL, ili210x_calibrate);
 
 static struct attribute *ili210x_attributes[] = {
 	&dev_attr_calibrate.attr,
-- 
2.9.2

