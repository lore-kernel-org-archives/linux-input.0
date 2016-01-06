From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] hid: core: add managed version of hid_hw_start
Date: Wed, 6 Jan 2016 15:37:36 +0100
Message-ID: <568D26B0.9080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37483 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbcAFOht (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 09:37:49 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so78360335wmf.0
        for <linux-input@vger.kernel.org>; Wed, 06 Jan 2016 06:37:48 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org

Most calls to hid_hw_stop are boilerplate code. The function comment
states: "This is usually called from remove function or from probe
when something failed and hid_hw_start was called already."

A managed version of hid_hw_start allows to avoid this boilerplate
code in most cases (similar to the other devm_ functions). 
hid_hw_stop is called automatically before the device is deleted.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-core.c | 22 ++++++++++++++++++++++
 include/linux/hid.h    |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e95f23f..61c6f63 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2752,6 +2752,28 @@ int hid_check_keys_pressed(struct hid_device *hid)
 
 EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 
+static void __hid_hw_stop(void *data)
+{
+	hid_hw_stop((struct hid_device *)data);
+}
+
+int __must_check devm_hid_hw_start(struct hid_device *hdev,
+				   unsigned int connect_mask)
+{
+	int ret;
+
+	ret = hid_hw_start(hdev, connect_mask);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action(&hdev->dev, __hid_hw_stop, hdev);
+	if (ret)
+		hid_hw_stop(hdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hid_hw_start);
+
 static int __init hid_init(void)
 {
 	int ret;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..2d85b3e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -774,6 +774,9 @@ extern bool hid_ignore(struct hid_device *);
 extern int hid_add_device(struct hid_device *);
 extern void hid_destroy_device(struct hid_device *);
 
+extern int __must_check devm_hid_hw_start(struct hid_device *hdev,
+					  unsigned int connect_mask);
+
 extern int __must_check __hid_register_driver(struct hid_driver *,
 		struct module *, const char *mod_name);
 
-- 
2.6.4


