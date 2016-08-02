From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0225/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:51:12 +0800
Message-ID: <20160802105112.28749-1-baolex.ni@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52244 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592AbcHBL3T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 07:29:19 -0400
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
 drivers/hid/hid-roccat-arvo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 329c5d1..680d339 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -75,7 +75,7 @@ static ssize_t arvo_sysfs_set_mode_key(struct device *dev,
 
 	return size;
 }
-static DEVICE_ATTR(mode_key, 0660,
+static DEVICE_ATTR(mode_key, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 		   arvo_sysfs_show_mode_key, arvo_sysfs_set_mode_key);
 
 static ssize_t arvo_sysfs_show_key_mask(struct device *dev,
@@ -125,7 +125,7 @@ static ssize_t arvo_sysfs_set_key_mask(struct device *dev,
 
 	return size;
 }
-static DEVICE_ATTR(key_mask, 0660,
+static DEVICE_ATTR(key_mask, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 		   arvo_sysfs_show_key_mask, arvo_sysfs_set_key_mask);
 
 /* retval is 1-5 on success, < 0 on error */
@@ -183,7 +183,7 @@ static ssize_t arvo_sysfs_set_actual_profile(struct device *dev,
 	mutex_unlock(&arvo->arvo_lock);
 	return retval;
 }
-static DEVICE_ATTR(actual_profile, 0660,
+static DEVICE_ATTR(actual_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
 		   arvo_sysfs_show_actual_profile,
 		   arvo_sysfs_set_actual_profile);
 
@@ -235,7 +235,7 @@ static ssize_t arvo_sysfs_write_button(struct file *fp,
 	return arvo_sysfs_write(fp, kobj, buf, off, count,
 			sizeof(struct arvo_button), ARVO_COMMAND_BUTTON);
 }
-static BIN_ATTR(button, 0220, NULL, arvo_sysfs_write_button,
+static BIN_ATTR(button, S_IWUSR | S_IWGRP, NULL, arvo_sysfs_write_button,
 		sizeof(struct arvo_button));
 
 static ssize_t arvo_sysfs_read_info(struct file *fp,
@@ -245,7 +245,7 @@ static ssize_t arvo_sysfs_read_info(struct file *fp,
 	return arvo_sysfs_read(fp, kobj, buf, off, count,
 			sizeof(struct arvo_info), ARVO_COMMAND_INFO);
 }
-static BIN_ATTR(info, 0440, arvo_sysfs_read_info, NULL,
+static BIN_ATTR(info, S_IRUSR | S_IRGRP, arvo_sysfs_read_info, NULL,
 		sizeof(struct arvo_info));
 
 static struct attribute *arvo_attrs[] = {
-- 
2.9.2

