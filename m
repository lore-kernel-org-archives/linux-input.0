From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/9] Input: serio-raw - use kref instead of rolling out its own refcounting
Date: Wed,  5 Oct 2011 22:08:08 -0700
Message-ID: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37992 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab1JFFIW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:22 -0400
Received: by ywb5 with SMTP id 5so2265031ywb.19
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index b7ba459..ef3a69c 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -9,6 +9,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/kref.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
@@ -33,7 +34,7 @@ struct serio_raw {
 	unsigned int tail, head;
 
 	char name[16];
-	unsigned int refcnt;
+	struct kref kref;
 	struct serio *serio;
 	struct miscdevice dev;
 	wait_queue_head_t wait;
@@ -104,7 +105,7 @@ static int serio_raw_open(struct inode *inode, struct file *file)
 	list->serio_raw = serio_raw;
 	file->private_data = list;
 
-	serio_raw->refcnt++;
+	kref_get(&serio_raw->kref);
 	list_add_tail(&list->node, &serio_raw->list);
 
 out:
@@ -112,17 +113,14 @@ out:
 	return retval;
 }
 
-static int serio_raw_cleanup(struct serio_raw *serio_raw)
+static void serio_raw_cleanup(struct kref *kref)
 {
-	if (--serio_raw->refcnt == 0) {
-		misc_deregister(&serio_raw->dev);
-		list_del_init(&serio_raw->node);
-		kfree(serio_raw);
+	struct serio_raw *serio_raw =
+			container_of(kref, struct serio_raw, kref);
 
-		return 1;
-	}
-
-	return 0;
+	misc_deregister(&serio_raw->dev);
+	list_del_init(&serio_raw->node);
+	kfree(serio_raw);
 }
 
 static int serio_raw_release(struct inode *inode, struct file *file)
@@ -132,7 +130,7 @@ static int serio_raw_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&serio_raw_mutex);
 
-	serio_raw_cleanup(serio_raw);
+	kref_put(&serio_raw->kref, serio_raw_cleanup);
 
 	mutex_unlock(&serio_raw_mutex);
 	return 0;
@@ -283,7 +281,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	mutex_lock(&serio_raw_mutex);
 
 	snprintf(serio_raw->name, sizeof(serio_raw->name), "serio_raw%d", serio_raw_no++);
-	serio_raw->refcnt = 1;
+	kref_init(&serio_raw->kref);
 	serio_raw->serio = serio;
 	INIT_LIST_HEAD(&serio_raw->list);
 	init_waitqueue_head(&serio_raw->wait);
@@ -357,8 +355,8 @@ static void serio_raw_disconnect(struct serio *serio)
 	serio_set_drvdata(serio, NULL);
 
 	serio_raw->serio = NULL;
-	if (!serio_raw_cleanup(serio_raw))
-		wake_up_interruptible(&serio_raw->wait);
+	wake_up_interruptible(&serio_raw->wait);
+	kref_put(&serio_raw->kref, serio_raw_cleanup);
 
 	mutex_unlock(&serio_raw_mutex);
 }
-- 
1.7.6.4

