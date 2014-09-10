From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4 v2] HID: wacom - Add default permission defines for sysfs  attributes
Date: Wed, 10 Sep 2014 12:40:05 -0700
Message-ID: <1410378005-14464-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47152 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbaIJTkO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 15:40:14 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq14so5222660pab.25
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 12:40:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: killertofu@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, "Paul A. Tessier" <phernost@gmail.com>

RW : ug=rw,o=r
WO : ug=w

And enabled reading relavent sysfs attributes.

Signed-off-by: Paul A. Tessier <phernost@gmail.com>
Signed-Off-by: Ping Cheng <pingc@wacom.com>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v2: Integrate actual permission with defines.

 drivers/hid/wacom_sys.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f0db7ec..950a205 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -23,6 +23,9 @@
 #define WAC_CMD_ICON_BT_XFER	0x26
 #define WAC_CMD_RETRIES		10
 
+#define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
+#define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
+
 static int wacom_get_report(struct hid_device *hdev, u8 type, u8 id,
 			    void *buf, size_t size, unsigned int retries)
 {
@@ -604,7 +607,7 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
 	return snprintf(buf, 2, "%d\n", wacom->led.select[SET_ID]);	\
 }									\
-static DEVICE_ATTR(status_led##SET_ID##_select, S_IWUSR | S_IRUSR,	\
+static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
 		    wacom_led##SET_ID##_select_show,			\
 		    wacom_led##SET_ID##_select_store)
 
@@ -641,7 +644,7 @@ static ssize_t wacom_##name##_luminance_store(struct device *dev,	\
 	return wacom_luminance_store(wacom, &wacom->led.field,		\
 				     buf, count);			\
 }									\
-static DEVICE_ATTR(name##_luminance, S_IWUSR,				\
+static DEVICE_ATTR(name##_luminance, DEV_ATTR_RW_PERM,			\
 		   NULL, wacom_##name##_luminance_store)
 
 DEVICE_LUMINANCE_ATTR(status0, llv);
@@ -683,7 +686,7 @@ static ssize_t wacom_btnimg##BUTTON_ID##_store(struct device *dev,	\
 {									\
 	return wacom_button_image_store(dev, BUTTON_ID, buf, count);	\
 }									\
-static DEVICE_ATTR(button##BUTTON_ID##_rawimg, S_IWUSR,			\
+static DEVICE_ATTR(button##BUTTON_ID##_rawimg, DEV_ATTR_WO_PERM,	\
 		   NULL, wacom_btnimg##BUTTON_ID##_store)
 
 DEVICE_BTNIMG_ATTR(0);
@@ -989,7 +992,7 @@ static ssize_t wacom_store_speed(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(speed, S_IRUGO | S_IWUSR | S_IWGRP,
+static DEVICE_ATTR(speed, DEV_ATTR_RW_PERM,
 		wacom_show_speed, wacom_store_speed);
 
 static struct input_dev *wacom_allocate_input(struct wacom *wacom)
-- 
1.9.1

