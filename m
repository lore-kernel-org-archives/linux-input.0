From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: uinput - uinput_validate_absbits() cleanup
Date: Fri, 20 Jun 2014 10:56:43 +1000
Message-ID: <20140620005643.GB22050@jelly.redhat.com>
References: <1403183579-15680-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:39970 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbaFTA4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 20:56:45 -0400
Content-Disposition: inline
In-Reply-To: <1403183579-15680-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Thu, Jun 19, 2014 at 03:12:59PM +0200, David Herrmann wrote:
> This moves basic checks and setup from uinput_setup_device() into
> uinput_validate_absbits() to make it easier to use. This way, we can call
> it from other places without copying the boilerplate code.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

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
> 2.0.0
> 
