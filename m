From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 01/12] HID: uhid: simplify report-cb shutdown
Date: Tue, 29 Jul 2014 17:14:15 +0200
Message-ID: <1406646866-999-2-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:42270 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbaG2POs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:48 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so9073397wgh.6
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:45 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

The report-query is blocking, so when user-space destroys a device we have
to wake up any blocking kernel context that is currently in the report-cb.
We used some broken correlation between @report_done and @running so far.
Replace it by a much more obvious use.

We now wake up the report-cb if either @report_done or @running is set.
wake_up() and wait_event() serve as implicit barriers (as they always do)
so no need to use smp_rmb/wmb directly.

Note that @report_done is never reset by anyone but the report-cb, thus
it cannot flip twice while we wait for it. And whenever we set @running,
we afterwards synchronously remove the HID device. Therefore, we wait for
all report-cbs to finish before we return. This way, @running can never
flip to true while we wait for it.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 0cb92e3..16af4d3 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -172,13 +172,9 @@ static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rnum,
 	spin_unlock_irqrestore(&uhid->qlock, flags);
 
 	ret = wait_event_interruptible_timeout(uhid->report_wait,
-				atomic_read(&uhid->report_done), 5 * HZ);
+			atomic_read(&uhid->report_done) || !uhid->running,
+			5 * HZ);
 
-	/*
-	 * Make sure "uhid->running" is cleared on shutdown before
-	 * "uhid->report_done" is set.
-	 */
-	smp_rmb();
 	if (!ret || !uhid->running) {
 		ret = -EIO;
 	} else if (ret < 0) {
@@ -493,10 +489,7 @@ static int uhid_dev_destroy(struct uhid_device *uhid)
 	if (!uhid->running)
 		return -EINVAL;
 
-	/* clear "running" before setting "report_done" */
 	uhid->running = false;
-	smp_wmb();
-	atomic_set(&uhid->report_done, 1);
 	wake_up_interruptible(&uhid->report_wait);
 
 	hid_destroy_device(uhid->hid);
-- 
2.0.3

