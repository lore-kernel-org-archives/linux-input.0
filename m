From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Fri, 7 Oct 2016 10:43:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610071038340.31629@cbobk.fhfr.pm>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58401 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbcJGIot (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 04:44:49 -0400
In-Reply-To: <1475628266-4767-1-git-send-email-gary.king@oculus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary King <gary.king@oculus.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

On Tue, 4 Oct 2016, Gary King wrote:

> hidraw input events are stored for each file descriptor in a lockless
> circular queue. 

Well, there is a per-hidraw device list_lock; but you're right that it's 
usage throughout hidraw.c is probably incomplete and that should be fixed.

> ---
>  drivers/hid/hidraw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index f0e2757..dc3465f 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -53,6 +53,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
>  	mutex_lock(&list->read_mutex);
>  
>  	while (ret == 0) {
> +		smp_rmb();

Which _wmb() does this one pair with?

>  		if (list->head == list->tail) {
>  			add_wait_queue(&list->hidraw->wait, &wait);
>  			set_current_state(TASK_INTERRUPTIBLE);
> @@ -98,7 +99,9 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
>  
>  		kfree(list->buffer[list->tail].value);
>  		list->buffer[list->tail].value = NULL;
> +		smp_wmb();
>  		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
> +		smp_wmb();

This is completely confusing; it seems like you imply that those two 
_wmb() should pair together, but that makes no sense. Please always, when 
using SMP barriers, document which _rmb() pairs to which _wmb(), otherwise 
the rules become quickly totally unclear.

>  	}
>  out:
>  	mutex_unlock(&list->read_mutex);
> @@ -487,7 +490,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  	spin_lock_irqsave(&dev->list_lock, flags);
>  	list_for_each_entry(list, &dev->list, node) {
>  		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> -
> +		smp_rmb();
>  		if (new_head == list->tail)

Again, which _wmb() does this one pair with please?

>  			continue;
>  
> @@ -496,7 +499,9 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  			break;
>  		}
>  		list->buffer[list->head].len = len;
> +		smp_wmb();
>  		list->head = new_head;
> +		smp_wmb();

Same as in hidraw_read(), I completely fail to see the point of having two 
here. Which read side does each of those pair with?

I think this is just papering the real problem (missing list_lock) over in 
an odd way; could you please look into whether locking list_lock properly 
would resolve the crashes you're able to trigger on your ARM system?

Thanks,

-- 
Jiri Kosina
SUSE Labs

