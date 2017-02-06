From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: xpad - restore LED state after device resume
Date: Mon, 6 Feb 2017 14:05:18 -0800
Message-ID: <20170206220518.GE17441@dtor-ws>
References: <20170205003002.28160-1-aicommander@gmail.com>
 <20170205003002.28160-5-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36588 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdBFWFV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2017 17:05:21 -0500
Content-Disposition: inline
In-Reply-To: <20170205003002.28160-5-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 04, 2017 at 04:30:01PM -0800, Cameron Gutman wrote:
> The state of pad LEDs can be inconsistent when the system is
> woken up after sleep. Rather than leaving the controllers blinking,
> let's resend the last LED command to Xbox 360 pads on resume.
> 
> Since Xbox One pads stop flashing only when reinitialized, we'll
> send them the initialization packet so they calm down too.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 13f298d..1179266 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1683,11 +1683,23 @@ static int xpad_resume(struct usb_interface *intf)
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
> +	/* LED state is lost across resume, so resend the last command */
> +	if (xpad->led)
> +		xpad_send_led_command(xpad, xpad->led->led_cdev.brightness);

I can see that we might need to send the "start" command, but I am not
sure that explicitly calling xpad_send_led_command() is needed: LED core
should restore LED state upon resume, and this should happen after its
parent (i.e. xbox device) is resumed.

Thanks.

-- 
Dmitry
