From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Tue, 4 Nov 2014 09:38:38 -0800
Message-ID: <CAF8JNhLPgG-dROf2f0Z6_8UBN7e_o_uicUDrO2sn+2yPgqdCmQ@mail.gmail.com>
References: <54424770.9090600@gmail.com>
	<20141021223311.GG8609@dtor-ws>
	<544889FD.5030004@gmail.com>
	<54489803.9030803@selasky.org>
	<CAF8JNhJ8ZR5vvtcrOvv9-ySzN4aytBziEO90_Kif=Q4q7WgwmA@mail.gmail.com>
	<54548E63.6060306@selasky.org>
	<20141104080816.GB13100@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:43998 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaKDRik (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2014 12:38:40 -0500
Received: by mail-lb0-f170.google.com with SMTP id z12so3164159lbi.15
        for <linux-input@vger.kernel.org>; Tue, 04 Nov 2014 09:38:38 -0800 (PST)
In-Reply-To: <20141104080816.GB13100@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Petter Selasky <hps@selasky.org>, Denis Akiyakov <d.akiyakov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

Hi Dmitry,

On Tue, Nov 4, 2014 at 12:08 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Nov 01, 2014 at 08:40:19AM +0100, Hans Petter Selasky wrote:
>> On 11/01/14 00:27, Ping Cheng wrote:
>> >If touch_input is NULL on FreeBSD, you need to figure out the root
>> >cause. Checking on touch_input itself would not fix the root cause...
>>
>> Right.
>>
>> The root cause is that FreeBSD launches two instances of the driver,
>> running in two different userland processes, for the two different
>> Wacom interfaces on a common USB device. In Linux the wacom
>> interface drivers are running from the same kernel, and can share
>> the data in question, but in FreeBSD's webcamd emulation, this
>> doesn't work. Then the first wacom probe call would have to grab the
>> second interface.
>>
>> Technically speaking this is a FreeBSD only problem and I plan to
>> deliver a patch with the webcamd software to fix this, like already
>> suggested to you guys. This situation can also happen on Linux in
>> case of a "BadUSB" device. That's why I think that the NULL check
>> should be upstreamed.
>
> Hmm, looking at this again it seems that we just cross our fingers and
> hope that both interfaces are enumerated by the time we get event data
> from the device. I do not think this is quite safe. We probably should
> be checking the overall state of probing (i.e. whether we are done
> probing both interfaces) before processing data for the device.

Are you going to make a patch to address the issue?

> Or maybe we should just forcibly try claiming secondary interface
> while probing primary instead of messing with shared data item.

If we incorporate the above idea into a patch, we need to keep in mind
that not all tablets support touch data. So, not all tablets have two
interfaces.

Cheers,

Ping

> That won't help Hans though: the devices do use 2 interfaces in tandem,
> treating them separately will result in incorrect behavior.
>
> Thanks.
>
> --
> Dmitry
