From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG] suspicious RCU usage
Date: Fri, 3 May 2013 13:28:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305031324590.11002@pobox.suse.cz>
References: <51835EFD.2070403@gmail.com> <CAN+gG=F5O_EAr8P2Zgy7w39JcBJwWVzUSUaj0s6U0C6SRP6tYA@mail.gmail.com> <alpine.LNX.2.00.1305031022260.11002@pobox.suse.cz> <518392FE.4000302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762019Ab3ECL23 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 May 2013 07:28:29 -0400
In-Reply-To: <518392FE.4000302@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: majianpeng <majianpeng@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Fri, 3 May 2013, majianpeng wrote:

> >> Jiri, we had a similar bug in the RH bugzilla:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=958935
> >>
> >> Are these two reports potentially fixed by your patch "HID: protect
> >> hid_debug_list" (https://patchwork.kernel.org/patch/2453931/)
> >> If so, maybe we should send it to stable as well...
> > I actually believe this bug is *introduced* by that patch :) All the 
> > reports were with the kernel containing it, right?
> >
> > Does the patch below fix it, please?
[ ... snip ... ]
> Add your patch.Found the following message:
> [  150.908051] ======================================================
> [  150.908053] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
> [  150.908056] 3.9.0+ #102 Not tainted

Right, oh well, I missed that scenario.

The patch below should cover that, please let me know. Thanks a lot for 
your testing.

 drivers/hid/hid-core.c  |    2 +-
 drivers/hid/hid-debug.c |   15 +++++++++------
 include/linux/hid.h     |    2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6961bbe..a506421 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2341,7 +2341,7 @@ struct hid_device *hid_allocate_device(void)
 
 	init_waitqueue_head(&hdev->debug_wait);
 	INIT_LIST_HEAD(&hdev->debug_list);
-	mutex_init(&hdev->debug_list_lock);
+	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_lock, 1);
 	sema_init(&hdev->driver_input_lock, 1);
 
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7e56cb3..8453214 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -579,15 +579,16 @@ void hid_debug_event(struct hid_device *hdev, char *buf)
 {
 	int i;
 	struct hid_debug_list *list;
+	unsigned long flags;
 
-	mutex_lock(&hdev->debug_list_lock);
+	spin_lock_irqsave(&hdev->debug_list_lock, flags);
 	list_for_each_entry(list, &hdev->debug_list, node) {
 		for (i = 0; i < strlen(buf); i++)
 			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
 				buf[i];
 		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
         }
-	mutex_unlock(&hdev->debug_list_lock);
+	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
 
 	wake_up_interruptible(&hdev->debug_wait);
 }
@@ -977,6 +978,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 {
 	int err = 0;
 	struct hid_debug_list *list;
+	unsigned long flags;
 
 	if (!(list = kzalloc(sizeof(struct hid_debug_list), GFP_KERNEL))) {
 		err = -ENOMEM;
@@ -992,9 +994,9 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
-	mutex_lock(&list->hdev->debug_list_lock);
+	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
 	list_add_tail(&list->node, &list->hdev->debug_list);
-	mutex_unlock(&list->hdev->debug_list_lock);
+	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 
 out:
 	return err;
@@ -1088,10 +1090,11 @@ static unsigned int hid_debug_events_poll(struct file *file, poll_table *wait)
 static int hid_debug_events_release(struct inode *inode, struct file *file)
 {
 	struct hid_debug_list *list = file->private_data;
+	unsigned long flags;
 
-	mutex_lock(&list->hdev->debug_list_lock);
+	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
 	list_del(&list->node);
-	mutex_unlock(&list->hdev->debug_list_lock);
+	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 	kfree(list->hid_debug_buf);
 	kfree(list);
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index af1b86d..0c48991 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -515,7 +515,7 @@ struct hid_device {							/* device report descriptor */
 	struct dentry *debug_rdesc;
 	struct dentry *debug_events;
 	struct list_head debug_list;
-	struct mutex debug_list_lock;
+	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
 };
 

-- 
Jiri Kosina
SUSE Labs
