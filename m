From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0288/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:57:01 +0800
Message-ID: <20160802105701.569-1-baolex.ni@intel.com>
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
 drivers/input/touchscreen/ad7877.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 9c250ae..85e6135 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -497,7 +497,7 @@ static ssize_t ad7877_disable_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(disable, 0664, ad7877_disable_show, ad7877_disable_store);
+static DEVICE_ATTR(disable, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_disable_show, ad7877_disable_store);
 
 static ssize_t ad7877_dac_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -527,7 +527,7 @@ static ssize_t ad7877_dac_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dac, 0664, ad7877_dac_show, ad7877_dac_store);
+static DEVICE_ATTR(dac, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_dac_show, ad7877_dac_store);
 
 static ssize_t ad7877_gpio3_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -558,7 +558,7 @@ static ssize_t ad7877_gpio3_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(gpio3, 0664, ad7877_gpio3_show, ad7877_gpio3_store);
+static DEVICE_ATTR(gpio3, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_gpio3_show, ad7877_gpio3_store);
 
 static ssize_t ad7877_gpio4_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -589,7 +589,7 @@ static ssize_t ad7877_gpio4_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(gpio4, 0664, ad7877_gpio4_show, ad7877_gpio4_store);
+static DEVICE_ATTR(gpio4, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_gpio4_show, ad7877_gpio4_store);
 
 static struct attribute *ad7877_attributes[] = {
 	&dev_attr_temp1.attr,
-- 
2.9.2
