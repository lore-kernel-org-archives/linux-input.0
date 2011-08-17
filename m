From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH V2 4/5] HID: wiimote: Add drm request
Date: Wed, 17 Aug 2011 11:43:23 +0200
Message-ID: <1313574204-12664-5-git-send-email-dh.herrmann@googlemail.com>
References: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55802 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1HQJoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:44:00 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so525058fxh.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 02:43:59 -0700 (PDT)
In-Reply-To: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: oliver@neukum.org, jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The wiimote reports data in several data reporting modes (DRM). The DRM
request makes the wiimote send data in the requested drm.

The DRM mode can be set explicitely or can be chosen by the driver. To let
the driver choose the DRM mode, pass WIIPROTO_REQ_NULL placeholder to it. This
is no valid request and is replaced with an appropriate DRM.

Currently, the driver always sets the basic DRM_K mode, but this will be
extended when further peripherals like accelerometer and IR are supported.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 29edd55..84c9eb9 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -57,7 +57,9 @@ struct wiimote_data {
 #define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
 
 enum wiiproto_reqs {
+	WIIPROTO_REQ_NULL = 0x0,
 	WIIPROTO_REQ_LED = 0x11,
+	WIIPROTO_REQ_DRM = 0x12,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
 
@@ -192,6 +194,30 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
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
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
 {
 	struct wiimote_data *wdata;
-- 
1.7.6

