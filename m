From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: HID vendor access from user space
Date: Tue, 8 Apr 2014 17:53:43 +0200
Message-ID: <CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
 <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
 <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
 <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz> <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
 <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na6sys009bog014.obsmtp.com ([74.125.150.68]:56865 "EHLO
	na6sys009bog014.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757128AbaDHQBl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Apr 2014 12:01:41 -0400
Received: by mail-vc0-f178.google.com with SMTP id im17so981212vcb.9
        for <linux-input@vger.kernel.org>; Tue, 08 Apr 2014 09:01:38 -0700 (PDT)
In-Reply-To: <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

On Mon, Apr 7, 2014 at 6:27 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Mon, Apr 7, 2014 at 6:15 PM, Nestor Lopez Casado
> <nlopezcasad@logitech.com> wrote:
>> We consider this a potential security problem and we are looking into
>> a solution that would enable the currently logged local user to access
>> the vendor collections of a hid device without requiring any special
>> permissions.
>>
>> Maybe the solution is not within the kernel itself, but rather on
>> using a user mode component, maybe the X server or even udev. Do you
>> get my point now ?
>
> There is a lot of work going on to make Xorg (and also Wayland
> compositors) run as non-root. Many people, however, seem to ignore
> that this means the compositor runs with the _same_ privileges as the
> applications. At least that is the security model we are going for.
> Therefore, if a compositor can access input devices, all applications
> can do so, too. Of course, you can introduce new privilege-levels and
> or run applications with less privileges than normal user processes.
> But I guess you get the point.
>
> Therefore, I really doubt there is much need to split the
> access-rights here. What you wanna do is to provide this
> privilege-separation on the kernel level. However, I think this is the
> wrong way to do it. Imagine an HID device that has several
> vendor-commands, some of them rather trivial and un-privileged, others
> not. Do you expect the kernel to provide one device-node for each? How
> do you expect the kernel to know which vender-extensions are _safe_ to
> be grouped together?

I do not expect the kernel to know whether vendor extensions are safe
to be grouped together, I would simply provide them as a separate
-user accessible- interface whose access rights can be assigned
separately from the classic input collections.

Assignment of access rights would then be up to udev rules. Which each
manufacturer/user can define for each of its devices. By default
access rights would stay for root only.

>
> Yes, the kernel should provide different interfaces for different
> hw-features so user-space can apply fine-grained access-modes.
> However, if we don't know what hardware feature a specific command
> represents, I don't think we should apply some kind of random
> interface separation. This is why Jiri and I recommend writing an
> in-kernel driver. That driver can be small and all it does it provide
> a separate interface for your vendor-extensions. This can be as easy
> as setting HID_QUIRK_MULTI_INPUT for given devices (or an equivalent
> HID_QUIRK_MULTI_HIDRAW, which doesn't exist, yet). I still think it
> would be nicer if the kernel provides a proper interface-abstraction,
> but I'd be fine with such a quirk, too.

The problem I see with a specific kernel driver for a specific vendor
extension is two fold:
1) It creates some potential for code bloat/duplication in the kernel
across multiple drivers for different manufacturers, while the only
purpose of this driver would be to expose some raw vendor
functionality to user programs.

2) The interface provided by this driver to user programs would
probably diverge from driver to driver, making it impossible to have a
generic user component (think signal11's HidApi lib for instance) to
provide a consistent hid access library across operating systems.

>
> Maybe you can describe one specific example? Otherwise, it's hard to
> imagine hid devices that provide two totally separate interfaces that
> we had the need to split them. All examples I know already provide
> different virtual HID devices and thus don't suffer from this problem.

You can look at the hid device descriptor that I posted in a previous
message of this thread. This device descriptor actually comes from one
of our devices: The Logitech BT Illuminated kbd K810. Most of our
input devices follow this pattern:

- Top level "classic" collection types (mouse, keyboard, etc)
- Top level vendor collections.

The vendor collections are the method we use to access extended
functionality of the device, (button reprogrammability, dpi settings,
extended battery status, firmware update and many others)

> Furthermore, did you do some research how other platforms deal with
> it?

Neither Microsoft Windows nor Apple Mac OS provide a posix-style
filesystem based device access model for HID devices. Nevertheless,
Windows does provide "physical device objects" for each top level
collection found in a hid device. From msdn:

"A report descriptor can include more than one top-level collection.
The HID class driver enumerates the top-level collections of an input
device and creates a physical device object (PDO) for each top-level
collection. User-mode applications or kernel-mode drivers can access a
top-level collection by opening its PDO and using the HIDClass support
routines and the HID class driver IOCTLs"

Access rights to vendor collection PDOs is granted to any logged on user.

Apple's Mac OS HidManager client API, provides a mechanism to select
the parent device of any top level hid collection, then Set/Get
report-style APIs to address each of the vendor collections.

Access rights seem to be given to any logged on user.

>
> Thanks
> David
