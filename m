From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: HID vendor access from user space
Date: Tue, 21 May 2013 15:12:38 +0200
Message-ID: <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43698 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232Ab3EUNMj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 May 2013 09:12:39 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so1461841iec.36
        for <linux-input@vger.kernel.org>; Tue, 21 May 2013 06:12:39 -0700 (PDT)
In-Reply-To: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <btissoires@logitech.com>, Andrew de los Reyes <adlr@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>

Hi

On Fri, May 17, 2013 at 1:47 PM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> Hi,
>
> In today's linux HID subsystem, a HID device can be accessed for
> control and configuration via dev/hidraw, via a hid-specific driver,
> as well as /dev/input (setting leds on a kbd for instance)
>
> Some HID devices share multiple functionality in the same HID
> interface, think of a keyboard with a touchpad and a vendor specific
> collection for configuration, special status, etc.
>
> For such device, there will be one hidraw node, and hid-input will
> take care of parsing the keyboard/mouse collections into the proper
> input objects.
>
> The vendor collection will be ignored.
>
> If a user wants to configure/control the device there are two choices,
> either write a hid-specific driver to deal with the vendor specific
> collection, or open the corresponding /hidraw node from userspace.
>
> But a hidraw node that carries system input data requires root priviledges.
>
> I'm interested in hearing your opinions on how to add the capability
> for a normal user process to control/configure a HID device via
> reports exchanged with a vendor collection.
>
> I have one proposal, which is to create, say  "/dev/hidvendorX", nodes
> for all top level HID collections which are today ignored by hid-input
> and/or other subsystems.
>
> These nodes would not require root priviledge by default and thus,
> users could control/reconfigure their devices from a standard
> application while keeping the "standard" input functionality intact.

Why not write a kernel driver? We have a pretty nice infrastructure
for all this.

If it's a license-issue, I recommend using udev rules to change
permissions on the requested devices directly during setup. You can
then use hidraw.
It would also help if you could describe the driver design. Do you run
it as daemon and feed data back into the kernel? Or do you forward it
to the xserver? Or what kind of setup do you have? For instance, a
library design would require dynamic permission setup, while a
daemon-design would allow static file-system permissions.
Furthermore, is it still an input driver? Or do you tunnel non-input
data via HID?

Regards
David
