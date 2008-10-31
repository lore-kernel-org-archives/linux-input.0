From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Fri, 31 Oct 2008 15:08:07 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0810311507070.31273@jikos.suse.cz>
References: <200810311031.39083.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:45332 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751403AbYJaOIJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 10:08:09 -0400
In-Reply-To: <200810311031.39083.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, 31 Oct 2008, Oliver Neukum wrote:

> this bug is old, the patch should go into 2.6.28 and stable.
> This fixes a memleak in hiddev's open in an error case.
> ---
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index b218cbc..6834d1f 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -291,8 +291,13 @@ static int hiddev_open(struct inode *inode, struct file *file)
>  		if (list->hiddev->exist) {
>  			struct hid_device *hid = hiddev_table[i]->hid;
>  			res = usbhid_get_power(hid);
> -			if (res < 0)
> +			if (res < 0) {
> +				spin_lock_irqsave(&list->hiddev->list_lock, flags);
> +				list_del(&list->node);
> +				spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
> +				kfree(list->hiddev);
>  				return -EIO;
> +			}
>  			usbhid_open(hid);
>  		}

Hmm, this is probably based on not-yet-merged usbhid autosuspend patchset, 
right?

Now, you are right that hiddev_open() doesn't handle error condition from 
usbhid_open(), and that should be fixed. But that doesn't seem to be 
addressed by your patch at all ... ?

Thanks,

-- 
Jiri Kosina
SUSE Labs
