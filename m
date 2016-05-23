From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH v3] input: tablet: add Pegasus Notetaker tablet driver
Date: Mon, 23 May 2016 14:43:59 +0200
Message-ID: <5742FB0F.5070508@posteo.de>
References: <1464003592-24043-1-git-send-email-martink@posteo.de>
 <1464006414.12181.53.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464006414.12181.53.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: dmitry.torokhov@gmail.com, kernel-testers@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 2016-05-23 um 14:26 schrieb Oliver Neukum:
> On Mon, 2016-05-23 at 13:39 +0200, Martin Kepplinger wrote:
> 
>> It's *really* fun to use as an input tablet though! So let's support this
>> for everybody.
> 
> Hi,
> 
> I am afraid there are a few issues.

Thanks for having a look, comments below.

> 
> 1. Why the kernel thread?

I provide switching to the xy tablet mode by pressing a button during
runtime. So usb_control_msg() is called from the thread, not the
interrupt routine.

We don't get in the way of any user app. If we leave that functionality
out, users may have to un- and replug in the device after using
userspace apps that transfer data or the like.

> 2. This driver has questionable power management.

I think I do it how others do it. Suspend/resume works. Anything
specific required here?

thanks!

                             martin

> 
> 	Regards
> 		Oliver
> 
>> +static int pegasus_probe(struct usb_interface *intf,
>> +			 const struct usb_device_id *id)
>> +{
>> +	struct usb_device *dev = interface_to_usbdev(intf);
>> +	struct usb_endpoint_descriptor *endpoint;
>> +	struct pegasus *pegasus;
>> +	struct input_dev *input_dev;
>> +	int error;
>> +	int pipe, maxp;
>> +
>> +	/* we control interface 0 */
>> +	if (intf->cur_altsetting->desc.bInterfaceNumber == 1)
>> +		return -ENODEV;
>> +
>> +	endpoint = &intf->cur_altsetting->endpoint[0].desc;
>> +
>> +	pegasus = kzalloc(sizeof(*pegasus), GFP_KERNEL);
>> +	input_dev = input_allocate_device();
>> +	if (!pegasus || !input_dev) {
>> +		error = -ENOMEM;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	pegasus->usbdev = dev;
>> +	pegasus->dev = input_dev;
>> +
>> +	pegasus->data = usb_alloc_coherent(dev, endpoint->wMaxPacketSize,
>> +					   GFP_KERNEL, &pegasus->data_dma);
>> +	if (!pegasus->data) {
>> +		error = -ENOMEM;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	pegasus->irq = usb_alloc_urb(0, GFP_KERNEL);
>> +	if (!pegasus->irq) {
>> +		error = -ENOMEM;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
>> +	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
>> +	pegasus->data_len = maxp;
>> +
>> +	usb_fill_int_urb(pegasus->irq, dev, pipe, pegasus->data, maxp,
>> +			 pegasus_irq, pegasus, endpoint->bInterval);
>> +
>> +	pegasus->irq->transfer_dma = pegasus->data_dma;
>> +	pegasus->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>> +
>> +	if (dev->manufacturer)
>> +		strlcpy(pegasus->name, dev->manufacturer,
>> +			sizeof(pegasus->name));
>> +
>> +	if (dev->product) {
>> +		if (dev->manufacturer)
>> +			strlcat(pegasus->name, " ", sizeof(pegasus->name));
>> +		strlcat(pegasus->name, dev->product, sizeof(pegasus->name));
>> +	}
>> +
>> +	if (!strlen(pegasus->name))
>> +		snprintf(pegasus->name, sizeof(pegasus->name),
>> +			 "USB Pegasus Device %04x:%04x",
>> +			 le16_to_cpu(dev->descriptor.idVendor),
>> +			 le16_to_cpu(dev->descriptor.idProduct));
>> +
>> +	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
>> +	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
>> +
>> +	usb_set_intfdata(intf, pegasus);
>> +
>> +	input_dev->name = pegasus->name;
>> +	input_dev->phys = pegasus->phys;
>> +	usb_to_input_id(dev, &input_dev->id);
>> +	input_dev->dev.parent = &intf->dev;
>> +
>> +	input_set_drvdata(input_dev, pegasus);
>> +
>> +	input_dev->open = pegasus_open;
>> +	input_dev->close = pegasus_close;
>> +
>> +	__set_bit(EV_ABS, input_dev->evbit);
>> +	__set_bit(EV_KEY, input_dev->evbit);
>> +
>> +	__set_bit(ABS_X, input_dev->absbit);
>> +	__set_bit(ABS_Y, input_dev->absbit);
>> +
>> +	__set_bit(BTN_TOUCH, input_dev->keybit);
>> +	__set_bit(BTN_RIGHT, input_dev->keybit);
>> +	__set_bit(BTN_TOOL_PEN, input_dev->keybit);
>> +
>> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>> +	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>> +
>> +	input_set_abs_params(input_dev, ABS_X, -1500, 1500, 8, 0);
>> +	input_set_abs_params(input_dev, ABS_Y, 1600, 3000, 8, 0);
>> +
>> +	error = input_register_device(pegasus->dev);
>> +	if (error)
>> +		goto err_free_dma;
>> +
>> +	pegasus_thread = kthread_run(pegasus_threadf, pegasus,
>> +				     "pegasus_notetaker_thread");
> 
> Why is that needed?

See comment above.

> 
>> +	if (IS_ERR(pegasus_thread)) {
>> +		error = -ENOMEM;
>> +		goto err_free_dma;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free_dma:
>> +	usb_free_coherent(dev, pegasus->data_len,
>> +			  pegasus->data, pegasus->data_dma);
>> +
>> +	usb_free_urb(pegasus->irq);
>> +err_free_mem:
>> +	kfree(pegasus);
>> +	usb_set_intfdata(intf, NULL);
>> +
>> +	return error;
>> +}
>> +
>> +static void pegasus_disconnect(struct usb_interface *intf)
>> +{
>> +	struct pegasus *pegasus = usb_get_intfdata(intf);
>> +
>> +	input_unregister_device(pegasus->dev);
>> +	if (pegasus_thread) {
>> +		if (kthread_stop(pegasus_thread) == -EINTR)
>> +			dev_err(&pegasus->usbdev->dev,
>> +				"wake_up_proc was never called\n");
>> +	}
>> +
>> +	usb_free_urb(pegasus->irq);
>> +	usb_free_coherent(interface_to_usbdev(intf),
>> +			  pegasus->data_len, pegasus->data,
>> +			  pegasus->data_dma);
>> +	kfree(pegasus);
>> +	usb_set_intfdata(intf, NULL);
>> +}
>> +
>> +static const struct usb_device_id pegasus_ids[] = {
>> +	{ USB_DEVICE(USB_VENDOR_ID_PEGASUSTECH,
>> +		     USB_DEVICE_ID_PEGASUS_NOTETAKER_EN100) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(usb, pegasus_ids);
>> +
>> +static struct usb_driver pegasus_driver = {
>> +	.name		= "pegasus_notetaker",
>> +	.probe		= pegasus_probe,
>> +	.disconnect	= pegasus_disconnect,
>> +	.id_table	= pegasus_ids,
>> +};
>> +
>> +module_usb_driver(pegasus_driver);
>> +
>> +MODULE_AUTHOR("Martin Kepplinger <martink@posteo.de>");
>> +MODULE_DESCRIPTION("Pegasus Mobile Notetaker Pen tablet driver");
>> +MODULE_LICENSE("GPL");
> 
> 
> 
