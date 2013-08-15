From: Yonghua Zheng <younghua.zheng@gmail.com>
Subject: Re: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to
 protect list
Date: Thu, 15 Aug 2013 22:57:01 +0800
Message-ID: <20130815145658.GA5813@gmail.com>
References: <CAMyfujdB0JrnNeHk3b=AqR+1nz_W=bzDJpk1=iYZBnytDk-ztw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:53493 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab3HOO5M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Aug 2013 10:57:12 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so926313pdj.26
        for <linux-input@vger.kernel.org>; Thu, 15 Aug 2013 07:57:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMyfujdB0JrnNeHk3b=AqR+1nz_W=bzDJpk1=iYZBnytDk-ztw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Retitle

Hi Jiri,

As hidraw_report_event can be called from interrupt context, it is a mistake
to use mutex_lock for protecting the list member in my previous patch, so
update the patch which adds a spinlock in struct hidraw to protect the list
member from concurrent access:

>From 21e3dfdf124065dac8bb56f4a7ed48d20870323b Mon Sep 17 00:00:00 2001
From: Yonghua Zheng <younghua.zheng@gmail.com>
Date: Wed, 14 Aug 2013 17:43:36 +0800
Subject: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to protect
 list

It is unsafe to call list_for_each_entry in hidraw_report_event to
traverse each hidraw_list node without a lock protection, the list
could be modified if someone calls hidraw_release and list_del to
remove itself from the list, this can cause hidraw_report_event
to touch a deleted list struct and panic.

To prevent this, introduce a spinlock in struct hidraw to protect
list from concurrent access.

Signed-off-by: Yonghua Zheng <younghua.zheng@gmail.com>

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 6f1feb2..a5372b8 100644
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
@@ -309,6 +312,7 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	struct hidraw_list *list = file->private_data;
 	int ret;
 	int i;
+	unsigned long flags;
 
 	mutex_lock(&minors_lock);
 	if (!hidraw_table[minor]) {
@@ -316,8 +320,10 @@ static int hidraw_release(struct inode * inode, struct file * file)
 		goto unlock;
 	}
 
-	list_del(&list->node);
 	dev = hidraw_table[minor];
+	spin_lock_irqsave(&dev->list_lock, flags);
+	list_del(&list->node);
+	spin_unlock_irqrestore(&dev->list_lock, flags);
 	if (!--dev->open) {
 		if (list->hidraw->exist) {
 			hid_hw_power(dev->hid, PM_HINT_NORMAL);
@@ -457,7 +463,9 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	struct hidraw *dev = hid->hidraw;
 	struct hidraw_list *list;
 	int ret = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&dev->list_lock, flags);
 	list_for_each_entry(list, &dev->list, node) {
 		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
 
@@ -468,10 +476,12 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 			ret = -ENOMEM;
 			break;
 		}
+
 		list->buffer[list->head].len = len;
 		list->head = new_head;
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
+	spin_unlock_irqrestore(&dev->list_lock, flags);
 
 	wake_up_interruptible(&dev->wait);
 	return ret;
@@ -519,6 +529,7 @@ int hidraw_connect(struct hid_device *hid)
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

Best regards
Yonghua

On Fri, Aug 09, 2013 at 04:45:19PM +0800, yonghua zheng wrote:
> Hi Jiri,
> 
> We met another kernel panic issue in hidraw_report_event while using
> BT remote on our Android system, the panic log below shows a unhandle
> kernel paging request at virtual address 001000f0, this can happen if
> hidraw_report_event access a hidraw_list node which is already removed
> by list_del() in hidraw_release.
> 
> One last thing list_del() does is set entry->next = LIST_POISON1;
> where LIST_POISON1 is 00100100, and this should be able to explain why
> panic address is 001000f0, hidraw_report_event try to access somewhere
> in struct hidraw_list:
> 
> [ 1337.530941] Unable to handle kernel paging request at virtual
> address 001000f0
> [ 1337.538679] pgd = a0570000
> [ 1337.541877] [001000f0] *pgd=00000000
> [ 1337.545884] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [ 1337.551373] Modules linked in: mbt8787 fusion(O) gal3d amp_core(O)
> [ 1337.557834] CPU: 0    Tainted: G           O  (3.4.50+ #1)
> [ 1337.563512] PC is at hidraw_report_event+0x38/0x98
> [ 1337.568462] LR is at hidraw_report_event+0x70/0x98
> [ 1337.573412] pc : [<8035286c>]    lr : [<803528a4>]    psr: a0000013
> [ 1337.573416] sp : a0eede30  ip : a0eede30  fp : a0eede54
> [ 1337.575086] [amp_driver] [vpp isr] MsgQ full
> [ 1337.589671] r10: a0b7e4c0  r9 : a035b800  r8 : a0bb002c
> [ 1337.595068] r7 : a0b7e4e4  r6 : 00000001  r5 : 0000001f  r4 : 000ffef0
> [ 1337.601809] r3 : a36db808  r2 : 00000020  r1 : 0000001f  r0 : a0bb002c
> [ 1337.608553] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [ 1337.615923] Control: 10c5387d  Table: 2157004a  DAC: 00000015
> 
> So the fix is to grab the minors_lock to avoid list_del in the middle
> of hidraw_report_event()
> 
> From 725ed6c402f36e34479739a8d6c68f78f2f96d31 Mon Sep 17 00:00:00 2001
> From: Yonghua Zheng <younghua.zheng@gmail.com>
> Date: Fri, 9 Aug 2013 15:54:59 +0800
> Subject: [PATCH 1/1] HID: hidraw: need to grab minors_lock in
>  hidraw_report_event
> 
> It is unsafe to call list_for_each_entry to go through each hidraw_list
> node without grabing the minors_lock, because the dev->list can be
> modified if other process calls hidraw_release to list_del itself from
> the same &dev->list, if this happens, it can result in kernel panic
> due to unable handle kernel paging request at invalid virtual address
> 
> Signed-off-by: Yonghua Zheng <younghua.zheng@gmail.com>
> ---
>  drivers/hid/hidraw.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 6f1feb2..8b408c4 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -458,6 +458,7 @@ int hidraw_report_event(struct hid_device *hid, u8
> *data, int len)
>      struct hidraw_list *list;
>      int ret = 0;
> 
> +    mutex_lock(&minors_lock);
>      list_for_each_entry(list, &dev->list, node) {
>          int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> 
> @@ -465,6 +466,7 @@ int hidraw_report_event(struct hid_device *hid, u8
> *data, int len)
>              continue;
> 
>          if (!(list->buffer[list->head].value = kmemdup(data, len,
> GFP_ATOMIC))) {
> +            mutex_unlock(&minors_lock);
>              ret = -ENOMEM;
>              break;
>          }
> @@ -472,6 +474,7 @@ int hidraw_report_event(struct hid_device *hid, u8
> *data, int len)
>          list->head = new_head;
>          kill_fasync(&list->fasync, SIGIO, POLL_IN);
>      }
> +    mutex_unlock(&minors_lock);
> 
>      wake_up_interruptible(&dev->wait);
>      return ret;
> -- 
> 1.7.9.5
> 
> Best regards
> Yonghua


