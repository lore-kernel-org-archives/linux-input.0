From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2.6.38] xpad: fix for player indicator and rumble support
Date: Mon, 16 May 2011 12:37:57 -0700
Message-ID: <20110516193757.GA18110@core.coreip.homeip.net>
References: <201105141929.00404.kode54@morbo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53749 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1EPTiD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 15:38:03 -0400
Received: by pvg12 with SMTP id 12so2244922pvg.19
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 12:38:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201105141929.00404.kode54@morbo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Moeller <kode54@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Chris,

On Sat, May 14, 2011 at 07:29:00PM -0700, Chris Moeller wrote:
> 1) It removes the bulk send interface and replaces it with a permanent instance of the send interface, which fixes sending LED commands to XBox360 Wireless Controllers, including the initial player number indicator so the light ring will stop flashing endlessly.
> 2) It implements rumble support for XBox360 Wireless Controllers.
> 

Thank you for the patch, please find some comments below.


> Signed-off-by: Chris Moeller <kode54@gmail.com>
> 
> ---
> 
> I could not separate the two features into different patches because the rumble support change depends on initialization and shutdown changes that are necessary for both features.
> 

It is OK if patches are dependent upon each other. In this case I'd
recommend adding XBox360 Wireless rumble first, keeping the rest of the
driver structure, and then reworking LED support, which requires more
changes.

> Resending this patch which KMail managed to munge because I did not know that it line wraps to fit the composer window regardless of the line wrapping setting. Let's see if a maximized window on 1920x1080 is big enough to get this out without wrapping anything, shall we?
> 
> I'm not sure if it matters, but I found the documentation necessary to implement the packet for XBox360 Wireless Controller rumble support in the source code to the drivers here:
> 
> http://www.katch.ne.jp/~morii/driver/x360wc/index.html
> 
> Neither the page nor the documentation included with the driver or source code, nor the source code itself, make any mention of a license. Does this matter much in the case of deriving knowledge of a single 12 byte data structure?
> 

As long as the code was not used I think this should be OK.

