From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 2/5] Input: uinput - uinput_validate_absbits()
 cleanup
Date: Sun, 20 Jul 2014 17:34:00 -0700
Message-ID: <20140721003400.GA22552@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
 <1405775445-4454-3-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51396 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaGUAeH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 20:34:07 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so8749323pab.12
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 17:34:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405775445-4454-3-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dtor@google.com>

On Sat, Jul 19, 2014 at 03:10:42PM +0200, David Herrmann wrote:
> This moves basic checks and setup from uinput_setup_device() into
> uinput_validate_absbits() to make it easier to use. This way, we can call
> it from other places without copying the boilerplate code.
> 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/uinput.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 8569362..615324c 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -311,7 +311,13 @@ static int uinput_open(struct inode *inode, struct file *file)
>  static int uinput_validate_absbits(struct input_dev *dev)
>  {
>  	unsigned int cnt;
> -	int retval = 0;
> +	int nslot;
> +
> +	if (!test_bit(EV_ABS, dev->evbit))
> +		return 0;
> +
> +	/* check if absmin/absmax/absfuzz/absflat are filled as
> +	 * told in Documentation/input/input-programming.txt */
>  
>  	for (cnt = 0; cnt < ABS_CNT; cnt++) {
>  		int min, max;
> @@ -327,8 +333,7 @@ static int uinput_validate_absbits(struct input_dev *dev)
>  				UINPUT_NAME, cnt,
>  				input_abs_get_min(dev, cnt),
>  				input_abs_get_max(dev, cnt));
> -			retval = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
>  
>  		if (input_abs_get_flat(dev, cnt) >
> @@ -340,11 +345,18 @@ static int uinput_validate_absbits(struct input_dev *dev)
>  				input_abs_get_flat(dev, cnt),
>  				input_abs_get_min(dev, cnt),
>  				input_abs_get_max(dev, cnt));
> -			retval = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
>  	}
> -	return retval;
> +
> +	if (test_bit(ABS_MT_SLOT, dev->absbit)) {
> +		nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
> +		input_mt_init_slots(dev, nslot, 0);
> +	} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
> +		input_set_events_per_packet(dev, 60);
> +	}
> +
> +	return 0;
>  }
>  
>  static int uinput_allocate_device(struct uinput_device *udev)
> @@ -410,19 +422,9 @@ static int uinput_setup_device(struct uinput_device *udev,
>  		input_abs_set_flat(dev, i, user_dev->absflat[i]);
>  	}
>  
> -	/* check if absmin/absmax/absfuzz/absflat are filled as
> -	 * told in Documentation/input/input-programming.txt */
> -	if (test_bit(EV_ABS, dev->evbit)) {
> -		retval = uinput_validate_absbits(dev);
> -		if (retval < 0)
> -			goto exit;
> -		if (test_bit(ABS_MT_SLOT, dev->absbit)) {
> -			int nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
> -			input_mt_init_slots(dev, nslot, 0);
> -		} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
> -			input_set_events_per_packet(dev, 60);
> -		}
> -	}
> +	retval = uinput_validate_absbits(dev);
> +	if (retval < 0)
> +		goto exit;
>  
>  	udev->state = UIST_SETUP_COMPLETE;
>  	retval = count;
> -- 
> 2.0.2
> 

-- 
Dmitry
