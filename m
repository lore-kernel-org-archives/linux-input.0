From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0230/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:36 +0800
Message-ID: <20160802105136.29079-1-baolex.ni@intel.com>
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
 drivers/hid/hid-roccat-pyra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index b30aa7b..fa85a8d 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -291,7 +291,7 @@ static ssize_t pyra_sysfs_show_actual_cpi(struct device *dev,
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
 	return snprintf(buf, PAGE_SIZE, "%d\n", pyra->actual_cpi);
 }
-static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
+static DEVICE_ATTR(actual_cpi, S_IRUSR | S_IRGRP, pyra_sysfs_show_actual_cpi, NULL);
 
 static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -308,8 +308,8 @@ static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", settings.startup_profile);
 }
-static DEVICE_ATTR(actual_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
-static DEVICE_ATTR(startup_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
+static DEVICE_ATTR(actual_profile, S_IRUSR | S_IRGRP, pyra_sysfs_show_actual_profile, NULL);
+static DEVICE_ATTR(startup_profile, S_IRUSR | S_IRGRP, pyra_sysfs_show_actual_profile, NULL);
 
 static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -329,7 +329,7 @@ static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
 }
-static DEVICE_ATTR(firmware_version, 0440, pyra_sysfs_show_firmware_version,
+static DEVICE_ATTR(firmware_version, S_IRUSR | S_IRGRP, pyra_sysfs_show_firmware_version,
 		   NULL);
 
 static struct attribute *pyra_attrs[] = {
-- 
2.9.2
