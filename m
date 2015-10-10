From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/15] Input: xpad: factor out URB submission in
 xpad_play_effect
Date: Sat, 10 Oct 2015 09:45:25 -0700
Message-ID: <20151010164525.GF39573@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-6-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36352 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbJJQp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2015 12:45:28 -0400
Received: by pablk4 with SMTP id lk4so114958927pab.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2015 09:45:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443733046-29610-6-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Thu, Oct 01, 2015 at 10:57:16PM +0200, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> Move submisson logic to a single point at the end of the function.
> This makes it easy to add locking/ queuing code later on.
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 140 ++++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 69 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index a379346..1195dbb 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -759,80 +759,78 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
>  static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
>  {
>  	struct usb_xpad *xpad = input_get_drvdata(dev);
> +	__u16 strong;
> +	__u16 weak;
>  
> -	if (effect->type == FF_RUMBLE) {
> -		__u16 strong = effect->u.rumble.strong_magnitude;
> -		__u16 weak = effect->u.rumble.weak_magnitude;
> -
> -		switch (xpad->xtype) {
> -
> -		case XTYPE_XBOX:
> -			xpad->odata[0] = 0x00;
> -			xpad->odata[1] = 0x06;
> -			xpad->odata[2] = 0x00;
> -			xpad->odata[3] = strong / 256;	/* left actuator */
> -			xpad->odata[4] = 0x00;
> -			xpad->odata[5] = weak / 256;	/* right actuator */
> -			xpad->irq_out->transfer_buffer_length = 6;
> -
> -			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
> -
> -		case XTYPE_XBOX360:
> -			xpad->odata[0] = 0x00;
> -			xpad->odata[1] = 0x08;
> -			xpad->odata[2] = 0x00;
> -			xpad->odata[3] = strong / 256;  /* left actuator? */
> -			xpad->odata[4] = weak / 256;	/* right actuator? */
> -			xpad->odata[5] = 0x00;
> -			xpad->odata[6] = 0x00;
> -			xpad->odata[7] = 0x00;
> -			xpad->irq_out->transfer_buffer_length = 8;
> -
> -			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
> -
> -		case XTYPE_XBOX360W:
> -			xpad->odata[0] = 0x00;
> -			xpad->odata[1] = 0x01;
> -			xpad->odata[2] = 0x0F;
> -			xpad->odata[3] = 0xC0;
> -			xpad->odata[4] = 0x00;
> -			xpad->odata[5] = strong / 256;
> -			xpad->odata[6] = weak / 256;
> -			xpad->odata[7] = 0x00;
> -			xpad->odata[8] = 0x00;
> -			xpad->odata[9] = 0x00;
> -			xpad->odata[10] = 0x00;
> -			xpad->odata[11] = 0x00;
> -			xpad->irq_out->transfer_buffer_length = 12;
> -
> -			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
> -
> -		case XTYPE_XBOXONE:
> -			xpad->odata[0] = 0x09; /* activate rumble */
> -			xpad->odata[1] = 0x08;
> -			xpad->odata[2] = 0x00;
> -			xpad->odata[3] = 0x08; /* continuous effect */
> -			xpad->odata[4] = 0x00; /* simple rumble mode */
> -			xpad->odata[5] = 0x03; /* L and R actuator only */
> -			xpad->odata[6] = 0x00; /* TODO: LT actuator */
> -			xpad->odata[7] = 0x00; /* TODO: RT actuator */
> -			xpad->odata[8] = strong / 256;	/* left actuator */
> -			xpad->odata[9] = weak / 256;	/* right actuator */
> -			xpad->odata[10] = 0x80;	/* length of pulse */
> -			xpad->odata[11] = 0x00;	/* stop period of pulse */
> -			xpad->irq_out->transfer_buffer_length = 12;
> -
> -			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
> -
> -		default:
> -			dev_dbg(&xpad->dev->dev,
> -				"%s - rumble command sent to unsupported xpad type: %d\n",
> -				__func__, xpad->xtype);
> -			return -1;
> -		}
> +	if (effect->type != FF_RUMBLE)
> +		return 0;
> +
> +	strong = effect->u.rumble.strong_magnitude;
> +	weak = effect->u.rumble.weak_magnitude;
> +
> +	switch (xpad->xtype) {
> +	case XTYPE_XBOX:
> +		xpad->odata[0] = 0x00;
> +		xpad->odata[1] = 0x06;
> +		xpad->odata[2] = 0x00;
> +		xpad->odata[3] = strong / 256;	/* left actuator */
> +		xpad->odata[4] = 0x00;
> +		xpad->odata[5] = weak / 256;	/* right actuator */
> +		xpad->irq_out->transfer_buffer_length = 6;
> +		break;
> +
> +	case XTYPE_XBOX360:
> +		xpad->odata[0] = 0x00;
> +		xpad->odata[1] = 0x08;
> +		xpad->odata[2] = 0x00;
> +		xpad->odata[3] = strong / 256;  /* left actuator? */
> +		xpad->odata[4] = weak / 256;	/* right actuator? */
> +		xpad->odata[5] = 0x00;
> +		xpad->odata[6] = 0x00;
> +		xpad->odata[7] = 0x00;
> +		xpad->irq_out->transfer_buffer_length = 8;
> +		break;
> +
> +	case XTYPE_XBOX360W:
> +		xpad->odata[0] = 0x00;
> +		xpad->odata[1] = 0x01;
> +		xpad->odata[2] = 0x0F;
> +		xpad->odata[3] = 0xC0;
> +		xpad->odata[4] = 0x00;
> +		xpad->odata[5] = strong / 256;
> +		xpad->odata[6] = weak / 256;
> +		xpad->odata[7] = 0x00;
> +		xpad->odata[8] = 0x00;
> +		xpad->odata[9] = 0x00;
> +		xpad->odata[10] = 0x00;
> +		xpad->odata[11] = 0x00;
> +		xpad->irq_out->transfer_buffer_length = 12;
> +		break;
> +
> +	case XTYPE_XBOXONE:
> +		xpad->odata[0] = 0x09; /* activate rumble */
> +		xpad->odata[1] = 0x08;
> +		xpad->odata[2] = 0x00;
> +		xpad->odata[3] = 0x08; /* continuous effect */
> +		xpad->odata[4] = 0x00; /* simple rumble mode */
> +		xpad->odata[5] = 0x03; /* L and R actuator only */
> +		xpad->odata[6] = 0x00; /* TODO: LT actuator */
> +		xpad->odata[7] = 0x00; /* TODO: RT actuator */
> +		xpad->odata[8] = strong / 256;	/* left actuator */
> +		xpad->odata[9] = weak / 256;	/* right actuator */
> +		xpad->odata[10] = 0x80;	/* length of pulse */
> +		xpad->odata[11] = 0x00;	/* stop period of pulse */
> +		xpad->irq_out->transfer_buffer_length = 12;
> +		break;
> +
> +	default:
> +		dev_dbg(&xpad->dev->dev,
> +			"%s - rumble command sent to unsupported xpad type: %d\n",
> +			__func__, xpad->xtype);
> +		return -EINVAL;
>  	}
>  
> -	return 0;
> +	return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
>  }
>  
>  static int xpad_init_ff(struct usb_xpad *xpad)
> -- 
> 1.9.1
> 

-- 
Dmitry
