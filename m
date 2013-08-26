From: Yonghua Zheng <younghua.zheng@gmail.com>
Subject: Re: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to
 protect list
Date: Mon, 26 Aug 2013 23:38:35 +0800
Message-ID: <20130826153833.GA2962@gmail.com>
References: <CAMyfujdB0JrnNeHk3b=AqR+1nz_W=bzDJpk1=iYZBnytDk-ztw@mail.gmail.com>
 <20130815145658.GA5813@gmail.com>
 <alpine.LNX.2.00.1308261359440.2077@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40826 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab3HZPir (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 11:38:47 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so3585679pac.3
        for <linux-input@vger.kernel.org>; Mon, 26 Aug 2013 08:38:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1308261359440.2077@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi Jiri,

Fix the conflict and update the patch:

>From 7c06e1f3a5959e73a5b827bda67e7c1eaed7da67 Mon Sep 17 00:00:00 2001
From: Yonghua Zheng <younghua.zheng@gmail.com>
Date: Wed, 14 Aug 2013 17:43:36 +0800
Subject: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to protect
 member list

It is unsafe to call list_for_each_entry in hidraw_report_event to
traverse each hidraw_list node without a lock protection, the list
could be modified if someone calls hidraw_release and list_del to
remove itself from the list, this can cause hidraw_report_event
to touch a deleted list struct and panic.

To prevent this, introduce a spinlock in struct hidraw to protect
list from concurrent access.

Signed-off-by: Yonghua Zheng <younghua.zheng@gmail.com>

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index dbfe300..8918dd1 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -253,6 +253,7 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	unsigned int minor = iminor(inode);
 	struct hidraw *dev;
 	struct hidraw_list *list;
+	unsigned long flags;
 	int err = 0;
 
 	if (!(list = kzalloc(sizeof(struct hidraw_list), GFP_KERNEL))) {
@@ -266,11 +267,6 @@ static int hidraw_open(struct inode *inode, struct file *file)
 		goto out_unlock;
 	}
 
-	list->hidraw = hidraw_table[minor];
-	mutex_init(&list->read_mutex);
-	list_add_tail(&list->node, &hidraw_table[minor]->list);
-	file->private_data = list;
-
 	dev = hidraw_table[minor];
 	if (!dev->open++) {
 		err = hid_hw_power(dev->hid, PM_HINT_FULLON);
@@ -283,9 +279,16 @@ static int hidraw_open(struct inode *inode, struct file *file)
 		if (err < 0) {
 			hid_hw_power(dev->hid, PM_HINT_NORMAL);
 			dev->open--;
+			goto out_unlock;
 		}
 	}
 
+	list->hidraw = hidraw_table[minor];
+	mutex_init(&list->read_mutex);
+	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
+	list_add_tail(&list->node, &hidraw_table[minor]->list);
+	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
+	file->private_data = list;
 out_unlock:
 	mutex_unlock(&minors_lock);
 out:
@@ -324,10 +327,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
 {
 	unsigned int minor = iminor(inode);
 	struct hidraw_list *list = file->private_data;
+	unsigned long flags;
 
 	mutex_lock(&minors_lock);
 
+	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
 	list_del(&list->node);
+	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	kfree(list);
 
 	drop_ref(hidraw_table[minor], 0);
@@ -456,7 +462,9 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	struct hidraw *dev = hid->hidraw;
 	struct hidraw_list *list;
 	int ret = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&dev->list_lock, flags);
 	list_for_each_entry(list, &dev->list, node) {
 		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
 
@@ -471,6 +479,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 		list->head = new_head;
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
+	spin_unlock_irqrestore(&dev->list_lock, flags);
 
 	wake_up_interruptible(&dev->wait);
 	return ret;
@@ -518,6 +527,7 @@ int hidraw_connect(struct hid_device *hid)
 	}
 
 	init_waitqueue_head(&dev->wait);
+	spin_lock_init(&dev->list_lock);
 	INIT_LIST_HEAD(&dev->list);
 
 	dev->hid = hid;
diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
index 2451662..ddf5261 100644
--- a/include/linux/hidraw.h
+++ b/include/linux/hidraw.h
@@ -23,6 +23,7 @@ struct hidraw {
 	wait_queue_head_t wait;
 	struct hid_device *hid;
 	struct device *dev;
+	spinlock_t list_lock;
 	struct list_head list;
 };
 
-- 
1.7.9.5

Thanks
Yonghua

On Mon, Aug 26, 2013 at 02:03:18PM +0200, Jiri Kosina wrote:
> On Thu, 15 Aug 2013, Yonghua Zheng wrote:
> 
> > As hidraw_report_event can be called from interrupt context, it is a mistake
> > to use mutex_lock for protecting the list member in my previous patch, so
> > update the patch which adds a spinlock in struct hidraw to protect the list
> > member from concurrent access:
> 
> Hi,
> 
> thanks for the patch.
> 
> I already have
> 
> 	commit 212a871a3934beccf43431608c27ed2e05a476ec
> 	Author: Manoj Chourasia <mchourasia@nvidia.com>
> 	Date:   Mon Jul 22 15:33:13 2013 +0530
> 
> 	    HID: hidraw: correctly deallocate memory on device disconnect
> 
> in the tree, which collides with your patch. Could you please check what 
> changes are needed on top of it so that it makes sense for my 'for-next' 
> branch, rebase, and resend to me?
> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs

On Mon, Aug 26, 2013 at 02:03:18PM +0200, Jiri Kosina wrote:
> On Thu, 15 Aug 2013, Yonghua Zheng wrote:
> 
> > As hidraw_report_event can be called from interrupt context, it is a mistake
> > to use mutex_lock for protecting the list member in my previous patch, so
> > update the patch which adds a spinlock in struct hidraw to protect the list
> > member from concurrent access:
> 
> Hi,
> 
> thanks for the patch.
> 
> I already have
> 
> 	commit 212a871a3934beccf43431608c27ed2e05a476ec
> 	Author: Manoj Chourasia <mchourasia@nvidia.com>
> 	Date:   Mon Jul 22 15:33:13 2013 +0530
> 
> 	    HID: hidraw: correctly deallocate memory on device disconnect
> 
> in the tree, which collides with your patch. Could you please check what 
> changes are needed on top of it so that it makes sense for my 'for-next' 
> branch, rebase, and resend to me?
> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
