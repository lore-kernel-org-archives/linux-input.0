From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: roccat: Remove use of the "exist" field
Date: Mon, 29 Aug 2016 12:15:14 +0200
Message-ID: <20160829101514.GA21864@mail.corp.redhat.com>
References: <20160821133302.16265-1-s.jegen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756027AbcH2KPT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Aug 2016 06:15:19 -0400
Content-Disposition: inline
In-Reply-To: <20160821133302.16265-1-s.jegen@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Silvan Jegen <s.jegen@gmail.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Silvan,

On Aug 21 2016 or thereabouts, Silvan Jegen wrote:
> The "exist" field is only checked when "roccat_open" has already been
> called or when we have made sure that the corresponding roccat_device is
> not NULL. Since the value of the "open" field has been increased by the
> "roccat_open" call, instead of checking "exist" we can just check if
> "open" is equal to zero to the same effect and remove the "exist" field
> as well as the code that touches it.
> 
> 
> Signed-off-by: Silvan Jegen <s.jegen@gmail.com>

Well, if you look at the history, since v4.4 this driver is deprecated
(see https://patchwork.kernel.org/patch/7422131/), so I am not so sure
you should put a lot of effort in cleaning this up.

> 
> ---
> I have tested this patch with the only Roccat hardware I own, a Roccat
> Kone Pure. Testing the patch with several pieces of Roccat hardware
> connected at the same time would be desirable.
> 
>  
>  drivers/hid/hid-roccat.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 76d06cf..7552a1e 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -43,7 +43,6 @@ struct roccat_device {
>  	unsigned int minor;
>  	int report_size;
>  	int open;
> -	int exist;
>  	wait_queue_head_t wait;
>  	struct device *dev;
>  	struct hid_device *hid;
> @@ -99,7 +98,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
>  				retval = -ERESTARTSYS;
>  				break;
>  			}
> -			if (!device->exist) {
> +			if (device->open == 0) {

It feels weird to check for the device we are currently reading to be
opened (by the caller?).

I think this changes a little bit the way the flag was designed for.
This flag is controlled when the physical HW is removed/added. But when
the physical HW is removed, you might have some readers to the special
chardev. And so it needs to have a way to stop the readers that are
waiting for incoming data (read or poll).

Stefan might have a deeper look and ACK/NACK it, but to me, the patch
looks wrong :/

Cheers,
Benjamin

>  				retval = -EIO;
>  				break;
>  			}
> @@ -143,7 +142,7 @@ static unsigned int roccat_poll(struct file *file, poll_table *wait)
>  	poll_wait(file, &reader->device->wait, wait);
>  	if (reader->cbuf_start != reader->device->cbuf_end)
>  		return POLLIN | POLLRDNORM;
> -	if (!reader->device->exist)
> +	if (reader->device->open == 0)
>  		return POLLERR | POLLHUP;
>  	return 0;
>  }
> @@ -224,13 +223,11 @@ static int roccat_release(struct inode *inode, struct file *file)
>  	kfree(reader);
>  
>  	if (!--device->open) {
> -		/* removing last reader */
> -		if (device->exist) {
> -			hid_hw_power(device->hid, PM_HINT_NORMAL);
> -			hid_hw_close(device->hid);
> -		} else {
> -			kfree(device);
> -		}
> +		/* we have removed the last reader */
> +		kfree(device);
> +	} else {
> +		hid_hw_power(device->hid, PM_HINT_NORMAL);
> +		hid_hw_close(device->hid);
>  	}
>  
>  	mutex_unlock(&devices_lock);
> @@ -340,7 +337,6 @@ int roccat_connect(struct class *klass, struct hid_device *hid, int report_size)
>  	mutex_init(&device->cbuf_lock);
>  	device->minor = minor;
>  	device->hid = hid;
> -	device->exist = 1;
>  	device->cbuf_end = 0;
>  	device->report_size = report_size;
>  
> @@ -359,8 +355,6 @@ void roccat_disconnect(int minor)
>  	device = devices[minor];
>  	mutex_unlock(&devices_lock);
>  
> -	device->exist = 0; /* TODO exist maybe not needed */
> -
>  	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
>  
>  	mutex_lock(&devices_lock);
> -- 
> 2.9.3
> 
