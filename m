From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: HID vendor access from user space
Date: Tue, 15 Apr 2014 10:47:29 +0200
Message-ID: <CAE7qMroYKj0rQQ32JMsp-myrESg5V0tkXF2JukhP4aauPapfcQ@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
 <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
 <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
 <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz> <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
 <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
 <CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
 <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com> <alpine.LNX.2.00.1404150935300.32344@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:37287 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664AbaDOIsA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 04:48:00 -0400
Received: by mail-ve0-f178.google.com with SMTP id jw12so8607065veb.23
        for <linux-input@vger.kernel.org>; Tue, 15 Apr 2014 01:47:59 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1404150935300.32344@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

On Tue, Apr 15, 2014 at 9:39 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 14 Apr 2014, Nestor Lopez Casado wrote:
>
>> After considering our discussion here, which is your position on
>> extending the hidraw nodes to include separate nodes for top level
>> vendor collections ?
>
> The exact usecase is still a bit unclear to me. Has there been any
> explanation how you are going to deal with the fact that X protocol
> exposes all the events to X session owner anyway? (sorry if it was and I
> missed it).

The X session owner can spy its own keystrokes. This seems acceptable.

Hidraw nodes are the only way a user can talk "vendor hid" with
plugged devices. Once you are less restrictive with hidraw nodes (i.e.
grant access to more users that root) to allow hid vendor interaction,
then any of those users can log anything happening on the concerned
hidraw node, even remotely. This is not the case in X.

Having more granularity at the hidraw level enables assigning
different user rights to the different nodes belonging to the same
parent hid device, so that sensitive user input can remain protected
while access to the vendor interface can be left open. As David said,
this clearly does not solve "all problems", as  some vendor features
in some devices might not be safe to be exposed, but then it will be
up to the users/vendors to grant/block access to those collections via
udev rules. Moreover, this feature will keep a very similar interface
to current hidraw ioctl/open/close and the code will most likely
remained contained to a single module or even can simply become part
of hidraw.c

As David mentions, the same kind of functionality could also be
achieved via hid specific drivers for vendor collections in each of
the products, but it has the drawback that we will be proliferating
more hid-specific drivers whose only purpose will be to expose a
vendor interface to user applications, creating the potential for
kernel code duplication and disparate user interfaces.

>
> Frankly, I'd really like to avoid any parsing (deciding about collections)
> whatsoever around hidraw, as that was the whole point of creating it in
> parallel to hiddev was simply 'no parsing, raw access'.

We should avoid naming the new nodes "hidrawX" they could be
"hidvendorX" for instance, or it could also be "hidcolX" where col
stands for collection. We will be moving the "raw" one level down.

It can be thought of as a multiple interface usb device that already
creates multiple hidraw devices, but taken one step further.

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

Cheers,
-nestor
