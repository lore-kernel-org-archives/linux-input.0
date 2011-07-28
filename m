From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 03/16] HID: wiimote: Add drm request
Date: Thu, 28 Jul 2011 18:08:23 +0200
Message-ID: <1311869316-17128-4-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab1G1QJH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:07 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400102fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:06 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The wiimote reports data in several data reporting modes (DRM). The DRM
request makes the wiimote send data in the requested drm.

The DRM mode can be set explicitely or can be calculated by the driver. To let
the driver choose the DRM mode, pass WIIPROTO_REQ_NULL placeholder to it. This
is no valid request and is replaced with an appropriate DRM.

Currently, the driver always sets the basic DRM_K mode, but this will be
extended when further peripherals like accelerometer and IR are supported.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 4070060..dfb8707 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -55,8 +55,10 @@ struct wiimote_data {
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
 enum wiiproto_reqs {
+	WIIPROTO_REQ_NULL = 0x0,
 	WIIPROTO_REQ_RUMBLE = 0x10,
 	WIIPROTO_REQ_LED = 0x11,
+	WIIPROTO_REQ_DRM = 0x12,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
 
@@ -228,6 +230,31 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
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
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
-- 
1.7.6

