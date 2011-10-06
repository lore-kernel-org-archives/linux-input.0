From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/9] Input: serio_raw - fix coding style issues
Date: Wed,  5 Oct 2011 22:08:13 -0700
Message-ID: <1317877696-7719-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41354 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab1JFFI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 01:08:27 -0400
Received: by mail-pz0-f42.google.com with SMTP id 1so5956148pzk.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 22:08:27 -0700 (PDT)
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thomas Tuttle <ttuttle@chromium.org>

This makes checkpatch.pl happy with the driver

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 396a17f..64fcefb 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -156,7 +156,8 @@ static bool serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
 	return !empty;
 }
 
-static ssize_t serio_raw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t serio_raw_read(struct file *file, char __user *buffer,
+			      size_t count, loff_t *ppos)
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
@@ -187,7 +188,8 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer, size_t cou
 	return retval;
 }
 
-static ssize_t serio_raw_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
@@ -250,7 +252,7 @@ static const struct file_operations serio_raw_fops = {
 
 
 /*********************************************************************
- *                   Interface with serio port   	             *
+ *                   Interface with serio port                       *
  *********************************************************************/
 
 static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
@@ -278,14 +280,16 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	struct serio_raw *serio_raw;
 	int err;
 
-	if (!(serio_raw = kzalloc(sizeof(struct serio_raw), GFP_KERNEL))) {
+	serio_raw = kzalloc(sizeof(struct serio_raw), GFP_KERNEL);
+	if (!serio_raw) {
 		dev_dbg(&serio->dev, "can't allocate memory for a device\n");
 		return -ENOMEM;
 	}
 
 	mutex_lock(&serio_raw_mutex);
 
-	snprintf(serio_raw->name, sizeof(serio_raw->name), "serio_raw%d", serio_raw_no++);
+	snprintf(serio_raw->name, sizeof(serio_raw->name),
+		 "serio_raw%d", serio_raw_no++);
 	kref_init(&serio_raw->kref);
 	serio_raw->serio = serio;
 	INIT_LIST_HEAD(&serio_raw->client_list);
-- 
1.7.6.4

