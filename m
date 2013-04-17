From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: protect hid_debug_list
Date: Wed, 17 Apr 2013 07:09:40 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1304170708140.31201@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58129 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966321Ab3DQOJl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Apr 2013 10:09:41 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 81501A51FF
	for <linux-input@vger.kernel.org>; Wed, 17 Apr 2013 16:09:40 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Accesses to hid_device->hid_debug_list are not serialized properly, which 
could result in SMP concurrency issues when HID debugfs events are 
accessesed by multiple userspace processess.

Serialize all the list operations by a mutex.

Spotted by Al Viro.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c  | 1 +
 drivers/hid/hid-debug.c | 6 ++++++
 include/linux/hid.h     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1129f49..e3b7123 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2347,6 +2347,7 @@ struct hid_device *hid_allocate_device(void)
 
 	init_waitqueue_head(&hdev->debug_wait);
 	INIT_LIST_HEAD(&hdev->debug_list);
+	mutex_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_lock, 1);
 	sema_init(&hdev->driver_input_lock, 1);
 
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 933fff0..3337261 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -580,12 +580,14 @@ void hid_debug_event(struct hid_device *hdev, char *buf)
 	int i;
 	struct hid_debug_list *list;
 
+	mutex_lock(&hdev->debug_list_lock);
 	list_for_each_entry(list, &hdev->debug_list, node) {
 		for (i = 0; i < strlen(buf); i++)
 			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
 				buf[i];
 		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
         }
+	mutex_unlock(&hdev->debug_list_lock);
 
 	wake_up_interruptible(&hdev->debug_wait);
 }
@@ -960,7 +962,9 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
+	mutex_lock(&list->hdev->debug_list_lock);
 	list_add_tail(&list->node, &list->hdev->debug_list);
+	mutex_unlock(&list->hdev->debug_list_lock);
 
 out:
 	return err;
@@ -1055,7 +1059,9 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 {
 	struct hid_debug_list *list = file->private_data;
 
+	mutex_lock(&list->hdev->debug_list_lock);
 	list_del(&list->node);
+	mutex_unlock(&list->hdev->debug_list_lock);
 	kfree(list->hid_debug_buf);
 	kfree(list);
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b7b5ff2..af1b86d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -515,6 +515,7 @@ struct hid_device {							/* device report descriptor */
 	struct dentry *debug_rdesc;
 	struct dentry *debug_events;
 	struct list_head debug_list;
+	struct mutex debug_list_lock;
 	wait_queue_head_t debug_wait;
 };
 
-- 
Jiri Kosina
SUSE Labs
