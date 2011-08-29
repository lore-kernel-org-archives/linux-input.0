From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 13/14] HID: wiimote: Add status request
Date: Mon, 29 Aug 2011 15:38:10 +0200
Message-ID: <1314625091-1405-14-git-send-email-dh.herrmann@googlemail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab1H2Niu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:50 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:49 -0700 (PDT)
In-Reply-To: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

The wiimote does not send status reports continuously so this adds a helper
function to request a status report and parses the battery charge level.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 6658398..48198cb 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -41,6 +41,7 @@ struct wiimote_state {
 	__u32 opt;
 
 	/* results of synchronous requests */
+	__u8 cmd_battery;
 	__u8 cmd_err;
 };
 
@@ -83,6 +84,7 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
 	WIIPROTO_REQ_IR1 = 0x13,
+	WIIPROTO_REQ_SREQ = 0x15,
 	WIIPROTO_REQ_WMEM = 0x16,
 	WIIPROTO_REQ_RMEM = 0x17,
 	WIIPROTO_REQ_IR2 = 0x1a,
@@ -354,6 +356,17 @@ static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+static void wiiproto_req_status(struct wiimote_data *wdata)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_SREQ;
+	cmd[1] = 0;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
 {
 	accel = !!accel;
@@ -805,6 +818,11 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 
 	/* on status reports the drm is reset so we need to resend the drm */
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+
+	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_SREQ, 0)) {
+		wdata->state.cmd_battery = payload[5];
+		wiimote_cmd_complete(wdata);
+	}
 }
 
 static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
-- 
1.7.6.1

