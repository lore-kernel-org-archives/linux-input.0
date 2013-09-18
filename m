From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Wed, 18 Sep 2013 12:49:55 -0700
Message-ID: <20130918194955.GB26085@core.coreip.homeip.net>
References: <1378934763-17938-1-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33434 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3IRTt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 15:49:59 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so8714012pac.31
        for <linux-input@vger.kernel.org>; Wed, 18 Sep 2013 12:49:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1378934763-17938-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, rydberg@euromail.se, dh.herrmann@gmail.com

Hi Florian,

On Wed, Sep 11, 2013 at 11:26:03PM +0200, Florian Echtler wrote:
> +
> +	/* allocate memory for our device state and initialize it */
> +	sur40 = kzalloc(sizeof(struct sur40_state), GFP_KERNEL);
> +	poll_dev = input_allocate_polled_device();
> +	if (!sur40 || !poll_dev)
> +		return -ENOMEM;

You are leaking memory here.

> +
> +	/* setup polled input device control struct */
> +	poll_dev->private = sur40;
> +	poll_dev->poll_interval = POLL_INTERVAL;
> +	poll_dev->open = sur40_open;
> +	poll_dev->poll = sur40_poll;
> +	poll_dev->close = sur40_close;
> +
> +	/* setup regular input device struct */
> +	sur40_input_setup(poll_dev->input);
> +
> +	poll_dev->input->name = "Samsung SUR40";
> +	usb_to_input_id(usbdev, &(poll_dev->input->id));
> +	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
> +	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
> +	poll_dev->input->phys = sur40->phys;
> +
> +	sur40->usbdev = usbdev;
> +	sur40->input = poll_dev;
> +
> +	/* use the bulk-in endpoint tested above */
> +	sur40->bulk_in_size = le16_to_cpu(endpoint->wMaxPacketSize);
> +	sur40->bulk_in_epaddr = endpoint->bEndpointAddress;
> +	sur40->bulk_in_buffer = kmalloc(2 * sur40->bulk_in_size, GFP_KERNEL);
> +	if (!sur40->bulk_in_buffer) {
> +		dev_err(&interface->dev, "Unable to allocate input buffer.");
> +		sur40_delete(sur40);
> +		return -ENOMEM;
> +	}
> +
> +	result = input_register_polled_device(poll_dev);
> +	if (result) {
> +		dev_err(&interface->dev,
> +			"Unable to register polled input device.");
> +		sur40_delete(sur40);
> +		return result;
> +	}
> +
> +	/* we can register the device now, as it is ready */
> +	usb_set_intfdata(interface, sur40);
> +	dev_info(&interface->dev, "%s now attached\n", DRIVER_DESC);

dev_dbg() if you must.

> +
> +	return 0;
> +}
> +
> +/* unregister device & clean up */
> +static void sur40_disconnect(struct usb_interface *interface)
> +{
> +	struct sur40_state *sur40 = usb_get_intfdata(interface);
> +
> +	input_unregister_polled_device(sur40->input);
> +
> +	usb_set_intfdata(interface, NULL);
> +
> +	sur40_delete(sur40);
> +
> +	dev_info(&interface->dev, "%s now disconnected\n", DRIVER_DESC);

Here as well.

Thanks.

-- 
Dmitry
