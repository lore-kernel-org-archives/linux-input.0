From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 03/12] HID: wiimote: Add wiimote device structure
Date: Wed, 15 Jun 2011 01:45:48 +0200
Message-ID: <1308095157-4699-4-git-send-email-dh.herrmann@googlemail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1FNXqR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:17 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so41764fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:17 -0700 (PDT)
In-Reply-To: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Allocate wiimote device structure with all wiimote related data
when registering new wiimote devices.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index ed4fe18..27a4261 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -17,6 +17,10 @@
 #define WIIMOTE_VERSION "0.1"
 #define WIIMOTE_NAME "Nintendo Wii Remote"
 
+struct wiimote_data {
+	struct hid_device *hdev;
+};
+
 static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 							u8 *raw_data, int size)
 {
@@ -26,31 +30,59 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static struct wiimote_data *wiimote_create(struct hid_device *hdev)
+{
+	struct wiimote_data *wdata;
+
+	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
+	if (!wdata)
+		return NULL;
+
+	wdata->hdev = hdev;
+	hid_set_drvdata(hdev, wdata);
+
+	return wdata;
+}
+
 static int wiimote_hid_probe(struct hid_device *hdev,
 				const struct hid_device_id *id)
 {
+	struct wiimote_data *wdata;
 	int ret;
 
+	wdata = wiimote_create(hdev);
+	if (!wdata) {
+		hid_err(hdev, "Can't alloc device\n");
+		return -ENOMEM;
+	}
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "HID parse failed\n");
-		return ret;
+		goto err;
 	}
 
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret) {
 		hid_err(hdev, "HW start failed\n");
-		return ret;
+		goto err;
 	}
 
 	hid_info(hdev, "New device registered\n");
 	return 0;
+
+err:
+	kfree(wdata);
+	return ret;
 }
 
 static void wiimote_hid_remove(struct hid_device *hdev)
 {
+	struct wiimote_data *wdata = hid_get_drvdata(hdev);
+
 	hid_info(hdev, "Device removed\n");
 	hid_hw_stop(hdev);
+	kfree(wdata);
 }
 
 static const struct hid_device_id wiimote_hid_devices[] = {
-- 
1.7.5.2

