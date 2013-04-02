From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 3/3] HID: wiimote: parse reduced status reports
Date: Tue,  2 Apr 2013 19:58:36 +0200
Message-ID: <1364925516-5724-3-git-send-email-dh.herrmann@gmail.com>
References: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:33061 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674Ab3DBR7M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Apr 2013 13:59:12 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so354255bkc.9
        for <linux-input@vger.kernel.org>; Tue, 02 Apr 2013 10:59:10 -0700 (PDT)
In-Reply-To: <1364925516-5724-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

It turns out the Wii accepts any status reports from clients reduced to
"BB BB" key data only, as long as the report actually includes key data at
the first two bytes.

The official devices don't send these reduced reports, but of course, 3rd
party devices make great use of this feature.

Hence, add parsers for these reduced reports for every matching report.
Also change the logic how we find handlers. There is no reason to call
multiple handlers on a single report, but instead find the best handler
and call it only once.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index d2c69b9..3118d058 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -789,12 +789,20 @@ static void __ir_to_input(struct wiimote_data *wdata, const __u8 *ir,
 	input_report_abs(wdata->ir, yid, y);
 }
 
-static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
+/* reduced status report with "BB BB" key data only */
+static void handler_status_K(struct wiimote_data *wdata,
+			     const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 
 	/* on status reports the drm is reset so we need to resend the drm */
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+}
+
+/* extended status report with "BB BB LF 00 00 VV" data */
+static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_status_K(wdata, payload);
 
 	wiiext_event(wdata, payload[2] & 0x02);
 
@@ -804,6 +812,12 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 	}
 }
 
+/* reduced generic report with "BB BB" key data only */
+static void handler_generic_K(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+}
+
 static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
 {
 	__u16 offset = payload[3] << 8 | payload[4];
@@ -947,16 +961,26 @@ struct wiiproto_handler {
 
 static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_STATUS, .size = 6, .func = handler_status },
+	{ .id = WIIPROTO_REQ_STATUS, .size = 2, .func = handler_status_K },
 	{ .id = WIIPROTO_REQ_DATA, .size = 21, .func = handler_data },
+	{ .id = WIIPROTO_REQ_DATA, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
+	{ .id = WIIPROTO_REQ_RETURN, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
+	{ .id = WIIPROTO_REQ_DRM_KA, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_KE, .size = 10, .func = handler_drm_KE },
+	{ .id = WIIPROTO_REQ_DRM_KE, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_KAI, .size = 17, .func = handler_drm_KAI },
+	{ .id = WIIPROTO_REQ_DRM_KAI, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_KEE, .size = 21, .func = handler_drm_KEE },
+	{ .id = WIIPROTO_REQ_DRM_KEE, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_KAE, .size = 21, .func = handler_drm_KAE },
+	{ .id = WIIPROTO_REQ_DRM_KAE, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_KIE, .size = 21, .func = handler_drm_KIE },
+	{ .id = WIIPROTO_REQ_DRM_KIE, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_KAIE, .size = 21, .func = handler_drm_KAIE },
+	{ .id = WIIPROTO_REQ_DRM_KAIE, .size = 2, .func = handler_generic_K },
 	{ .id = WIIPROTO_REQ_DRM_E, .size = 21, .func = handler_drm_E },
 	{ .id = WIIPROTO_REQ_DRM_SKAI1, .size = 21, .func = handler_drm_SKAI1 },
 	{ .id = WIIPROTO_REQ_DRM_SKAI2, .size = 21, .func = handler_drm_SKAI2 },
@@ -970,7 +994,6 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	struct wiiproto_handler *h;
 	int i;
 	unsigned long flags;
-	bool handled = false;
 
 	if (size < 1)
 		return -EINVAL;
@@ -981,11 +1004,11 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 		h = &handlers[i];
 		if (h->id == raw_data[0] && h->size < size) {
 			h->func(wdata, &raw_data[1]);
-			handled = true;
+			break;
 		}
 	}
 
-	if (!handled)
+	if (!handlers[i].id)
 		hid_warn(hdev, "Unhandled report %hhu size %d\n", raw_data[0],
 									size);
 
-- 
1.8.2

