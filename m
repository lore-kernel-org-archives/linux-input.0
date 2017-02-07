From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: xpad - restore LED state after device resume
Date: Mon, 6 Feb 2017 17:03:45 -0800
Message-ID: <20170207010345.GC35854@dtor-ws>
References: <20170207005838.20095-1-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33336 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBGBDt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2017 20:03:49 -0500
Content-Disposition: inline
In-Reply-To: <20170207005838.20095-1-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 06, 2017 at 04:58:38PM -0800, Cameron Gutman wrote:
> Set the LED_CORE_SUSPENDRESUME flag on our LED device so the
> LED state will be automatically restored by LED core on resume.
> 
> Since Xbox One pads stop flashing only when reinitialized, we'll
> send them the initialization packet so they calm down too.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>

Applied, thank you.

> ---
> Sending this one alone, since the rest of the series was applied or
> needs non-trivial reworking.
> 
> Thanks,
> Cameron
> 
> ---
>  drivers/input/joystick/xpad.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 13975aa..18697f1 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1240,6 +1240,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>  	led_cdev = &led->led_cdev;
>  	led_cdev->name = led->name;
>  	led_cdev->brightness_set = xpad_led_set;
> +	led_cdev->flags = LED_CORE_SUSPENDRESUME;
>  
>  	error = led_classdev_register(&xpad->udev->dev, led_cdev);
>  	if (error)
> @@ -1716,8 +1717,16 @@ static int xpad_resume(struct usb_interface *intf)
>  		retval = xpad360w_start_input(xpad);
>  	} else {
>  		mutex_lock(&input->mutex);
> -		if (input->users)
> +		if (input->users) {
>  			retval = xpad_start_input(xpad);
> +		} else if (xpad->xtype == XTYPE_XBOXONE) {
> +			/*
> +			 * Even if there are no users, we'll send Xbox One pads
> +			 * the startup sequence so they don't sit there and
> +			 * blink until somebody opens the input device again.
> +			 */
> +			retval = xpad_start_xbox_one(xpad);
> +		}
>  		mutex_unlock(&input->mutex);
>  	}
>  
> -- 
> 2.9.3
> 

-- 
Dmitry
