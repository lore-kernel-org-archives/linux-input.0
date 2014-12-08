From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-replay captured data
Date: Mon, 8 Dec 2014 17:04:35 -0500
Message-ID: <CAN+gG=H5Zxfn1mRRYoypnMetfWzzOtc6XuvoJmKmJC8AW+9Wwg@mail.gmail.com>
References: <20141208215218.w5d4pi1sg8s0s4wo@webmail.fib.upc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:39284 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbaLHWEg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 17:04:36 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so4793145qcw.9
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 14:04:35 -0800 (PST)
In-Reply-To: <20141208215218.w5d4pi1sg8s0s4wo@webmail.fib.upc.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: josep.sanchez.ferreres@est.fib.upc.edu
Cc: linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>

Thanks for the logs (both way arrived in my mailbox, attached file or pastebin).

I'll try to have a look at them on Wednesday.

On Mon, Dec 8, 2014 at 3:52 PM,  <josep.sanchez.ferreres@est.fib.upc.edu> wrote:
> I attach a .tar.gz with all the captures I took, the filenames should be
> self explanatory. If you prefer me to dump all that into the e-mail text
> field just ask, but it's quite a big amount of data.
>
> Both 3.16 and 3.18 kernels seemed to respond to the same events. Oddly
> enough I've noticed that although 3 devices for rawhid were listed, only two
> captured events. Here's the output from hid-replay that shows my devices:
>
> Available devices:
> /dev/hidraw0:   USB Keyboard
> /dev/hidraw1:   USB Keyboard
> /dev/hidraw2:   USB OPTICAL MOUSE
> /dev/hidraw3:   Wacom Co.,Ltd. Bamboo Pad, USB
> /dev/hidraw4:   Wacom Co.,Ltd. Bamboo Pad, USB
> /dev/hidraw5:   Wacom Co.,Ltd. Bamboo Pad, USB
>
> Only hidraw4 and 5 reported events to hid-replay. Also note that hidraw5
> corresponds to the touchpad while hidraw5 corresponds to the stylus.
>
> I also just found out that the stylus hardware button is captured by the
> touchpad device and not by the stylus one (that actually makes more sense as
> it acts like a mouse button), so all the data I put about the stylus key
> should just contain stylus movement data. I added a file stylus-key.hid
> which is actually capturing the clicks for that button.
>
> I should also say that some events, like clicking the screen with the stylus
> will be mixed with the mouse movement (I tried to avoid that by clicking
> fast enough but I guess it's impossible to completely avoid it).
>
> PD: I see you're using a gmail address to reply, should I reply to that
> address better?

I think that's better to keep all the people in CC of the thread. we
generally have rules to filter linux-input/lkml mails, so it avoids
losing traces of a thread.

Cheers,
Benjamin
