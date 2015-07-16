From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Uinput: Deadlock upon UI_DEV_DESTROY ioctl while a non-zero number of
 ff_effects is still active (uploaded)
Date: Thu, 16 Jul 2015 23:21:46 +0200
Message-ID: <CADbOyBQjENrUdKW9=P=NUvFZ7EiWEihPp6qFsSym5rZOjPcFrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35251 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbGPVVq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 17:21:46 -0400
Received: by oihq81 with SMTP id q81so59143985oih.2
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 14:21:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, vojtech@suse.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi everyone,

In the process of extending the libsuinput library
(https://github.com/tuomasjjrasanen/python-uinput/tree/master/libsuinput/src)
to support force feedback,
I encountered some bugs in the kernel.
For some bugs, I'm not sure for the right fix,
so it's safer to first present the problem and ask for feedback.
For clarity, I divided the bugs between different mail subjects.

This subject handles about a deadlock encountered
when userspace issues a UI_DEV_DESTROY ioctl on a uinput device,
while a non-zero number of ff_effects is still active
(i.e. the application that issued the ioctl
has not yet erased all uploaded effects).

The mutex causing the deadlock is "(struct uinput_device).mutex".

The chain of the deadlock is as follows:
- uinput.c::uinput_ioctl_handler() LOCKS using mutex_lock_interruptible()
- uinput.c::uinput_ioctl_handler() calls uinput.c::uinput_destroy_device()
- uinput.c::uinput_destroy_device() calls input.c::input_unregister_device()
- input.c::input_unregister_device() calls input.c::__input_unregister_device()
- input.c::__input_unregister_device() calls handle->handler->disconnect()
- evdev.c::evdev_disconnect calls evdev.c::evdev_cleanup()
- evdev.c::evdev_cleanup() calls input.c::input_flush_device()
- input.c::input_flush_device() calls dev->flush()
- ff-core.c::flush_effects() calls ff-core.c::erase_effect()
- ff-core.c::erase_effect() calls ff->erase()
- uinput.c::uinput_dev_erase_effect() calls uinput.c::uinput_request_submit()
- uinput.c::uinput_request_submit() calls uinput.c::uinput_request_send()
- uinput.c::uinput_request_send() LOCKS using mutex_lock_interruptible()

Hints for solving this problem are much appreciated.
Maybe by setting a flag when UI_DEV_DESTROY ioctl is issued,
and avoiding to acquire the mutex in uinput_request_send()
when this flag is found to be set?

Thanks,
Elias
