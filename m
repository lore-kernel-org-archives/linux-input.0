From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 2/3] HID: debug: provide reader-writer locking for the ring buffer
Date: Wed,  3 Oct 2018 19:19:35 +0200
Message-ID: <20181003171936.11271-3-vdronov@redhat.com>
References: <20181003171936.11271-1-vdronov@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>
List-Id: linux-input@vger.kernel.org

hdev->debug_list->hid_debug_buf is not protected from concurrent updates
from the writer, hid_debug_event() and reads by the reader,
hid_debug_events_read(). Fix this by adding per-list-element spinlock.
Also introduce a temporary buffer tempbuf so copy_to_user() is not called
from under a spinlock.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/hid/hid-debug.c   | 47 +++++++++++++++++++++++----------------
 include/linux/hid-debug.h |  1 +
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 20580871b0ec..e827784baf1a 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -663,15 +663,17 @@ void hid_debug_event(struct hid_device *hdev, char *buf)
 {
 	unsigned i;
 	struct hid_debug_list *list;
-	unsigned long flags;
+	unsigned long flags, flags2;
 
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
 	list_for_each_entry(list, &hdev->debug_list, node) {
+		spin_lock_irqsave(&list->list_lock, flags2);
 		for (i = 0; buf[i]; i++)
 			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
 				buf[i];
 		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
-        }
+		spin_unlock_irqrestore(&list->list_lock, flags2);
+	}
 	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
 
 	wake_up_interruptible(&hdev->debug_wait);
@@ -1095,6 +1097,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
 	file->private_data = list;
+	spin_lock_init(&list->list_lock);
 	mutex_init(&list->read_mutex);
 
 	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
@@ -1109,6 +1112,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	struct hid_debug_list *list = file->private_data;
+	char *tmpbuf;
+	unsigned long flags;
 	int ret = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -1151,10 +1156,18 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 	if (ret)
 		goto out;
 
-	/* pass the ringbuffer content to userspace */
+	tmpbuf = kmalloc(min_t(size_t, count, HID_DEBUG_BUFSIZE),
+			 GFP_KERNEL|__GFP_NOWARN);
+	if (!tmpbuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* lock and copy the ringbuffer content to tmpbuf */
+	spin_lock_irqsave(&list->list_lock, flags);
 copy_rest:
 	if (list->tail == list->head)
-		goto out;
+		goto out_unlock;
 
 	/* the data from the head to the tail in the buffer is linear */
 	if (list->tail > list->head) {
@@ -1162,11 +1174,7 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		if (len > count)
 			len = count;
 
-		if (copy_to_user(buffer + ret,
-		      &list->hid_debug_buf[list->head], len)) {
-			ret = -EFAULT;
-			goto out;
-		}
+		memcpy(tmpbuf + ret, &list->hid_debug_buf[list->head], len);
 		ret += len;
 		list->head += len;
 	} else {
@@ -1180,19 +1188,11 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		if (len > count) {
 			len = count;
 
-			if (copy_to_user(buffer,
-			      &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
-				goto out;
-			}
+			memcpy(tmpbuf, &list->hid_debug_buf[list->head], len);
 			ret += len;
 			list->head += len;
 		} else {
-			if (copy_to_user(buffer,
-			      &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
-				goto out;
-			}
+			memcpy(tmpbuf, &list->hid_debug_buf[list->head], len);
 			list->head = 0;
 			ret += len;
 			count -= len;
@@ -1202,6 +1202,15 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 				goto copy_rest;
 		}
 	}
+
+out_unlock:
+	spin_unlock_irqrestore(&list->list_lock, flags);
+
+	/* copy out tmpbuf content to userspace */
+	if (ret && copy_to_user(buffer, tmpbuf, ret))
+		ret = -EFAULT;
+	kfree(tmpbuf);
+
 out:
 	mutex_unlock(&list->read_mutex);
 	return ret;
diff --git a/include/linux/hid-debug.h b/include/linux/hid-debug.h
index 8663f216c563..f58665651cb5 100644
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -45,6 +45,7 @@ struct hid_debug_list {
 	struct fasync_struct *fasync;
 	struct hid_device *hdev;
 	struct list_head node;
+	spinlock_t list_lock;
 	struct mutex read_mutex;
 };
 
-- 
2.19.0
