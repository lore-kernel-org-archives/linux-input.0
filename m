From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] hid: Make report_descriptor available for all devices
Date: Thu, 19 Nov 2015 08:19:31 -0800
Message-ID: <8e1380539994340dd37e16abcc21c75cf9fc6e89.1447949840.git.luto@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36308 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901AbbKSQTf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 11:19:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Andy Lutomirski <luto@kernel.org>

Currently the sysfs report_descriptor attribute is only available if
the device is claimed.  We have the descriptor before we even create
the device node, so just instantiate report_descriptor statically.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/hid/hid-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 70a11ac38119..b2ea77d06d45 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1687,11 +1687,6 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		hid_warn(hdev,
 			 "can't create sysfs country code attribute err: %d\n", ret);
 
-	ret = device_create_bin_file(&hdev->dev, &dev_bin_attr_report_desc);
-	if (ret)
-		hid_warn(hdev,
-			 "can't create sysfs report descriptor attribute err: %d\n", ret);
-
 	hid_info(hdev, "%s: %s HID v%x.%02x %s [%s] on %s\n",
 		 buf, bus, hdev->version >> 8, hdev->version & 0xff,
 		 type, hdev->name, hdev->phys);
@@ -1703,7 +1698,6 @@ EXPORT_SYMBOL_GPL(hid_connect);
 void hid_disconnect(struct hid_device *hdev)
 {
 	device_remove_file(&hdev->dev, &dev_attr_country);
-	device_remove_bin_file(&hdev->dev, &dev_bin_attr_report_desc);
 	if (hdev->claimed & HID_CLAIMED_INPUT)
 		hidinput_disconnect(hdev);
 	if (hdev->claimed & HID_CLAIMED_HIDDEV)
@@ -2228,7 +2222,15 @@ static struct attribute *hid_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(hid_dev);
+static struct bin_attribute *hid_dev_bin_attrs[] = {
+	&dev_bin_attr_report_desc,
+	NULL
+};
+static const struct attribute_group hid_dev_group = {
+	.attrs = hid_dev_attrs,
+	.bin_attrs = hid_dev_bin_attrs,
+};
+__ATTRIBUTE_GROUPS(hid_dev);
 
 static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-- 
2.5.0

