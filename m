From: Florian Echtler <floe@butterbrot.org>
Subject: [RFC] surface-input
Date: Thu, 05 Sep 2013 16:15:37 +0200
Message-ID: <52289209.2070707@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Pumsx9c2rVXStBLUdDKX0BMQD74pWum1O"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:39897 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab3IEOPs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Sep 2013 10:15:48 -0400
Received: from [132.199.142.38] (pc1081206209.uni-regensburg.de [132.199.142.38])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPSA id C82B7C00288
	for <linux-input@vger.kernel.org>; Thu,  5 Sep 2013 16:15:38 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pumsx9c2rVXStBLUdDKX0BMQD74pWum1O
Content-Type: multipart/mixed;
 boundary="------------030900030800070806070508"

This is a multi-part message in MIME format.
--------------030900030800070806070508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,

as mentioned earlier, I'm currently writing a multitouch input driver
for the Pixelsense (formerly Surface 2.0). It's now at a point where I'd
consider it mostly done, but a) I have very limited experience with
kernel drivers and b) there are some additional questions I have, so I'm
attaching the current state of my source code and would like to ask for
your comments.

Open question: it looks like just calling

input_mt_init_slots(poll_dev->input, MAX_CONTACTS, INPUT_MT_DIRECT);

in the initialization routine isn't enough. hid-multitouch doesn't seem
to use any other init commands, though, or did I overlook something?

Are there any other caveats of the input-mt library which I should be
aware of?

Thanks for your input, and best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL

--------------030900030800070806070508
Content-Type: text/plain; charset=UTF-8;
 name="Makefile"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Makefile"

# Assumptions:
# 	This makefile assumes that kernel modules are installed in=20
#	      /lib/modules/'uname -r'/.
#	Should the assumption be incorrect, please use:
#	    make MODULE_ROOT=3D"/path/to/modules/for/your/kernel"
#	to override assumed path

MODULE=3Dsurface-input

srcs :=3D $(MODULE).c
obj-m :=3D $(srcs:%.c=3D%.o)

MODULE_ROOT:=3D /lib/modules/$(shell uname -r)
BUILDDIR   :=3D $(MODULE_ROOT)/build
MODDIR     :=3D $(MODULE_ROOT)/updates
PWD        :=3D $(shell pwd)

override install_targets :=3D $(srcs:%.c=3Dinstall_%)

default:
	$(MAKE) -C $(BUILDDIR) SUBDIRS=3D$(PWD) "obj-m=3D$(obj-m)" modules

=2EPHONY: default install all clean help $(install_targets)

install:
	install -m 644 $(MODULE).ko $(MODDIR)
	depmod -a
	modprobe -r $(MODULE)
	modprobe $(MODULE)

debug:
	@echo
	@echo "srcs=3D"$(srcs)
	@echo "obj-m=3D"$(obj-m)
	@echo "MODULE_ROOT=3D"$(MODULE_ROOT)
	@echo "PWD=3D"$(PWD)
	@echo "install targets: " $(install_targets)
	@echo

clean:
	-rm -rf *.o *.ko $(MODULE)*.mod.c Module.symvers .$(MODULE)* .tmp_versio=
ns modules.order


--------------030900030800070806070508
Content-Type: text/x-chdr;
 name="surface-data.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="surface-data.h"

/*=20
  Surface2.0/SUR40/PixelSense input driver v0.0.1

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

  Copyright (C) 2013 by Florian 'floe' Echtler <floe@butterbrot.org>

  Derived from the USB Skeleton driver 1.1,
  Copyright (C) 2003 Greg Kroah-Hartman (greg@kroah.com)

	Derived from the Apple USB BCM5974 multitouch driver,
	Copyright (C) 2008 Henrik Rydberg (rydberg@euromail.se)
*/

#ifndef _SURFACE_DATA_H_
#define _SURFACE_DATA_H_


#define ID_MICROSOFT 0x045e
#define ID_SURFACE   0x0775

#define VIDEO_RES_X 960
#define VIDEO_RES_Y 540

#define VIDEO_BUFFER_SIZE  VIDEO_RES_X * VIDEO_RES_Y


// read 512 bytes from endpoint 0x86 -> get header + blobs
struct surface_header {

	uint16_t type;  // always 0x0001
	uint16_t count; // count of blobs (if =3D=3D 0: continue prev. packet ID=
)

	uint32_t packet_id;

	uint32_t timestamp; // milliseconds (increases by 16 or 17 each frame)
	uint32_t unknown;   // "epoch?" always 02/03 00 00 00=20

};


struct surface_blob {

	uint16_t blob_id;

	uint8_t action;     // 0x02 =3D enter/exit, 0x03 =3D update (?)=20
	uint8_t unknown;    // always 0x01 or 0x02 (no idea what this is?)

