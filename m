From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Added check for grabbed device
Date: Sun, 4 Jan 2015 14:46:57 -0800
Message-ID: <20150104224657.GD31987@dtor-ws>
References: <anshul.g@samsung.com>
 <1420359955-21553-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46294 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbADWrD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Jan 2015 17:47:03 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so18634629ier.41
        for <linux-input@vger.kernel.org>; Sun, 04 Jan 2015 14:47:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420359955-21553-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

Hi Anshul,

On Sun, Jan 04, 2015 at 12:25:55AM -0800, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> If input device is grabbed then client which has grabbed the device can
> flush or write to the device so for other clients -EINVAL should be returned.
> 
> Signed-off-by: Anshul Garg <anshul.g@samsung.com>
> ---
>  drivers/input/evdev.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index b1a52ab..105e489 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -277,6 +277,8 @@ static int evdev_flush(struct file *file, fl_owner_t id)
>  
>  	if (!evdev->exist || client->revoked)
>  		retval = -ENODEV;
> +	else if (evdev->grab && evdev->grab != client)
> +		retval = -EINVAL;
>  	else
>  		retval = input_flush_device(&evdev->handle, file);
>  
> @@ -475,6 +477,11 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  		goto out;
>  	}
>  
> +
> +	if (evdev->grab && evdev->grab != client) {
> +		retval = -EINVAL;
> +		goto out;
> +	}

Grab is supposed to be transparent to the other users, so returning
error here is not desirable. Also, input_inject_event() will already
ignore events if device is grabbed, so everything is good as far as
evdev_write() concerned.

Flush is a bit trickier: the driver should only "flush" data that
belongs to the user that issued flush request (and the owner is
identified by file handle passed to flush() method). I think it is OK to
allow owner to flush its own data even while device is grabbed.

Thanks.

-- 
Dmitry
