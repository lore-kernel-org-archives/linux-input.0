From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 10/14] HID: wiimote: Add write-register helpers
Date: Mon, 29 Aug 2011 15:38:07 +0200
Message-ID: <1314625091-1405-11-git-send-email-dh.herrmann@googlemail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab1H2Nip (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:45 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:44 -0700 (PDT)
In-Reply-To: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

Add helpers to synchronously write registers of the wiimote. This is heavily
used by initialization functions for wiimote peripherals.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 0a5e458..59a0893 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -39,6 +39,9 @@ struct wiimote_state {
 	struct completion ready;
 	int cmd;
 	__u32 opt;
+
+	/* results of synchronous requests */
+	__u8 cmd_err;
 };
 
 struct wiimote_data {
@@ -394,6 +397,25 @@ static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+/* requries the cmd-mutex to be held */
+static int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
+						const __u8 *wmem, __u8 size)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
+	wiiproto_req_wreg(wdata, offset, wmem, size);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	if (!ret && wdata->state.cmd_err)
+		ret = -EIO;
+
+	return ret;
+}
+
 static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
 {
 	struct wiimote_data *wdata;
@@ -635,9 +657,13 @@ static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 
 	handler_keys(wdata, payload);
 
-	if (err)
+	if (wiimote_cmd_pending(wdata, cmd, 0)) {
+		wdata->state.cmd_err = err;
+		wiimote_cmd_complete(wdata);
+	} else if (err) {
 		hid_warn(wdata->hdev, "Remote error %hhu on req %hhu\n", err,
 									cmd);
+	}
 }
 
 static void handler_drm_KA(struct wiimote_data *wdata, const __u8 *payload)
-- 
1.7.6.1

