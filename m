From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] HID: lenovo: Remove sysfs group on failure path
Date: Fri, 29 May 2015 03:39:31 +0300
Message-ID: <1432859971-28185-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:35829 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbbE2Ajl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 20:39:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

There is no sysfs_group_remove() on failure path in lenovo_probe_tpkbd().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/hid/hid-lenovo.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index c4c3f0952521..64ed3e3f227a 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -599,7 +599,8 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 				    GFP_KERNEL);
 	if (data_pointer == NULL) {
 		hid_err(hdev, "Could not allocate memory for driver data\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	// set same default values as windows driver
@@ -610,7 +611,8 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	name_micmute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
 	if (name_mute == NULL || name_micmute == NULL) {
 		hid_err(hdev, "Could not allocate memory for led data\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 	snprintf(name_mute, name_sz, "%s:amber:mute", dev_name(dev));
 	snprintf(name_micmute, name_sz, "%s:amber:micmute", dev_name(dev));
@@ -634,6 +636,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	lenovo_features_set_tpkbd(hdev);
 
 	return 0;
+err:
+	sysfs_remove_group(&hdev->dev.kobj, &lenovo_attr_group_tpkbd);
+	return ret;
 }
 
 static int lenovo_probe_cptkbd(struct hid_device *hdev)
-- 
1.9.1

