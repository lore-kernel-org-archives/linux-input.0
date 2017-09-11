From: Juanito <juam+kernel@posteo.net>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Mon, 11 Sep 2017 13:26:30 +0200
Message-ID: <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709080848.53286@pali> <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
 <201709091036.06899@pali> <20170909181218.GA29107@dtor-ws>
 <b3b06164-183b-d3f8-8de2-804eb1d343dd@posteo.net>
 <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:55694 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbdIKL0f (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 07:26:35 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 1FDB820B1C
        for <linux-input@vger.kernel.org>; Mon, 11 Sep 2017 13:26:33 +0200 (CEST)
In-Reply-To: <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Paul Donohue <linux-kernel@paulsd.com>

Hi Masaki Ota,

Thanks!

On 11.09.2017 04:38, Masaki Ota wrote:
> Hi, Juanito,
> 
> In my information, ALPS Touchpad is used on Thinkpad E series and L series.
> I don't know the device that is ALPS Touchpad + other vendor TrackStick.
> But Lenovo might use ALPS Touchpad on such a combination.
> 

Well, that is probably my fault, as it is not the original touchpad that
was delievered with the laptop. I bought the touchpad (that included
the three buttons) separately because I didn't like the clickpad that
came with my laptop.

> And I have found that the V7 protocol device has a special ID for Lenovo.
> ALPS assigns the value that is the model type to 0xC399 address.
> 
> Could you check 0xC399 address value such like a below code?
> reg_val = alps_command_mode_read_reg(psmouse, 0xC399);
> 
> If the value is 0x1 or 0x2 or 0x6 or 0x10 or 0xF, it has a Stick buttons.
> 

I will check this as soon as I can (I don't have access to the laptop
right now).

> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Juanito [mailto:juam+kernel@posteo.net] 
> Sent: Sunday, September 10, 2017 3:22 AM
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Pali Rohár <pali.rohar@gmail.com>
> Cc: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; linux-input@vger.kernel.org; Paul Donohue <linux-kernel@paulsd.com>
> Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
> 
> On 09/09/2017 08:12 PM, Dmitry Torokhov wrote:
>> On Sat, Sep 09, 2017 at 10:36:06AM +0200, Pali Rohár wrote:
>>> On Saturday 09 September 2017 10:12:42 Juanito wrote:
>>>> Hello,
>>>>
>>>> On 09/08/2017 08:48 AM, Pali Rohár wrote:
>>>>> On Friday 08 September 2017 07:00:34 Juanito wrote:
>>>>>>> ThinkPad with ALPS? Should not be it Synaptic? Maybe 
>>>>>>> miss-detection?
>>>>>>
>>>>>> Sorry, I forgot to mention this. The ThinkPad came with a clickpad 
>>>>>> I **really** disliked, so I bought this on the Internet.
>>>>>
>>>>> So, here is a problem. ThinkPads works with Synaptic touchpads, not 
>>>>> with ALPS.
>>>>
>>>> There definitely seems to be a problem here :)
>>>>
>>>> Do you mean that the alps code might not be detecting the trackpoint 
>>>> because probably the red thingie works with synaptics?
>>>>
>>>> So could this be the situation:
>>>> ALPS driver: Hey touchpad! Do you have a trackstick?
>>>> ALPS touchpad: No, I don't.
>>>> AD: Ok! (and thinks 'I am going to have to ignore all trackstick 
>>>> packets that might arrive')
>>>>
>>>> So the driver understands that there can't possibly be any buttons 
>>>> because there is no trackstick?
>>>
>>> IIRC ALPS touchpad hardware itself does not work with non-ALPS 
>>> trackpoint.
>>>
>>> Masaki, any comments?
>>>
>>>>>> If by trackstick you mean the red thingie, it is **not** working.
>>>>>
>>>>> Ok. And it is working with your patch?
>>>>
>>>> No, it isn't :(
>>>
>>> I expected... You just created franken-hardware.
>>>
>>> Looks like with your hack patch it is possible to make buttons 
>>> working, but I suspect that trackstick would.
>>>
>>> Maybe Masaki can provide more information about this fact if we can 
>>> do anything.
>>>
>>> Dmitry, what you as maintainer going to do with this problem?
>>
>> It really depends on Ota-san response. If ALPS needs a special version 
>> of firmware flashed for proper trackstick identification, then I guess 
>> Juanito will have to carry a local patch. I do not think we want to 
>> complicate the driver any further for supporting such after-market 
>> modification.
>>
> 
> If this only happens in this after-market (or franken-hardware...
> hahaha), I'd totally understand if you didn't want to patch it upstream, although it would be nice for me :)
> 
>> Does booting with psmouse.proto=imps makes trackstick work?
>>
> 
> I am afraid I can't test it now as I don't have access to the laptop. I won't be able to test until two weeks. Will definitely do as soon as I can.
> 
>> Thanks.
>>
> 
> Thank **you** (Dmitry and everybody esle) for taking the time to look at this.
> 
> Juanito
> 


Thank you very much!

Best regards,
Juanito

