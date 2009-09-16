From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 15:43:19 +0800
Message-ID: <4AB09717.6040704@gmail.com>
References: <4AB0929D.4030007@gmail.com> <20090916073207.GI2756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.211.180]:34067 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZIPHn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 03:43:28 -0400
Received: by ywh10 with SMTP id 10so3257503ywh.1
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 00:43:32 -0700 (PDT)
In-Reply-To: <20090916073207.GI2756@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, Sep 16, 2009 at 03:24:13PM +0800, Xiangfu Liu wrote:
>> Hi
>>
>> I know in the IBM laptop, you use Fn + F1 to do something.
>> I want [Fn + U = 7] in my device. 
>> when you press Fn + U in the terminal it will display '7'.
>>
>>
>> I look into the keyboard.c file.
>> but don't know which function is handle the Fn key?
>>
>> there is [1] in the keyboard.h file. I don't know 
>> which Fn key belong. is it KT_SHIFT???
>>
> 
> Fn in laptops usually handled by firmware (OS does not see the scancode
> for Fn at all). In your driver you will probably have to handle it
> manually and adjust which keycode you emit (KEY_Y or KEY_7) depending on
> whether Fn is active or not. I'd recommend not hardcoding KEY_* but
> actually "shift" to different part of driver keymap so userspace could
> change the keycodes if it wishes to do so.
Hi Dmitry
 thanks for the reply.
see [1], I change the [Red arrow] key to [ALTGR] then I can easy change the 
defkeymap.map. make all the red keys work.

but for the [Blue Fn] key. I don't know how to make it work in keymap?
there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier keys.
all used. so I can not may the [Fn] to those four modifier keys.

can I make the leftAlt and rightAlt generate different keys?
like:
 LeftAlt + 'U' = Alt + 'U'
 RightAlt + 'U' = '7'

thanks for help.


[1] http://downloads.qi-hardware.com/hardware/mechanical/ben/2009_08_26/keyboard_problem_2.JPG
> 


-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
