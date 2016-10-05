From: Gary King <gary.king@oculus.com>
Subject: [PATCH] hidraw: fix list->buffer race condition
Date: Tue, 4 Oct 2016 17:44:26 -0700
Message-ID: <1475628266-4767-1-git-send-email-gary.king@oculus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48993 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753466AbcJEAo4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Oct 2016 20:44:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, Gary King <gary.king@oculus.com>

hidraw input events are stored for each file descriptor in a lockless
circular queue. no memory barriers were used when the queue was
updated, which caused intermittent kernel panics due to heap corruption
when used on multi-core ARM systems.

add memory barriers to ensure that value updates are observable before
the head and tail referents are updated.

Change-Id: Ifb50f5ebe13c55c83aa105c5cd5926ca16fd93e0
Signed-off-by: Gary King <gary.king@oculus.com>
Reviewed-on: http://prn-ocugerrit01.thefacebook.com:8080/88
Reviewed-by: Ahmed Amin <ahmed.amin@oculus.com>
---
 drivers/hid/hidraw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index f0e2757..dc3465f 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -53,6 +53,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 	mutex_lock(&list->read_mutex);
 
 	while (ret == 0) {
+		smp_rmb();
 		if (list->head == list->tail) {
 			add_wait_queue(&list->hidraw->wait, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -98,7 +99,9 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 
 		kfree(list->buffer[list->tail].value);
 		list->buffer[list->tail].value = NULL;
+		smp_wmb();
 		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
+		smp_wmb();
 	}
 out:
 	mutex_unlock(&list->read_mutex);
@@ -487,7 +490,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	spin_lock_irqsave(&dev->list_lock, flags);
 	list_for_each_entry(list, &dev->list, node) {
 		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
-
+		smp_rmb();
 		if (new_head == list->tail)
 			continue;
 
@@ -496,7 +499,9 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 			break;
 		}
 		list->buffer[list->head].len = len;
+		smp_wmb();
 		list->head = new_head;
+		smp_wmb();
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
 	spin_unlock_irqrestore(&dev->list_lock, flags);
-- 
1.9.1

