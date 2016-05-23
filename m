From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v3] input: tablet: add Pegasus Notetaker tablet driver
Date: Mon, 23 May 2016 14:26:54 +0200
Message-ID: <1464006414.12181.53.camel@suse.com>
References: <1464003592-24043-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464003592-24043-1-git-send-email-martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 2016-05-23 at 13:39 +0200, Martin Kepplinger wrote:

> It's *really* fun to use as an input tablet though! So let's support this
> for everybody.

Hi,

I am afraid there are a few issues.

1. Why the kernel thread?
2. This driver has questionable power management.

	Regards
		Oliver

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
> +	/* we control interface 0 */
> +	if (intf->cur_altsetting->desc.bInterfaceNumber == 1)
> +		return -ENODEV;
> +
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
> +		goto err_free_mem;
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
> +	error = input_register_device(pegasus->dev);
> +	if (error)
> +		goto err_free_dma;
> +
> +	pegasus_thread = kthread_run(pegasus_threadf, pegasus,
> +				     "pegasus_notetaker_thread");

Why is that needed?

> +	if (IS_ERR(pegasus_thread)) {
> +		error = -ENOMEM;
> +		goto err_free_dma;
> +	}
> +
> +	return 0;
> +
> +err_free_dma:
> +	usb_free_coherent(dev, pegasus->data_len,
> +			  pegasus->data, pegasus->data_dma);
> +
> +	usb_free_urb(pegasus->irq);
> +err_free_mem:
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
> +	if (pegasus_thread) {
> +		if (kthread_stop(pegasus_thread) == -EINTR)
> +			dev_err(&pegasus->usbdev->dev,
> +				"wake_up_proc was never called\n");
> +	}
> +
> +	usb_free_urb(pegasus->irq);
> +	usb_free_coherent(interface_to_usbdev(intf),
> +			  pegasus->data_len, pegasus->data,
> +			  pegasus->data_dma);
> +	kfree(pegasus);
> +	usb_set_intfdata(intf, NULL);
> +}
> +
> +static const struct usb_device_id pegasus_ids[] = {
> +	{ USB_DEVICE(USB_VENDOR_ID_PEGASUSTECH,
> +		     USB_DEVICE_ID_PEGASUS_NOTETAKER_EN100) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(usb, pegasus_ids);
> +
> +static struct usb_driver pegasus_driver = {
> +	.name		= "pegasus_notetaker",
> +	.probe		= pegasus_probe,
> +	.disconnect	= pegasus_disconnect,
> +	.id_table	= pegasus_ids,
> +};
> +
> +module_usb_driver(pegasus_driver);
> +
> +MODULE_AUTHOR("Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>");
> +MODULE_DESCRIPTION("Pegasus Mobile Notetaker Pen tablet driver");
> +MODULE_LICENSE("GPL");
