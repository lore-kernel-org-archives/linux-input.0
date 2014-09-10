From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4 v2] HID: wacom - Clean up of sysfs
Date: Wed, 10 Sep 2014 12:40:30 -0700
Message-ID: <1410378030-14504-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33545 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbaIJTkl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 15:40:41 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so6194223pdb.28
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 12:40:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: killertofu@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, "Paul A. Tessier" <phernost@gmail.com>

changed to scnprintf(buf, PAGE_SIZE, ... ) as suggested in sysfs.txt
for show functions

Signed-off-by: Paul A. Tessier <phernost@gmail.com>
Signed-Off-by: Ping Cheng <pingc@wacom.com>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v2: Move actual permission to patch one.

 drivers/hid/wacom_sys.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 950a205..4a7b9c8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -605,7 +605,8 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 {									\
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
-	return snprintf(buf, 2, "%d\n", wacom->led.select[SET_ID]);	\
+	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
+			 wacom->led.select[SET_ID]);			\
 }									\
 static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
 		    wacom_led##SET_ID##_select_show,			\
@@ -644,8 +645,15 @@ static ssize_t wacom_##name##_luminance_store(struct device *dev,	\
 	return wacom_luminance_store(wacom, &wacom->led.field,		\
 				     buf, count);			\
 }									\
+static ssize_t wacom_##name##_luminance_show(struct device *dev,	\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct wacom *wacom = dev_get_drvdata(dev);			\
+	return scnprintf(buf, PAGE_SIZE, "%d\n", wacom->led.field);	\
+}									\
 static DEVICE_ATTR(name##_luminance, DEV_ATTR_RW_PERM,			\
-		   NULL, wacom_##name##_luminance_store)
+		   wacom_##name##_luminance_show,			\
+		   wacom_##name##_luminance_store)
 
 DEVICE_LUMINANCE_ATTR(status0, llv);
 DEVICE_LUMINANCE_ATTR(status1, hlv);
-- 
1.9.1

