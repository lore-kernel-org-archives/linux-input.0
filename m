From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 09/12] HID: wiimote: Add wiimote input button parser
Date: Tue,  5 Jul 2011 13:45:16 +0200
Message-ID: <1309866319-12899-9-git-send-email-dh.herrmann@googlemail.com>
References: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59515 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab1GELpm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 07:45:42 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so6110854fxd.11
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 04:45:41 -0700 (PDT)
In-Reply-To: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Parse input report 0x30 from the wiimote as button input. We need to
send events for all buttons on every input report because the wiimote
does not send events for single buttons but always for all buttons
to us. The input layer, however, filters redundant events.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   66 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index c86ae92..efdf62b 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -39,6 +39,39 @@ struct wiimote_data {
 	struct work_struct worker;
 };
 
+enum wiiproto_reqs {
+	WIIPROTO_REQ_DRM_K = 0x30,
+};
+
+enum wiiproto_keys {
+	WIIPROTO_KEY_LEFT,
+	WIIPROTO_KEY_RIGHT,
+	WIIPROTO_KEY_UP,
+	WIIPROTO_KEY_DOWN,
+	WIIPROTO_KEY_PLUS,
+	WIIPROTO_KEY_MINUS,
+	WIIPROTO_KEY_ONE,
+	WIIPROTO_KEY_TWO,
+	WIIPROTO_KEY_A,
+	WIIPROTO_KEY_B,
+	WIIPROTO_KEY_HOME,
+	WIIPROTO_KEY_COUNT
+};
+
+static __u16 wiiproto_keymap[] = {
+	KEY_LEFT,	/* WIIPROTO_KEY_LEFT */
+	KEY_RIGHT,	/* WIIPROTO_KEY_RIGHT */
+	KEY_UP,		/* WIIPROTO_KEY_UP */
+	KEY_DOWN,	/* WIIPROTO_KEY_DOWN */
+	KEY_NEXT,	/* WIIPROTO_KEY_PLUS */
+	KEY_PREVIOUS,	/* WIIPROTO_KEY_MINUS */
+	BTN_1,		/* WIIPROTO_KEY_ONE */
+	BTN_2,		/* WIIPROTO_KEY_TWO */
+	BTN_A,		/* WIIPROTO_KEY_A */
+	BTN_B,		/* WIIPROTO_KEY_B */
+	BTN_MODE,	/* WIIPROTO_KEY_HOME */
+};
+
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 								size_t count)
 {
@@ -130,6 +163,33 @@ static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 	return 0;
 }
 
+static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
+{
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_LEFT],
+							!!(payload[0] & 0x01));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_RIGHT],
+							!!(payload[0] & 0x02));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_DOWN],
+							!!(payload[0] & 0x04));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_UP],
+							!!(payload[0] & 0x08));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_PLUS],
+							!!(payload[0] & 0x10));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_TWO],
+							!!(payload[1] & 0x01));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_ONE],
+							!!(payload[1] & 0x02));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_B],
+							!!(payload[1] & 0x04));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_A],
+							!!(payload[1] & 0x08));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_MINUS],
+							!!(payload[1] & 0x10));
+	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_HOME],
+							!!(payload[1] & 0x80));
+	input_sync(wdata->input);
+}
+
 struct wiiproto_handler {
 	__u8 id;
 	size_t size;
@@ -137,6 +197,7 @@ struct wiiproto_handler {
 };
 
 static struct wiiproto_handler handlers[] = {
+	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = 0 }
 };
 
@@ -167,6 +228,7 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 {
 	struct wiimote_data *wdata;
+	int i;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (!wdata)
@@ -190,6 +252,10 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->input->id.version = wdata->hdev->version;
 	wdata->input->name = WIIMOTE_NAME;
 
+	set_bit(EV_KEY, wdata->input->evbit);
+	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
+		set_bit(wiiproto_keymap[i], wdata->input->keybit);
+
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
-- 
1.7.6

