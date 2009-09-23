From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: Ben_Nanonote keyboard driver bug
Date: Wed, 23 Sep 2009 15:13:06 +0800
Message-ID: <4AB9CA82.5000302@gmail.com>
References: <4AB33A1A.7090508@gmail.com> <200909222337.26608.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:32872 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbZIWHNK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 03:13:10 -0400
Received: by pxi32 with SMTP id 32so408140pxi.4
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2009 00:13:14 -0700 (PDT)
In-Reply-To: <200909222337.26608.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Hard- and Software Development, Kernel, Distribution, Roadmap" <developer@lists.qi-hardware.com>, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Friday 18 September 2009 12:43:22 am Xiangfu Liu wrote:
>> Hi
>>
>> with Dmitry's help, our keyboard is work.
>>
>> we use the matrix_keypad.c driver. I found a problem.
>> for example. the keypad is like this: (part of keypad)
>> GPIO    GPIO    GPIO
>>
>> a_______w_______u_____GPIO
>>
>> |_______s_______j_____GPIO
>>
>> Shift___Alt_____Ctrl__GPIO
>>
>> first time press [Shift] + [a] it's output [a] not the [A]
>> second time press [Shift] + [a] it's output [A]. correct.
>> then all work fine.  but when I release the [Shift]. and press [a]
>> it's will also output big [A]. but if the midifier and character not
>> in same column GPIO. it will work fine.
>>
>> other modifier all like this. same GPIO will cause problem.
>>
>> I should look into the matrix_keypad.c to fix this, right?
>>
> 
> It would be interesting to see what events are being reported by either evbug 
> module or evtest utility.
> 
Hi Dmitry. I will try to look into the evbug or evtest. 
will send email when I have progress.

-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
