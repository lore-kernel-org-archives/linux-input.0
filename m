From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 17:25:10 +0800
Message-ID: <4AB0AEF6.7020103@gmail.com>
References: <4AB0929D.4030007@gmail.com> <20090916073207.GI2756@core.coreip.homeip.net> <4AB09717.6040704@gmail.com> <20090916080607.GJ2756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f176.google.com ([209.85.216.176]:36150 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZIPJZN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 05:25:13 -0400
Received: by pxi6 with SMTP id 6so3862939pxi.21
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 02:25:16 -0700 (PDT)
In-Reply-To: <20090916080607.GJ2756@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

>>  thanks for the reply.
>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy change the 
>> defkeymap.map. make all the red keys work.
>>
>> but for the [Blue Fn] key. I don't know how to make it work in keymap?
>> there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier keys.
>> all used. so I can not may the [Fn] to those four modifier keys.
>>
>> can I make the leftAlt and rightAlt generate different keys?
>> like:
>>  LeftAlt + 'U' = Alt + 'U'
>>  RightAlt + 'U' = '7'
>>
> 
> Keyboard driver supports 9 modifiers total, you should be able use one
> of these for your numeric buttons.
> 

oh. can you give me some tips on the other modifiers.
how to define them? 
can I just change the defkeymap.map file?
or I must change the source code?




-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
