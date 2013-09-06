From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] surface-input
Date: Fri, 06 Sep 2013 15:25:35 +0200
Message-ID: <5229D7CF.4090401@gmail.com>
References: <52289209.2070707@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5944 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab3IFNZq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Sep 2013 09:25:46 -0400
In-Reply-To: <52289209.2070707@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Florian,

On 05/09/13 16:15, Florian Echtler wrote:
> Hello everyone,
> 
> as mentioned earlier, I'm currently writing a multitouch input driver
> for the Pixelsense (formerly Surface 2.0). It's now at a point where I'd
> consider it mostly done, but a) I have very limited experience with
> kernel drivers and b) there are some additional questions I have, so I'm
> attaching the current state of my source code and would like to ask for
> your comments.

Thanks for sharing this with us.

I will not do a proper review right now (just coming back from some days off, so I am quickly emptying my mail box).

Some generic comments:
- please always inline the code in the message, it is *much* easier to review and comment it
- please directly use a patch format: if the code is good, Dmitry can take it directly through his tree
- add the following people for further submissions:
  * Henrik - multitouch maintainer in the kernel, and I'm sure he will be happy to see this stuff
  * Dmitry - input maintainer, the driver will go through his tree, so it's better to let him know as soon as possible of the different discussions.
- please stick to the kernel formatting guidelines (without orders: do not use C99-style ("// ..."), do not mix tabs and spaces, stick to 80 columns, etc..). The whole documentation is in Documentation/CodingStyle, and use the script scripts/checkpatch.pl to validate most of these.
- I don't think a separate ".h" will be accepted as the declarations will not be used outside of the driver. Just merge the header on top of you .c file.

> 
> Open question: it looks like just calling
> 
> input_mt_init_slots(poll_dev->input, MAX_CONTACTS, INPUT_MT_DIRECT);
> 
> in the initialization routine isn't enough. hid-multitouch doesn't seem
> to use any other init commands, though, or did I overlook something?
> 
> Are there any other caveats of the input-mt library which I should be
> aware of?

You need to also set up the different axes (ABS_MT_POSITION_X and others) before calling input_mt_init_slots(). See setup_events_to_report() in bcm5974.c for an example.

> 
> Thanks for your input, and best regards, Florian
> 

Few comments inlined:

> /* 

>   Surface2.0/SUR40/PixelSense input driver v0.0.1

> 

>   This program is free software; you can redistribute it and/or

>   modify it under the terms of the GNU General Public License as

>   published by the Free Software Foundation; either version 2 of

>   the License, or (at your option) any later version.

> 

>   Copyright (C) 2013 by Florian 'floe' Echtler <floe@butterbrot.org>

> 

>   Derived from the USB Skeleton driver 1.1,

>   Copyright (C) 2003 Greg Kroah-Hartman (greg@kroah.com)

> 

> 	Derived from the Apple USB BCM5974 multitouch driver,

> 	Copyright (C) 2008 Henrik Rydberg (rydberg@euromail.se)

> */

> 

>[snipped]
> 

> /*

>  * this function is called when a whole contact has been processed,

>  * so that it can assign it to a slot and store the data there

>  */

> static void report_blob(struct surface_blob *blob, struct input_dev *input)

> {

> 	int wide, major, minor;

> 

> 	int slotnum = input_mt_get_slot_by_key(input, blob->blob_id);

> 	if (slotnum < 0 || slotnum >= MAX_CONTACTS)

> 		return;

> 

> 	/* FIXME: is this needed for the Pixelsense? */


I doubt. This was required in hid-multitouch because we sometimes have "blobs" without valuable information. So we drop them.
Here it looks like each blob contains information, so it should be fine without this.

> 	/*if ((td->mtclass.quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {

> 		struct input_mt *mt = input->mt;

> 		struct input_mt_slot *slot = &mt->slots[slotnum];

> 		if (input_mt_is_active(slot) &&

> 				input_mt_is_used(mt, slot))

> 			return;

> 	}*/

> 

> 	input_mt_slot(input, slotnum);

> 	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);


looks like you never release the touch... :(
See below.

> 	wide = (blob->bb_size_x > blob->bb_size_y);

> 	major = max(blob->bb_size_x, blob->bb_size_y);

> 	minor = min(blob->bb_size_x, blob->bb_size_y);

> 

> 	input_event(input, EV_ABS, ABS_MT_POSITION_X, blob->pos_x);

> 	input_event(input, EV_ABS, ABS_MT_POSITION_Y, blob->pos_y);

> 	input_event(input, EV_ABS, ABS_MT_TOOL_X, blob->ctr_x);

> 	input_event(input, EV_ABS, ABS_MT_TOOL_Y, blob->ctr_y);

> 	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);

