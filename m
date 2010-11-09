From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Tue, 9 Nov 2010 10:10:21 -0800
Message-ID: <AANLkTik9-kqGzEDw5hfahi9mmWq+=zyV4OOek60Fm9sW@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
	<20101109033149.GC19313@barra.redhat.com>
	<20101109065933.GA13921@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56414 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0KISKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 13:10:22 -0500
Received: by gwj21 with SMTP id 21so4494934gwj.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 10:10:22 -0800 (PST)
In-Reply-To: <20101109065933.GA13921@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 8, 2010 at 10:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 09, 2010 at 01:31:49PM +1000, Peter Hutterer wrote:
>>
>> That said, it also goes counter the whole multi-touch approach - allowing
>> more than one device on a single physical device.
>
> So maybe we should teach wacom to handle all devices as a single input device even
> in cases when they use several USB interfaces?

Hehe, we got you talking again. I need to understand if the lessons
are for hardware/firmware or driver engineers ;).

> We should be able to detect related interfaces by examining intf->intf_assoc (I hope) and
> using usb_driver_claim_interface() to claim them.

I guess you mean we do this in the kernel driver.

Providing more than one type of HID devices from one physical device
is not Wacom specific. Standalone keyboard with touchpad has the same
feature/issue. When I plug an USB keyboard (whcih has a touchpad) on a
Linux system, I see two input ports (/dev/input/input9 and
/dev/input/event10) displayed. So, unless we only show one logical
port for the same device (no matter how many types of devices it
supports), userland clients would not be able to get the data from the
same port. That is what we get from the Linux kernel, right?

HID specification does not exclude one physical device supporting more
than one type of HID devices. So, it is a question of how we represent
the device to the userland on Linux (Windows and Mac have their own
ways). To me, both one or two logical posts have pros and cons.

Sorry to talk before listening. I am all ears now ;).

Ping
