From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/9] Input: serio_raw - rename serio_raw_list to serio_raw_client
Date: Wed,  5 Oct 2011 22:08:09 -0700
Message-ID: <1317877696-7719-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51810 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1JFFIV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:21 -0400
Received: by ggnv2 with SMTP id v2so1383425ggn.19
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:21 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

'serio_raw_list' and 'list' names do not accurately represent their objects
and are extremely confusing when reading the code. Let's use better suited
names.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   75 ++++++++++++++++++++------------------
 1 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index ef3a69c..6b57ee3 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -38,11 +38,11 @@ struct serio_raw {
 	struct serio *serio;
 	struct miscdevice dev;
 	wait_queue_head_t wait;
-	struct list_head list;
+	struct list_head client_list;
 	struct list_head node;
 };
 
-struct serio_raw_list {
+struct serio_raw_client {
 	struct fasync_struct *fasync;
 	struct serio_raw *serio_raw;
 	struct list_head node;
@@ -58,9 +58,9 @@ static unsigned int serio_raw_no;
 
 static int serio_raw_fasync(int fd, struct file *file, int on)
 {
-	struct serio_raw_list *list = file->private_data;
+	struct serio_raw_client *client = file->private_data;
 
-	return fasync_helper(fd, file, on, &list->fasync);
+	return fasync_helper(fd, file, on, &client->fasync);
 }
 
 static struct serio_raw *serio_raw_locate(int minor)
@@ -78,8 +78,8 @@ static struct serio_raw *serio_raw_locate(int minor)
 static int serio_raw_open(struct inode *inode, struct file *file)
 {
 	struct serio_raw *serio_raw;
-	struct serio_raw_list *list;
-	int retval = 0;
+	struct serio_raw_client *client;
+	int retval;
 
 	retval = mutex_lock_interruptible(&serio_raw_mutex);
 	if (retval)
@@ -96,17 +96,17 @@ static int serio_raw_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	list = kzalloc(sizeof(struct serio_raw_list), GFP_KERNEL);
-	if (!list) {
+	client = kzalloc(sizeof(struct serio_raw_client), GFP_KERNEL);
+	if (!client) {
 		retval = -ENOMEM;
 		goto out;
 	}
 
-	list->serio_raw = serio_raw;
-	file->private_data = list;
+	client->serio_raw = serio_raw;
+	file->private_data = client;
 
 	kref_get(&serio_raw->kref);
-	list_add_tail(&list->node, &serio_raw->list);
+	list_add_tail(&client->node, &serio_raw->client_list);
 
 out:
 	mutex_unlock(&serio_raw_mutex);
@@ -125,8 +125,8 @@ static void serio_raw_cleanup(struct kref *kref)
 
 static int serio_raw_release(struct inode *inode, struct file *file)
 {
-	struct serio_raw_list *list = file->private_data;
-	struct serio_raw *serio_raw = list->serio_raw;
+	struct serio_raw_client *client = file->private_data;
+	struct serio_raw *serio_raw = client->serio_raw;
 
 	mutex_lock(&serio_raw_mutex);
 
@@ -156,8 +156,8 @@ static int serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
 
 static ssize_t serio_raw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
-	struct serio_raw_list *list = file->private_data;
-	struct serio_raw *serio_raw = list->serio_raw;
+	struct serio_raw_client *client = file->private_data;
+	struct serio_raw *serio_raw = client->serio_raw;
 	char uninitialized_var(c);
 	ssize_t retval = 0;
 
@@ -167,8 +167,9 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer, size_t cou
 	if (serio_raw->head == serio_raw->tail && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
-	retval = wait_event_interruptible(list->serio_raw->wait,
-					  serio_raw->head != serio_raw->tail || !serio_raw->serio);
+	retval = wait_event_interruptible(serio_raw->wait,
+					  serio_raw->head != serio_raw->tail ||
+						!serio_raw->serio);
 	if (retval)
 		return retval;
 
@@ -186,7 +187,8 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer, size_t cou
 
 static ssize_t serio_raw_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
-	struct serio_raw_list *list = file->private_data;
+	struct serio_raw_client *client = file->private_data;
+	struct serio_raw *serio_raw = client->serio_raw;
 	ssize_t written = 0;
 	int retval;
 	unsigned char c;
@@ -195,7 +197,7 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer, siz
 	if (retval)
 		return retval;
 
-	if (!list->serio_raw->serio) {
+	if (!serio_raw->serio) {
 		retval = -ENODEV;
 		goto out;
 	}
@@ -208,7 +210,7 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer, siz
 			retval = -EFAULT;
 			goto out;
 		}
-		if (serio_write(list->serio_raw->serio, c)) {
+		if (serio_write(serio_raw->serio, c)) {
 			retval = -EIO;
 			goto out;
 		}
@@ -222,25 +224,26 @@ out:
 
 static unsigned int serio_raw_poll(struct file *file, poll_table *wait)
 {
-	struct serio_raw_list *list = file->private_data;
+	struct serio_raw_client *client = file->private_data;
+	struct serio_raw *serio_raw = client->serio_raw;
 
-	poll_wait(file, &list->serio_raw->wait, wait);
+	poll_wait(file, &serio_raw->wait, wait);
 
-	if (list->serio_raw->head != list->serio_raw->tail)
+	if (serio_raw->head != serio_raw->tail)
 		return POLLIN | POLLRDNORM;
 
 	return 0;
 }
 
 static const struct file_operations serio_raw_fops = {
-	.owner =	THIS_MODULE,
-	.open =		serio_raw_open,
-	.release =	serio_raw_release,
-	.read =		serio_raw_read,
-	.write =	serio_raw_write,
-	.poll =		serio_raw_poll,
-	.fasync =	serio_raw_fasync,
-	.llseek = noop_llseek,
+	.owner		= THIS_MODULE,
+	.open		= serio_raw_open,
+	.release	= serio_raw_release,
+	.read		= serio_raw_read,
+	.write		= serio_raw_write,
+	.poll		= serio_raw_poll,
+	.fasync		= serio_raw_fasync,
+	.llseek		= noop_llseek,
 };
 
 
@@ -252,16 +255,16 @@ static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
 					unsigned int dfl)
 {
 	struct serio_raw *serio_raw = serio_get_drvdata(serio);
-	struct serio_raw_list *list;
+	struct serio_raw_client *client;
 	unsigned int head = serio_raw->head;
 
-	/* we are holding serio->lock here so we are prootected */
+	/* we are holding serio->lock here so we are protected */
 	serio_raw->queue[head] = data;
 	head = (head + 1) % SERIO_RAW_QUEUE_LEN;
 	if (likely(head != serio_raw->tail)) {
 		serio_raw->head = head;
-		list_for_each_entry(list, &serio_raw->list, node)
-			kill_fasync(&list->fasync, SIGIO, POLL_IN);
+		list_for_each_entry(client, &serio_raw->client_list, node)
+			kill_fasync(&client->fasync, SIGIO, POLL_IN);
 		wake_up_interruptible(&serio_raw->wait);
 	}
 
@@ -283,7 +286,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	snprintf(serio_raw->name, sizeof(serio_raw->name), "serio_raw%d", serio_raw_no++);
 	kref_init(&serio_raw->kref);
 	serio_raw->serio = serio;
-	INIT_LIST_HEAD(&serio_raw->list);
+	INIT_LIST_HEAD(&serio_raw->client_list);
 	init_waitqueue_head(&serio_raw->wait);
 
 	serio_set_drvdata(serio, serio_raw);
-- 
1.7.6.4

