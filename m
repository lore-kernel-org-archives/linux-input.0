From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Thu, 6 Nov 2014 17:30:08 -0800
Message-ID: <CAF8JNhJ0vJHQzGzMygYg8yUa7oH4HqYx2YG_FtxEGPBo=31LTQ@mail.gmail.com>
References: <54424770.9090600@gmail.com>
	<20141021223311.GG8609@dtor-ws>
	<544889FD.5030004@gmail.com>
	<54489803.9030803@selasky.org>
	<CAF8JNhJ8ZR5vvtcrOvv9-ySzN4aytBziEO90_Kif=Q4q7WgwmA@mail.gmail.com>
	<54548E63.6060306@selasky.org>
	<20141104080816.GB13100@dtor-ws>
	<CAF8JNhLPgG-dROf2f0Z6_8UBN7e_o_uicUDrO2sn+2yPgqdCmQ@mail.gmail.com>
	<20141104180648.GA440@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:53421 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKGBaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2014 20:30:11 -0500
Received: by mail-la0-f44.google.com with SMTP id gf13so3686217lab.17
        for <linux-input@vger.kernel.org>; Thu, 06 Nov 2014 17:30:09 -0800 (PST)
In-Reply-To: <20141104180648.GA440@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Petter Selasky <hps@selasky.org>, Denis Akiyakov <d.akiyakov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

On Tue, Nov 4, 2014 at 10:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 04, 2014 at 09:38:38AM -0800, Ping Cheng wrote:
>> Hi Dmitry,
>>
>> On Tue, Nov 4, 2014 at 12:08 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Sat, Nov 01, 2014 at 08:40:19AM +0100, Hans Petter Selasky wrote:
>> >> On 11/01/14 00:27, Ping Cheng wrote:
>> >> >If touch_input is NULL on FreeBSD, you need to figure out the root
>> >> >cause. Checking on touch_input itself would not fix the root cause...
>> >>
>> >> Right.
>> >>
>> >> The root cause is that FreeBSD launches two instances of the driver,
>> >> running in two different userland processes, for the two different
>> >> Wacom interfaces on a common USB device. In Linux the wacom
>> >> interface drivers are running from the same kernel, and can share
>> >> the data in question, but in FreeBSD's webcamd emulation, this
>> >> doesn't work. Then the first wacom probe call would have to grab the
>> >> second interface.
>> >>
>> >> Technically speaking this is a FreeBSD only problem and I plan to
>> >> deliver a patch with the webcamd software to fix this, like already
>> >> suggested to you guys. This situation can also happen on Linux in
>> >> case of a "BadUSB" device. That's why I think that the NULL check
>> >> should be upstreamed.
>> >
>> > Hmm, looking at this again it seems that we just cross our fingers and
>> > hope that both interfaces are enumerated by the time we get event data
>> > from the device. I do not think this is quite safe. We probably should
>> > be checking the overall state of probing (i.e. whether we are done
>> > probing both interfaces) before processing data for the device.
>>
>> Are you going to make a patch to address the issue?
>
> Not in the nearest future, sorry.

No problem. I just want to make sure we don't duplicate the work...

>> > Or maybe we should just forcibly try claiming secondary interface
>> > while probing primary instead of messing with shared data item.

I looked into the code. It is not a simple task to claim secondary
interface while probing the primary one. For some devices, there is no
easy way to tell if they have multi-interfaces or not before accessing
the data,

>> If we incorporate the above idea into a patch, we need to keep in mind
>> that not all tablets support touch data. So, not all tablets have two
>> interfaces.
>
> Right, but we do know the models that use multiple interfaces, right?

Some models may have same product ID but can have pen or pen and touch
interfaces. We'll have to request the device to be sure...

Since touch_input is the only shared data/pointer that should not be
called before all interlaces are probed, checking on touch_input when
it is called, as suggested by Hans, is a feasible solution. As a
by-product, it also fixes the FreeBSD issue.

I'll post my patch here soon.

Ping
