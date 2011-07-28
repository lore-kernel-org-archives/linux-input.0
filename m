From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 13/16] HID: wiimote: Add IR initializer
Date: Thu, 28 Jul 2011 18:08:33 +0200
Message-ID: <1311869316-17128-14-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab1G1QJW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:22 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400102fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:21 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The wiimote IR cam needs a fairly complex initialization sequence. This adds a
helper function that performs IR initialization synchronously.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |  134 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index c6b1d24..bca46ba 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -77,8 +77,10 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_RUMBLE = 0x10,
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
+	WIIPROTO_REQ_IR1 = 0x13,
 	WIIPROTO_REQ_WMEM = 0x16,
 	WIIPROTO_REQ_RMEM = 0x17,
+	WIIPROTO_REQ_IR2 = 0x1a,
 	WIIPROTO_REQ_STATUS = 0x20,
 	WIIPROTO_REQ_DATA = 0x21,
 	WIIPROTO_REQ_RETURN = 0x22,
@@ -363,6 +365,28 @@ static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
 }
 
+static void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_IR1;
+	cmd[1] = flags;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
+static void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_IR2;
+	cmd[1] = flags;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 #define wiiproto_req_wreg(wdata, os, buf, sz) \
 			wiiproto_req_wmem((wdata), false, (os), (buf), (sz))
 
@@ -443,6 +467,116 @@ static int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 	return ret;
 }
 
+static int wiimote_init_ir(struct wiimote_data *wdata, __u16 mode)
+{
+	int ret;
+	unsigned long flags;
+	__u8 format = 0;
+	static const __u8 data_enable[] = { 0x01 };
+	static const __u8 data_sens1[] = { 0x02, 0x00, 0x00, 0x71, 0x01,
+						0x00, 0xaa, 0x00, 0x64 };
+	static const __u8 data_sens2[] = { 0x63, 0x03 };
+	static const __u8 data_fin[] = { 0x08 };
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
+	if (mode == (wdata->state.flags & WIIPROTO_FLAGS_IR)) {
+		spin_unlock_irqrestore(&wdata->state.lock, flags);
+		goto unlock;
+	}
+
+	if (mode == 0) {
+		wdata->state.flags &= ~WIIPROTO_FLAGS_IR;
+		wiiproto_req_ir1(wdata, 0);
+		wiiproto_req_ir2(wdata, 0);
+		wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+		spin_unlock_irqrestore(&wdata->state.lock, flags);
+		goto unlock;
+	}
+
+	/* send PIXEL CLOCK ENABLE cmd first */
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_IR1, 0);
+	wiiproto_req_ir1(wdata, 0x06);
+
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	if (ret)
+		goto unlock;
+	if (wdata->state.cmd_err) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	/* enable IR LOGIC then */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_IR2, 0);
+	wiiproto_req_ir2(wdata, 0x06);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	if (ret)
+		goto unlock;
+	if (wdata->state.cmd_err) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	/* enable IR cam but do not make it send data, yet */
+	ret = wiimote_cmd_write(wdata, 0xb00030, data_enable,
+							sizeof(data_enable));
+	if (ret)
+		goto unlock;
+
+	/* write first sensitivity block */
+	ret = wiimote_cmd_write(wdata, 0xb00000, data_sens1,
+							sizeof(data_sens1));
+	if (ret)
+		goto unlock;
+
+	/* write second sensitivity block */
+	ret = wiimote_cmd_write(wdata, 0xb0001a, data_sens2,
+							sizeof(data_sens2));
+	if (ret)
+		goto unlock;
+
+	/* put IR cam into desired state */
+	switch (mode) {
+		case WIIPROTO_FLAG_IR_FULL:
+			format = 5;
+			break;
+		case WIIPROTO_FLAG_IR_EXT:
+			format = 3;
+			break;
+		case WIIPROTO_FLAG_IR_BASIC:
+			format = 1;
+			break;
+	}
+	ret = wiimote_cmd_write(wdata, 0xb00033, &format, sizeof(format));
+	if (ret)
+		goto unlock;
+
+	/* make IR cam send data */
+	ret = wiimote_cmd_write(wdata, 0xb00030, data_fin, sizeof(data_fin));
+	if (ret)
+		goto unlock;
+
+	/* request new DRM mode compatible to IR mode */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags &= ~WIIPROTO_FLAGS_IR;
+	wdata->state.flags |= mode;
+	wiiproto_req_drm(wdata, 0);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+unlock:
+	wiimote_cmd_release(wdata);
+	return ret;
+}
+
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
-- 
1.7.6

