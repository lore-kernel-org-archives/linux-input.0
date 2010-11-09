From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Tue, 9 Nov 2010 21:36:44 +0100
Message-ID: <AANLkTinWYqEmS=FCbXm9pJJr_jmkoDBt66D2bwCQerd-@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
 <20101108035121.GA4630@barra.bne.redhat.com> <4CD7B012.1030809@cena.fr>
 <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
 <20101109033149.GC19313@barra.redhat.com> <20101109065933.GA13921@core.coreip.homeip.net>
 <AANLkTik9-kqGzEDw5hfahi9mmWq+=zyV4OOek60Fm9sW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49155 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0KIUhH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 15:37:07 -0500
Received: by wyb36 with SMTP id 36so5224063wyb.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 12:37:05 -0800 (PST)
In-Reply-To: <AANLkTik9-kqGzEDw5hfahi9mmWq+=zyV4OOek60Fm9sW@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On 9 November 2010 19:10, Ping Cheng <pinglinux@gmail.com> wrote:
> On Mon, Nov 8, 2010 at 10:59 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, Nov 09, 2010 at 01:31:49PM +1000, Peter Hutterer wrote:
>>>
>>> That said, it also goes counter the whole multi-touch approach - allowing
>>> more than one device on a single physical device.
>>
>> So maybe we should teach wacom to handle all devices as a single input device even
>> in cases when they use several USB interfaces?
>
> Hehe, we got you talking again. I need to understand if the lessons
> are for hardware/firmware or driver engineers ;).
>
>> We should be able to detect related interfaces by examining intf->intf_assoc (I hope) and
>> using usb_driver_claim_interface() to claim them.
>
> I guess you mean we do this in the kernel driver.
>
> Providing more than one type of HID devices from one physical device
> is not Wacom specific. Standalone keyboard with touchpad has the same
> feature/issue. When I plug an USB keyboard (whcih has a touchpad) on a
> Linux system, I see two input ports (/dev/input/input9 and
> /dev/input/event10) displayed. So, unless we only show one logical
> port for the same device (no matter how many types of devices it
> supports), userland clients would not be able to get the data from the
> same port. That is what we get from the Linux kernel, right?

The thing is that while the keyboard has separate devices for a
touchpad and for keys these devices really are separate, logically
from the user's point of view and physically. A keyboard with a
trackpoint is not physically separate from the pointing device but it
is still logically separate. It has only two axes on the single
pointer device which are somewhat related but other than that you can
have separate device for every button and key and lose no information
whatsoever. This same applies to tablets with one tool and buttons.
Tablets with multiple tools don't pose much problem either. The tools
are related and should ideally be reported from the same device but
they also behave the same and don't pose any difficulties when
collected from multiple related devices,  they have the same range of
motion, resolution, etc.

The situation with a P&T is special in that two largely disparate
devices are superimposed physically so that using one hinders using
the other to the point that measures have to be taken and some events
filtered when both devices are in proximity to make the hardware
usable.

The implication of the situation is that if you want to make any sense
of the input events you

 - absolutely have to know these two devices are related at some level
 - at a level where you know the devices are related you have to
filter out some events
 - when using the devices at the same time for different purposes
(button clicks and gestures vs moves) the difference in resolution and
range does not pose a problem but when the user moves both pen and
finger it might be challenging or even impossible  to determine
whether the touchdown points moved towards each other or away from
each other due to differences in available motion range, resolution
and hardware manufacture

Thanks

Michal
