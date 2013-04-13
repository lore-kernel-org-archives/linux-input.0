From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 03/21] HID: wiimote: keep HID device open
Date: Sat, 13 Apr 2013 12:47:44 +0200
Message-ID: <1365850082-3585-4-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:41000 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3DMKsb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:31 -0400
Received: by mail-ea0-f178.google.com with SMTP id o10so1592541eaj.37
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:29 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

We need constant I/O to keep the state up-to-date and not miss any
packets. Hence, call hid_hw_open() during setup and hid_hw_close() during
destruction.

These are no-ops for Bluetooth HIDP, but lets be safe.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 48 ++++++++++--------------------------------
 drivers/hid/hid-wiimote-ext.c  | 12 -----------
 2 files changed, 11 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 2d85d3a..02656a8 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -626,30 +626,11 @@ static int wiimote_ff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int wiimote_input_open(struct input_dev *dev)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-
-	return hid_hw_open(wdata->hdev);
-}
-
-static void wiimote_input_close(struct input_dev *dev)
-{
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-
-	hid_hw_close(wdata->hdev);
-}
-
 static int wiimote_accel_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
-	int ret;
 	unsigned long flags;
 
-	ret = hid_hw_open(wdata->hdev);
-	if (ret)
-		return ret;
-
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wiiproto_req_accel(wdata, true);
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
@@ -665,26 +646,13 @@ static void wiimote_accel_close(struct input_dev *dev)
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wiiproto_req_accel(wdata, false);
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
-	hid_hw_close(wdata->hdev);
 }
 
 static int wiimote_ir_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
-	int ret;
-
-	ret = hid_hw_open(wdata->hdev);
-	if (ret)
-		return ret;
-
-	ret = wiimote_init_ir(wdata, WIIPROTO_FLAG_IR_BASIC);
-	if (ret) {
-		hid_hw_close(wdata->hdev);
-		return ret;
-	}
 
-	return 0;
+	return wiimote_init_ir(wdata, WIIPROTO_FLAG_IR_BASIC);
 }
 
 static void wiimote_ir_close(struct input_dev *dev)
@@ -692,7 +660,6 @@ static void wiimote_ir_close(struct input_dev *dev)
 	struct wiimote_data *wdata = input_get_drvdata(dev);
 
 	wiimote_init_ir(wdata, 0);
-	hid_hw_close(wdata->hdev);
 }
 
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
@@ -1091,8 +1058,6 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	hid_set_drvdata(hdev, wdata);
 
 	input_set_drvdata(wdata->input, wdata);
-	wdata->input->open = wiimote_input_open;
-	wdata->input->close = wiimote_input_close;
 	wdata->input->dev.parent = &wdata->hdev->dev;
 	wdata->input->id.bustype = wdata->hdev->bus;
 	wdata->input->id.vendor = wdata->hdev->vendor;
@@ -1193,6 +1158,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	input_unregister_device(wdata->ir);
 	input_unregister_device(wdata->input);
 	cancel_work_sync(&wdata->queue.worker);
+	hid_hw_close(wdata->hdev);
 	hid_hw_stop(wdata->hdev);
 
 	kfree(wdata);
@@ -1224,10 +1190,16 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err;
 	}
 
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "cannot start hardware I/O\n");
+		goto err_stop;
+	}
+
 	ret = input_register_device(wdata->accel);
 	if (ret) {
 		hid_err(hdev, "Cannot register input device\n");
-		goto err_stop;
+		goto err_close;
 	}
 
 	ret = input_register_device(wdata->ir);
@@ -1298,6 +1270,8 @@ err_input:
 err_ir:
 	input_unregister_device(wdata->accel);
 	wdata->accel = NULL;
+err_close:
+	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
 err:
diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 1c104fc..267c89c 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -661,11 +661,6 @@ static DEVICE_ATTR(extension, S_IRUGO, wiiext_show, NULL);
 static int wiiext_input_open(struct input_dev *dev)
 {
 	struct wiimote_ext *ext = input_get_drvdata(dev);
-	int ret;
-
-	ret = hid_hw_open(ext->wdata->hdev);
-	if (ret)
-		return ret;
 
 	atomic_inc(&ext->opened);
 	wiiext_schedule(ext);
@@ -679,17 +674,11 @@ static void wiiext_input_close(struct input_dev *dev)
 
 	atomic_dec(&ext->opened);
 	wiiext_schedule(ext);
-	hid_hw_close(ext->wdata->hdev);
 }
 
 static int wiiext_mp_open(struct input_dev *dev)
 {
 	struct wiimote_ext *ext = input_get_drvdata(dev);
-	int ret;
-
-	ret = hid_hw_open(ext->wdata->hdev);
-	if (ret)
-		return ret;
 
 	atomic_inc(&ext->mp_opened);
 	wiiext_schedule(ext);
@@ -703,7 +692,6 @@ static void wiiext_mp_close(struct input_dev *dev)
 
 	atomic_dec(&ext->mp_opened);
 	wiiext_schedule(ext);
-	hid_hw_close(ext->wdata->hdev);
 }
 
 /* Initializes the extension driver of a wiimote */
-- 
1.8.2.1

