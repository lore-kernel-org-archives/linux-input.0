From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 09/15] Input: xpad: handle "present" and "gone" correctly
Date: Sat, 10 Oct 2015 09:42:38 -0700
Message-ID: <20151010164238.GA39573@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-10-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34493 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbJJQml (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2015 12:42:41 -0400
Received: by padhy16 with SMTP id hy16so114575671pad.1
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2015 09:42:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443733046-29610-10-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

Hi Pavel,

On Thu, Oct 01, 2015 at 10:57:20PM +0200, Pavel Rojtberg wrote:
> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> 
> Handle the "a new device is present" message properly by dynamically
> creating the input device at this point in time. This means we now do
> not "preallocate" all 4 devices when a single
> wireless base station is seen. This requires a workqueue as we are in
> interrupt context when we learn about this.
> 
> Also properly disconnect any devices that we are told are removed.
> 
> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 52 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 7d66d77..31bcd78 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -344,8 +344,12 @@ struct usb_xpad {
>  	int xtype;			/* type of xbox device */
>  	unsigned long pad_nr;		/* the order x360 pads were attached */
>  	const char *name;		/* name of the device */
> +	struct work_struct work;	/* init/remove device from callback */
>  };
>  
> +static int xpad_init_input(struct usb_xpad *xpad);
> +static void xpad_deinit_input(struct usb_xpad *xpad);
> +
>  /*
>   *	xpad_process_packet
>   *
> @@ -496,6 +500,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
>  
>  static void xpad_identify_controller(struct usb_xpad *xpad);
>  
> +static void presence_work_function(struct work_struct *work)
> +{
> +	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
> +	int error;
> +
> +	if (xpad->pad_present) {
> +		error = xpad_init_input(xpad);
> +		if (error) {
> +			/* complain only, not much else we can do here */
> +			dev_err(&xpad->dev->dev, "unable to init device\n");
> +		}
> +	} else {
> +		xpad_deinit_input(xpad);
> +	}
> +}
> +
>  /*
>   * xpad360w_process_packet
>   *
> @@ -512,13 +532,16 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
>   */
>  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
>  {
> +	int presence;
> +
>  	/* Presence change */
>  	if (data[0] & 0x08) {
> -		if (data[1] & 0x80) {
> -			xpad->pad_present = 1;
> -			xpad_identify_controller(xpad);
> -		} else
> -			xpad->pad_present = 0;
> +		presence = (data[1] & 0x80) != 0;
> +
> +		if (xpad->pad_present != presence) {
> +			xpad->pad_present = presence;
> +			schedule_work(&xpad->work);
> +		}
>  	}
>  
>  	/* Valid pad data */
> @@ -965,8 +988,6 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>  		return error;
>  	}
>  
> -	xpad_identify_controller(xpad);
> -
>  	return 0;
>  }
>  
> @@ -1123,6 +1144,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
>  	if (error)
>  		goto fail_input_register;
>  
> +	xpad_identify_controller(xpad);
> +
>  	return 0;
>  
>  fail_input_register:
> @@ -1187,6 +1210,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  	xpad->mapping = xpad_device[i].mapping;
>  	xpad->xtype = xpad_device[i].xtype;
>  	xpad->name = xpad_device[i].name;
> +	INIT_WORK(&xpad->work, presence_work_function);
>  
>  	if (xpad->xtype == XTYPE_UNKNOWN) {
>  		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
> @@ -1260,11 +1284,12 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  		xpad->irq_out->transfer_buffer_length = 12;
>  		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>  		mutex_unlock(&xpad->odata_mutex);
> +	} else {
> +		xpad->pad_present = 1;
> +		error = xpad_init_input(xpad);
> +		if (error)
> +			goto fail4;
>  	}
> -	xpad->pad_present = 1;
> -	error = xpad_init_input(xpad);
> -	if (error)
> -		goto fail4;
>  
>  	return 0;
>  
> @@ -1286,7 +1311,8 @@ static void xpad_disconnect(struct usb_interface *intf)
>  {
>  	struct usb_xpad *xpad = usb_get_intfdata (intf);
>  
> -	xpad_deinit_input(xpad);
> +	if (xpad->pad_present)
> +		xpad_deinit_input(xpad);
>  	xpad_deinit_output(xpad);
>  
>  	if (xpad->xtype == XTYPE_XBOX360W) {
> @@ -1297,6 +1323,8 @@ static void xpad_disconnect(struct usb_interface *intf)
>  	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
>  			xpad->idata, xpad->idata_dma);
>  
> +	cancel_work_sync(&xpad->work);
> +

This is too late. You need to stop the IO, then cancel the work and then
see if input device is created or not and destroy it if it is present.
BTW current logic for X360W is broken in this regard as well.

>  	kfree(xpad);
>  
>  	usb_set_intfdata(intf, NULL);
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
