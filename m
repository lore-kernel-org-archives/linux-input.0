From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: calibrating a hid device
Date: Mon, 24 May 2010 18:54:45 -0400
Message-ID: <4BFB03B5.5030404@seas.upenn.edu>
References: <4BFADD60.7020901@seas.upenn.edu> <alpine.LNX.2.00.1005242216410.28092@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030903000500000709090608"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:51996 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab0EXWz0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 18:55:26 -0400
In-Reply-To: <alpine.LNX.2.00.1005242216410.28092@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, linux-usb@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is a multi-part message in MIME format.
--------------030903000500000709090608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/24/10 16:20, Jiri Kosina wrote:
> On Mon, 24 May 2010, Rafi Rubin wrote:
> 
>> I've written a calibration tool for my touch screen that works well from user
>> space (just sends a few commands over usb telling the digitizer to recalibrate
>> and reset itself).  I've been running that with the ntrig and usbhid modules
>> unloaded.
>>
>> Now I'm trying to translate that to something in the kernel which I can run just
>> by poking a sysfs node.  However as I sort of expected, it doesn't actually work
>> quite right.  I've been seeing something like this:
>>
>> - From user space:
>>   S Ii:3:002:2 -115:2 94 <
>>   C Ii:3:002:2 0:2 94 = 033fbc07 0000a014 f012ce01 68010100 000c0701 00000000
>> 00fa0096 00000b00
>>
>> kernel space:
>>   S Ii:3:002:2 -115:2 94 <
>>   C Ii:3:002:2 -2:2 0
>>
>> What sort of calls should I wrap the calibration code with?
> 
> And what exactly are you doing from the sysfs-triggered code? I'd guess 
> that simply calling usb_control_msg() should be enough, but without 
> actually seeing the working userspace version and its (non-working) 
> kernel-side counterpart, it's really a little bit difficult to tell.
> 
>> Also, the process seems to involve telling the digitizer to go off and run
>> calibration, and then interrupting it after a while.  I've been using a number
>> of microseconds dumped to the sysfs node for that.  Is there any harm in using
>> "msleep(val);"?
> 
> Depends on the context. If called from context that can safely sleep, it's 
> fine.
> 

Ok, pardon that excessive attachments.  Attached is a snip of the kernel code,
just the sysfs function, the user space equivalent, and logs of both (with the
time stamps cropped out for comparison.

Also please put on slop code filter glasses before reading the code, I hold no
responsibility to damaged eyes or loss of sanity.  It will be cleaned up, later.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkv7A7MACgkQwuRiAT9o609u/wCeO7LWUUyqr/wvbAIawpxVl5Dg
UNAAn3UYhBbaJxpTnzD+r1iM6jpopx7t
=TtOJ
-----END PGP SIGNATURE-----

--------------030903000500000709090608
Content-Type: text/x-csrc;
 name="kernel_snip.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kernel_snip.c"

static ssize_t set_mode(struct device *dev,
			       struct device_attribute *attr,
			       const char *buf, size_t count)
{
	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
	struct usb_device *udev = hid_to_usb_dev(hdev);
	unsigned long val;
	int ret;
	unsigned char data[2] = {0,0};
	__u16 value = 0x402;
	__u16 index = 0x100;


	if (strict_strtoul(buf, 0, &val))
		return -EINVAL;

	if (val > 3)
		return -EINVAL;

	data[0] = (unsigned char) val;

	ret = usb_control_msg(udev, usb_sndctrlpipe(udev,0),
			0xf, 0x40, value, index, data, 2, 1000);

	return count;
}

static DEVICE_ATTR(mode, S_IWUSR, NULL, set_mode);

static ssize_t run_calibration(struct device *dev,
			       struct device_attribute *attr,
			       const char *buf, size_t count)
{
	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
	struct usb_device *udev = hid_to_usb_dev(hdev);
	unsigned long val;
	int ret;
	unsigned char data[94];
	int actual_length;


	if (strict_strtoul(buf, 0, &val))
		return -EINVAL;

	/* Co */
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x01, 0x00, 1, 0, data,0, 1000);
	msleep(val);
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x0a, 0x21, 0, 1, data,0, 1000);
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x0a, 0x21, 0, 0, data,0, 1000);

	/* Ii */
	ret = usb_interrupt_msg(udev, usb_rcvintpipe(udev,2), data, 94, &actual_length, 1000);
	/*
	ret = usb_interrupt_msg(udev, usb_rcvintpipe(udev,0)
			        void *data, int len, int *actual_length, int timeout);
*/

	/* Ci */
	ret = usb_control_msg (udev, usb_rcvctrlpipe(udev,0), 0x01, 0xa1, 0x030b, 1, data,4, 1000);
	
	/* Co */
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x0a, 0x21, 0, 0, data,0, 1000);
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x03, 0x00, 1, 0, data,0, 1000);
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x01, 0x00, 1, 0, data,0, 1000);
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x0a, 0x21, 0, 0, data,0, 1000);
	ret = usb_control_msg (udev, usb_sndctrlpipe(udev,0), 0x0a, 0x21, 0, 1, data,0, 1000);
	
	/* Ii */
	ret = usb_interrupt_msg(udev, usb_rcvintpipe(udev,2), data, 94, &actual_length, 1000);
	/* Ci */
	ret = usb_control_msg (udev, usb_rcvctrlpipe(udev,0), 0x01, 0xa1, 0x0311, 1, data,4, 1000);

//	ret = usb_control_msg(udev, usb_sndctrlpipe(udev,0), 0xf, 0x40, value, index, data, 2, 1000);
//	      usb_control_msg(usb_handle,                    0x40, 0xf, value, index, buf, bytes, 1000);


	return count;
}

