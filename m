From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] uinput: Rename a jump label in uinput_ioctl_handler()
Date: Sat, 12 Dec 2015 14:23:28 -0800
Message-ID: <20151212222328.GA40689@dtor-ws>
References: <566ABCD9.1060404@users.sourceforge.net>
 <566BE5F2.9070909@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35553 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbbLLWXb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2015 17:23:31 -0500
Content-Disposition: inline
In-Reply-To: <566BE5F2.9070909@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

Hi Markus,

On Sat, Dec 12, 2015 at 10:16:34AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 12 Dec 2015 10:06:00 +0100
> 
> This issue was detected by using the Coccinelle software.
> 
> Choose a jump label according to the current Linux coding style convention.

While I am mildly curious where you  found this Coccinelle script
complaining about label names I find the current name is perfectly fine.

Thanks.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/input/misc/uinput.c | 66 ++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 5adbced..466f62d 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -717,7 +717,7 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  	if (!udev->dev) {
>  		retval = uinput_allocate_device(udev);
>  		if (retval)
> -			goto out;
> +			goto unlock;
>  	}
>  
>  	switch (cmd) {
> @@ -725,82 +725,82 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  			if (put_user(UINPUT_VERSION,
>  				     (unsigned int __user *)p))
>  				retval = -EFAULT;
> -			goto out;
> +			goto unlock;
>  
>  		case UI_DEV_CREATE:
>  			retval = uinput_create_device(udev);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_DEV_DESTROY:
>  			uinput_destroy_device(udev);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_EVBIT:
>  			retval = uinput_set_bit(arg, evbit, EV_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_KEYBIT:
>  			retval = uinput_set_bit(arg, keybit, KEY_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_RELBIT:
>  			retval = uinput_set_bit(arg, relbit, REL_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_ABSBIT:
>  			retval = uinput_set_bit(arg, absbit, ABS_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_MSCBIT:
>  			retval = uinput_set_bit(arg, mscbit, MSC_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_LEDBIT:
>  			retval = uinput_set_bit(arg, ledbit, LED_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_SNDBIT:
>  			retval = uinput_set_bit(arg, sndbit, SND_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_FFBIT:
>  			retval = uinput_set_bit(arg, ffbit, FF_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_SWBIT:
>  			retval = uinput_set_bit(arg, swbit, SW_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_PROPBIT:
>  			retval = uinput_set_bit(arg, propbit, INPUT_PROP_MAX);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_SET_PHYS:
>  			if (udev->state == UIST_CREATED) {
>  				retval = -EINVAL;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			phys = strndup_user(p, 1024);
>  			if (IS_ERR(phys)) {
>  				retval = PTR_ERR(phys);
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			kfree(udev->dev->phys);
>  			udev->dev->phys = phys;
> -			goto out;
> +			goto unlock;
>  
>  		case UI_BEGIN_FF_UPLOAD:
>  			retval = uinput_ff_upload_from_user(p, &ff_up);
>  			if (retval)
> -				goto out;
> +				goto unlock;
>  
>  			req = uinput_request_find(udev, ff_up.request_id);
>  			if (!req || req->code != UI_FF_UPLOAD ||
>  			    !req->u.upload.effect) {
>  				retval = -EINVAL;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			ff_up.retval = 0;
> @@ -811,60 +811,60 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  				memset(&ff_up.old, 0, sizeof(struct ff_effect));
>  
>  			retval = uinput_ff_upload_to_user(p, &ff_up);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_BEGIN_FF_ERASE:
>  			if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
>  				retval = -EFAULT;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			req = uinput_request_find(udev, ff_erase.request_id);
>  			if (!req || req->code != UI_FF_ERASE) {
>  				retval = -EINVAL;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			ff_erase.retval = 0;
>  			ff_erase.effect_id = req->u.effect_id;
>  			if (copy_to_user(p, &ff_erase, sizeof(ff_erase))) {
>  				retval = -EFAULT;
> -				goto out;
> +				goto unlock;
>  			}
>  
> -			goto out;
> +			goto unlock;
>  
>  		case UI_END_FF_UPLOAD:
>  			retval = uinput_ff_upload_from_user(p, &ff_up);
>  			if (retval)
> -				goto out;
> +				goto unlock;
>  
>  			req = uinput_request_find(udev, ff_up.request_id);
>  			if (!req || req->code != UI_FF_UPLOAD ||
>  			    !req->u.upload.effect) {
>  				retval = -EINVAL;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			req->retval = ff_up.retval;
>  			uinput_request_done(udev, req);
> -			goto out;
> +			goto unlock;
>  
>  		case UI_END_FF_ERASE:
>  			if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
>  				retval = -EFAULT;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			req = uinput_request_find(udev, ff_erase.request_id);
>  			if (!req || req->code != UI_FF_ERASE) {
>  				retval = -EINVAL;
> -				goto out;
> +				goto unlock;
>  			}
>  
>  			req->retval = ff_erase.retval;
>  			uinput_request_done(udev, req);
> -			goto out;
> +			goto unlock;
>  	}
>  
>  	size = _IOC_SIZE(cmd);
> @@ -874,15 +874,15 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  	case UI_GET_SYSNAME(0):
>  		if (udev->state != UIST_CREATED) {
>  			retval = -ENOENT;
> -			goto out;
> +			goto unlock;
>  		}
>  		name = dev_name(&udev->dev->dev);
>  		retval = uinput_str_to_user(p, name, size);
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	retval = -EINVAL;
> - out:
> + unlock:
>  	mutex_unlock(&udev->mutex);
>  	return retval;
>  }
> -- 
> 2.6.3
> 

-- 
Dmitry
