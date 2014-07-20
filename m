From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2] Input: evdev - drop redundant list-locking
Date: Sun, 20 Jul 2014 22:03:34 +0200
Message-ID: <1405886614-11660-1-git-send-email-dh.herrmann@gmail.com>
References: <1405882092-7005-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:50303 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaGTUDq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 16:03:46 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so5535413wev.40
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 13:03:43 -0700 (PDT)
In-Reply-To: <1405882092-7005-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, David Herrmann <dh.herrmann@gmail.com>

evdev->client_list is rcu-protected. We need the client_lock only to
protect against concurrent writes. However, all paths that access
client_list already lock evdev->mutex. Therefore, drop client_lock and use
evdev->mutex as list-protection.

This also drops several helper functions that are called only once. Most
of them are fairly trivial so there's little reason to extract them. This
is needed to get better control over evdev->mutex locking.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
v2:
  - use evdev->mutex to protect against concurrent writes
  - inline most of the helper functions

 drivers/input/evdev.c | 126 ++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 86 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 7a25a7a..406acde 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -34,7 +34,6 @@ struct evdev {
 	wait_queue_head_t wait;
 	struct evdev_client __rcu *grab;
 	struct list_head client_list;
-	spinlock_t client_lock; /* protects client_list */
 	struct mutex mutex;
 	struct device dev;
 	struct cdev cdev;
@@ -430,69 +429,6 @@ static int evdev_ungrab(struct evdev *evdev, struct evdev_client *client)
 	return 0;
 }
 
-static void evdev_attach_client(struct evdev *evdev,
-				struct evdev_client *client)
-{
-	spin_lock(&evdev->client_lock);
-	list_add_tail_rcu(&client->node, &evdev->client_list);
-	spin_unlock(&evdev->client_lock);
-}
-
-static void evdev_detach_client(struct evdev *evdev,
-				struct evdev_client *client)
-{
-	spin_lock(&evdev->client_lock);
-	list_del_rcu(&client->node);
-	spin_unlock(&evdev->client_lock);
-	synchronize_rcu();
-}
-
-static int evdev_open_device(struct evdev *evdev)
-{
-	int retval;
-
-	retval = mutex_lock_interruptible(&evdev->mutex);
-	if (retval)
-		return retval;
-
-	if (!evdev->exist)
-		retval = -ENODEV;
-	else if (!evdev->open++) {
-		retval = input_open_device(&evdev->handle);
-		if (retval)
-			evdev->open--;
-	}
-
-	mutex_unlock(&evdev->mutex);
-	return retval;
-}
-
-static void evdev_close_device(struct evdev *evdev)
-{
-	mutex_lock(&evdev->mutex);
-
-	if (evdev->exist && !--evdev->open)
-		input_close_device(&evdev->handle);
-
-	mutex_unlock(&evdev->mutex);
-}
-
-/*
- * Wake up users waiting for IO so they can disconnect from
- * dead device.
- */
-static void evdev_hangup(struct evdev *evdev)
-{
-	struct evdev_client *client;
-
-	spin_lock(&evdev->client_lock);
-	list_for_each_entry(client, &evdev->client_list, node)
-		kill_fasync(&client->fasync, SIGIO, POLL_HUP);
-	spin_unlock(&evdev->client_lock);
-
-	wake_up_interruptible(&evdev->wait);
-}
-
 static int evdev_release(struct inode *inode, struct file *file)
 {
 	struct evdev_client *client = file->private_data;
@@ -501,9 +437,12 @@ static int evdev_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&evdev->mutex);
 	evdev_ungrab(evdev, client);
+	list_del_rcu(&client->node);
+	if (evdev->exist && !--evdev->open)
+		input_close_device(&evdev->handle);
 	mutex_unlock(&evdev->mutex);
 
-	evdev_detach_client(evdev, client);
+	synchronize_rcu();
 
 	for (i = 0; i < EV_CNT; ++i)
 		kfree(client->evmasks[i]);
@@ -513,8 +452,6 @@ static int evdev_release(struct inode *inode, struct file *file)
 	else
 		kfree(client);
 
-	evdev_close_device(evdev);
-
 	return 0;
 }
 
@@ -545,19 +482,38 @@ static int evdev_open(struct inode *inode, struct file *file)
 	client->bufsize = bufsize;
 	spin_lock_init(&client->buffer_lock);
 	client->evdev = evdev;
-	evdev_attach_client(evdev, client);
 
-	error = evdev_open_device(evdev);
+	error = mutex_lock_interruptible(&evdev->mutex);
 	if (error)
-		goto err_free_client;
+		goto err_free;
+
+	list_add_tail_rcu(&client->node, &evdev->client_list);
+
+	if (!evdev->exist) {
+		error = -ENODEV;
+		goto err_detach;
+	}
+
+	if (!evdev->open++) {
+		error = input_open_device(&evdev->handle);
+		if (error) {
+			evdev->open--;
+			goto err_detach;
+		}
+	}
+
+	mutex_unlock(&evdev->mutex);
 
 	file->private_data = client;
 	nonseekable_open(inode, file);
 
 	return 0;
 
- err_free_client:
-	evdev_detach_client(evdev, client);
+err_detach:
+	list_del_rcu(&client->node);
+	mutex_unlock(&evdev->mutex);
+	synchronize_rcu();
+err_free:
 	kfree(client);
 	return error;
 }
@@ -1384,24 +1340,23 @@ static const struct file_operations evdev_fops = {
 	.llseek		= no_llseek,
 };
 
-/*
- * Mark device non-existent. This disables writes, ioctls and
- * prevents new users from opening the device. Already posted
- * blocking reads will stay, however new ones will fail.
- */
-static void evdev_mark_dead(struct evdev *evdev)
+static void evdev_cleanup(struct evdev *evdev)
 {
+	struct input_handle *handle = &evdev->handle;
+	struct evdev_client *client;
+
+	/*
+	 * Mark device non-existent to disable writes, ioctls and new users.
+	 * Then wake up running users that wait for I/O so they can disconnect
+	 * from the dead device.
+	 */
 	mutex_lock(&evdev->mutex);
 	evdev->exist = false;
+	list_for_each_entry(client, &evdev->client_list, node)
+		kill_fasync(&client->fasync, SIGIO, POLL_HUP);
 	mutex_unlock(&evdev->mutex);
-}
 
-static void evdev_cleanup(struct evdev *evdev)
-{
-	struct input_handle *handle = &evdev->handle;
-
-	evdev_mark_dead(evdev);
-	evdev_hangup(evdev);
+	wake_up_interruptible(&evdev->wait);
 
 	cdev_del(&evdev->cdev);
 
@@ -1438,7 +1393,6 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 	}
 
 	INIT_LIST_HEAD(&evdev->client_list);
-	spin_lock_init(&evdev->client_lock);
 	mutex_init(&evdev->mutex);
 	init_waitqueue_head(&evdev->wait);
 	evdev->exist = true;
-- 
2.0.2