> --- linux/drivers/input/joystick/xpad.c.orig	2011-03-14 18:20:32.000000000 -0700
> +++ linux/drivers/input/joystick/xpad.c	2011-05-14 18:41:08.000000000 -0700
> @@ -250,20 +250,17 @@ struct usb_xpad {
>  	struct usb_device *udev;	/* usb device */
>  
>  	int pad_present;
> +	
> +	int interface_number;
>  
>  	struct urb *irq_in;		/* urb for interrupt in report */
>  	unsigned char *idata;		/* input data */
>  	dma_addr_t idata_dma;
>  
> -	struct urb *bulk_out;
> -	unsigned char *bdata;
> -
> -#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
>  	struct urb *irq_out;		/* urb for interrupt out report */
>  	unsigned char *odata;		/* output data */
>  	dma_addr_t odata_dma;
>  	struct mutex odata_mutex;
> -#endif
>  
>  #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
>  	struct xpad_led *led;
> @@ -432,13 +429,15 @@ static void xpad360_process_packet(struc
>   *
>   */
>  
> +static void xpad_send_led_command(struct usb_xpad *xpad, int command, int mutex);
> +
>  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
>  {
>  	/* Presence change */
>  	if (data[0] & 0x08) {
>  		if (data[1] & 0x80) {
>  			xpad->pad_present = 1;
> -			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
> +			xpad_send_led_command(xpad, 0x42 + ((xpad->interface_number / 2) & 3), 0);

I'd prefer the "command" calculation be hidden in
xpad_send_led_command(), i.e. it should accept led number and figure out
the proper command byte based on device type.

>  		} else
>  			xpad->pad_present = 0;
>  	}
> @@ -492,24 +491,6 @@ exit:
>  		     __func__, retval);
>  }
>  
> -static void xpad_bulk_out(struct urb *urb)
> -{
> -	switch (urb->status) {
> -	case 0:
> -		/* success */
> -		break;
> -	case -ECONNRESET:
> -	case -ENOENT:
> -	case -ESHUTDOWN:
> -		/* this urb is terminated, clean up */
> -		dbg("%s - urb shutting down with status: %d", __func__, urb->status);
> -		break;
> -	default:
> -		dbg("%s - nonzero urb status received: %d", __func__, urb->status);
> -	}
> -}
> -
> -#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
>  static void xpad_irq_out(struct urb *urb)
>  {
>  	int retval, status;
> @@ -545,9 +526,6 @@ static int xpad_init_output(struct usb_i
>  	struct usb_endpoint_descriptor *ep_irq_out;
>  	int error;
>  
> -	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
> -		return 0;
> -
>  	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
>  					 GFP_KERNEL, &xpad->odata_dma);
>  	if (!xpad->odata) {
> @@ -579,23 +557,15 @@ static int xpad_init_output(struct usb_i
>  
>  static void xpad_stop_output(struct usb_xpad *xpad)
>  {
> -	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX)
> -		usb_kill_urb(xpad->irq_out);
> +	usb_kill_urb(xpad->irq_out);
>  }
>  
>  static void xpad_deinit_output(struct usb_xpad *xpad)
>  {
> -	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX) {
> -		usb_free_urb(xpad->irq_out);
> -		usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
> -				xpad->odata, xpad->odata_dma);
> -	}
> +	usb_free_urb(xpad->irq_out);
> +	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
> +			xpad->odata, xpad->odata_dma);
>  }
> -#else
> -static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad) { return 0; }
> -static void xpad_deinit_output(struct usb_xpad *xpad) {}
> -static void xpad_stop_output(struct usb_xpad *xpad) {}
> -#endif
>  
>  #ifdef CONFIG_JOYSTICK_XPAD_FF
>  static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
> @@ -632,6 +602,23 @@ static int xpad_play_effect(struct input
>  
>  			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
>  
> +		case XTYPE_XBOX360W:
> +			xpad->odata[0] = 0x00;
> +			xpad->odata[1] = 0x01;
> +			xpad->odata[2] = 0x0F;
> +			xpad->odata[3] = 0xC0;
> +			xpad->odata[4] = 0x00;
> +			xpad->odata[5] = strong / 256;
> +			xpad->odata[6] = weak / 256;
> +			xpad->odata[7] = 0x00;
> +			xpad->odata[8] = 0x00;
> +			xpad->odata[9] = 0x00;
> +			xpad->odata[10] = 0x00;
> +			xpad->odata[11] = 0x00;
> +			xpad->irq_out->transfer_buffer_length = 12;
> +
> +			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
> +
>  		default:
>  			dbg("%s - rumble command sent to unsupported xpad type: %d",
>  				__func__, xpad->xtype);
> @@ -644,7 +631,7 @@ static int xpad_play_effect(struct input
>  
>  static int xpad_init_ff(struct usb_xpad *xpad)
>  {
> -	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
> +	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX && xpad->xtype != XTYPE_XBOX360W)

This should probably be:

	if (xpad->xtype == XTYPE_UNKNOWN)

>  		return 0;
>  
>  	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
> @@ -665,16 +652,33 @@ struct xpad_led {
>  	struct usb_xpad *xpad;
>  };
>  
> -static void xpad_send_led_command(struct usb_xpad *xpad, int command)
> +static void xpad_send_led_command(struct usb_xpad *xpad, int command, int mutex)
>  {
>  	if (command >= 0 && command < 14) {
> -		mutex_lock(&xpad->odata_mutex);
> +		if (mutex) mutex_lock(&xpad->odata_mutex);

No, this conditional locking will not do. What happens if
xpad_send_led_command() gets called from both xpad360w_process_packet()
and xpad_led_set()? There is also bigger problem - we are using the same
URB/buffers as FF playback so we need to make sure we do not stomp on
each other toes.

Thanks.

-- 
Dmitry