	uint16_t bb_pos_x;  // upper left corner of bounding box
	uint16_t bb_pos_y;

	uint16_t bb_size_x; // size of bounding box
	uint16_t bb_size_y;

	uint16_t pos_x;     // finger tip position
	uint16_t pos_y;

	uint16_t ctr_x;     // centroid position
	uint16_t ctr_y;=20

	uint16_t axis_x;    // somehow related to major/minor axis, mostly:
	uint16_t axis_y;    // axis_x =3D=3D bb_size_y && axis_y =3D=3D bb_size_=
x=20

	float    angle;     // orientation in radians relative to x axis
	uint32_t area;      // size in pixels/pressure (?)

	uint8_t padding[32];
};


// read 512 bytes from endpoint 0x82 -> get header below
// continue reading 16k blocks until header.size bytes read
struct surface_image {
	uint32_t magic;     // "SUBF"
	uint32_t packet_id;
	uint32_t size;      // always 0x0007e900 =3D 960x540
	uint32_t timestamp; // milliseconds (increases by 16 or 17 each frame)
	uint32_t unknown;   // "epoch?" always 02/03 00 00 00=20
};


// read 8 bytes using control message 0xc0,0xb1,0x00,0x00
struct surface_sensors {
	uint16_t temp;
	uint16_t acc_x;
	uint16_t acc_y;
	uint16_t acc_z;
};


#endif // _SURFACE_DATA_H_


--------------030900030800070806070508
Content-Type: text/x-csrc;
 name="surface-input.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="surface-input.c"

/*=20
  Surface2.0/SUR40/PixelSense input driver v0.0.1

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

  Copyright (C) 2013 by Florian 'floe' Echtler <floe@butterbrot.org>

  Derived from the USB Skeleton driver 1.1,
  Copyright (C) 2003 Greg Kroah-Hartman (greg@kroah.com)

	Derived from the Apple USB BCM5974 multitouch driver,
	Copyright (C) 2008 Henrik Rydberg (rydberg@euromail.se)
*/

#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/completion.h>
#include <asm/uaccess.h>
#include <linux/usb.h>
#include <linux/printk.h>
#include <linux/input-polldev.h>
#include <linux/input/mt.h>
#include <linux/usb/input.h>

#include "surface-data.h"

/* version information */
#define DRIVER_VERSION "0.0.1"
#define DRIVER_SHORT   "surface-input"
#define DRIVER_AUTHOR  "Florian 'floe' Echtler <floe@butterbrot.org>"
#define DRIVER_DESC    "Surface2.0/SUR40/PixelSense input driver"

/* vendor and device IDs */
#define ID_MICROSOFT 0x045e
#define ID_SURFACE   0x0775

/* touch data endpoint */
#define TOUCH_ENDPOINT 0x86

/* polling interval (ms) */
#define POLL_INTERVAL 10

/* maximum number of contacts */
#define MAX_CONTACTS 64

/* device ID table */
static const struct usb_device_id surface_table[] =3D {
	{USB_DEVICE(ID_MICROSOFT, ID_SURFACE)}, /* Microsoft Surface 2.0  */
	{}                                      /* terminating null entry */
};

/* control commands */
#define SURFACE_GET_VERSION 0xb0 /* 12 bytes string    */
#define SURFACE_UNKNOWN1    0xb3 /*  5 bytes           */
#define SURFACE_UNKNOWN2    0xc1 /* 24 bytes           */

#define SURFACE_GET_STATE   0xc5 /*  4 bytes state (?) */
#define SURFACE_GET_SENSORS 0xb1 /*  8 bytes sensors   */

/* FIXME: previous version used USB_RECIP_ENDPOINT, may have corrupted ee=
prom? */
#define surface_command(dev, command, index, buffer, size) \
	usb_control_msg (dev->usbdev, usb_rcvctrlpipe (dev->usbdev, 0), command,=
 \
	USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN, 0x00, index, buffer, si=
ze, 1000)

MODULE_DEVICE_TABLE(usb, surface_table);

/* structure to hold all of our device specific stuff */
struct usb_surface {

	struct usb_device *usbdev; /* save the usb device pointer */
	struct usb_interface *interface; /* the interface for this device */
	struct input_polled_dev *input; /* struct for polled input device */

	unsigned char *bulk_in_buffer; /* the buffer to receive data */
	size_t bulk_in_size; /* the maximum bulk packet size */
	__u8 bulk_in_endpointAddr; /* the address of the bulk in endpoint */
	char phys[64];
};

