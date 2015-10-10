From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 12/15] Input: xpad: replace mutex by spinlock
Date: Sat, 10 Oct 2015 11:10:38 -0700
Message-ID: <20151010181038.GJ39573@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-13-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33274 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbJJSKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2015 14:10:42 -0400
Received: by pacex6 with SMTP id ex6so116277739pac.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2015 11:10:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443733046-29610-13-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Thu, Oct 01, 2015 at 10:57:23PM +0200, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> since we cannot use mutexes in xpad_play_effect.
> see: http://www.spinics.net/lists/linux-input/msg40242.html

This seems to be a fixup to an earlier patch that is not in mainline.
Please fold it into the patch introducing the problem.

> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 5eec515..1fd2e23 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -333,7 +333,7 @@ struct usb_xpad {
>  	int irq_out_active;		/* we must not use an active URB */
>  	unsigned char *odata;		/* output data */
>  	dma_addr_t odata_dma;
> -	struct mutex odata_mutex;
> +	spinlock_t odata_lock;
>  
>  #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
>  	struct xpad_led *led;
> @@ -752,7 +752,7 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
>  		goto fail1;
>  	}
>  
> -	mutex_init(&xpad->odata_mutex);
> +	spin_lock_init(&xpad->odata_lock);
>  
>  	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
>  	if (!xpad->irq_out) {
> @@ -800,13 +800,15 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
>  	__u16 weak;
>  	int retval;
>  
> +	unsigned long flags;
> +
>  	if (effect->type != FF_RUMBLE)
>  		return 0;
>  
>  	strong = effect->u.rumble.strong_magnitude;
>  	weak = effect->u.rumble.weak_magnitude;
>  
> -	mutex_lock(&xpad->odata_mutex);
> +	spin_lock_irqsave(&xpad->odata_lock, flags);
>  
>  	switch (xpad->xtype) {
>  	case XTYPE_XBOX:
> @@ -864,7 +866,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
>  		break;
>  
>  	default:
> -		mutex_unlock(&xpad->odata_mutex);
> +		spin_unlock_irqrestore(&xpad->odata_lock, flags);
>  		dev_dbg(&xpad->dev->dev,
>  			"%s - rumble command sent to unsupported xpad type: %d\n",
>  			__func__, xpad->xtype);
> @@ -880,7 +882,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
>  				__func__);
>  	}
>  
> -	mutex_unlock(&xpad->odata_mutex);
> +	spin_unlock_irqrestore(&xpad->odata_lock, flags);
>  
>  	return retval;
>  }
> @@ -930,9 +932,11 @@ struct xpad_led {
>   */
>  static void xpad_send_led_command(struct usb_xpad *xpad, int command)
>  {
> +	unsigned long flags;
> +
>  	command %= 16;
>  
> -	mutex_lock(&xpad->odata_mutex);
> +	spin_lock_irqsave(&xpad->odata_lock, flags);
>  
>  	switch (xpad->xtype) {
>  	case XTYPE_XBOX360:
> @@ -965,7 +969,7 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
>  		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
>  				__func__);
>  
> -	mutex_unlock(&xpad->odata_mutex);
> +	spin_unlock_irqrestore(&xpad->odata_lock, flags);
>  }
>  
>  /*
> @@ -1054,6 +1058,8 @@ static int xpad_open(struct input_dev *dev)
>  	struct usb_xpad *xpad = input_get_drvdata(dev);
>  	int retval;
>  
> +	unsigned long flags;
> +
>  	/* URB was submitted in probe */
>  	if (xpad->xtype == XTYPE_XBOX360W)
>  		return 0;
> @@ -1063,13 +1069,13 @@ static int xpad_open(struct input_dev *dev)
>  		return -EIO;
>  
>  	if (xpad->xtype == XTYPE_XBOXONE) {
> -		mutex_lock(&xpad->odata_mutex);
> +		spin_lock_irqsave(&xpad->odata_lock, flags);
>  		/* Xbox one controller needs to be initialized. */
>  		xpad->odata[0] = 0x05;
>  		xpad->odata[1] = 0x20;
>  		xpad->irq_out->transfer_buffer_length = 2;
>  		retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
> -		mutex_unlock(&xpad->odata_mutex);
> +		spin_unlock_irqrestore(&xpad->odata_lock, flags);
>  		return retval;
>  	}
>  
> @@ -1213,6 +1219,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  	int ep_irq_in_idx;
>  	int i, error;
>  
> +	unsigned long flags;
> +
>  	for (i = 0; xpad_device[i].idVendor; i++) {
>  		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
>  		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
> @@ -1314,7 +1322,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  		 * adapter has been plugged in, as it won't automatically
>  		 * send us info about the controllers.
>  		 */
> -		mutex_lock(&xpad->odata_mutex);
> +		spin_lock_irqsave(&xpad->odata_lock, flags);
>  		xpad->odata[0] = 0x08;
>  		xpad->odata[1] = 0x00;
>  		xpad->odata[2] = 0x0F;
> @@ -1336,7 +1344,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  			dev_dbg(&xpad->dev->dev,
>  				"%s - dropped, irq_out is active\n", __func__);
>  
> -		mutex_unlock(&xpad->odata_mutex);
> +		spin_unlock_irqrestore(&xpad->odata_lock, flags);
>  	} else {
>  		xpad->pad_present = 1;
>  		error = xpad_init_input(xpad);
> -- 
> 1.9.1
> 

-- 
Dmitry
