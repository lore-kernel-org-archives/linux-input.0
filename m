From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH] input: polldev can cause crash in case of polling disabled
Date: Tue, 16 Feb 2010 16:44:41 +0200
Message-ID: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32473 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0BPOow (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 09:44:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

If polling is set to disabled value and polled input device
is opened and closed several times, address to workqueue will probably
change at some point. Since nothing is queued (due to polled disabled
state), content of the work struct contains pointer to the old and non-existent
workqueue. When the device is closed again, cancel_delayed_work_sync
goes crazy due to pointer to nonexisting workqueue.

In case on disabled polling, init work struct to initial value to
clean up the old values.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input-polldev.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index aa6713b..f9c8e34 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -88,9 +88,17 @@ static int input_open_polled_device(struct input_dev *input)
 	if (dev->open)
 		dev->open(dev);
 
-	/* Only start polling if polling is enabled */
+	/*
+	 * Only start polling if polling is enabled.
+	 * If polling is not running, clean up work struct since
+	 * pointer to just allocated WQ may have been changed since
+	 * previous use. If polling is not used, canceling of the
+	 * work goes crazy.
+	 */
 	if (dev->poll_interval > 0)
 		queue_delayed_work(polldev_wq, &dev->work, 0);
+	else
+		INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
 
 	return 0;
 }
-- 
1.6.0.4