/* initialization routine, called from surface_open */
static int surface_init(struct usb_surface *dev)
{
	int result;
	__u8 buffer[24];

	/* stupidly replay the original MS driver init sequence */
	result =3D surface_command(dev, SURFACE_GET_VERSION, 0x00, buffer, 12 );=

	if (result < 0)
		return result;

	result =3D surface_command(dev, SURFACE_GET_VERSION, 0x01, buffer, 12 );=

	if (result < 0)
		return result;

	result =3D surface_command(dev, SURFACE_GET_VERSION, 0x02, buffer, 12 );=

	if (result < 0)
		return result;

	result =3D surface_command(dev, SURFACE_UNKNOWN2,    0x00, buffer, 24 );=

	if (result < 0)
		return result;

	result =3D surface_command(dev, SURFACE_UNKNOWN1,    0x00, buffer,  5 );=

	if (result < 0)
		return result;

	result =3D surface_command(dev, SURFACE_GET_VERSION, 0x03, buffer, 12 );=


	/* discard the result buffer - no known data inside except=20
	some version strings, maybe extract these sometime..    */

	return result;
}

/*
 * callback routines from input_polled_dev
*/

/* enable the device, polling will now start */
void surface_open(struct input_polled_dev *polldev) {
	struct usb_surface *surface =3D polldev->private;
	pr_info("surface_open");
	surface_init(surface);
}

/* disable device, polling has stopped */
void surface_close(struct input_polled_dev *polldev) {
	/* no known way to stop the device, except to stop polling */
	pr_info("surface_close");
}

/*
 * this function is called when a whole contact has been processed,
 * so that it can assign it to a slot and store the data there
 */
static void report_blob(struct surface_blob *blob, struct input_dev *inpu=
t)
{
	int wide, major, minor;

	int slotnum =3D input_mt_get_slot_by_key(input, blob->blob_id);
	if (slotnum < 0 || slotnum >=3D MAX_CONTACTS)
		return;

	/* FIXME: is this needed for the Pixelsense? */
	/*if ((td->mtclass.quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
		struct input_mt *mt =3D input->mt;
		struct input_mt_slot *slot =3D &mt->slots[slotnum];
		if (input_mt_is_active(slot) &&
				input_mt_is_used(mt, slot))
			return;
	}*/

	input_mt_slot(input, slotnum);
	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
	wide =3D (blob->bb_size_x > blob->bb_size_y);
	major =3D max(blob->bb_size_x, blob->bb_size_y);
	minor =3D min(blob->bb_size_x, blob->bb_size_y);

	input_event(input, EV_ABS, ABS_MT_POSITION_X, blob->pos_x);
	input_event(input, EV_ABS, ABS_MT_POSITION_Y, blob->pos_y);
	input_event(input, EV_ABS, ABS_MT_TOOL_X, blob->ctr_x);
	input_event(input, EV_ABS, ABS_MT_TOOL_Y, blob->ctr_y);
	input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
	input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
	input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
}


/* core function: poll for new input data */
void surface_poll(struct input_polled_dev *polldev) {

	struct usb_surface *surface =3D polldev->private;
	struct input_dev *input =3D polldev->input;
	int result, bulk_read, need_blobs, packet_blobs, i;
	uint32_t packet_id;

	struct surface_header* header =3D (struct surface_header*)(surface->bulk=
_in_buffer);
	struct surface_blob*   inblob =3D (struct surface_blob*)(surface->bulk_i=
n_buffer+sizeof(struct surface_header));

	need_blobs =3D -1;

	pr_info("surface_poll\n");

	do {

		/* perform a blocking bulk read to get data from the device */
		result =3D usb_bulk_msg (surface->usbdev,
			usb_rcvbulkpipe (surface->usbdev, surface->bulk_in_endpointAddr),
			surface->bulk_in_buffer, 512, &bulk_read, 1000);

		pr_info("got %d bytes\n",bulk_read);

		if (result < 0) {=20
			pr_err("error in usb_bulk_read");
			return;
		}

		result =3D bulk_read - sizeof(struct surface_header);

		if (result % sizeof(struct surface_blob) !=3D 0) {
			pr_err("transfer size mismatch");
			return;
		}

		/* first packet? */
		if (need_blobs =3D=3D -1) {
			need_blobs =3D header->count;
			pr_info("expecting %d blobs\n",need_blobs);
			packet_id =3D header->packet_id;
		}

		/* sanity check. when video data is also being retrieved, the packet ID=

		will usually increase in the middle of a series instead of at the end. =
*/
		if (packet_id !=3D header->packet_id)
			pr_warn("packet ID mismatch\n");

		packet_blobs =3D result / sizeof(struct surface_blob);
		pr_info("got %d blobs\n",packet_blobs);

		/* packets always contain at least 4 blobs, even if they are empty */
		if (packet_blobs > need_blobs)
			packet_blobs =3D need_blobs;

		for (i =3D 0; i < packet_blobs; i++) {
			need_blobs--;
			pr_info("got a blob\n");
			report_blob( &(inblob[i]), input );
		}

	}	while (need_blobs > 0);

	input_mt_sync_frame(input);
	input_sync(input);
}

