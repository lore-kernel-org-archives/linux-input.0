From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Mon, 5 Feb 2018 12:56:35 +0100
Message-ID: <CAEk1YH7=aWJDGbdNj7jeRsOAn01eTCnm9Sc=KVTQ4KFEZ2PsSA@mail.gmail.com>
References: <20170818193436.GA31365@dtor-ws> <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
 <20170821154522.GA21773@dtor-ws> <CAEk1YH7+8Vnqpe5o30bsgH+fU7U+T9uEtHmK+dah5vaPwo1w0Q@mail.gmail.com>
 <CAEk1YH7Ni04Hs4RHtDJyE368aA4-DSW5aGx+v8kpbhLF2OR2Sg@mail.gmail.com> <20180202205050.i5pkl3rji45oovxb@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36044 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeBEL4h (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Feb 2018 06:56:37 -0500
Received: by mail-wm0-f45.google.com with SMTP id f3so25398008wmc.1
        for <linux-input@vger.kernel.org>; Mon, 05 Feb 2018 03:56:36 -0800 (PST)
In-Reply-To: <20180202205050.i5pkl3rji45oovxb@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

>> >>> Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
>> >>> Mouse". Middle button scrolling is not enabled by default.
>> >>
>> >> I think this will be fixed by:
>> >>
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/patch/?id=ec667683c532c93fb41e100e5d61a518971060e2
>> >>
>> >
>> > Interesting, with this patch, the trackpoint appeared sooner, but
>> > still late (at the 44 second mark):
>>
>> but that seems sporadic. on second boot, it didn't show up until I
>> reloaded the psmouse module
>>
>> any ideas how to debug this issue further? possibly before the change
>> goes upstream.
>
> Damjan,
>
> Since my other patches seem to have fixed the trackpoint detection
> issue, mind giving your "tested-by" to this patch so I can get it in?

let me just run some more tests and I'll get back to you soon.

I'm getting some weird clicks on the trackpad, I want to compare with
vanilla kernel.

Dimitry, what's best for testing, 4.15.1 + your patches or should I use 4.16rc1?


-- 
damjan
