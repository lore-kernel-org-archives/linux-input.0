From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0289/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:05 +0800
Message-ID: <20160802105705.635-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/touchscreen/ad7879.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e4bf110..83be4c5 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -364,7 +364,7 @@ static ssize_t ad7879_disable_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(disable, 0664, ad7879_disable_show, ad7879_disable_store);
+static DEVICE_ATTR(disable, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7879_disable_show, ad7879_disable_store);
 
 static struct attribute *ad7879_attributes[] = {
 	&dev_attr_disable.attr,
-- 
2.9.2
