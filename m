From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hidraw : fix list->buffer memleak
Date: Fri, 20 Jul 2012 10:13:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207201013210.21929@pobox.suse.cz>
References: <1340895116-13002-1-git-send-email-matthieu.castet@parrot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54148 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2GTINo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 04:13:44 -0400
In-Reply-To: <1340895116-13002-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 28 Jun 2012, Matthieu CASTET wrote:

> If we don't read fast enough hidraw device, hidraw_report_event
> will cycle and we will leak list->buffer.
> Also list->buffer are not free on release.
> After this patch, kmemleak report nothing.
> 
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
> ---
>  drivers/hid/hidraw.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 36fa77b..3b6f7bf 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -96,6 +96,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
>  		}
>  
>  		kfree(list->buffer[list->tail].value);
> +		list->buffer[list->tail].value = NULL;
>  		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
>  	}
>  out:
> @@ -300,6 +301,7 @@ static int hidraw_release(struct inode * inode, struct file * file)
>  	struct hidraw *dev;
>  	struct hidraw_list *list = file->private_data;
>  	int ret;
> +	int i;
>  
>  	mutex_lock(&minors_lock);
>  	if (!hidraw_table[minor]) {
> @@ -317,6 +319,9 @@ static int hidraw_release(struct inode * inode, struct file * file)
>  			kfree(list->hidraw);
>  		}
>  	}
> +
> +	for (i = 0; i < HIDRAW_BUFFER_SIZE; ++i)
> +		kfree(list->buffer[i].value);
>  	kfree(list);
>  	ret = 0;
>  unlock:
> @@ -446,12 +451,17 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  	int ret = 0;
>  
>  	list_for_each_entry(list, &dev->list, node) {
> +		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> +
> +		if (new_head == list->tail)
> +			continue;
> +
>  		if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
>  			ret = -ENOMEM;
>  			break;
>  		}
>  		list->buffer[list->head].len = len;
> -		list->head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> +		list->head = new_head;
>  		kill_fasync(&list->fasync, SIGIO, POLL_IN);
>  	}
>  

Applied, thank you Matthieu.

-- 
Jiri Kosina
SUSE Labs
