From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 12/15] HID: wiimote: Initialize IR cam on request
Date: Tue,  6 Sep 2011 13:50:37 +0200
Message-ID: <1315309840-4664-13-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab1IFLvZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:25 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:25 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Initialize the IR cam if the related input device is opened by userspace. Stop
IR cam again if userspace is no longer interested in its data events.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 35dc293..6658398 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -668,6 +668,32 @@ static void wiimote_accel_close(struct input_dev *dev)
 	hid_hw_close(wdata->hdev);
 }
 
+static int wiimote_ir_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	int ret;
+
+	ret = hid_hw_open(wdata->hdev);
+	if (ret)
+		return ret;
+
+	ret = wiimote_init_ir(wdata, WIIPROTO_FLAG_IR_BASIC);
+	if (ret) {
+		hid_hw_close(wdata->hdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void wiimote_ir_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	wiimote_init_ir(wdata, 0);
+	hid_hw_close(wdata->hdev);
+}
+
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 {
 	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
@@ -1062,6 +1088,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 		goto err_ir;
 
 	input_set_drvdata(wdata->ir, wdata);
+	wdata->ir->open = wiimote_ir_open;
+	wdata->ir->close = wiimote_ir_close;
 	wdata->ir->dev.parent = &wdata->hdev->dev;
 	wdata->ir->id.bustype = wdata->hdev->bus;
 	wdata->ir->id.vendor = wdata->hdev->vendor;
-- 
1.7.6.1

