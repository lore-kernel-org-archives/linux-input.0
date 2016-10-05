From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Wed, 5 Oct 2016 09:53:29 +0200
Message-ID: <20161005075329.GZ19261@mail.corp.redhat.com>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbcJEHxe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 Oct 2016 03:53:34 -0400
Content-Disposition: inline
In-Reply-To: <1475628266-4767-1-git-send-email-gary.king@oculus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary King <gary.king@oculus.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org

Hi Gary,

On Oct 04 2016 or thereabouts, Gary King wrote:
> hidraw input events are stored for each file descriptor in a lockless
> circular queue. no memory barriers were used when the queue was
> updated, which caused intermittent kernel panics due to heap corruption
> when used on multi-core ARM systems.
> 
> add memory barriers to ensure that value updates are observable before
> the head and tail referents are updated.

As a foreword, I must confess I am not that comfortable with memory
barriers on SMP.

I have a hard time trying to understand where the code can be reordered
and why you are having the heap corruption and how these barriers solve
the issue.

> 
> Change-Id: Ifb50f5ebe13c55c83aa105c5cd5926ca16fd93e0
> Signed-off-by: Gary King <gary.king@oculus.com>
> Reviewed-on: http://prn-ocugerrit01.thefacebook.com:8080/88

This doesn't look like a public URL, please drop if not.

> Reviewed-by: Ahmed Amin <ahmed.amin@oculus.com>
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

How does these barriers be needed? To me, list->tail gets accessed just
before, so I doubt the compiler would decide to reorder the code without
changing the semantic.

Again, I am not an expert regarding memory barriers, but either you
convince me that this is the best solution, either there is an other
solution (like protecting the circular buffer with spinlocks between the
feeder and consumer).

>  	}
>  out:
>  	mutex_unlock(&list->read_mutex);
> @@ -487,7 +490,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  	spin_lock_irqsave(&dev->list_lock, flags);
>  	list_for_each_entry(list, &dev->list, node) {
>  		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> -

Nitpicking, please do not drop this empty line, see the kernel coding
style, an empty line is required after a declaration.

> +		smp_rmb();
>  		if (new_head == list->tail)
>  			continue;
>  
> @@ -496,7 +499,9 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  			break;
>  		}
>  		list->buffer[list->head].len = len;
> +		smp_wmb();
>  		list->head = new_head;
> +		smp_wmb();

Same comment than before, I don't understand how the barrier can help
you here.

>  		kill_fasync(&list->fasync, SIGIO, POLL_IN);
>  	}
>  	spin_unlock_irqrestore(&dev->list_lock, flags);
> -- 
> 1.9.1

Cheers,
Benjamin 
