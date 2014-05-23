From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Additional driver for USB touch support
Date: Fri, 23 May 2014 08:51:42 -0400
Message-ID: <CAN+gG=HA1Y-aJbt+RHYfoWJfPeypduCaCE5NKNLJJBhtMa4C6g@mail.gmail.com>
References: <CAAFf3B-1-G9e8+2Ci1MWf2OJfXCWk38e50nOA3piTpAQLM-J7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:55691 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbaEWMvn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 May 2014 08:51:43 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so7849532qge.26
        for <linux-input@vger.kernel.org>; Fri, 23 May 2014 05:51:42 -0700 (PDT)
In-Reply-To: <CAAFf3B-1-G9e8+2Ci1MWf2OJfXCWk38e50nOA3piTpAQLM-J7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Prajosh Premdas <premdas.prajosh@gmail.com>
Cc: daniel.ritz@gmx.ch, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Prajosh,

On Fri, May 23, 2014 at 6:55 AM, Prajosh Premdas
<premdas.prajosh@gmail.com> wrote:
> Hi
>
> I have some USB based touch controllers. These controllers are working
> well using the hid_multitouch driver.
>
> I would also like to add some additional protocol support for
> diagnostics and re calibration. I am using the touch interface for the
> same, whereby the control endpoint is used to send the request and
> digitizer end point is used to get the response. (it is a legacy
> design so i cannot change it)
>
> My plan is to add the additional driver support to this file
> drivers/input/touchscreen/usbtouchscreen.c and disable the default
> support for the hid_multitouch by making an entry in the hid-blacklist
> array in this file drivers/hid/usbhid/hid-quirks.c

2 things:
- adding the device to hid-blacklist either in hid-quirks or
hid-core.c will not help, the device will still be bound to the HID
subsystem, and the usb driver will not be able to catch it. If you
were to go to this road, you would have to add the VID/PID to
hid-ignore in hid-core.c
- I don't think it is a good idea to move from hid-multitouch to
usbtouchscreen: as far as I know, this driver only support single
touch devices, and it will be a burden to implement the multitouch
part

>
> Is there a better idea than this?

If you need to talk to the device through the control endpoint and get
the responses through the interrupt endpoint, hidraw seems to be
perfect for your case:
you can either use the ioctl HIDIOCSFEATURE or directly write on the
hidraw node to send reports, and reading back to the node will give
you the interrupts. Bonus point, you are enterily in userspace, so no
risk of crashing your kernel. Then, you just set up an udev rule if
you need the commands to be launched at plug.

You can find an example in samples/hidraw/hid-example.c in the kernel tree.

Cheers,
Benjamin
