From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 04/12] HID: uhid: avoid magic-numbers when setting strings
Date: Tue, 29 Jul 2014 17:14:18 +0200
Message-ID: <1406646866-999-5-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:57620 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaG2POw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:52 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so9148821wgg.12
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:51 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Avoid hard-coding the target buffer sizes and use sizeof() instead. This
also makes us future-proof to buffer-extensions later on.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index bf13746..5dee8bd 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -363,7 +363,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 			    const struct uhid_event *ev)
 {
 	struct hid_device *hid;
-	size_t rd_size;
+	size_t rd_size, len;
 	void *rd_data;
 	int ret;
 
@@ -387,12 +387,12 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	strncpy(hid->name, ev->u.create2.name, 127);
-	hid->name[127] = 0;
-	strncpy(hid->phys, ev->u.create2.phys, 63);
-	hid->phys[63] = 0;
-	strncpy(hid->uniq, ev->u.create2.uniq, 63);
-	hid->uniq[63] = 0;
+	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
+	strncpy(hid->name, ev->u.create2.name, len);
+	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
+	strncpy(hid->phys, ev->u.create2.phys, len);
+	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
+	strncpy(hid->uniq, ev->u.create2.uniq, len);
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;
-- 
2.0.3

