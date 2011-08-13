From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 6/7] HID: wiimote: Add drm request
Date: Sat, 13 Aug 2011 15:29:14 +0200
Message-ID: <1313242155-3620-7-git-send-email-dh.herrmann@googlemail.com>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55308 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1HMN3q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Aug 2011 09:29:46 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2801621fxh.19
        for <linux-input@vger.kernel.org>; Sat, 13 Aug 2011 06:29:45 -0700 (PDT)
In-Reply-To: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

The wiimote reports data in several data reporting modes (DRM). The DRM
request makes the wiimote send data in the requested drm.

The DRM mode can be set explicitely or can be chosen by the driver. To let
the driver choose the DRM mode, pass WIIPROTO_REQ_NULL placeholder to it. This
is no valid request and is replaced with an appropriate DRM.

Currently, the driver always sets the basic DRM_K mode, but this will be
extended when further peripherals like accelerometer and IR are supported.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 4a68565..3efc126 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -59,8 +59,10 @@ struct wiimote_data {
 #define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
 
 enum wiiproto_reqs {
+	WIIPROTO_REQ_NULL = 0x0,
 	WIIPROTO_REQ_RUMBLE = 0x10,
 	WIIPROTO_REQ_LED = 0x11,
+	WIIPROTO_REQ_DRM = 0x12,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
 
@@ -232,6 +234,31 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+/*
+ * Check what peripherals of the wiimote are currently
+ * active and select a proper DRM that supports all of
+ * the requested data inputs.
+ */
+static __u8 select_drm(struct wiimote_data *wdata)
+{
+	return WIIPROTO_REQ_DRM_K;
+}
+
+static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
+{
+	__u8 cmd[3];
+
+	if (drm == WIIPROTO_REQ_NULL)
+		drm = select_drm(wdata);
+
+	cmd[0] = WIIPROTO_REQ_DRM;
+	cmd[1] = 0;
+	cmd[2] = drm;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
 {
 	struct wiimote_data *wdata;
-- 
1.7.6

