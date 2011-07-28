From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 01/16] HID: wiimote: Support rumble device
Date: Thu, 28 Jul 2011 18:08:21 +0200
Message-ID: <1311869316-17128-2-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657Ab1G1QJF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:05 -0400
Received: by fxh19 with SMTP id 19so1400102fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:04 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

This adds support for the wiimote's rumble device. Every output report can
enable and disable the rumble motor. Hence, every output report must look up our
new RUMBLE flag and make sure that it does not unintentionally toggle the
rumble motor.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index a594383..6fa73c7 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -46,14 +46,16 @@ struct wiimote_data {
 	struct wiimote_state state;
 };
 
-#define WIIPROTO_FLAG_LED1 0x01
-#define WIIPROTO_FLAG_LED2 0x02
-#define WIIPROTO_FLAG_LED3 0x04
-#define WIIPROTO_FLAG_LED4 0x08
+#define WIIPROTO_FLAG_LED1		0x01
+#define WIIPROTO_FLAG_LED2		0x02
+#define WIIPROTO_FLAG_LED3		0x04
+#define WIIPROTO_FLAG_LED4		0x08
+#define WIIPROTO_FLAG_RUMBLE		0x10
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
 enum wiiproto_reqs {
+	WIIPROTO_REQ_RUMBLE = 0x10,
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
@@ -168,6 +170,39 @@ static void wiimote_queue(struct wiimote_data *wdata, const __u8 *buffer,
 	spin_unlock_irqrestore(&wdata->qlock, flags);
 }
 
+/*
+ * This sets the rumble bit on the given output report if rumble is
+ * currently enabled.
+ * \cmd1 must point to the second byte in the output report => &cmd[1]
+ * This must be called on nearly every output report before passing it
+ * into the output queue!
+ */
+static inline void wiiproto_keep_rumble(struct wiimote_data *wdata, __u8 *cmd1)
+{
+	if (wdata->state.flags & WIIPROTO_FLAG_RUMBLE)
+		*cmd1 |= 0x01;
+}
+
+static void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble)
+{
+	__u8 cmd[2];
+
+	rumble = !!rumble;
+	if (rumble == !!(wdata->state.flags & WIIPROTO_FLAG_RUMBLE))
+		return;
+
+	if (rumble)
+		wdata->state.flags |= WIIPROTO_FLAG_RUMBLE;
+	else
+		wdata->state.flags &= ~WIIPROTO_FLAG_RUMBLE;
+
+	cmd[0] = WIIPROTO_REQ_RUMBLE;
+	cmd[1] = 0;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 {
 	__u8 cmd[2];
@@ -189,6 +224,7 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 	if (leds & WIIPROTO_FLAG_LED4)
 		cmd[1] |= 0x80;
 
+	wiiproto_keep_rumble(wdata, &cmd[1]);
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-- 
1.7.6

