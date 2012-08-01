From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Problems with a Zytronic touchscreen on kernel 3.5 (USB ID
 0x14c8:0x0005) - regression from kernel 3.0
Date: Wed, 1 Aug 2012 11:50:28 +0200
Message-ID: <CAN+gG=EZHh0AU43DzU35M0z5tyE75aRU8_XYwOhxmVHQYycGtw@mail.gmail.com>
References: <1514977.1uDfr8LPn9@f17simon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52056 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab2HAJu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Aug 2012 05:50:29 -0400
Received: by yhmm54 with SMTP id m54so7082725yhm.19
        for <linux-input@vger.kernel.org>; Wed, 01 Aug 2012 02:50:29 -0700 (PDT)
In-Reply-To: <1514977.1uDfr8LPn9@f17simon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-input <linux-input@vger.kernel.org>, Greg Kroah-Hartman <greg@kroah.com>

Hi Simon,

well, it's a known bug. This panel is now fixed in 3.6-rc0, and I
submitted the fix for stable. I'm still waiting for the stable
approval.

BTW, Zytronic 0005 is a multitouch device and not only a single touch
one. So I think we should handle it through hid-multitouch. I know
that Zytronic develops its own driver in parallel to fix some problems
they may have with the multitouch layer. This will also allow them to
flash their firmware.

Cheers,
 Benjamin

PS: the fix is at
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=4aceed37e315e8eaa26cb4c8dfd619a32fa24669

On Wed, Aug 1, 2012 at 10:20 AM, Simon Farnsworth
<simon.farnsworth@onelan.co.uk> wrote:
> Hello,
>
> Greg K-H pointed me this way from linux-usb; I've had no replies there, but if
> you've already seen the message on linux-usb, nothing's changed in the text
> below or the attachments.
>
> I'm trying to get a Zytronic single-touch touchscreen to work with Linux
> kernel 3.5; it previously worked on a 3.0 kernel. I'm happy to try git kernels
> and patches, even if they're just intended to gather more information.
>
> hid-multitouch is picking up the device because it has multitouch report
> descriptors as well as the single-touch descriptors. There's a quirk to make
> it use MT_CLS_SERIAL, but that seems to be insufficient for my needs.
>
> I've got as far as determining that it's mt_event in hid-multitouch.c that
> consumes the events, but as the screen never sends the events hid-multitouch.c
> expects to see, mt_event nevers sends an input event.
>
> evtest on 3.0 shows touch events as expected. evtest on 3.5 shows no touch
> events.
>
> I've attached /sys/kernel/debug/hid/0003:14C8:0005.0001/rdesc as
> zyntronic.rdesc and /sys/kernel/debug/hid/0003:14C8:0005.0001/events while I
> touch the screen as zytronic.events.
>
> I had evtest /dev/input/event5 running while I captured zytronic.events, and
> got the following output:
>
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x14c8 product 0x5 version 0x101
> Input device name: "Zytronic Displays Limited Zytronic Touchscreen Controller"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 330 (BTN_TOUCH)
>   Event type 3 (EV_ABS)
>     Event code 0 (ABS_X)
>       Value      0
>       Min        0
>       Max     4096
>     Event code 1 (ABS_Y)
>       Value      0
>       Min        0
>       Max     4096
>     Event code 47 (ABS_MT_SLOT)
>       Value      0
>       Min        0
>       Max        9
>     Event code 53 (ABS_MT_POSITION_X)
>       Value      0
>       Min        0
>       Max     4096
>     Event code 54 (ABS_MT_POSITION_Y)
>       Value      0
>       Min        0
>       Max     4096
>     Event code 57 (ABS_MT_TRACKING_ID)
>       Value      0
>       Min        0
>       Max    65535
> Testing ... (interrupt to exit)
> ^C
>
> Any ideas, or instructions for gathering more debug information will be
> gratefully received.
> --
> Simon Farnsworth
> Software Engineer
> ONELAN Ltd
> http://www.onelan.com
