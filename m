From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 22:44:01 +0800
Message-ID: <4AB0F9B1.90606@gmail.com>
References: <4AB0929D.4030007@gmail.com> <20090916073207.GI2756@core.coreip.homeip.net> <4AB09717.6040704@gmail.com> <20090916080607.GJ2756@core.coreip.homeip.net> <4AB0AEF6.7020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:48472 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZIPOoH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 10:44:07 -0400
Received: by fxm17 with SMTP id 17so2328911fxm.37
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 07:44:09 -0700 (PDT)
In-Reply-To: <4AB0AEF6.7020103@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Xiangfu Liu wrote:
> Hi Dmitry
> 
>>>  thanks for the reply.
>>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy change the 
>>> defkeymap.map. make all the red keys work.
>>>
>>> but for the [Blue Fn] key. I don't know how to make it work in keymap?
>>> there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier keys.
>>> all used. so I can not may the [Fn] to those four modifier keys.
>>>
>>> can I make the leftAlt and rightAlt generate different keys?
>>> like:
>>>  LeftAlt + 'U' = Alt + 'U'
>>>  RightAlt + 'U' = '7'
>>>
>> Keyboard driver supports 9 modifiers total, you should be able use one
>> of these for your numeric buttons.
>>
> 
> oh. can you give me some tips on the other modifiers.
> how to define them? 
> can I just change the defkeymap.map file?
> or I must change the source code?
> 
Hi Dmitry I found this[1] in the 'man keymaps', three are 9 modifiers.
but the in defkaymap.map, there is alwasy like:

control keycode  53 = Delete

there is no ctrll in the defkeymap.map.
how to implement this?
ShiftL + u = U
ShiflR + u = 7

thansk for help


[1]
Which  of  the  actions bound to a given key is taken when it is pressed depends on what modifiers are in effect at
       that moment.  The keyboard driver supports 9 modifiers. These modifiers are labeled (completely arbitrarily) Shift,
       AltGr,  Control, Alt, ShiftL, ShiftR, CtrlL, CtrlR and CapsShift.  Each of these modifiers has an associated weight
       of power of two according to the following table:

              modifier                weight

              Shift                     1
              AltGr                     2
              Control                   4
              Alt                       8
              ShiftL                   16
              ShiftR                   32
              CtrlL                    64
              CtrlR                   128
              CapsShift               256



-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