static DEVICE_ATTR(calibrate, S_IWUSR, NULL, run_calibration);



--------------030903000500000709090608
Content-Type: text/x-csrc;
 name="calib.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="calib.c"

/*
 *  HID driver for N-Trig touchscreens
 *
 *  Copyright (c) 2009-2010 Rafi Rubin
 *  Copyright (c) 2009-2010 Stephane Chatty
 *
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <usb.h>



static struct usb_device **
device_init ()
{
  struct usb_bus *usb_bus;
  struct usb_device *dev;

  /* calloc to pre-zero */
  struct usb_device ** out = (struct usb_device **)calloc(8,
		  sizeof(struct usb_device *));
  int count = 0;

  usb_init ();
  usb_find_busses ();
  usb_find_devices ();

  for (usb_bus = usb_busses ; usb_bus ; usb_bus = usb_bus->next)
  {
	  printf("bus %lu\n",usb_bus->location);
	  for (dev = usb_bus->devices ; dev ; dev = dev->next)
		  if (dev->descriptor.idVendor == 0x1b96 && dev->descriptor.idProduct == 0x1)
			  out[count++] = dev;
  }
  return out;
}

#define BUFSIZE 1024

int main (int argc, char ** argv)
{
  struct usb_device *usb_dev;
  struct usb_device ** devs;
  struct usb_dev_handle *usb_handle;
  int retval = 1;

  char buf [BUFSIZE] = {0};
  int bytes=0;
  int value = 0x402;
  int i;
  int d;


  devs = device_init ();
  for(d=0; devs[d] != 0 && d<8 ; d++)
  {
	  usb_dev = devs[d];
	  if (!usb_dev) {
	    fprintf (stderr, "device not found\n");
	    return 0;
	  }

	  usb_handle = usb_open (usb_dev);
	  if (!usb_handle) {
	    fprintf (stderr, "could not open device\n");
	    return 0;
	  }
	  //printf ("ok\n");                         402           0x0300   2
	  //usb_control_msg (usb_handle, 0x40, 0x0f, value, 0x100, buf,   bytes, 1000);
	  retval = usb_control_msg (usb_handle, 0x00, 0x01, 1, 0, buf,0, 1000);
	  sleep(5);
	  retval = usb_control_msg (usb_handle, 0x21, 0x0a, 0, 1, buf,0, 1000);
	  retval = usb_control_msg (usb_handle, 0x21, 0x0a, 0, 0, buf,0, 1000);
	  retval = usb_interrupt_read (usb_handle, 2, buf,94, 1000);
	  retval = usb_control_msg (usb_handle, 0xa1, 0x01, 0x030b, 1, buf,4, 1000);
	  retval = usb_control_msg (usb_handle, 0x21, 0x0a, 0, 0, buf,0, 1000);
	  retval = usb_control_msg (usb_handle, 0x00, 0x03, 1, 0, buf,0, 1000);
	  retval = usb_control_msg (usb_handle, 0x00, 0x01, 1, 0, buf,0, 1000);
	  retval = usb_control_msg (usb_handle, 0x21, 0x0a, 0, 0, buf,0, 1000);
	  retval = usb_control_msg (usb_handle, 0x21, 0x0a, 0, 1, buf,0, 1000);
	  retval = usb_interrupt_read (usb_handle, 2, buf,94, 1000);
	  retval = usb_control_msg (usb_handle, 0xa1, 0x01, 0x0311, 1, buf,4, 1000);
	  printf ("done\n");

	  usb_close (usb_handle);
  }

  return 0;
}

--------------030903000500000709090608
Content-Type: text/plain;
 name="holly_kernel_8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="holly_kernel_8"

S Co:3:002:0 s 00 01 0001 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0001 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0000 0000 0
C Co:3:002:0 0 0
S Ii:3:002:2 -115:2 94 <
C Ii:3:002:2 -2:2 0
S Ci:3:002:0 s a1 01 030b 0001 0004 4 <
C Ci:3:002:0 0 4 = 0b000000
S Co:3:002:0 s 21 0a 0000 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 00 03 0001 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 00 01 0001 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0001 0000 0
C Co:3:002:0 0 0
S Ii:3:002:2 -115:2 94 <
C Ii:3:002:2 -2:2 0
S Ci:3:002:0 s a1 01 0311 0001 0004 4 <
C Ci:3:002:0 0 4 = 1121422e

--------------030903000500000709090608
Content-Type: text/plain;
 name="holly_user"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="holly_user"

S Co:3:002:0 s 00 01 0001 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0001 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0000 0000 0
C Co:3:002:0 0 0
S Ii:3:002:2 -115:2 94 <
C Ii:3:002:2 0:2 94 = 033fbc07 0000a014 f012ce01 68010100 000c0701 00000000 00fa0096 00000b00
S Ci:3:002:0 s a1 01 030b 0001 0004 4 <
C Ci:3:002:0 0 4 = 0b000000
S Co:3:002:0 s 21 0a 0000 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 00 03 0001 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 00 01 0001 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0000 0000 0
C Co:3:002:0 0 0
S Co:3:002:0 s 21 0a 0000 0001 0000 0
C Co:3:002:0 0 0
S Ii:3:002:2 -115:2 94 <
C Ii:3:002:2 0:2 94 = 0340bc07 00007e14 e2123401 68010100 000c0701 00000000 00fa0096 00000b00
S Ci:3:002:0 s a1 01 0311 0001 0004 4 <
C Ci:3:002:0 0 4 = 11630064

--------------030903000500000709090608--
