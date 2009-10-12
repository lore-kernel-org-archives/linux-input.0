From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 1/1] Polled input device: Add closing indication
Date: Mon, 12 Oct 2009 11:09:41 +0300
Message-ID: <1255334981-24118-2-git-send-email-samu.p.onkalo@nokia.com>
References: <1255334981-24118-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33154 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZJLILT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 04:11:19 -0400
In-Reply-To: <1255334981-24118-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

When closing polled input device, call optional closing method
to make it possible to turn off the HW.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input-polldev.c |    3 +++
 include/linux/input-polldev.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 0d3ce7a..50e1cb4 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -95,6 +95,9 @@ static void input_close_polled_device(struct input_dev *input)
 
 	cancel_delayed_work_sync(&dev->work);
 	input_polldev_stop_workqueue();
+
+	if (dev->close)
+		dev->close(dev);
 }
 
 /**
diff --git a/include/linux/input-polldev.h b/include/linux/input-polldev.h
index 597a007..23a6fc6 100644
--- a/include/linux/input-polldev.h
+++ b/include/linux/input-polldev.h
@@ -32,6 +32,7 @@ struct input_polled_dev {
 
 	void (*flush)(struct input_polled_dev *dev);
 	void (*poll)(struct input_polled_dev *dev);
+	void (*close)(struct input_polled_dev *dev);
 	unsigned int poll_interval; /* msec */
 
 	struct input_dev *input;
-- 
1.5.6.3

