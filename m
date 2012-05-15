From: Mika Kuoppala <mika.kuoppala@nokia.com>
Subject: [PATCH] input: allocate event circular buffer separately
Date: Tue, 15 May 2012 15:46:24 +0300
Message-ID: <1337085984-5811-1-git-send-email-mika.kuoppala@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:30607 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092Ab2EOMrS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 May 2012 08:47:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Mika Kuoppala <mika.kuoppala@nokia.com>

If struct evdev_client is added to the already power of two
buffer allocation and the buffer is large, for multitouch devices,
the allocation will spill over into the the next page.
Alloc buffer separately instead of binding it to evdev_client struct
to avoid multipage kmalloc.

Reviewed-by: Andi Shyti <andi.shyti@nokia.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@nokia.com>
---
 drivers/input/evdev.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 6288d7d..c8d4ca3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -51,7 +51,7 @@ struct evdev_client {
 	struct evdev *evdev;
 	struct list_head node;
 	unsigned int bufsize;
-	struct input_event buffer[];
+	struct input_event *buffer;
 };
 
 static struct evdev *evdev_table[EVDEV_MINORS];
@@ -268,6 +268,7 @@ static int evdev_release(struct inode *inode, struct file *file)
 	evdev_detach_client(evdev, client);
 	if (client->use_wake_lock)
 		wake_lock_destroy(&client->wake_lock);
+	kfree(client->buffer);
 	kfree(client);
 
 	evdev_close_device(evdev);
@@ -309,14 +310,18 @@ static int evdev_open(struct inode *inode, struct file *file)
 
 	bufsize = evdev_compute_buffer_size(evdev->handle.dev);
 
-	client = kzalloc(sizeof(struct evdev_client) +
-				bufsize * sizeof(struct input_event),
-			 GFP_KERNEL);
+	client = kzalloc(sizeof(struct evdev_client), GFP_KERNEL);
 	if (!client) {
 		error = -ENOMEM;
 		goto err_put_evdev;
 	}
 
+	client->buffer = kzalloc(bufsize * sizeof(struct input_event),
+				GFP_KERNEL);
+	if (!client->buffer) {
+		error = -ENOMEM;
+		goto err_free_client;
+	}
 	client->bufsize = bufsize;
 	spin_lock_init(&client->buffer_lock);
 	snprintf(client->name, sizeof(client->name), "%s-%d",
@@ -326,13 +331,15 @@ static int evdev_open(struct inode *inode, struct file *file)
 
 	error = evdev_open_device(evdev);
 	if (error)
-		goto err_free_client;
+		goto err_free_buffer;
 
 	file->private_data = client;
 	nonseekable_open(inode, file);
 
 	return 0;
 
+ err_free_buffer:
+	kfree(client->buffer);
  err_free_client:
 	evdev_detach_client(evdev, client);
 	kfree(client);
-- 
1.7.4.1

