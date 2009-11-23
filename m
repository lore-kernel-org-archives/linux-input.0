From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH] input-polldev: Poll interval setting can cause polling with zero interval
Date: Mon, 23 Nov 2009 13:21:44 +0200
Message-ID: <1258975304-4751-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51947 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbZKWLWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 06:22:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

If the poll interval is set to 0 via new sysfs entry and device
is opened after that, polling is started with interval 0. This causes
huge CPU load. Same happens if the rate was 0 when the device
was closed and then reopened.

Applies to input-tree next branch

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input-polldev.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 3187427..2d2c626 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -59,12 +59,13 @@ static void input_polldev_stop_workqueue(void)
 static void input_polldev_queue_work(struct input_polled_dev *dev)
 {
 	unsigned long delay;
+	if (dev->poll_interval > 0) {
+		delay = msecs_to_jiffies(dev->poll_interval);
+		if (delay >= HZ)
+			delay = round_jiffies_relative(delay);
 
-	delay = msecs_to_jiffies(dev->poll_interval);
-	if (delay >= HZ)
-		delay = round_jiffies_relative(delay);
-
-	queue_delayed_work(polldev_wq, &dev->work, delay);
+		queue_delayed_work(polldev_wq, &dev->work, delay);
+	}
 }
 
 static void input_polled_device_work(struct work_struct *work)
@@ -88,8 +89,7 @@ static int input_open_polled_device(struct input_dev *input)
 	if (dev->open)
 		dev->open(dev);
 
-	queue_delayed_work(polldev_wq, &dev->work,
-			   msecs_to_jiffies(dev->poll_interval));
+	input_polldev_queue_work(dev);
 
 	return 0;
 }
@@ -138,8 +138,7 @@ static ssize_t input_polldev_set_poll(struct device *dev,
 
 	if (input->users) {
 		cancel_delayed_work_sync(&polldev->work);
-		if (polldev->poll_interval > 0)
-			input_polldev_queue_work(polldev);
+		input_polldev_queue_work(polldev);
 	}
 
 	mutex_unlock(&input->mutex);
-- 
1.6.0.4

