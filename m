From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 1/1] Polled input device: add device open and close methods
Date: Tue, 13 Oct 2009 09:24:48 +0300
Message-ID: <1255415088-31845-2-git-send-email-samu.p.onkalo@nokia.com>
References: <1255415088-31845-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30674 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758917AbZJMG0c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 02:26:32 -0400
In-Reply-To: <1255415088-31845-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Optional open and close methods for preparing and closing
the device.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/input-polldev.c |    6 ++++++
 include/linux/input-polldev.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 0d3ce7a..0ad788b 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -80,6 +80,9 @@ static int input_open_polled_device(struct input_dev *input)
 	if (error)
 		return error;
 
+	if (dev->open)
+		dev->open(dev);
+
 	if (dev->flush)
 		dev->flush(dev);
 
@@ -95,6 +98,9 @@ static void input_close_polled_device(struct input_dev *input)
 
 	cancel_delayed_work_sync(&dev->work);
 	input_polldev_stop_workqueue();
+
+	if (dev->close)
+		dev->close(dev);
 }
 
 /**
diff --git a/include/linux/input-polldev.h b/include/linux/input-polldev.h
index 597a007..ba266c1 100644
--- a/include/linux/input-polldev.h
+++ b/include/linux/input-polldev.h
@@ -30,6 +30,8 @@
 struct input_polled_dev {
 	void *private;
 
+	void (*open)(struct input_polled_dev *dev);
+	void (*close)(struct input_polled_dev *dev);
 	void (*flush)(struct input_polled_dev *dev);
 	void (*poll)(struct input_polled_dev *dev);
 	unsigned int poll_interval; /* msec */
-- 
1.5.6.3

