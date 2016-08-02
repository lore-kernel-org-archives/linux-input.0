From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0227/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:21 +0800
Message-ID: <20160802105121.28881-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6754 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275AbcHBL3I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:29:08 -0400
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
 drivers/hid/hid-roccat-kone.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index bf4675a..06e5960 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -324,7 +324,7 @@ static ssize_t kone_sysfs_write_settings(struct file *fp, struct kobject *kobj,
 
 	return sizeof(struct kone_settings);
 }
-static BIN_ATTR(settings, 0660, kone_sysfs_read_settings,
+static BIN_ATTR(settings, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP, kone_sysfs_read_settings,
 		kone_sysfs_write_settings, sizeof(struct kone_settings));
 
 static ssize_t kone_sysfs_read_profilex(struct file *fp,
@@ -399,7 +399,7 @@ static ssize_t kone_sysfs_show_actual_profile(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_profile);
 }
-static DEVICE_ATTR(actual_profile, 0440, kone_sysfs_show_actual_profile, NULL);
+static DEVICE_ATTR(actual_profile, S_IRUSR | S_IRGRP, kone_sysfs_show_actual_profile, NULL);
 
 static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -408,7 +408,7 @@ static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_dpi);
 }
-static DEVICE_ATTR(actual_dpi, 0440, kone_sysfs_show_actual_dpi, NULL);
+static DEVICE_ATTR(actual_dpi, S_IRUSR | S_IRGRP, kone_sysfs_show_actual_dpi, NULL);
 
 /* weight is read each time, since we don't get informed when it's changed */
 static ssize_t kone_sysfs_show_weight(struct device *dev,
@@ -431,7 +431,7 @@ static ssize_t kone_sysfs_show_weight(struct device *dev,
 		return retval;
 	return snprintf(buf, PAGE_SIZE, "%d\n", weight);
 }
-static DEVICE_ATTR(weight, 0440, kone_sysfs_show_weight, NULL);
+static DEVICE_ATTR(weight, S_IRUSR | S_IRGRP, kone_sysfs_show_weight, NULL);
 
 static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -440,7 +440,7 @@ static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", kone->firmware_version);
 }
-static DEVICE_ATTR(firmware_version, 0440, kone_sysfs_show_firmware_version,
+static DEVICE_ATTR(firmware_version, S_IRUSR | S_IRGRP, kone_sysfs_show_firmware_version,
 		   NULL);
 
 static ssize_t kone_sysfs_show_tcu(struct device *dev,
@@ -543,7 +543,7 @@ exit_unlock:
 	mutex_unlock(&kone->kone_lock);
 	return retval;
 }
-static DEVICE_ATTR(tcu, 0660, kone_sysfs_show_tcu, kone_sysfs_set_tcu);
+static DEVICE_ATTR(tcu, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP, kone_sysfs_show_tcu, kone_sysfs_set_tcu);
 
 static ssize_t kone_sysfs_show_startup_profile(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -590,7 +590,7 @@ static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
 	mutex_unlock(&kone->kone_lock);
 	return size;
 }
-static DEVICE_ATTR(startup_profile, 0660, kone_sysfs_show_startup_profile,
+static DEVICE_ATTR(startup_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP, kone_sysfs_show_startup_profile,
 		   kone_sysfs_set_startup_profile);
 
 static struct attribute *kone_attrs[] = {
-- 
2.9.2

