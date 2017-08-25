From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Fri, 25 Aug 2017 12:55:29 +0200
Message-ID: <CAEk1YH7Ni04Hs4RHtDJyE368aA4-DSW5aGx+v8kpbhLF2OR2Sg@mail.gmail.com>
References: <20170818193436.GA31365@dtor-ws> <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
 <20170821154522.GA21773@dtor-ws> <CAEk1YH7+8Vnqpe5o30bsgH+fU7U+T9uEtHmK+dah5vaPwo1w0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35129 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbdHYKzb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Aug 2017 06:55:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id r187so2188041wma.2
        for <linux-input@vger.kernel.org>; Fri, 25 Aug 2017 03:55:30 -0700 (PDT)
In-Reply-To: <CAEk1YH7+8Vnqpe5o30bsgH+fU7U+T9uEtHmK+dah5vaPwo1w0Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 21 August 2017 at 18:25, Damjan Georgievski <gdamjan@gmail.com> wrote:
>> I wonder if we have different configs...
>>
>>>
>>> Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
>>> Mouse". Middle button scrolling is not enabled by default.
>>
>> I think this will be fixed by:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/patch/?id=ec667683c532c93fb41e100e5d61a518971060e2
>>
>
> Interesting, with this patch, the trackpoint appeared sooner, but
> still late (at the 44 second mark):

but that seems sporadic. on second boot, it didn't show up until I
reloaded the psmouse module

any ideas how to debug this issue further? possibly before the change
goes upstream.

-- 
damjan
