From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH] input: polled device power saving
Date: Wed, 12 Sep 2007 13:41:41 +0200
Message-ID: <20070912134141.38c32f6c@oldman>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

For slow running polling, it saves power to align wakeups on tick boundary.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/drivers/input/input-polldev.c	2007-06-22 03:36:04.000000000 +0200
+++ b/drivers/input/input-polldev.c	2007-09-12 13:18:59.000000000 +0200
@@ -70,6 +70,7 @@ static int input_open_polled_device(stru
 {
 	struct input_polled_dev *dev = input->private;
 	int error;
+	unsigned long ticks;
 
 	error = input_polldev_start_workqueue();
 	if (error)
@@ -78,8 +79,10 @@ static int input_open_polled_device(stru
 	if (dev->flush)
 		dev->flush(dev);
 
-	queue_delayed_work(polldev_wq, &dev->work,
-			   msecs_to_jiffies(dev->poll_interval));
+	ticks = msecs_to_jiffies(dev->poll_interval);
+	if (ticks >= HZ)
+		ticks = round_jiffies(ticks);
+	queue_delayed_work(polldev_wq, &dev->work, ticks);
 
 	return 0;
 }
