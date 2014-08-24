From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Sun, 24 Aug 2014 11:34:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408241127320.26310-100000@netrider.rowland.org>
References: <CAOVJa8FgtSDM-F=Nu1kOU_Ax_6a0_U3jKU6_PKPDoVD9zW+JWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44805 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752684AbaHXPe6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Aug 2014 11:34:58 -0400
In-Reply-To: <CAOVJa8FgtSDM-F=Nu1kOU_Ax_6a0_U3jKU6_PKPDoVD9zW+JWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

On Sun, 24 Aug 2014, vichy wrote:

> hi Alan:
> >
> > I originally tried using usb_reset_device, and it caused a deadlock:
> >
> >         Unplug the HID device.
> >
> >         I/O error occurs.  hid_io_error schedules reset_work.
> >
> >         The reset_work callback routine is hid_reset.  It calls
> >         usb_reset_device.
> >
> >         The reset fails because the device is gone.  At the end of the
> >         reset, hid_post_reset is called.
> >
> >         hid_post_reset returns 1 because hid_get_class_descriptor
> >         fails.
> >
> >         Because the post_reset routine failed, usb_reset_device calls
> >         usb_unbind_and_rebind_marked_interfaces.
> 
> "usb_unbind_and_rebind_marked_interfaces" is called if config
> parameter is not null,
> it seems no matter post_reset routine fail or not.

Yes, that's right.  I should have said: "Because the post_reset routine 
failed, usb_unbind_and_rebind_marked_interfaces indirectly calls 
usbhid_disconnect.

> >         That routine indirectly calls usbhid_disconnect.
> 
> Why that routine, usb_reset_device, will call usbhid_disconnect?
> No matter port reset success or fail, usbhid_disconnect should not be
> called except that did happen disconnection.

usbhid_disconnect gets called when the driver is unbound, regardless of
whether the device was unplugged.  The kernel unbinds a driver when a
device is reset but the driver isn't able to handle the reset.

> >         usbhid_disconnect calls usbhid_close by way of
> >         hid_destroy_device.
> 
> below is the content of hid_destroy and hid_remove_device, but I
> cannot find where usbhid_close be called by way of hid_destroy_device.
> static void hid_remove_device(struct hid_device *hdev)
> {
>     if (hdev->status & HID_STAT_ADDED) {
>         device_del(&hdev->dev);
>         hid_debug_unregister(hdev);
>         hdev->status &= ~HID_STAT_ADDED;
>     }
>     kfree(hdev->dev_rdesc);
>     hdev->dev_rdesc = NULL;
>     hdev->dev_rsize = 0;
> }
> 
> void hid_destroy_device(struct hid_device *hdev)
> {
>     hid_remove_device(hdev);
>     put_device(&hdev->dev);
> }

I don't remember the entire call chain.  It was pretty long.  
hid_destroy_device calls hid_remove_device, which calls device_del,
which calls lots of other things.  If you really want to see all the
details, put a dump_stack() call in usbhid_close and examine what it
prints in the kernel log when you unplug an HID device.

Alan Stern

