From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 04/12] HID: wiimote: Register input device in wiimote hid driver
Date: Tue,  5 Jul 2011 13:45:11 +0200
Message-ID: <1309866319-12899-4-git-send-email-dh.herrmann@googlemail.com>
References: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:37593 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657Ab1GELpg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 07:45:36 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so6110868fxd.11
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 04:45:35 -0700 (PDT)
In-Reply-To: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Register input device so the wiimote can report input events on
it. We do not use HIDINPUT because the wiimote does not provide any
descriptor table which might be used by HIDINPUT. So we avoid
having HIDINPUT parse the wiimote descriptor and create unrelated
or unknown event flags. Instead we register our own input device
that we have full control of.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index ff7cf12..deaf232 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -10,7 +10,9 @@
  * any later version.
  */
 
+#include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/input.h>
 #include <linux/module.h>
 #include "hid-ids.h"
 
@@ -19,8 +21,15 @@
 
 struct wiimote_data {
 	struct hid_device *hdev;
+	struct input_dev *input;
 };
 
+static int wiimote_input_event(struct input_dev *dev, unsigned int type,
+						unsigned int code, int value)
+{
+	return 0;
+}
+
 static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 							u8 *raw_data, int size)
 {
@@ -38,9 +47,24 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	if (!wdata)
 		return NULL;
 
+	wdata->input = input_allocate_device();
+	if (!wdata->input) {
+		kfree(wdata);
+		return NULL;
+	}
+
 	wdata->hdev = hdev;
 	hid_set_drvdata(hdev, wdata);
 
+	input_set_drvdata(wdata->input, wdata);
+	wdata->input->event = wiimote_input_event;
+	wdata->input->dev.parent = &wdata->hdev->dev;
+	wdata->input->id.bustype = wdata->hdev->bus;
+	wdata->input->id.vendor = wdata->hdev->vendor;
+	wdata->input->id.product = wdata->hdev->product;
+	wdata->input->id.version = wdata->hdev->version;
+	wdata->input->name = WIIMOTE_NAME;
+
 	return wdata;
 }
 
@@ -73,10 +97,19 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err;
 	}
 
+	ret = input_register_device(wdata->input);
+	if (ret) {
+		hid_err(hdev, "Cannot register input device\n");
+		goto err_stop;
+	}
+
 	hid_info(hdev, "New device registered\n");
 	return 0;
 
+err_stop:
+	hid_hw_stop(hdev);
 err:
+	input_free_device(wdata->input);
 	wiimote_destroy(wdata);
 	return ret;
 }
@@ -87,6 +120,7 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 
 	hid_info(hdev, "Device removed\n");
 	hid_hw_stop(hdev);
+	input_unregister_device(wdata->input);
 	wiimote_destroy(wdata);
 }
 
-- 
1.7.6

