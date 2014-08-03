From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [Question: Drivers/input/evdev.c] How to get instance of struct
 evdev in some driver ?
Date: Sun, 3 Aug 2014 12:23:00 +0530
Message-ID: <CADYu30-_ozzaNroEC4---R8o=uAq7sMuFzxoCkWpw=S4fE1bKA@mail.gmail.com>
References: <CADYu30-RSdvCmtyn0NmZ4weDsgqhcieV86s9+7OTVJOQEQiSpA@mail.gmail.com>
	<20140803064238.GA897@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:56654 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaHCGxC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Aug 2014 02:53:02 -0400
Received: by mail-la0-f43.google.com with SMTP id hr17so4455613lab.16
        for <linux-input@vger.kernel.org>; Sat, 02 Aug 2014 23:53:00 -0700 (PDT)
In-Reply-To: <20140803064238.GA897@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Mr. Torokhov,

Thank you for your quick reply and clearing my doubt. :)

On Sun, Aug 3, 2014 at 12:12 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Aniroop,
>
> On Sun, Aug 03, 2014 at 12:05:11PM +0530, Aniroop Mathur wrote:
>> Dear Mr. Torokhov and Linux-Input Community,
>> Greetings of the day !! :)
>>
>> I am stuck at one point and could not find the solution over internet.
>> Can you please help in answering my query below:
>>
>> As you know, struct evdev is defined in evdev.c and not in some header file.
>> So, Is it possible to get instance of struct evdev in some input
>> peripheral driver ?
>> If possible, then how can we get it ?
>>
>> In the input peripheral driver,
>> we can get instance struct input_dev by including input.h file
>> and then calling input_allocate_device().
>> struct input_dev = input_allocate_device();
>>
>> May be evdev is embedded somewhere in input_dev.
>> So, can we get the instance of evdev using input_dev ?
>
> Not really. Technically speaking the evdev cam be compiled as a module and it
> will not be bound to the input device until later.
>
> Input devices should be ignorant of the input handlers bound to them, they
> should just supply event stream and not care about anything else. Also evdev
> internal structure is exactly that - internal - and the rest of the kernel
> should not try to poke into it.
>
> Thanks.
>
> --
> Dmitry
