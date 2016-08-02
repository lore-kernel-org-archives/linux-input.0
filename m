From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0277/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:55:55 +0800
Message-ID: <20160802105555.32276-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, haggaie@mellanox.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/misc/adxl34x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 2b2d02f..dd5c8ff 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -477,7 +477,7 @@ static ssize_t adxl34x_disable_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(disable, 0664, adxl34x_disable_show, adxl34x_disable_store);
+static DEVICE_ATTR(disable, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adxl34x_disable_show, adxl34x_disable_store);
 
 static ssize_t adxl34x_calibrate_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -524,7 +524,7 @@ static ssize_t adxl34x_calibrate_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(calibrate, 0664,
+static DEVICE_ATTR(calibrate, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 		   adxl34x_calibrate_show, adxl34x_calibrate_store);
 
 static ssize_t adxl34x_rate_show(struct device *dev,
@@ -559,7 +559,7 @@ static ssize_t adxl34x_rate_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(rate, 0664, adxl34x_rate_show, adxl34x_rate_store);
+static DEVICE_ATTR(rate, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adxl34x_rate_show, adxl34x_rate_store);
 
 static ssize_t adxl34x_autosleep_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -597,7 +597,7 @@ static ssize_t adxl34x_autosleep_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(autosleep, 0664,
+static DEVICE_ATTR(autosleep, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 		   adxl34x_autosleep_show, adxl34x_autosleep_store);
 
 static ssize_t adxl34x_position_show(struct device *dev,
@@ -639,7 +639,7 @@ static ssize_t adxl34x_write_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(write, 0664, NULL, adxl34x_write_store);
+static DEVICE_ATTR(write, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, NULL, adxl34x_write_store);
 #endif
 
 static struct attribute *adxl34x_attributes[] = {
-- 
2.9.2
