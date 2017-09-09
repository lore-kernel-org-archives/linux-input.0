From: Juanito <juam+kernel@posteo.net>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Sat, 9 Sep 2017 10:12:42 +0200
Message-ID: <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709072354.02681@pali> <30e888e8-39a8-6d74-7610-e467ed96815e@posteo.net>
 <201709080848.53286@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:51594 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755674AbdIIIMn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 9 Sep 2017 04:12:43 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 252BA20AD2
        for <linux-input@vger.kernel.org>; Sat,  9 Sep 2017 10:12:42 +0200 (CEST)
In-Reply-To: <201709080848.53286@pali>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>, Paul Donohue <linux-kernel@paulsd.com>

Hello,

On 09/08/2017 08:48 AM, Pali Rohár wrote:
> On Friday 08 September 2017 07:00:34 Juanito wrote:
>>
>>> ThinkPad with ALPS? Should not be it Synaptic? Maybe
>>> miss-detection?
>>
>> Sorry, I forgot to mention this. The ThinkPad came with a clickpad I
>> **really** disliked, so I bought this on the Internet.
> 
> So, here is a problem. ThinkPads works with Synaptic touchpads, not with 
> ALPS.
> 

There definitely seems to be a problem here :)

Do you mean that the alps code might not be detecting the trackpoint
because probably the red thingie works with synaptics?

So could this be the situation:
ALPS driver: Hey touchpad! Do you have a trackstick?
ALPS touchpad: No, I don't.
AD: Ok! (and thinks 'I am going to have to ignore all trackstick packets
that might arrive')

So the driver understands that there can't possibly be any buttons
because there is no trackstick?

>>
>> If by trackstick you mean the red thingie, it is **not** working.
> 
> Ok. And it is working with your patch?
>

No, it isn't :(

>>>>> I am not sure if the device is actually a DualPoint or not (I
>>>>> don't really understand the terminology here), but the thing is
>>>>> that the buttons work when the kernel believes it to be one.
>>>>>
>>>>> This is the info I have managed to find about the device while
>>>>> running on the non-working debian:
>>>>>
>>>>> dmesg:
>>>>> [    2.914806] input: AlpsPS/2 ALPS GlidePoint as
>>>>> /devices/platform/i8042/serio1/input/input2
>>>>>
>>>>> lsinput:
>>>>> /dev/input/event11
>>>>>
>>>>>    bustype : BUS_I8042
>>>>>    vendor  : 0x2
>>>>>    product : 0x8
>>>>>    version : 1792
>>>>>    name    : "AlpsPS/2 ALPS GlidePoint"
>>>>>    phys    : "isa0060/serio1/input0"
>>>>>    bits ev : (null) (null) (null)
>>>>>
>>>>> I have played around with the drivers/input/mouse/alps.c file and
>>>>> found out the following:
>>>>>
>>>>> e7 and ec are important (although I don't know what these are
>>>>> exactly) and have the following values:
>>>>>
>>>>> e7: 73 03 0a
>>>>> ec: 88 b0 13
>>>
>>> Masaki should know exact type of device...
>>>
