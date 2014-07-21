From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 4/5] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Sun, 20 Jul 2014 18:01:10 -0700
Message-ID: <20140721010110.GD22552@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
 <1405775445-4454-5-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36212 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaGUBBP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 21:01:15 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so8253946pdj.0
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 18:01:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405775445-4454-5-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dtor@google.com>

Hi David,

On Sat, Jul 19, 2014 at 03:10:44PM +0200, David Herrmann wrote:
> This adds a new ioctl UINPUT_DEV_SETUP that replaces the old device setup
> method (by write()'ing "struct uinput_user_dev" to the node). The old
> method is not easily extendable and requires huge payloads. Furthermore,
> overloading write() without properly versioned objects is error-prone.
> 
> Therefore, we introduce a new ioctl to replace the old method. The ioctl
> supports all features of the old method, plus a "resolution" field for
> absinfo. Furthermore, it's properly forward-compatible to new ABS codes
> and a growing "struct input_absinfo" structure.
> 
> The ioctl also allows user-space to skip unknown axes if not set. The
> payload-size can now be specified by the caller. There is no need to copy
> the whole array temporarily into the kernel, but instead we can iterate
> over it and copy each value manually.
> 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/input/misc/uinput.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/uinput.h | 55 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 118 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index a2a3895..0f45595 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -371,8 +371,67 @@ static int uinput_allocate_device(struct uinput_device *udev)
>  	return 0;
>  }
>  
> -static int uinput_setup_device(struct uinput_device *udev,
> -			       const char __user *buffer, size_t count)
> +static int uinput_dev_setup(struct uinput_device *udev,
> +			    struct uinput_setup __user *arg)
> +{
> +	struct uinput_setup setup;
> +	struct input_dev *dev;
> +	int i, retval;
> +
> +	if (udev->state == UIST_CREATED)
> +		return -EINVAL;
> +	if (copy_from_user(&setup, arg, sizeof(setup)))
> +		return -EFAULT;
> +	if (!setup.name[0])
> +		return -EINVAL;
> +	/* So far we only support the original "struct input_absinfo", but be
> +	 * forward compatible and allow larger payloads. */
> +	if (setup.absinfo_size < sizeof(struct input_absinfo))
> +		return -EINVAL;

No, we can not do this, as it breaks backward compatibility (the most
important one!). If we were to increase size of in-kernel input_absinfo
in let's say 3.20, userspace compiled against older kernel headers
(but using the new ioctl available let's say since 3.16 - don't hold me
to the numbers ;) ), would break since it wold start tripping on thi
check.

The proper way to handle it is to convert "old" absinfo into new one,
applying as much as we can.

Thanks.

-- 
Dmitry
