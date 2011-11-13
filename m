From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 09/16] HID: wiimote: Add extension handler stubs
Date: Sun, 13 Nov 2011 14:27:12 +0100
Message-ID: <1321190839-3517-10-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1KMN2I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:28:08 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:28:07 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

All supported extensions report data as 6 byte block. All DRMs with extension
data provide at least 6 extension bytes. Hence a generic handler for all
extension bytes is sufficient and can be called on all DRMs.

The handler distinguishes the input and passes it to the right handler. Motion+
passes data interleaved so we can have Motion+ and a regular extension enabled
simultaneously.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c |    6 ++++++
 drivers/hid/hid-wiimote-ext.c  |   29 +++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h      |    2 ++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 2ca8bfd..d8ed1ec 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -857,6 +857,7 @@ static void handler_drm_KA(struct wiimote_data *wdata, const __u8 *payload)
 static void handler_drm_KE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
+	wiiext_handle(wdata, &payload[2]);
 }
 
 static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
@@ -873,6 +874,7 @@ static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 static void handler_drm_KEE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
+	wiiext_handle(wdata, &payload[2]);
 }
 
 static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
@@ -883,12 +885,14 @@ static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input2(wdata, &payload[7], false);
 	ir_to_input3(wdata, &payload[9], true);
 	input_sync(wdata->ir);
+	wiiext_handle(wdata, &payload[12]);
 }
 
 static void handler_drm_KAE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 	handler_accel(wdata, payload);
+	wiiext_handle(wdata, &payload[5]);
 }
 
 static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
@@ -900,10 +904,12 @@ static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input2(wdata, &payload[10], false);
 	ir_to_input3(wdata, &payload[12], true);
 	input_sync(wdata->ir);
+	wiiext_handle(wdata, &payload[15]);
 }
 
 static void handler_drm_E(struct wiimote_data *wdata, const __u8 *payload)
 {
+	wiiext_handle(wdata, payload);
 }
 
 static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index cbfb655..e108f0c 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -204,6 +204,35 @@ bool wiiext_active(struct wiimote_data *wdata)
 	return wdata->ext->motionp || wdata->ext->ext_type;
 }
 
+static void handler_motionp(struct wiimote_ext *ext, const __u8 *payload)
+{
+}
+
+static void handler_nunchuck(struct wiimote_ext *ext, const __u8 *payload)
+{
+}
+
+static void handler_classic(struct wiimote_ext *ext, const __u8 *payload)
+{
+}
+
+/* call this with state.lock spinlock held */
+void wiiext_handle(struct wiimote_data *wdata, const __u8 *payload)
+{
+	struct wiimote_ext *ext = wdata->ext;
+
+	if (!ext)
+		return;
+
+	if (ext->motionp && (payload[5] & 0x02)) {
+		handler_motionp(ext, payload);
+	} else if (ext->ext_type == WIIEXT_NUNCHUCK) {
+		handler_nunchuck(ext, payload);
+	} else if (ext->ext_type == WIIEXT_CLASSIC) {
+		handler_classic(ext, payload);
+	}
+}
+
 static ssize_t wiiext_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index abbfab8..1f3e53a 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -125,6 +125,7 @@ extern int wiiext_init(struct wiimote_data *wdata);
 extern void wiiext_deinit(struct wiimote_data *wdata);
 extern void wiiext_event(struct wiimote_data *wdata, bool plugged);
 extern bool wiiext_active(struct wiimote_data *wdata);
+extern void wiiext_handle(struct wiimote_data *wdata, const __u8 *payload);
 
 #else
 
@@ -132,6 +133,7 @@ static inline int wiiext_init(void *u) { return 0; }
 static inline void wiiext_deinit(void *u) { }
 static inline void wiiext_event(void *u, bool p) { }
 static inline bool wiiext_active(void *u) { return false; }
+static inline void wiiext_handle(void *u, const __u8 *p) { }
 
 #endif
 
-- 
1.7.7.3

