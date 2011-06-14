From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 10/12] HID: wiimote: Add wiimote led request
Date: Wed, 15 Jun 2011 01:45:55 +0200
Message-ID: <1308095157-4699-11-git-send-email-dh.herrmann@googlemail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1FNXq0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:26 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so41764fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:26 -0700 (PDT)
In-Reply-To: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Add new request that sets the leds on the target device. Also, per
default, set led1 after initializing a device.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 4c3f5eb..fbdd7ef 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -39,7 +39,13 @@ struct wiimote_data {
 	struct work_struct worker;
 };
 
+#define WIIPROTO_FLAG_LED1 0x01
+#define WIIPROTO_FLAG_LED2 0x02
+#define WIIPROTO_FLAG_LED3 0x04
+#define WIIPROTO_FLAG_LED4 0x08
+
 enum wiiproto_reqs {
+	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
 
@@ -154,6 +160,25 @@ static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
 	spin_unlock_irqrestore(&wdata->qlock, flags);
 }
 
+static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_LED;
+	cmd[1] = 0;
+
+	if (leds & WIIPROTO_FLAG_LED1)
+		cmd[1] |= 0x10;
+	if (leds & WIIPROTO_FLAG_LED2)
+		cmd[1] |= 0x20;
+	if (leds & WIIPROTO_FLAG_LED3)
+		cmd[1] |= 0x40;
+	if (leds & WIIPROTO_FLAG_LED4)
+		cmd[1] |= 0x80;
+
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -294,6 +319,7 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 
 	atomic_set(&wdata->ready, 1);
 	hid_info(hdev, "New device registered\n");
+	wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
 	return 0;
 
 err_stop:
-- 
1.7.5.2

