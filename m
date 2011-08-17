From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH V2 2/5] HID: wiimote: Correctly call HID open/close callbacks
Date: Wed, 17 Aug 2011 11:43:21 +0200
Message-ID: <1313574204-12664-3-git-send-email-dh.herrmann@googlemail.com>
References: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55802 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1HQJn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:43:56 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so525058fxh.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 02:43:56 -0700 (PDT)
In-Reply-To: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: oliver@neukum.org, jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Even though the bluetooth hid backend does not react on open/close callbacks, we
should call them to be consistent with other hid drivers.

Also the new input open/close handlers will be used in future to prepare the
wiimote device for IR/extension input.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 8a68bf5..d49f67c 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -239,6 +239,20 @@ static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 	return 0;
 }
 
+static int wiimote_input_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	return hid_hw_open(wdata->hdev);
+}
+
+static void wiimote_input_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+
+	hid_hw_close(wdata->hdev);
+}
+
 static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 {
 	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
@@ -321,6 +335,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 	input_set_drvdata(wdata->input, wdata);
 	wdata->input->event = wiimote_input_event;
+	wdata->input->open = wiimote_input_open;
+	wdata->input->close = wiimote_input_close;
 	wdata->input->dev.parent = &wdata->hdev->dev;
 	wdata->input->id.bustype = wdata->hdev->bus;
 	wdata->input->id.vendor = wdata->hdev->vendor;
-- 
1.7.6