> 	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);

> 	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);

> }

> 

> 
[snipped]
> 

> /* check candidate USB interface */

> static int surface_probe(struct usb_interface *interface,

> 				const struct usb_device_id *id)

> {

> 	struct usb_device *usbdev = interface_to_usbdev(interface);

> 	struct usb_surface *surface;

> 	struct usb_host_interface *iface_desc;

> 	struct usb_endpoint_descriptor *endpoint;

> 	struct input_polled_dev* poll_dev;

> 

> 	/* check if we really have the right interface */

> 	iface_desc = &interface->altsetting[0];

> 	if (iface_desc->desc.bInterfaceClass != 0xFF)

> 		return -ENODEV;

> 

> 	/* allocate memory for our device state and initialize it */

> 	surface = kzalloc(sizeof(struct usb_surface), GFP_KERNEL);

> 	poll_dev = input_allocate_polled_device();

> 	surface->input = poll_dev;

> 	if (!surface || !poll_dev)

> 		return -ENOMEM;

> 

> 	poll_dev->private = surface;

> 	poll_dev->poll_interval = POLL_INTERVAL;

> 	poll_dev->open  = surface_open;

> 	poll_dev->poll  = surface_poll;

> 	poll_dev->close = surface_close;

> 

> 	poll_dev->input->name = "Samsung SUR40";

> 	usb_to_input_id(usbdev,&(poll_dev->input->id));

> 	usb_make_path(usbdev, surface->phys, sizeof(surface->phys));

> 	strlcat(surface->phys, "/input0", sizeof(surface->phys));

> 	poll_dev->input->phys = surface->phys;

> 

> 	input_mt_init_slots(poll_dev->input, MAX_CONTACTS, INPUT_MT_DIRECT);


If the device always reports actual touches and discards the release information, you may need to use the flag INPUT_MT_DROP_UNUSED.

> 

> 	surface->usbdev = usbdev;

> 	surface->interface = interface;

> 

> 	/* use endpoint #4 (0x86) */

> 	endpoint = &iface_desc->endpoint[4].desc;

> 	if (endpoint->bEndpointAddress == TOUCH_ENDPOINT) {

> 		/* we found a bulk in endpoint */

> 		surface->bulk_in_size = le16_to_cpu(endpoint->wMaxPacketSize);

> 		surface->bulk_in_endpointAddr = endpoint->bEndpointAddress;

> 		surface->bulk_in_buffer = kmalloc(2*surface->bulk_in_size, GFP_KERNEL);

> 		if (!surface->bulk_in_buffer) {

> 			pr_err("Unable to allocate input buffer.");

> 			surface_delete(surface);

> 			return -ENOMEM;

> 		}

> 	}

> 

> 	if (!(surface->bulk_in_endpointAddr)) {

> 		pr_err("Unable to find bulk-in endpoint.");

> 		surface_delete(surface);

> 		return -ENODEV;

> 	}

> 

> 	/* we can register the device now, as it is ready */

> 	usb_set_intfdata(interface, surface);

> 

> 	if (input_register_polled_device(poll_dev)) {

> 		pr_err("Unable to register polled input device.");

> 		surface_delete(surface);

> 		return -ENODEV;

> 	}

> 

> 	dev_info(&interface->dev,"%s now attached\n",DRIVER_DESC);

> 

> 	return 0;

> }

> 

> [snipped]
>
> /* usb specific object needed to register this driver with the usb subsystem */

> static struct usb_driver surface_driver = {

> 	.name = DRIVER_SHORT,

> 	.probe = surface_probe,

> 	.disconnect = surface_disconnect,

> 	/*.suspend = surface_suspend,

> 	.resume = surface_resume,*/


if they are commented, they are not required, so just drop it :)

> 	.id_table = surface_table,

> 	/*.supports_autosuspend = 1,*/


ditto

> };

> 

> module_usb_driver(surface_driver);

> 

> MODULE_AUTHOR(DRIVER_AUTHOR);

> MODULE_DESCRIPTION(DRIVER_DESC);

> MODULE_LICENSE("GPL");



Cheers,
Benjamin
