From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Why does adding HID USB ID allow a keyboard to work?
Date: Thu, 19 Dec 2013 10:42:15 +0100
Message-ID: <CANq1E4SDOarFpDkRNswmqCwu6iuwsPsmLgL62fv5iK=jfjC0iQ@mail.gmail.com>
References: <CA+BWVUT_v4nQTY7DHfdwegJ8rKOEraodReAkWt4y7Ck93_-PBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:60256 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3LSJmP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Dec 2013 04:42:15 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so982748iec.7
        for <linux-input@vger.kernel.org>; Thu, 19 Dec 2013 01:42:15 -0800 (PST)
In-Reply-To: <CA+BWVUT_v4nQTY7DHfdwegJ8rKOEraodReAkWt4y7Ck93_-PBQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Sat, Dec 14, 2013 at 8:14 AM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> I have a basic question about the way the linux kernel handles human
> input devices. I bought a Surface Pro 2 with a Type cover keyboard.
> This did not work out of the box with stock linux kernel 3.11. When I
> added the hardware id of the device to the hid-microsoft.c driver it
> worked.
>
> Does this work simply because when I add the hardware id to the
> driver, the kernel knows to use usb-hid generic driver with the
> device? I'm trying to understand the hid-microsoft driver and it seems
> to apply quirks/hacks that enable Microsoft devices to work with the
> hid driver. Such as remapping keys. I don't need any of these quirks
> as all the media keys on the keyboard work all by adding the hardware
> id.
>
> Why doesn't the device work out of the box? Is the device not
> advertising itself as a hid device over usb? I'm little confused as to
> how this should be fixed. Does the kernel fail in noticing this hid
> device or does the device fail in telling the kernel it is a
> keyboard/mouse?

There are lots of HID devices out there that either don't follow the
HID specification or are not covered by the specification. Such
devices cannot be supported out-of-the-box. How should we know how
they work? That's why we provide lots of HID quirks for such devices.
The hid-microsoft driver is one of them. It applies a bunch of fixups
so HID core knows how it works.

We could use some broader heuristics to detect such devices, however,
the conservative approach is the safest. That means, only device-IDs
that have been reported to work are added to the hid-quirk lists. This
way, we don't break well-defined working devices via false positives,
but on the other hand, every new device needs to be added manually.

If you have suggestions how to improve this situation, please provide
patches. But input-development (or generally kernel development) must
be conservative in that regard. A regression is never acceptable and
we'll revert such patches. So someone has yet to come up with better
heuristics or we'll keep our ID lists.

Cheers
David
