From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: USB vulnerabilities
Date: Sat, 30 Jul 2016 18:14:43 -0700
Message-ID: <20160731011443.GA22515@dtor-ws>
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
 <20160728174848.GA16852@dtor-ws>
 <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
 <2fd29934-03ac-b67c-a644-07aebbfe8aff@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34607 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbcGaB2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2016 21:28:07 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so7434731pac.1
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2016 18:28:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2fd29934-03ac-b67c-a644-07aebbfe8aff@cisco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rosie Hall <roswest@cisco.com>, abagde1@gmail.com
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>

Hi Rosie, Anirudh,

On Fri, Jul 29, 2016 at 08:48:01PM -0400, Rosie Hall wrote:
> Dmitry,
> 
> Attached are the patches Anirudh created.  Also, I have added him to the
> thread if you have any questions or comments for him.
> 
> Rosie

...


> --- a/drivers/input/joystick/iforce/iforce-usb.c	2016-07-29 15:02:47.602630504 -0400
> +++ b/drivers/input/joystick/iforce/iforce-usb.c	2016-07-29 15:02:32.946812336 -0400
> @@ -135,12 +135,23 @@
>  {
>  	struct usb_device *dev = interface_to_usbdev(intf);
>  	struct usb_host_interface *interface;
> -	struct usb_endpoint_descriptor *epirq, *epout;
> +	struct usb_endpoint_descriptor *epirq = NULL, *epout = NULL;
>  	struct iforce *iforce;
> -	int err = -ENOMEM;
> +	int i, err = -ENOMEM;
>  
>  	interface = intf->cur_altsetting;
>  
> +	for (i = 0; i < interface->desc.bNumEndpoints; i++) {
> +		if (!epirq &&
> +		    usb_endpoint_dir_in(&interface->endpoint[i].desc))
> +			epirq = &interface->endpoint[i].desc;
> +		if (!epout &&
> +		    usb_endpoint_dir_out(&interface->endpoint[i].desc))
> +			epout = &interface->endpoint[i].desc;
> +	}
> +	if (!epirq || !epout)
> +		return -ENODEV;
> +
>  	epirq = &interface->endpoint[0].desc;
>  	epout = &interface->endpoint[1].desc;
>  


The iforce patch looks good, but I need "Signed-off-by" from Anirudh for
me to apply it. Please see Documentation/SubmittingPatches. 


>  
> -static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
> +static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt,
> +			   unsigned int len)

I do not think we need to pass the length to the readers: we know what
protocol we are dealing with and we can simply use NEXIO_BUFSIZE.

>  {
>  	struct nexio_touch_packet *packet = (void *) pkt;
>  	struct nexio_priv *priv = usbtouch->priv;
> @@ -977,6 +996,11 @@
>  	if ((pkt[0] & 0xe0) != 0xe0)
>  		return 0;
>  
> +	if (data_len > len)
> +		data_len = len;
> +	if (x_len + y_len > data_len)
> +		return 0;

We have more adjustments to x_len and data_len below, so maybe we
should move these new checks there as well?
 
> +
>  	if (data_len > 0xff)
>  		data_len -= 0x100;
>  	if (x_len > 0xff)

Thanks.

-- 
Dmitry
