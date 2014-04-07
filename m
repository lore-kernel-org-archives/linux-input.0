From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: HID vendor access from user space
Date: Mon, 7 Apr 2014 18:27:00 +0200
Message-ID: <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
	<CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
	<CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
	<alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
	<CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:41392 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbaDGQ1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Apr 2014 12:27:01 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so3839696igc.1
        for <linux-input@vger.kernel.org>; Mon, 07 Apr 2014 09:27:01 -0700 (PDT)
In-Reply-To: <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

Hi

On Mon, Apr 7, 2014 at 6:15 PM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> We consider this a potential security problem and we are looking into
> a solution that would enable the currently logged local user to access
> the vendor collections of a hid device without requiring any special
> permissions.
>
> Maybe the solution is not within the kernel itself, but rather on
> using a user mode component, maybe the X server or even udev. Do you
> get my point now ?

There is a lot of work going on to make Xorg (and also Wayland
compositors) run as non-root. Many people, however, seem to ignore
that this means the compositor runs with the _same_ privileges as the
applications. At least that is the security model we are going for.
Therefore, if a compositor can access input devices, all applications
can do so, too. Of course, you can introduce new privilege-levels and
or run applications with less privileges than normal user processes.
But I guess you get the point.

Therefore, I really doubt there is much need to split the
access-rights here. What you wanna do is to provide this
privilege-separation on the kernel level. However, I think this is the
wrong way to do it. Imagine an HID device that has several
vendor-commands, some of them rather trivial and un-privileged, others
not. Do you expect the kernel to provide one device-node for each? How
do you expect the kernel to know which vender-extensions are _safe_ to
be grouped together?

Yes, the kernel should provide different interfaces for different
hw-features so user-space can apply fine-grained access-modes.
However, if we don't know what hardware feature a specific command
represents, I don't think we should apply some kind of random
interface separation. This is why Jiri and I recommend writing an
in-kernel driver. That driver can be small and all it does it provide
a separate interface for your vendor-extensions. This can be as easy
as setting HID_QUIRK_MULTI_INPUT for given devices (or an equivalent
HID_QUIRK_MULTI_HIDRAW, which doesn't exist, yet). I still think it
would be nicer if the kernel provides a proper interface-abstraction,
but I'd be fine with such a quirk, too.

Maybe you can describe one specific example? Otherwise, it's hard to
imagine hid devices that provide two totally separate interfaces that
we had the need to split them. All examples I know already provide
different virtual HID devices and thus don't suffer from this problem.
Furthermore, did you do some research how other platforms deal with
it?

Thanks
David
