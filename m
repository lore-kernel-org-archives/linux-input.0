From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: HID vendor access from user space
Date: Mon, 7 Apr 2014 18:15:52 +0200
Message-ID: <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
 <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
 <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com> <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:59223 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753310AbaDGQQZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Apr 2014 12:16:25 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so5355085vcb.8
        for <linux-input@vger.kernel.org>; Mon, 07 Apr 2014 09:16:23 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

On Thu, Apr 3, 2014 at 3:57 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 2 Apr 2014, Nestor Lopez Casado wrote:
>
>> >> If a user wants to configure/control the device there are two choices,
>> >> either write a hid-specific driver to deal with the vendor specific
>> >> collection, or open the corresponding /hidraw node from userspace.
>> >>
>> >> But a hidraw node that carries system input data requires root priviledges.
>> >>
>> >> I'm interested in hearing your opinions on how to add the capability
>> >> for a normal user process to control/configure a HID device via
>> >> reports exchanged with a vendor collection.
>> >>
>> >> I have one proposal, which is to create, say  "/dev/hidvendorX", nodes
>> >> for all top level HID collections which are today ignored by hid-input
>> >> and/or other subsystems.
>> >>
>> >> These nodes would not require root priviledge by default and thus,
>> >> users could control/reconfigure their devices from a standard
>> >> application while keeping the "standard" input functionality intact.
>> >
>> > Why not write a kernel driver? We have a pretty nice infrastructure
>> > for all this.
>>
>> Do you mean a "hid-specific" driver for certain vid & pid devices ?
>
> I indeed believe that it's what David was proposing. Writing in-kernel
> drivers that handle just specific collections/usages, and let the rest
> be handled by the core infrastructure, is super-easy these days.

I don't think that the burden of hid input device status and
configuration should belong to the kernel 'for all devices in all
situations', as it would mandate the proliferation of many hid
specific code and too much kernel bloating that would be best handled
at a higher level. If we take for example the Logitech devices, we
have many features which are accessible via vendor collections, and
the easiest way to use them is via a user space application or
library.

>
> Also, if you need users to be able to trigger particular actions being
> perfomed by the driver, sysfs knobs should be a reasonable way to doing
> this.
>
> As an example of such interface -- creating a sysfs trigger for
> hid-logitech-dj that will send the pairing command to the unified
> receiver, has been on my TODO list for quite some time already (and was
> even suggested by Linus).
>
This is fine, but this solves a very particular case, the
pairing/unpairing of devices with the Unifying receiver. There is much
more to device configuration that just pairing/unpairing, it does not
even need to be Unifying devices, or Logitech devices, for that
matter.
(See also previous comment)


>> > If it's a license-issue, I recommend using udev rules to change
>> > permissions on the requested devices directly during setup. You can
>> > then use hidraw.
>> It is not a license issue, it is a security issue.
>>
>> Every hid class interface, (either usb, bluetooth, i2c, etc) has an
>> associated hidraw node, and that node aggregates all reports sent from
>> the device.
>>
>> Say that for example, the device has a keyboard collection and a
>> vendor collection, then changing permissions on the associated hidraw
>> node (so as to give any desktop user unrestricted access to the vendor
>> collection) would open the door to malicious code that could log the
>> keyboard activity (as both the vendor reports and input reports are
>> seen on the same hidraw node)
>
> I think I am missing the point here. If you own the credentials of the
> session owner, you can log keystrokes anyway even now, just use
>
>         xinput list
>         xinput test <id>
>
> and see the result :) Admittedly, this is a little bit more difficult when
> you are outside X11 session, but I am not sure how much concerned you are
> about such scenario anyway.

Oh, this I did not know!

Let me try to sketch the scenario we are concerned with:

We want user processes to be able to communicate with hid input
devices, via vendor specific commands. This vendor specific data flows
thru hid vendor reports.
Today, user processes can only access these reports via hidraw. Hidraw
aggregates user input (keyboard, mouse, etc) with vendor reports.

Hidraw nodes are owned by root by default. This means that an
unprivileged user would not be able to send vendor commands to a hid
device.
On the other hand, if an unprivileged user (or group) is given access
to hidraw, then she will also be able to spy the input, even if she is
remotely logged to a computer.

We consider this a potential security problem and we are looking into
a solution that would enable the currently logged local user to access
the vendor collections of a hid device without requiring any special
permissions.

Maybe the solution is not within the kernel itself, but rather on
using a user mode component, maybe the X server or even udev. Do you
get my point now ?

>
> --
> Jiri Kosina
> SUSE Labs

-nestor.
