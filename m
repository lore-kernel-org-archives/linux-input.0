From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCHv2] input: polldev can cause crash in case of polling disabled
Date: Thu, 18 Feb 2010 10:23:40 +0200
Message-ID: <1266481420-9405-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53705 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0BRIYJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 03:24:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, oleg@redhat.com, Samu Onkalo <samu.p.onkalo@nokia.com>

When polled input device is opened and closed and there are no other
users of polled device, the workqueue is created and destroyed in
every open / close operation. It is probable that at some point
dynamic allocation of internal parts of the workqueue cause changes to the
workqueue.

When a work is queued to the workqueue the work struct contains pointers
to the workqueue data. If the workqueue has been changed and the work
has never been queued to the new workqueue, work-struct contains pointers
to the non-existing workqueue. This will cause crash at the work
cancellation during device close since cancellation of a work assumes
that the workqueue exists.

To prevent that, work struct is cleaned up at device close. This keeps
work struct clean for the next use.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input-polldev.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index aa6713b..291d939 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -100,6 +100,12 @@ static void input_close_polled_device(struct input_dev *input)
 	struct input_polled_dev *dev = input_get_drvdata(input);
 
 	cancel_delayed_work_sync(&dev->work);
+	/*
+	 * Clean up work struct to remove references to the workqueue.
+	 * It may be destroyed by the next call. This causes problems
+	 * at next device open-close in case of poll_interval == 0.
+	 */
+	INIT_DELAYED_WORK(&dev->work, dev->work.work.func);
 	input_polldev_stop_workqueue();
 
 	if (dev->close)
-- 
1.6.0.4

