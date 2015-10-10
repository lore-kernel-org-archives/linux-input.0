From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/15] Input: xpad: x360w: report dpad as buttons and axes
Date: Sat, 10 Oct 2015 09:45:51 -0700
Message-ID: <20151010164551.GG39573@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-7-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33634 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbJJQpy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2015 12:45:54 -0400
Received: by pacex6 with SMTP id ex6so115190907pac.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2015 09:45:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443733046-29610-7-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Thu, Oct 01, 2015 at 10:57:17PM +0200, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> as discussed here[0], x360w is the only pad that maps dpad_to_button.
> This is bad for downstream developers as they have to differ between
> x360 and x360w which is not intuitive.
> 
> This patch implements the suggested solution of exposing the dpad both
> as axes and as buttons. This retains backward compability with software
> already dealing with the difference while makes new software work as
> expected across x360/ x360w pads.
> 
> [0] http://www.spinics.net/lists/linux-input/msg34421.html
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 1195dbb..15da2a3 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -436,7 +436,14 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
>  		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08);
>  		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01);
>  		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02);
> -	} else {
> +	}
> +	/* this should be a simple else block. However historically xbox360w
> +	 * has mapped DPAD to buttons while xbox360 did not.
> +	 * This made no sense, but now we can not just switch back and have to
> +	 * support both behaviors.
> +	 */
> +	if (!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
> +			xpad->xtype == XTYPE_XBOX360W) {
>  		input_report_abs(dev, ABS_HAT0X,
>  				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
>  		input_report_abs(dev, ABS_HAT0Y,
> @@ -1144,7 +1151,14 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
>  		for (i = 0; xpad_btn_pad[i] >= 0; i++)
>  			__set_bit(xpad_btn_pad[i], input_dev->keybit);
> -	} else {
> +	}
> +	/* this should be a simple else block. However historically xbox360w
> +	 * has mapped DPAD to buttons while xbox360 did not.
> +	 * This made no sense, but now we can not just switch back and have to
> +	 * support both behaviors.
> +	 */
> +	if(!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
> +			xpad->xtype == XTYPE_XBOX360W) {
>  		for (i = 0; xpad_abs_pad[i] >= 0; i++)
>  			xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
>  	}
> -- 
> 1.9.1
> 

-- 
Dmitry
