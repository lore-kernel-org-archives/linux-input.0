From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 08/12] HID: wiimote: Add wiimote event handler
Date: Wed, 15 Jun 2011 01:45:53 +0200
Message-ID: <1308095157-4699-9-git-send-email-dh.herrmann@googlemail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1FNXqY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:24 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so41764fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:23 -0700 (PDT)
In-Reply-To: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Create array of all event handlers and call each handler when we
receive the related event.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 687a469..0104e41 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -132,10 +132,22 @@ static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 	return 0;
 }
 
+struct wiiproto_handler {
+	__u8 id;
+	size_t size;
+	void (*func)(struct wiimote_data *wdata, const __u8 *payload);
+};
+
+static struct wiiproto_handler handlers[] = {
+	{ .id = 0 }
+};
+
 static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 							u8 *raw_data, int size)
 {
 	struct wiimote_data *wdata = hid_get_drvdata(hdev);
+	struct wiiproto_handler *h;
+	int i;
 
 	if (!atomic_read(&wdata->ready))
 		return -EBUSY;
@@ -143,6 +155,12 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	if (size < 1)
 		return -EINVAL;
 
+	for (i = 0; handlers[i].id; ++i) {
+		h = &handlers[i];
+		if (h->id == raw_data[0] && h->size < size)
+			h->func(wdata, &raw_data[1]);
+	}
+
 	return 0;
 }
 
-- 
1.7.5.2

