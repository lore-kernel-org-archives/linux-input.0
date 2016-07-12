From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: Supporting the new Xbox One controller with wireless/BT
 connectivity
Date: Tue, 12 Jul 2016 10:42:37 -0700
Message-ID: <57852C0D.2040907@gmail.com>
References: <5783DBBA.8070503@gmail.com>
 <CAN+gG=FsUodBNnUVLfyHi38FY=ziEsTSgDrvK6GpYMLTinkk_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34522 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbcGLRmj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 13:42:39 -0400
Received: by mail-pf0-f179.google.com with SMTP id h14so9021522pfe.1
        for <linux-input@vger.kernel.org>; Tue, 12 Jul 2016 10:42:39 -0700 (PDT)
In-Reply-To: <CAN+gG=FsUodBNnUVLfyHi38FY=ziEsTSgDrvK6GpYMLTinkk_g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>

On 07/12/2016 01:34 AM, Benjamin Tissoires wrote:
> On Mon, Jul 11, 2016 at 7:47 PM, Cameron Gutman <aicommander@gmail.com> wrote:
>> I'm trying to come up with the best way to support wirelessly connected Xbox
>> One controllers. Microsoft has previously released a wireless adapter that
>> uses a proprietary protocol to talk to the Xbox One controllers. Recently,
>> they have also announced an Xbox One controller with Bluetooth connectivity.
>> Though we can't be sure yet since it hasn't come out yet, I would guess that
>> they're using the same protocol as they do when attached via USB. If it's a
>> standard HID gamepad, we don't have any work to do but I'm not holding my
>> breath ;)
> 
> That's assuming they won't be using BLE (Bluetooth 4), in which case
> they will likely not use the HID BLE protocol. Most input
> manufacturers don't use it when they have weird devices.

We'll see once they release.

>>
>> Unfortunately, our xpad driver is quite tied to USB so it will be difficult to
>> support HID communication over Bluetooth. My initial thinking is that we can
>> add a new hid-xpad driver that will initially take over this single Bluetooth
>> Xbox One controller. After it is tested and feature parity with xpad, we can
>> possibly expand it to handle all Xbox One controllers to avoid duplicated
>> logic.
> 
> I don't think you'll be able to have a hid-xpad driver for the USB
> controllers. From what I can read in the driver, my memories and the
> various lsusb I can find on the internet, the Xbox (360 or one) are
> not using HID at all. So they are not bound to HID, and unless you add
> some weird logic, you can't have HID core handle non HID devices.

We might have to bend the rules of HID to make it work, but I think
it can be done. hid-sony for PlayStation controllers doesn't exactly
scream standard HID either. Microsoft does use HID to interact with
the controller on Windows, so I think we should at least explore that
possibility.

>>
>> 1) Write a driver for the Xbox One wireless adapter that will expose a virtual
>>    USB controller that enumerates Xbox One controllers and allows our existing
>>    xpad driver to run them. The OZWPAN driver in staging does something like
>>    this and would be a good reference. The advantage is that it doesn't require
>>    a new hid-xpad driver. The disadvantages are that there's a bunch of
>>    complexity in writing a virtual USB host controller driver and even after
>>    doing it, we still can't support Bluetooth Xbox One Controllers.
> 
> I personally don't like it as you are getting up and down in the
> abstraction layers, which is doomed to be bugs prone.

Yes, I agree.

>>
>> 2) Write a HID transport for the Xbox One wireless adapter that enumerates HID
>>    devices for the hid-xpad driver. By moving the abstracting up a layer, it
>>    really cuts down on the amount of code required. This would also let us
> 
> If the Xbox One wireless adapter is HID, then yes, please add this hid-xpad.

The adapter itself isn't a HID device nor even really related to the Xbox
One controller at all. It's just a WLAN NIC that can connect to them and
allow a protocol driver to communicate with the controllers over the link.

The thought would be to expose a HID bus via a driver that sits atop the
WLAN interface itself. Microsoft's xboxgip.sys driver does just this.

> 
> solution 3 would be: ignore the Xbox One wireless adapter in HID and
> let xpad.c handle it if both protocols are similar.
> 

xpad.c shouldn't handle it though. We would have to write a MediaTek
NIC driver into xpad ourselves to handle it. That's why the
Xbox GIP <-> HID transport driver makes sense.

>>    support USB, proprietary wireless, and Bluetooth attached Xbox One
>>    controllers with a single xpad driver.
> 
> That would be a sweet dream. Not sure we can make it happen.

I really think we can. FWIW, Microsoft has done it. We obviously may decide
that they did it in a very messy way and not go that way, but I think it's
worth considering.

In scenario #2, the (simplified) device stacks would look like this:

For USB controller: USB hub -> xpad (possibly hid-xpad later)
For proprietary wireless adapter:
	USB hub -> MediaTek NIC driver -> xgip-transport -> hid-xpad
For BT controller (speculating): BT stack -> hid-xpad

xgip-transport would be a HID transport driver that uses the Xbox Game
Input Protocol (GIP) to enumerate and pass HID reports to each connected
controller. hid-xpad would attach to the device(s) exposed by
xgip-transport.

>>
>> As far as I'm concerned, #2 seems like the obvious choice.
>>
>> Jiri and Dmitry, do either of you see anything wrong with #2 or have any other
>> comments or concerns?
>>
> 
> I'd say it's difficult to build a plan on future devices when we have
> no information besides marketing.
> 
> In the end, we always prefer the solution that has less code
> duplication, but sometimes we can't make apples looks like oranges, so
> we have barely no choices but to have several similar drivers.
> 

2 of 3 devices are out today. We're only waiting on the BT-compatible
Xbox controller. I'm definitely not advocating that people start work
on a driver for unreleased hardware based on speculation.

I just think it's worth having a little design discussion before anyone
begins working on something that will lead to nowhere or a big design
mess.

> Cheers,
> Benjamin
> 

Thanks,
Cameron