/*
 * power management routines
*/

/* PM operations are nops as this driver does IO only during open() */
/*static int surface_suspend(struct usb_interface *intf, pm_message_t mes=
sage)
{
	return 0;
}

static int surface_resume(struct usb_interface *intf)
{
	return 0;
}*/

/*
 * housekeeping routines
*/

/* clean up all allocated buffers/structs */
static inline void surface_delete(struct usb_surface *surface)
{
	input_free_polled_device(surface->input);
	kfree(surface->bulk_in_buffer);
	kfree(surface);
}

/* check candidate USB interface */
static int surface_probe(struct usb_interface *interface,
				const struct usb_device_id *id)
{
	struct usb_device *usbdev =3D interface_to_usbdev(interface);
	struct usb_surface *surface;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;
	struct input_polled_dev* poll_dev;

	/* check if we really have the right interface */
	iface_desc =3D &interface->altsetting[0];
	if (iface_desc->desc.bInterfaceClass !=3D 0xFF)
		return -ENODEV;

	/* allocate memory for our device state and initialize it */
	surface =3D kzalloc(sizeof(struct usb_surface), GFP_KERNEL);
	poll_dev =3D input_allocate_polled_device();
	surface->input =3D poll_dev;
	if (!surface || !poll_dev)
		return -ENOMEM;

	poll_dev->private =3D surface;
	poll_dev->poll_interval =3D POLL_INTERVAL;
	poll_dev->open  =3D surface_open;
	poll_dev->poll  =3D surface_poll;
	poll_dev->close =3D surface_close;

	poll_dev->input->name =3D "Samsung SUR40";
	usb_to_input_id(usbdev,&(poll_dev->input->id));
	usb_make_path(usbdev, surface->phys, sizeof(surface->phys));
	strlcat(surface->phys, "/input0", sizeof(surface->phys));
	poll_dev->input->phys =3D surface->phys;

	input_mt_init_slots(poll_dev->input, MAX_CONTACTS, INPUT_MT_DIRECT);

	surface->usbdev =3D usbdev;
	surface->interface =3D interface;

	/* use endpoint #4 (0x86) */
	endpoint =3D &iface_desc->endpoint[4].desc;
	if (endpoint->bEndpointAddress =3D=3D TOUCH_ENDPOINT) {
		/* we found a bulk in endpoint */
		surface->bulk_in_size =3D le16_to_cpu(endpoint->wMaxPacketSize);
		surface->bulk_in_endpointAddr =3D endpoint->bEndpointAddress;
		surface->bulk_in_buffer =3D kmalloc(2*surface->bulk_in_size, GFP_KERNEL=
);
		if (!surface->bulk_in_buffer) {
			pr_err("Unable to allocate input buffer.");
			surface_delete(surface);
			return -ENOMEM;
		}
	}

	if (!(surface->bulk_in_endpointAddr)) {
		pr_err("Unable to find bulk-in endpoint.");
		surface_delete(surface);
		return -ENODEV;
	}

	/* we can register the device now, as it is ready */
	usb_set_intfdata(interface, surface);

	if (input_register_polled_device(poll_dev)) {
		pr_err("Unable to register polled input device.");
		surface_delete(surface);
		return -ENODEV;
	}

	dev_info(&interface->dev,"%s now attached\n",DRIVER_DESC);

	return 0;
}

/* unregister device & clean up */
static void surface_disconnect(struct usb_interface *interface)
{
	struct usb_surface *surface =3D usb_get_intfdata(interface);

	input_unregister_polled_device(surface->input);

	usb_set_intfdata(interface, NULL);

	surface_delete(surface);

	dev_info(&interface->dev, "%s now disconnected\n",DRIVER_DESC);
}

/* usb specific object needed to register this driver with the usb subsys=
tem */
static struct usb_driver surface_driver =3D {
	.name =3D DRIVER_SHORT,
	.probe =3D surface_probe,
	.disconnect =3D surface_disconnect,
	/*.suspend =3D surface_suspend,
	.resume =3D surface_resume,*/
	.id_table =3D surface_table,
	/*.supports_autosuspend =3D 1,*/
};

module_usb_driver(surface_driver);

MODULE_AUTHOR(DRIVER_AUTHOR);
MODULE_DESCRIPTION(DRIVER_DESC);
MODULE_LICENSE("GPL");


--------------030900030800070806070508--

--Pumsx9c2rVXStBLUdDKX0BMQD74pWum1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlIokgkACgkQ7CzyshGvatjahwCfSVxzNeWqV6Pj9IK+ekfKCli3
5DgAoPqE5Q326Eiy958AgTcS1wIYqLHB
=GycX
-----END PGP SIGNATURE-----

--Pumsx9c2rVXStBLUdDKX0BMQD74pWum1O--
