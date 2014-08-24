From: vichy <vichy.kuo@gmail.com>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Sun, 24 Aug 2014 22:52:30 +0800
Message-ID: <CAOVJa8FgtSDM-F=Nu1kOU_Ax_6a0_U3jKU6_PKPDoVD9zW+JWg@mail.gmail.com>
References: <CAOVJa8HLSQ9cqEHR8srT3QikvJ6i0ZYFqmOZ7MvMpN5aULdk9A@mail.gmail.com>
	<Pine.LNX.4.44L0.1408221358030.967-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:63840 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbaHXOwb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Aug 2014 10:52:31 -0400
In-Reply-To: <Pine.LNX.4.44L0.1408221358030.967-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

hi Alan:
>
> I originally tried using usb_reset_device, and it caused a deadlock:
>
>         Unplug the HID device.
>
>         I/O error occurs.  hid_io_error schedules reset_work.
>
>         The reset_work callback routine is hid_reset.  It calls
>         usb_reset_device.
>
>         The reset fails because the device is gone.  At the end of the
>         reset, hid_post_reset is called.
>
>         hid_post_reset returns 1 because hid_get_class_descriptor
>         fails.
>
>         Because the post_reset routine failed, usb_reset_device calls
>         usb_unbind_and_rebind_marked_interfaces.

"usb_unbind_and_rebind_marked_interfaces" is called if config
parameter is not null,
it seems no matter post_reset routine fail or not.

>
>         That routine indirectly calls usbhid_disconnect.

Why that routine, usb_reset_device, will call usbhid_disconnect?
No matter port reset success or fail, usbhid_disconnect should not be
called except that did happen disconnection.

>
>         usbhid_disconnect calls usbhid_close by way of
>         hid_destroy_device.

below is the content of hid_destroy and hid_remove_device, but I
cannot find where usbhid_close be called by way of hid_destroy_device.
static void hid_remove_device(struct hid_device *hdev)
{
    if (hdev->status & HID_STAT_ADDED) {
        device_del(&hdev->dev);
        hid_debug_unregister(hdev);
        hdev->status &= ~HID_STAT_ADDED;
    }
    kfree(hdev->dev_rdesc);
    hdev->dev_rdesc = NULL;
    hdev->dev_rsize = 0;
}

void hid_destroy_device(struct hid_device *hdev)
{
    hid_remove_device(hdev);
    put_device(&hdev->dev);
}
>
>         usbhid_close calls hid_cancel_delayed_stuff.
>
>         hid_cancel_delayed_stuff calls cancel_work_sync for reset_work.
>
> So the reset_work routine tries to cancel itself synchronously while it
> is running.  usb_queue_reset_device was carefully written to avoid such
> deadlocks.
>
thanks for your help,
