From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0229/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:30 +0800
Message-ID: <20160802105130.29013-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: erazor_de@users.sourceforge.net, jikos@kernel.org, benjamin.tissoires@redhat.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, alexander.deucher@amd.com, ville.syrjala@linux.intel.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 43617fb..b010514 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -319,7 +319,7 @@ static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
 
 	return size;
 }
-static DEVICE_ATTR(actual_profile, 0660,
+static DEVICE_ATTR(actual_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 		   kovaplus_sysfs_show_actual_profile,
 		   kovaplus_sysfs_set_actual_profile);
 
@@ -330,7 +330,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
 }
-static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
+static DEVICE_ATTR(actual_cpi, S_IRUSR | S_IRGRP, kovaplus_sysfs_show_actual_cpi, NULL);
 
 static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -339,7 +339,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
 }
-static DEVICE_ATTR(actual_sensitivity_x, 0440,
+static DEVICE_ATTR(actual_sensitivity_x, S_IRUSR | S_IRGRP,
 		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
 
 static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
@@ -349,7 +349,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
 }
-static DEVICE_ATTR(actual_sensitivity_y, 0440,
+static DEVICE_ATTR(actual_sensitivity_y, S_IRUSR | S_IRGRP,
 		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
 
 static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
@@ -370,7 +370,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
 }
-static DEVICE_ATTR(firmware_version, 0440,
+static DEVICE_ATTR(firmware_version, S_IRUSR | S_IRGRP,
 		   kovaplus_sysfs_show_firmware_version, NULL);
 
 static struct attribute *kovaplus_attrs[] = {
-- 
2.9.2
