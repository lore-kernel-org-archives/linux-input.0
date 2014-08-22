From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Fri, 22 Aug 2014 14:23:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408221358030.967-100000@iolanthe.rowland.org>
References: <CAOVJa8HLSQ9cqEHR8srT3QikvJ6i0ZYFqmOZ7MvMpN5aULdk9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40911 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932593AbaHVSX7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2014 14:23:59 -0400
In-Reply-To: <CAOVJa8HLSQ9cqEHR8srT3QikvJ6i0ZYFqmOZ7MvMpN5aULdk9A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

On Sat, 23 Aug 2014, vichy wrote:

> from your patch, I have some questions:
> a. in Alan's version, if both HID_CLEAR_HALT and HID_RESET_PENDING are
> set, hid_reset will both "clear ep halt" and "reset devcie".
> But in original one, even HID_CLEAR_HALT and HID_RESET_PENDING are
> both set, hid_reset only do one of them.

Yes.  In my patch, the clear-halt handler will turn on the
HID_RESET_PENDING bit if something goes wrong.  In that case we want to
do both things.

> is there any special reason in original hid_reset to use below flow?
>     if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
>             xxxxx
>     } else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
>             xxxxxx
>     }

No special reason.  We probably never thought that both flags would be
set.

> b. in original hid_reset, if "Clear halt ep" or "Rest device" success
> or none of those flags raise up, it will call hid_io_error for later
> resending the urb.

No, the clear-halt part calls hid_start_in when everything works.  It 
doesn't call hid_io_error, because hid_start_in turns on the 
HID_IN_RUNNING flag.

> Shall we need to call "hid_io_error(hid);" in the
> end if "clear halt" or "reset device" success?

In the clear-halt case, we don't have to because we call hid_start_in.

In the reset device case, we don't have to because hid_post_reset calls 
hid_start_in if there are no errors.

> c. why we chose to use usb_queue_reset_device instead of usb_reset_device()?

I originally tried using usb_reset_device, and it caused a deadlock:

	Unplug the HID device.

	I/O error occurs.  hid_io_error schedules reset_work.

	The reset_work callback routine is hid_reset.  It calls
	usb_reset_device.

	The reset fails because the device is gone.  At the end of the 
	reset, hid_post_reset is called.

	hid_post_reset returns 1 because hid_get_class_descriptor 
	fails.

	Because the post_reset routine failed, usb_reset_device calls
	usb_unbind_and_rebind_marked_interfaces.

	That routine indirectly calls usbhid_disconnect.

	usbhid_disconnect calls usbhid_close by way of 
	hid_destroy_device.

	usbhid_close calls hid_cancel_delayed_stuff.

	hid_cancel_delayed_stuff calls cancel_work_sync for reset_work.

So the reset_work routine tries to cancel itself synchronously while it
is running.  usb_queue_reset_device was carefully written to avoid such 
deadlocks.

> d. shall we "useusb_lock_device_for_reset(hid_to_usb_dev(hid),
> usbhid->intf)" or "spin_lock_irq(&usbhid->lock)" before calling
> usb_queue_reset_device?

No.  usb_queue_reset_device takes care of the locking.

Alan Stern

