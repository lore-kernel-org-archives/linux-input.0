From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 3/5] Input: uinput - add UI_GET_VERSION ioctl
Date: Sun, 20 Jul 2014 17:34:14 -0700
Message-ID: <20140721003413.GB22552@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
 <1405775445-4454-4-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57468 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaGUAeR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 20:34:17 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so8597037pab.20
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 17:34:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405775445-4454-4-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dtor@google.com>

On Sat, Jul 19, 2014 at 03:10:43PM +0200, David Herrmann wrote:
> This ioctl is the counterpart to EVIOCGVERSION and returns the
> uinput-version the kernel was compiled with.
> 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/uinput.c | 6 ++++++
>  include/uapi/linux/uinput.h | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 615324c..a2a3895 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -722,6 +722,12 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  	}
>  
>  	switch (cmd) {
> +		case UI_GET_VERSION:
> +			if (put_user(UINPUT_VERSION,
> +				     (unsigned int __user*)p))
> +				retval = -EFAULT;
> +			goto out;
> +
>  		case UI_DEV_CREATE:
>  			retval = uinput_create_device(udev);
>  			goto out;
> diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
> index 0389b48..19339cf 100644
> --- a/include/uapi/linux/uinput.h
> +++ b/include/uapi/linux/uinput.h
> @@ -84,6 +84,15 @@ struct uinput_ff_erase {
>   */
>  #define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 300, len)
>  
> +/**
> + * UI_GET_VERSION - Return uinput version of the kernel
> + *
> + * This writes the kernel's uinput version into the integer pointed to by the
> + * ioctl argument. The uinput-version is hard-coded in the kernel and
> + * independent of the uinput device.
> + */
> +#define UI_GET_VERSION _IOR(UINPUT_IOCTL_BASE, 301, unsigned int)
> +
>  /*
>   * To write a force-feedback-capable driver, the upload_effect
>   * and erase_effect callbacks in input_dev must be implemented.
> -- 
> 2.0.2
> 

-- 
Dmitry
