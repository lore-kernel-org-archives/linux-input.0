From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 12/16] HID: wiimote: Add write-register helpers
Date: Thu, 28 Jul 2011 18:08:32 +0200
Message-ID: <1311869316-17128-13-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab1G1QJU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:20 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:20 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Add helpers to synchronously write registers of the wiimote. This is heavily
used by initialization functions for wiimote peripherals.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 0181971..c6b1d24 100644
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
@@ -422,6 +425,24 @@ static void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom,
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
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
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
@@ -664,9 +685,13 @@ static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 
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
1.7.6

