From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v7] input: tablet: add Pegasus Notetaker tablet driver
Date: Thu, 09 Jun 2016 17:00:29 +0200
Message-ID: <1465484429.17248.13.camel@suse.com>
References: <1464785703-5555-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464785703-5555-1-git-send-email-martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2016-06-01 at 14:55 +0200, Martin Kepplinger wrote:

> It's *really* fun to use as an input tablet though! So let's support this
> for everybody.

Nice job, but a few issues are left. I'll comment in the code.


> +static void pegasus_close(struct input_dev *dev)
> +{
> +	struct pegasus *pegasus = input_get_drvdata(dev);
> +	int autopm_error;
> +
> +	autopm_error = usb_autopm_get_interface(pegasus->intf);

There is no need for this.

> +	usb_kill_urb(pegasus->irq);
> +	cancel_work_sync(&pegasus->init);
> +
> +	if (!autopm_error)
> +		usb_autopm_put_interface(pegasus->intf);
> +}
> +
> +static int pegasus_probe(struct usb_interface *intf,
> +			 const struct usb_device_id *id)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	struct usb_endpoint_descriptor *endpoint;
> +	struct pegasus *pegasus;
> +	struct input_dev *input_dev;
> +	int error;
> +	int pipe, maxp;
> +
> +	/* We control interface 0 */
> +	if (intf->cur_altsetting->desc.bInterfaceNumber == 1)
> +		return -ENODEV;
> +
> +	/* Sanity check that the device has an endpoint */
> +	if (intf->altsetting[0].desc.bNumEndpoints < 1) {
> +		dev_err(&intf->dev, "Invalid number of endpoints\n");
> +		return -EINVAL;
> +	}
> +	endpoint = &intf->cur_altsetting->endpoint[0].desc;
> +
> +	pegasus = kzalloc(sizeof(*pegasus), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!pegasus || !input_dev) {
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	pegasus->usbdev = dev;
> +	pegasus->dev = input_dev;
> +	pegasus->intf = intf;
> +
> +	pegasus->data = usb_alloc_coherent(dev, endpoint->wMaxPacketSize,
> +					   GFP_KERNEL, &pegasus->data_dma);
> +	if (!pegasus->data) {
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	pegasus->irq = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!pegasus->irq) {
> +		error = -ENOMEM;
> +		goto err_free_dma;
> +	}
> +
> +	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
> +	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
> +	pegasus->data_len = maxp;
> +
> +	usb_fill_int_urb(pegasus->irq, dev, pipe, pegasus->data, maxp,
> +			 pegasus_irq, pegasus, endpoint->bInterval);
> +
> +	pegasus->irq->transfer_dma = pegasus->data_dma;
> +	pegasus->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +
> +	if (dev->manufacturer)
> +		strlcpy(pegasus->name, dev->manufacturer,
> +			sizeof(pegasus->name));
> +
> +	if (dev->product) {
> +		if (dev->manufacturer)
> +			strlcat(pegasus->name, " ", sizeof(pegasus->name));
> +		strlcat(pegasus->name, dev->product, sizeof(pegasus->name));
> +	}
> +
> +	if (!strlen(pegasus->name))
> +		snprintf(pegasus->name, sizeof(pegasus->name),
> +			 "USB Pegasus Device %04x:%04x",
> +			 le16_to_cpu(dev->descriptor.idVendor),
> +			 le16_to_cpu(dev->descriptor.idProduct));
> +
> +	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
> +	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
> +
> +	INIT_WORK(&pegasus->init, pegasus_init);
> +
> +	usb_set_intfdata(intf, pegasus);
> +
> +	input_dev->name = pegasus->name;
> +	input_dev->phys = pegasus->phys;
> +	usb_to_input_id(dev, &input_dev->id);
> +	input_dev->dev.parent = &intf->dev;
> +
> +	input_set_drvdata(input_dev, pegasus);
> +
> +	input_dev->open = pegasus_open;
> +	input_dev->close = pegasus_close;
> +
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +
> +	__set_bit(ABS_X, input_dev->absbit);
> +	__set_bit(ABS_Y, input_dev->absbit);
> +
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(BTN_RIGHT, input_dev->keybit);
> +	__set_bit(BTN_TOOL_PEN, input_dev->keybit);
> +
> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> +	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> +
> +	input_set_abs_params(input_dev, ABS_X, -1500, 1500, 8, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 1600, 3000, 8, 0);
> +
> +	pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);

If you need to do this here. It is also needed in reset_resume()

> +	error = input_register_device(pegasus->dev);
> +	if (error)
> +		goto err_free_urb;
> +
> +	return 0;
> +
> +err_free_urb:
> +	usb_free_urb(pegasus->irq);
> +err_free_dma:
> +	usb_free_coherent(dev, pegasus->data_len,
> +			  pegasus->data, pegasus->data_dma);
> +err_free_mem:
> +	input_free_device(input_dev);
> +	kfree(pegasus);
> +	usb_set_intfdata(intf, NULL);
> +
> +	return error;
> +}
> +
> +static void pegasus_disconnect(struct usb_interface *intf)
> +{
> +	struct pegasus *pegasus = usb_get_intfdata(intf);
> +
> +	input_unregister_device(pegasus->dev);
> +
> +	usb_free_urb(pegasus->irq);
> +	usb_free_coherent(interface_to_usbdev(intf),
> +			  pegasus->data_len, pegasus->data,
> +			  pegasus->data_dma);
> +	kfree(pegasus);
> +	usb_set_intfdata(intf, NULL);
> +}
> +
> +static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct pegasus *pegasus = usb_get_intfdata(intf);
> +
> +	mutex_lock(&pegasus->dev->mutex);
> +	usb_kill_urb(pegasus->irq);

You must also stop the scheduled work.

> +	mutex_unlock(&pegasus->dev->mutex);
> +
> +	return 0;
> +}
> +
> +static int pegasus_resume(struct usb_interface *intf)
> +{
> +	struct pegasus *pegasus = usb_get_intfdata(intf);
> +	int retval = 0;
> +
> +	mutex_lock(&pegasus->dev->mutex);
> +	if (pegasus->dev->users && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
> +		retval = -EIO;
> +	mutex_unlock(&pegasus->dev->mutex);
> +
> +	return retval;
> +}
> +
> +static int pegasus_reset_resume(struct usb_interface *intf)
> +{

Either the mode must be set on fresh hardware, or this is unnecessary.

> +	return pegasus_resume(intf);
> +}

	HTH
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
