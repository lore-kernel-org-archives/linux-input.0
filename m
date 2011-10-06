From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 9/9] Input: serio_raw - fix memory leak when closing char device
Date: Wed,  5 Oct 2011 22:08:16 -0700
Message-ID: <1317877696-7719-9-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36527 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab1JFFId (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:33 -0400
Received: by yxl31 with SMTP id 31so2268529yxl.19
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:33 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

Apparently we never freed memory allocated when users open our char
devices nor removed old users from the list of connected clients.

Also unregister misc device immediately upon disconnecting the port
instead of waiting until last user drops off (refcounting in misc
device code will make sure needed pieces stay around while they
are needed) and make sure we are not holing holding serio_raw_mutex
when registering/unregistering misc device. This should fix potential
deadlock between serio_raw and misc device code uncovered by lockdep
and reported by Thomas Tuttle.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   54 +++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 830e2fe..4d4cd14 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -51,7 +51,6 @@ struct serio_raw_client {
 
 static DEFINE_MUTEX(serio_raw_mutex);
 static LIST_HEAD(serio_raw_list);
-static unsigned int serio_raw_no;
 
 /*********************************************************************
  *             Interface with userspace (file operations)            *
@@ -117,14 +116,11 @@ out:
 	return retval;
 }
 
-static void serio_raw_cleanup(struct kref *kref)
+static void serio_raw_free(struct kref *kref)
 {
 	struct serio_raw *serio_raw =
 			container_of(kref, struct serio_raw, kref);
 
-	misc_deregister(&serio_raw->dev);
-	list_del_init(&serio_raw->node);
-
 	put_device(&serio_raw->serio->dev);
 	kfree(serio_raw);
 }
@@ -134,11 +130,14 @@ static int serio_raw_release(struct inode *inode, struct file *file)
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
 
-	mutex_lock(&serio_raw_mutex);
+	serio_pause_rx(serio_raw->serio);
+	list_del(&client->node);
+	serio_continue_rx(serio_raw->serio);
 
-	kref_put(&serio_raw->kref, serio_raw_cleanup);
+	kfree(client);
+
+	kref_put(&serio_raw->kref, serio_raw_free);
 
-	mutex_unlock(&serio_raw_mutex);
 	return 0;
 }
 
@@ -281,6 +280,7 @@ static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
 
 static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 {
+	static atomic_t serio_raw_no = ATOMIC_INIT(0);
 	struct serio_raw *serio_raw;
 	int err;
 
@@ -290,10 +290,8 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&serio_raw_mutex);
-
 	snprintf(serio_raw->name, sizeof(serio_raw->name),
-		 "serio_raw%d", serio_raw_no++);
+		 "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no) - 1);
 	kref_init(&serio_raw->kref);
 	INIT_LIST_HEAD(&serio_raw->client_list);
 	init_waitqueue_head(&serio_raw->wait);
@@ -305,9 +303,14 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 
 	err = serio_open(serio, drv);
 	if (err)
-		goto out_free;
+		goto err_free;
+
+	err = mutex_lock_killable(&serio_raw_mutex);
+	if (err)
+		goto err_close;
 
 	list_add_tail(&serio_raw->node, &serio_raw_list);
+	mutex_unlock(&serio_raw_mutex);
 
 	serio_raw->dev.minor = PSMOUSE_MINOR;
 	serio_raw->dev.name = serio_raw->name;
@@ -324,22 +327,20 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 		dev_err(&serio->dev,
 			"failed to register raw access device for %s\n",
 			serio->phys);
-		goto out_close;
+		goto err_unlink;
 	}
 
 	dev_info(&serio->dev, "raw access enabled on %s (%s, minor %d)\n",
 		 serio->phys, serio_raw->name, serio_raw->dev.minor);
-	goto out;
+	return 0;
 
-out_close:
-	serio_close(serio);
+err_unlink:
 	list_del_init(&serio_raw->node);
-out_free:
+err_close:
+	serio_close(serio);
+err_free:
 	serio_set_drvdata(serio, NULL);
-	put_device(&serio->dev);
-	kfree(serio_raw);
-out:
-	mutex_unlock(&serio_raw_mutex);
+	kref_put(&serio_raw->kref, serio_raw_free);
 	return err;
 }
 
@@ -382,14 +383,17 @@ static void serio_raw_disconnect(struct serio *serio)
 {
 	struct serio_raw *serio_raw = serio_get_drvdata(serio);
 
-	mutex_lock(&serio_raw_mutex);
+	misc_deregister(&serio_raw->dev);
 
-	serio_close(serio);
+	mutex_lock(&serio_raw_mutex);
 	serio_raw->dead = true;
+	list_del_init(&serio_raw->node);
+	mutex_unlock(&serio_raw_mutex);
+
 	serio_raw_hangup(serio_raw);
-	kref_put(&serio_raw->kref, serio_raw_cleanup);
 
-	mutex_unlock(&serio_raw_mutex);
+	serio_close(serio);
+	kref_put(&serio_raw->kref, serio_raw_free);
 
 	serio_set_drvdata(serio, NULL);
 }
-- 
1.7.6.4

