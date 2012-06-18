From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 16/22 v4] Input: atmel_mxt_ts - add sysfs entries to read fw and hw version
Date: Mon, 18 Jun 2012 12:08:36 +0800
Message-ID: <1339992522-22073-17-git-send-email-djkurtz@chromium.org>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:44649 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab2FREIt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 00:08:49 -0400
Received: by vcbfl13 with SMTP id fl13so409946vcb.1
        for <linux-input@vger.kernel.org>; Sun, 17 Jun 2012 21:08:48 -0700 (PDT)
In-Reply-To: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>

Make firmware and hardware version strings available to userspace.
This is useful, for example, to allow a userspace program to implement
a firwmare update policy.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9200cf4..0d769de 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -863,6 +863,26 @@ static void mxt_calc_resolution(struct mxt_data *data)
 	}
 }
 
+/* Firmware Version is returned as Major.Minor.Build */
+static ssize_t mxt_fw_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct mxt_data *data = dev_get_drvdata(dev);
+	struct mxt_info *info = &data->info;
+	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
+			 info->version >> 4, info->version & 0xf, info->build);
+}
+
+/* Hardware Version is returned as FamilyID.VariantID */
+static ssize_t mxt_hw_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct mxt_data *data = dev_get_drvdata(dev);
+	struct mxt_info *info = &data->info;
+	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
+			 info->family_id, info->variant_id);
+}
+
 static ssize_t mxt_object_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -1024,10 +1044,14 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	return count;
 }
 
+static DEVICE_ATTR(fw_version, S_IRUGO, mxt_fw_version_show, NULL);
+static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);
 static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_attrs[] = {
+	&dev_attr_fw_version.attr,
+	&dev_attr_hw_version.attr,
 	&dev_attr_object.attr,
 	&dev_attr_update_fw.attr,
 	NULL
-- 
1.7.7.3

