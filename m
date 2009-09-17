From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Thu, 17 Sep 2009 10:31:56 +0800
Message-ID: <4AB19F9C.3080707@gmail.com>
References: <4AB0929D.4030007@gmail.com> <20090916163305.GB4970@core.coreip.homeip.net> <4AB11F49.6060308@gmail.com> <200909161040.20085.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:38683 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZIQCb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 22:31:57 -0400
Received: by yxe12 with SMTP id 12so20662yxe.1
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 19:32:00 -0700 (PDT)
In-Reply-To: <200909161040.20085.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wednesday 16 September 2009 10:24:25 am Xiangfu Liu wrote:
>> Dmitry Torokhov wrote:
>>> On Wed, Sep 16, 2009 at 10:44:01PM +0800, Xiangfu Liu wrote:
>>>> Xiangfu Liu wrote:
>>>>> Hi Dmitry
>>>>>
>>>>>>>  thanks for the reply.
>>>>>>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy
>>>>>>> change the defkeymap.map. make all the red keys work.
>>>>>>>
>>>>>>> but for the [Blue Fn] key. I don't know how to make it work in
>>>>>>> keymap? there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier
>>>>>>> keys. all used. so I can not may the [Fn] to those four modifier
>>>>>>> keys.
>>>>>>>
>>>>>>> can I make the leftAlt and rightAlt generate different keys?
>>>>>>> like:
>>>>>>>  LeftAlt + 'U' = Alt + 'U'
>>>>>>>  RightAlt + 'U' = '7'
>>>>>> Keyboard driver supports 9 modifiers total, you should be able use one
>>>>>> of these for your numeric buttons.
>>>>> oh. can you give me some tips on the other modifiers.
>>>>> how to define them?
>>>>> can I just change the defkeymap.map file?
>>>>> or I must change the source code?
>>>> Hi Dmitry I found this[1] in the 'man keymaps', three are 9 modifiers.
>>>> but the in defkaymap.map, there is alwasy like:
>>>>
>>>> control keycode  53 = Delete
>>>>
>>>> there is no ctrll in the defkeymap.map.
>>>> how to implement this?
>>>>
>>>> ShiftL + u = U
>>>> ShiflR + u = 7
>>> The same as with AltGr you need to do
>>>
>>> keycode XX = CtrlR
>>>
>>> and then
>>>
>>> keycode YY = u
>>> shift keycode YY = U
>>> ctrlr keycode YY = seven
>> Hi Dmitry
>> thanks for the reply. I test this, it's not work.
>> ----------
>> $ loadkeys -m defkeymap.map > defkeymap.c && rm defkeymap.o
>> loadkeys: defkeymap.map:71: adding map 64 violates explicit keymaps line
> 
> You need to fix this ^^^^ first.
> 
the line 71 is the "ctrlr ....", so I think the defkeymap.map not support 
the "ctrlr".





-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
