From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 08/12] HID: wiimote: Add wiimote event handler
Date: Tue,  5 Jul 2011 13:45:15 +0200
Message-ID: <1309866319-12899-8-git-send-email-dh.herrmann@googlemail.com>
References: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:37593 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab1GELpl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 07:45:41 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so6110868fxd.11
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 04:45:40 -0700 (PDT)
In-Reply-To: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Create array of all event handlers and call each handler when we
receive the related event.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index bfc5049..c86ae92 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -130,10 +130,22 @@ static int wiimote_input_event(struct input_dev *dev, unsigned int type,
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
1.7.6

