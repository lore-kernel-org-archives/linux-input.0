From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Adonit Jot Pixel Stylus driver
Date: Wed, 25 Jan 2017 11:19:02 +0100
Message-ID: <CAN+gG=FZhRwNQfsrsWCdswGMsq2wBWtyx2N7UT_SDWQLBQycJg@mail.gmail.com>
References: <CAAzBBqut4ki4A1ygqcL54Bq=NP-TWPe9M_SVLJYZLkk=guOGDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36250 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdAYKTD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 05:19:03 -0500
Received: by mail-ua0-f173.google.com with SMTP id 96so155382404uaq.3
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 02:19:03 -0800 (PST)
In-Reply-To: <CAAzBBqut4ki4A1ygqcL54Bq=NP-TWPe9M_SVLJYZLkk=guOGDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Farrell <davidnmfarrell@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

On Tue, Jan 24, 2017 at 5:12 AM, David Farrell <davidnmfarrell@gmail.com> wrote:
> Hi folks,
>
> I have an adonit jot pixel bluetooth stylus. Adapting someone else's
> code (source http://gerev.github.io/laptop-cintiq/) I have it working
> with uinput, posting ABS_PRESSURE and BTN_1/2 event codes and so on.
> I'm running upstream.
>
> What I'm wondering is; as the stylus relies on a bluetooth connection,
> is it a suitable device to develop a kernel input driver for? And if
> yes, are there any reference drivers you'd recommend I look at?

Hi,

Coincidentally, I talked to Peter yesterday about this very same
stylus. I can only talk for the Wacom Creative Stylus 2, which I have,
but which I believe is similar to yours in many aspects.
So if your stylus is similar to mine, it uses BLE (or Bluetooth 4).
And in that case, you don't really need to write a kernel driver, but
more a bluez plugin in the same way HID over GATT (HID over BLE) is
working. This requires connecting over BLE to the stylus, then create
a uhid device (and you will have to write the report descriptors
matching your device by reverse engineering it), and inject that uhid
device in the same way bluez does for HID over GATT. Then you just
need to forward the raw events from the device to the uhid node and
the kernel will simply translate the events for you.

As a starter, you can have a look at profiles/input/hog.c and
profiles/input/hog-lib.c in the bluez repository.

Of course, if the stylus is not using BLE, then it perfectly makes
sense to write a full kernel driver for it (but I strongly suspect it
uses BLE).

Cheers,
Benjamin

>
> Many thanks in advance
>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
