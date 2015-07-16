From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Uinput: Deadlock upon UI_DEV_DESTROY ioctl while a non-zero
 number of ff_effects is still active (uploaded)
Date: Thu, 16 Jul 2015 16:31:46 -0700
Message-ID: <20150716233146.GG32571@dtor-ws>
References: <CADbOyBQjENrUdKW9=P=NUvFZ7EiWEihPp6qFsSym5rZOjPcFrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:32955 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbbGPXbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 19:31:51 -0400
Received: by pdbqm3 with SMTP id qm3so51720833pdb.0
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 16:31:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADbOyBQjENrUdKW9=P=NUvFZ7EiWEihPp6qFsSym5rZOjPcFrQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, vojtech@suse.cz

On Thu, Jul 16, 2015 at 11:21:46PM +0200, Elias Vanderstuyft wrote:
> Hi everyone,
> 
> In the process of extending the libsuinput library
> (https://github.com/tuomasjjrasanen/python-uinput/tree/master/libsuinput/src)
> to support force feedback,
> I encountered some bugs in the kernel.
> For some bugs, I'm not sure for the right fix,
> so it's safer to first present the problem and ask for feedback.
> For clarity, I divided the bugs between different mail subjects.
> 
> This subject handles about a deadlock encountered
> when userspace issues a UI_DEV_DESTROY ioctl on a uinput device,
> while a non-zero number of ff_effects is still active
> (i.e. the application that issued the ioctl
> has not yet erased all uploaded effects).
> 
> The mutex causing the deadlock is "(struct uinput_device).mutex".
> 
> The chain of the deadlock is as follows:
> - uinput.c::uinput_ioctl_handler() LOCKS using mutex_lock_interruptible()
> - uinput.c::uinput_ioctl_handler() calls uinput.c::uinput_destroy_device()
> - uinput.c::uinput_destroy_device() calls input.c::input_unregister_device()
> - input.c::input_unregister_device() calls input.c::__input_unregister_device()
> - input.c::__input_unregister_device() calls handle->handler->disconnect()
> - evdev.c::evdev_disconnect calls evdev.c::evdev_cleanup()
> - evdev.c::evdev_cleanup() calls input.c::input_flush_device()
> - input.c::input_flush_device() calls dev->flush()
> - ff-core.c::flush_effects() calls ff-core.c::erase_effect()
> - ff-core.c::erase_effect() calls ff->erase()
> - uinput.c::uinput_dev_erase_effect() calls uinput.c::uinput_request_submit()
> - uinput.c::uinput_request_submit() calls uinput.c::uinput_request_send()
> - uinput.c::uinput_request_send() LOCKS using mutex_lock_interruptible()

Ugh... :(

> 
> Hints for solving this problem are much appreciated.
> Maybe by setting a flag when UI_DEV_DESTROY ioctl is issued,
> and avoiding to acquire the mutex in uinput_request_send()
> when this flag is found to be set?

No, it woudl still be racy. Unfortunately uinput allows to continue
using the device after "destroying" it...

Maybe instead of using mutex in uinput_request_send() we could use RCU
to fetch the input device assigned to uinput device and validate that
it is the same device for which we are trying to submit requests. And
have uinput_destroy_device() smash NULL into udev->dev early, before
calling uinput_flush_requests(udev) and input_unregister_device(). 

Thanks.

-- 
Dmitry
