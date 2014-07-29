From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 03/12] HID: uhid: avoid dangling pointers in uhid context
Date: Tue, 29 Jul 2014 17:14:17 +0200
Message-ID: <1406646866-999-4-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:46143 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaG2POv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:51 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so9382927wes.0
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:50 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Avoid keeping uhid->rd_data and uhid->rd_size set in case
uhid_dev_create2() fails. This is non-critical as we never flip
uhid->running and thus never enter uhid_dev_destroy(). However, it's much
nicer for debugging if pointers are only set if they point to valid data.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index c05b544..bf13746 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -363,20 +363,24 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 			    const struct uhid_event *ev)
 {
 	struct hid_device *hid;
+	size_t rd_size;
+	void *rd_data;
 	int ret;
 
 	if (uhid->running)
 		return -EALREADY;
 
-	uhid->rd_size = ev->u.create2.rd_size;
-	if (uhid->rd_size <= 0 || uhid->rd_size > HID_MAX_DESCRIPTOR_SIZE)
+	rd_size = ev->u.create2.rd_size;
+	if (rd_size <= 0 || rd_size > HID_MAX_DESCRIPTOR_SIZE)
 		return -EINVAL;
 
-	uhid->rd_data = kmemdup(ev->u.create2.rd_data, uhid->rd_size,
-				GFP_KERNEL);
-	if (!uhid->rd_data)
+	rd_data = kmemdup(ev->u.create2.rd_data, rd_size, GFP_KERNEL);
+	if (!rd_data)
 		return -ENOMEM;
 
+	uhid->rd_size = rd_size;
+	uhid->rd_data = rd_data;
+
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
@@ -416,6 +420,8 @@ err_hid:
 	uhid->running = false;
 err_free:
 	kfree(uhid->rd_data);
+	uhid->rd_data = NULL;
+	uhid->rd_size = 0;
 	return ret;
 }
 
-- 
2.0.3

