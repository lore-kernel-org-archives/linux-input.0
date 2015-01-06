From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-replay captured data
Date: Tue, 6 Jan 2015 15:39:01 -0500
Message-ID: <CAN+gG=GcLCS8mBApNkEegqvCr8PRd1rmEYq=7WVzDJA3CM-F9g@mail.gmail.com>
References: <20150106191346.6zze9x2sg0coskkc@webmail.fib.upc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:63725 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbAFUjD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 15:39:03 -0500
Received: by mail-qg0-f52.google.com with SMTP id i50so4142639qgf.39
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 12:39:01 -0800 (PST)
In-Reply-To: <20150106191346.6zze9x2sg0coskkc@webmail.fib.upc.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: josep.sanchez.ferreres@est.fib.upc.edu
Cc: linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>

On Tue, Jan 6, 2015 at 1:13 PM,  <josep.sanchez.ferreres@est.fib.upc.edu> wrote:
> Here's the data you asked for:
>
> D: 0
> R: 117 06 0d ff 09 01 a1 01 85 10 a1 00 06 00 ff 09 01 15 00 26 ff 00 75 08
> 95 3f 81 02 c0 09 01 85 11 95 3f b1 02 09 01 85 02 95 01 b1 02 09 01 85 cc
> 95 02 b1 02 09 01 85 b0 95 01 b1 02 09 01 85 b1 95 28 81 02 09 01 85 07 95
> 06 b1 02 09 01 85 08 95 04 b1 02 09 01 85 0a 95 01 b1 02 09 01 85 0b 95 01
> b1 02 09 01 85 0c 95 01 b1 02 09 01 85 0d 95 3f 81 02 c0
> N: Wacom Co.,Ltd. Bamboo Pad, USB
> P: usb-0000:00:1d.7-2.4.3/input0
> I: 3 056a 0318
>
> The three lines you told me are there.

Thanks for the log.
So there are room here for a custom protocol apparently. However, I do
not think the ones we currently have in wacom_wac.c would fit (given
the potential report ID).
So we will need one of the Wacom guys to have a look at it.

Jason, Ping, do you have any info on these devices? Should we turn
them into a proprietary protocol or does the touch only works as a
mouse?

>
> PD: Sorry for not replying correctly. I can't use my gmail because the mail
> server from vger.kernel.org doesn't allow html mails, so I'm using my
> college e-mail address that's redirected to my gmail. So long story short I
> can't hit reply and have to do it manually, sorry for that. I've included
> everyone from the cc, is it ok now? If not please tell me and I'll try to
> avoid the mail redirection so I can reply properly.

One the lower right corner of the mail compose window, there is a
small arrow pointing down. Click it and select "Plain text mode" and
your message will not be sent in html but txt only :)

Cheers,
Benjamin
