From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/9] Input: serio_raw - explicitly mark disconnected ports as dead
Date: Wed,  5 Oct 2011 22:08:14 -0700
Message-ID: <1317877696-7719-7-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40708 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab1JFFIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:30 -0400
Received: by mail-pz0-f42.google.com with SMTP id 1so5956160pzk.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:29 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

Instead of relying on setting serio_raw->serio to NULL upon disconnecting
ports mark them explicitly as "dead". Also take and carry reference to
underlying serio port to make sure it does not go away until we are done
with it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 64fcefb..30ff963 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -40,6 +40,7 @@ struct serio_raw {
 	wait_queue_head_t wait;
 	struct list_head client_list;
 	struct list_head node;
+	bool dead;
 };
 
 struct serio_raw_client {
@@ -91,7 +92,7 @@ static int serio_raw_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	if (!serio_raw->serio) {
+	if (serio_raw->dead) {
 		retval = -ENODEV;
 		goto out;
 	}
@@ -123,6 +124,8 @@ static void serio_raw_cleanup(struct kref *kref)
 
 	misc_deregister(&serio_raw->dev);
 	list_del_init(&serio_raw->node);
+
+	put_device(&serio_raw->serio->dev);
 	kfree(serio_raw);
 }
 
@@ -164,19 +167,18 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer,
 	char uninitialized_var(c);
 	ssize_t retval = 0;
 
-	if (!serio_raw->serio)
+	if (serio_raw->dead)
 		return -ENODEV;
 
 	if (serio_raw->head == serio_raw->tail && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(serio_raw->wait,
-					  serio_raw->head != serio_raw->tail ||
-						!serio_raw->serio);
+			serio_raw->head != serio_raw->tail || serio_raw->dead);
 	if (retval)
 		return retval;
 
-	if (!serio_raw->serio)
+	if (serio_raw->dead)
 		return -ENODEV;
 
 	while (retval < count && serio_raw_fetch_byte(serio_raw, &c)) {
@@ -201,7 +203,7 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
 	if (retval)
 		return retval;
 
-	if (!serio_raw->serio) {
+	if (serio_raw->dead) {
 		retval = -ENODEV;
 		goto out;
 	}
@@ -291,10 +293,12 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	snprintf(serio_raw->name, sizeof(serio_raw->name),
 		 "serio_raw%d", serio_raw_no++);
 	kref_init(&serio_raw->kref);
-	serio_raw->serio = serio;
 	INIT_LIST_HEAD(&serio_raw->client_list);
 	init_waitqueue_head(&serio_raw->wait);
 
+	serio_raw->serio = serio;
+	get_device(&serio->dev);
+
 	serio_set_drvdata(serio, serio_raw);
 
 	err = serio_open(serio, drv);
@@ -330,6 +334,7 @@ out_close:
 	list_del_init(&serio_raw->node);
 out_free:
 	serio_set_drvdata(serio, NULL);
+	put_device(&serio->dev);
 	kfree(serio_raw);
 out:
 	mutex_unlock(&serio_raw_mutex);
@@ -365,7 +370,7 @@ static void serio_raw_disconnect(struct serio *serio)
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 
-	serio_raw->serio = NULL;
+	serio_raw->dead = true;
 	wake_up_interruptible(&serio_raw->wait);
 	kref_put(&serio_raw->kref, serio_raw_cleanup);
 
-- 
1.7.6.4

