From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] HID: wacom - enable reading relavent sysfs attributes
Date: Wed, 10 Sep 2014 11:40:59 -0700
Message-ID: <1410374459-25872-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54182 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaIJSlI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 14:41:08 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so7997521pdi.21
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 11:41:07 -0700 (PDT)
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
 drivers/hid/wacom_sys.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2ce102b..4a7b9c8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -605,9 +605,10 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 {									\
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
-	return snprintf(buf, 2, "%d\n", wacom->led.select[SET_ID]);	\
+	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
+			 wacom->led.select[SET_ID]);			\
 }									\
-static DEVICE_ATTR(status_led##SET_ID##_select, S_IWUSR | S_IRUSR,	\
+static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
 		    wacom_led##SET_ID##_select_show,			\
 		    wacom_led##SET_ID##_select_store)
 
@@ -644,8 +645,15 @@ static ssize_t wacom_##name##_luminance_store(struct device *dev,	\
 	return wacom_luminance_store(wacom, &wacom->led.field,		\
 				     buf, count);			\
 }									\
-static DEVICE_ATTR(name##_luminance, S_IWUSR,				\
-		   NULL, wacom_##name##_luminance_store)
+static ssize_t wacom_##name##_luminance_show(struct device *dev,	\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct wacom *wacom = dev_get_drvdata(dev);			\
+	return scnprintf(buf, PAGE_SIZE, "%d\n", wacom->led.field);	\
+}									\
+static DEVICE_ATTR(name##_luminance, DEV_ATTR_RW_PERM,				\
+		   wacom_##name##_luminance_show,			\
+		   wacom_##name##_luminance_store)
 
 DEVICE_LUMINANCE_ATTR(status0, llv);
 DEVICE_LUMINANCE_ATTR(status1, hlv);
@@ -686,7 +694,7 @@ static ssize_t wacom_btnimg##BUTTON_ID##_store(struct device *dev,	\
 {									\
 	return wacom_button_image_store(dev, BUTTON_ID, buf, count);	\
 }									\
-static DEVICE_ATTR(button##BUTTON_ID##_rawimg, S_IWUSR,			\
+static DEVICE_ATTR(button##BUTTON_ID##_rawimg, DEV_ATTR_WO_PERM,	\
 		   NULL, wacom_btnimg##BUTTON_ID##_store)
 
 DEVICE_BTNIMG_ATTR(0);
@@ -992,7 +1000,7 @@ static ssize_t wacom_store_speed(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(speed, S_IRUGO | S_IWUSR | S_IWGRP,
+static DEVICE_ATTR(speed, DEV_ATTR_RW_PERM,
 		wacom_show_speed, wacom_store_speed);
 
 static struct input_dev *wacom_allocate_input(struct wacom *wacom)
-- 
1.9.1

