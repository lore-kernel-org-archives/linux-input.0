From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 05/12] HID: uhid: turn report_id into u32
Date: Tue, 29 Jul 2014 17:14:19 +0200
Message-ID: <1406646866-999-6-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:32993 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaG2POy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:54 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so9236716wes.28
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:53 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

All accesses to @report_id are protected by @qlock. No need to use an
atomic.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 5dee8bd..db4e119 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -44,10 +44,11 @@ struct uhid_device {
 	__u8 tail;
 	struct uhid_event *outq[UHID_BUFSIZE];
 
+	/* blocking GET_REPORT support; state changes protected by qlock */
 	struct mutex report_lock;
 	wait_queue_head_t report_wait;
 	atomic_t report_done;
-	atomic_t report_id;
+	u32 report_id;
 	struct uhid_event report_buf;
 };
 
@@ -163,7 +164,7 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 
 	spin_lock_irqsave(&uhid->qlock, flags);
 	ev->type = UHID_FEATURE;
-	ev->u.feature.id = atomic_inc_return(&uhid->report_id);
+	ev->u.feature.id = ++uhid->report_id;
 	ev->u.feature.rnum = rnum;
 	ev->u.feature.rtype = report_type;
 
@@ -497,7 +498,7 @@ static int uhid_dev_feature_answer(struct uhid_device *uhid,
 	spin_lock_irqsave(&uhid->qlock, flags);
 
 	/* id for old report; drop it silently */
-	if (atomic_read(&uhid->report_id) != ev->u.feature_answer.id)
+	if (uhid->report_id != ev->u.feature_answer.id)
 		goto unlock;
 	if (atomic_read(&uhid->report_done))
 		goto unlock;
-- 
2.0.3

