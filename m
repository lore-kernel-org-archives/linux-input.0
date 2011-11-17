From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 08/17] HID: wiimote: Register input devices for extensions
Date: Thu, 17 Nov 2011 14:12:05 +0100
Message-ID: <1321535534-7950-9-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQNNB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:13:01 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873323eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:13:00 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

Motion+ and regular extensions are physical adapters for the wiimote so create
one input device for each of them. This also allows to enable only opened
extensions and turn unused extenions off to save battery power.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |  109 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 477513d..b925401 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -19,6 +19,8 @@
 struct wiimote_ext {
 	struct wiimote_data *wdata;
 	struct work_struct worker;
+	struct input_dev *input;
+	struct input_dev *mp_input;
 
 	atomic_t opened;
 	atomic_t mp_opened;
@@ -57,6 +59,9 @@ static bool motionp_read(struct wiimote_ext *ext)
 	ssize_t ret;
 	bool avail = false;
 
+	if (!atomic_read(&ext->mp_opened))
+		return false;
+
 	if (wiimote_cmd_acquire(ext->wdata))
 		return false;
 
@@ -82,7 +87,7 @@ static __u8 ext_read(struct wiimote_ext *ext)
 	__u8 rmem[2], wmem;
 	__u8 type = WIIEXT_NONE;
 
-	if (!ext->plugged)
+	if (!ext->plugged || !atomic_read(&ext->opened))
 		return WIIEXT_NONE;
 
 	if (wiimote_cmd_acquire(ext->wdata))
@@ -234,6 +239,54 @@ static ssize_t wiiext_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(extension, S_IRUGO, wiiext_show, NULL);
 
+static int wiiext_input_open(struct input_dev *dev)
+{
+	struct wiimote_ext *ext = input_get_drvdata(dev);
+	int ret;
+
+	ret = hid_hw_open(ext->wdata->hdev);
+	if (ret)
+		return ret;
+
+	atomic_inc(&ext->opened);
+	wiiext_schedule(ext);
+
+	return 0;
+}
+
+static void wiiext_input_close(struct input_dev *dev)
+{
+	struct wiimote_ext *ext = input_get_drvdata(dev);
+
+	atomic_dec(&ext->opened);
+	wiiext_schedule(ext);
+	hid_hw_close(ext->wdata->hdev);
+}
+
+static int wiiext_mp_open(struct input_dev *dev)
+{
+	struct wiimote_ext *ext = input_get_drvdata(dev);
+	int ret;
+
+	ret = hid_hw_open(ext->wdata->hdev);
+	if (ret)
+		return ret;
+
+	atomic_inc(&ext->mp_opened);
+	wiiext_schedule(ext);
+
+	return 0;
+}
+
+static void wiiext_mp_close(struct input_dev *dev)
+{
+	struct wiimote_ext *ext = input_get_drvdata(dev);
+
+	atomic_dec(&ext->mp_opened);
+	wiiext_schedule(ext);
+	hid_hw_close(ext->wdata->hdev);
+}
+
 /* Initializes the extension driver of a wiimote */
 int wiiext_init(struct wiimote_data *wdata)
 {
@@ -248,9 +301,53 @@ int wiiext_init(struct wiimote_data *wdata)
 	ext->wdata = wdata;
 	INIT_WORK(&ext->worker, wiiext_worker);
 
+	ext->input = input_allocate_device();
+	if (!ext->input) {
+		ret = -ENOMEM;
+		goto err_input;
+	}
+
+	input_set_drvdata(ext->input, ext);
+	ext->input->open = wiiext_input_open;
+	ext->input->close = wiiext_input_close;
+	ext->input->dev.parent = &wdata->hdev->dev;
+	ext->input->id.bustype = wdata->hdev->bus;
+	ext->input->id.vendor = wdata->hdev->vendor;
+	ext->input->id.product = wdata->hdev->product;
+	ext->input->id.version = wdata->hdev->version;
+	ext->input->name = WIIMOTE_NAME " Extension";
+
+	ret = input_register_device(ext->input);
+	if (ret) {
+		input_free_device(ext->input);
+		goto err_input;
+	}
+
+	ext->mp_input = input_allocate_device();
+	if (!ext->mp_input) {
+		ret = -ENOMEM;
+		goto err_mp;
+	}
+
+	input_set_drvdata(ext->mp_input, ext);
+	ext->mp_input->open = wiiext_mp_open;
+	ext->mp_input->close = wiiext_mp_close;
+	ext->mp_input->dev.parent = &wdata->hdev->dev;
+	ext->mp_input->id.bustype = wdata->hdev->bus;
+	ext->mp_input->id.vendor = wdata->hdev->vendor;
+	ext->mp_input->id.product = wdata->hdev->product;
+	ext->mp_input->id.version = wdata->hdev->version;
+	ext->mp_input->name = WIIMOTE_NAME " Motion+";
+
+	ret = input_register_device(ext->mp_input);
+	if (ret) {
+		input_free_device(ext->mp_input);
+		goto err_mp;
+	}
+
 	ret = device_create_file(&wdata->hdev->dev, &dev_attr_extension);
 	if (ret)
-		goto err;
+		goto err_dev;
 
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wdata->ext = ext;
@@ -258,7 +355,11 @@ int wiiext_init(struct wiimote_data *wdata)
 
 	return 0;
 
-err:
+err_dev:
+	input_unregister_device(ext->mp_input);
+err_mp:
+	input_unregister_device(ext->input);
+err_input:
 	kfree(ext);
 	return ret;
 }
@@ -285,6 +386,8 @@ void wiiext_deinit(struct wiimote_data *wdata)
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+	input_unregister_device(ext->mp_input);
+	input_unregister_device(ext->input);
 
 	cancel_work_sync(&ext->worker);
 	kfree(ext);
-- 
1.7.7.3

