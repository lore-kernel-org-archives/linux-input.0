From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 11/12] HID: wiimote: Cache wiimote led state
Date: Wed, 15 Jun 2011 01:45:56 +0200
Message-ID: <1308095157-4699-12-git-send-email-dh.herrmann@googlemail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40020 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1FNXq2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:28 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so41850fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:27 -0700 (PDT)
In-Reply-To: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Save the current state of the leds in the wiimote data structure. This
allows us to discard new led requests that wouldn't change anything.
Protect the whole state structure by a spinlock. Every wiiproto_*
function expects this spinlock to be held when called.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index fbdd7ef..eb86c5d 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -27,6 +27,11 @@ struct wiimote_buf {
 	size_t size;
 };
 
+struct wiimote_state {
+	spinlock_t lock;
+	__u8 flags;
+};
+
 struct wiimote_data {
 	atomic_t ready;
 	struct hid_device *hdev;
@@ -37,12 +42,16 @@ struct wiimote_data {
 	__u8 tail;
 	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
 	struct work_struct worker;
+
+	struct wiimote_state state;
 };
 
 #define WIIPROTO_FLAG_LED1 0x01
 #define WIIPROTO_FLAG_LED2 0x02
 #define WIIPROTO_FLAG_LED3 0x04
 #define WIIPROTO_FLAG_LED4 0x08
+#define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
+					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
 enum wiiproto_reqs {
 	WIIPROTO_REQ_LED = 0x11,
@@ -164,6 +173,11 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 {
 	__u8 cmd[2];
 
+	leds &= WIIPROTO_FLAGS_LEDS;
+	if ((wdata->state.flags & WIIPROTO_FLAGS_LEDS) == leds)
+		return;
+	wdata->state.flags = (wdata->state.flags & ~WIIPROTO_FLAGS_LEDS) | leds;
+
 	cmd[0] = WIIPROTO_REQ_LED;
 	cmd[1] = 0;
 
@@ -234,6 +248,7 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	struct wiimote_data *wdata = hid_get_drvdata(hdev);
 	struct wiiproto_handler *h;
 	int i;
+	unsigned long flags;
 
 	if (!atomic_read(&wdata->ready))
 		return -EBUSY;
@@ -241,12 +256,16 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	if (size < 1)
 		return -EINVAL;
 
+	spin_lock_irqsave(&wdata->state.lock, flags);
+
 	for (i = 0; handlers[i].id; ++i) {
 		h = &handlers[i];
 		if (h->id == raw_data[0] && h->size < size)
 			h->func(wdata, &raw_data[1]);
 	}
 
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
 	return 0;
 }
 
@@ -284,6 +303,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
+	spin_lock_init(&wdata->state.lock);
+
 	return wdata;
 }
 
@@ -319,7 +340,12 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 
 	atomic_set(&wdata->ready, 1);
 	hid_info(hdev, "New device registered\n");
+
+	/* by default set led1 after device initialization */
+	spin_lock(&wdata->state.lock);
 	wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
+	spin_unlock(&wdata->state.lock);
+
 	return 0;
 
 err_stop:
-- 
1.7.5.2

