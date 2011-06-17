From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 11/12 v2] HID: wiimote: Cache wiimote led state
Date: Fri, 17 Jun 2011 16:49:21 +0200
Message-ID: <1308322162-13953-11-git-send-email-dh.herrmann@googlemail.com>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42426 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759258Ab1FQOu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 10:50:29 -0400
Received: by fxm17 with SMTP id 17so1796243fxm.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 07:50:27 -0700 (PDT)
In-Reply-To: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, dh.herrmann@googlemail.com

Save the current state of the leds in the wiimote data structure. This
allows us to discard new led requests that wouldn't change anything.
Protect the whole state structure by a spinlock. Every wiiproto_*
function expects this spinlock to be held when called.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Fix spinlocks, use irqsave version

 drivers/hid/hid-wiimote.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index be8d871..7779f41 100644
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
@@ -174,6 +183,11 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 {
 	__u8 cmd[2];
 
+	leds &= WIIPROTO_FLAGS_LEDS;
+	if ((wdata->state.flags & WIIPROTO_FLAGS_LEDS) == leds)
+		return;
+	wdata->state.flags = (wdata->state.flags & ~WIIPROTO_FLAGS_LEDS) | leds;
+
 	cmd[0] = WIIPROTO_REQ_LED;
 	cmd[1] = 0;
 
@@ -245,6 +259,7 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	struct wiimote_data *wdata = hid_get_drvdata(hdev);
 	struct wiiproto_handler *h;
 	int i;
+	unsigned long flags;
 
 	if (!atomic_read(&wdata->ready))
 		return -EBUSY;
@@ -253,12 +268,16 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
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
 
@@ -296,6 +315,8 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
+	spin_lock_init(&wdata->state.lock);
+
 	return wdata;
 }
 
@@ -337,7 +358,12 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	smp_wmb();
 	atomic_set(&wdata->ready, 1);
 	hid_info(hdev, "New device registered\n");
+
+	/* by default set led1 after device initialization */
+	spin_lock_irq(&wdata->state.lock);
 	wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
+	spin_unlock_irq(&wdata->state.lock);
+
 	return 0;
 
 err_stop:
-- 
1.7.5.2

