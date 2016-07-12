From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Supporting the new Xbox One controller with wireless/BT connectivity
Date: Tue, 12 Jul 2016 10:34:58 +0200
Message-ID: <CAN+gG=FsUodBNnUVLfyHi38FY=ziEsTSgDrvK6GpYMLTinkk_g@mail.gmail.com>
References: <5783DBBA.8070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33634 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbcGLIfA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 04:35:00 -0400
Received: by mail-vk0-f46.google.com with SMTP id x130so12084445vkc.0
        for <linux-input@vger.kernel.org>; Tue, 12 Jul 2016 01:35:00 -0700 (PDT)
In-Reply-To: <5783DBBA.8070503@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Jul 11, 2016 at 7:47 PM, Cameron Gutman <aicommander@gmail.com> wrote:
> I'm trying to come up with the best way to support wirelessly connected Xbox
> One controllers. Microsoft has previously released a wireless adapter that
> uses a proprietary protocol to talk to the Xbox One controllers. Recently,
> they have also announced an Xbox One controller with Bluetooth connectivity.
> Though we can't be sure yet since it hasn't come out yet, I would guess that
> they're using the same protocol as they do when attached via USB. If it's a
> standard HID gamepad, we don't have any work to do but I'm not holding my
> breath ;)

That's assuming they won't be using BLE (Bluetooth 4), in which case
they will likely not use the HID BLE protocol. Most input
manufacturers don't use it when they have weird devices.

>
> Unfortunately, our xpad driver is quite tied to USB so it will be difficult to
> support HID communication over Bluetooth. My initial thinking is that we can
> add a new hid-xpad driver that will initially take over this single Bluetooth
> Xbox One controller. After it is tested and feature parity with xpad, we can
> possibly expand it to handle all Xbox One controllers to avoid duplicated
> logic.

I don't think you'll be able to have a hid-xpad driver for the USB
controllers. From what I can read in the driver, my memories and the
various lsusb I can find on the internet, the Xbox (360 or one) are
not using HID at all. So they are not bound to HID, and unless you add
some weird logic, you can't have HID core handle non HID devices.

>
> The wrinkle in these plans is the Xbox One wireless adapter which seems to be
> simply a MediaTek WLAN adapter that MS is binding a protocol driver to in order
> to emulate the HID protocol for the rest of their device stack. Fortunately, it
> looks like people are started to have success reverse engineering the wireless
> protocol, so we should be able to do something similar to how MS implements it.
>
> In order to support the proprietary wireless adapter, I see two options:
>
> 1) Write a driver for the Xbox One wireless adapter that will expose a virtual
>    USB controller that enumerates Xbox One controllers and allows our existing
>    xpad driver to run them. The OZWPAN driver in staging does something like
>    this and would be a good reference. The advantage is that it doesn't require
>    a new hid-xpad driver. The disadvantages are that there's a bunch of
>    complexity in writing a virtual USB host controller driver and even after
>    doing it, we still can't support Bluetooth Xbox One Controllers.

I personally don't like it as you are getting up and down in the
abstraction layers, which is doomed to be bugs prone.

>
> 2) Write a HID transport for the Xbox One wireless adapter that enumerates HID
>    devices for the hid-xpad driver. By moving the abstracting up a layer, it
>    really cuts down on the amount of code required. This would also let us

If the Xbox One wireless adapter is HID, then yes, please add this hid-xpad.

solution 3 would be: ignore the Xbox One wireless adapter in HID and
let xpad.c handle it if both protocols are similar.

>    support USB, proprietary wireless, and Bluetooth attached Xbox One
>    controllers with a single xpad driver.

That would be a sweet dream. Not sure we can make it happen.

>
> As far as I'm concerned, #2 seems like the obvious choice.
>
> Jiri and Dmitry, do either of you see anything wrong with #2 or have any other
> comments or concerns?
>

I'd say it's difficult to build a plan on future devices when we have
no information besides marketing.

In the end, we always prefer the solution that has less code
duplication, but sometimes we can't make apples looks like oranges, so
we have barely no choices but to have several similar drivers.

Cheers,
Benjamin

>
> Thanks,
> Cameron
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
