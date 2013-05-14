From: James M Leddy <james.leddy@canonical.com>
Subject: Re: Possible regression 3.8.7 -> 3.9 with Dell touchpad
Date: Tue, 14 May 2013 14:50:18 -0400
Message-ID: <5192876A.4060407@canonical.com>
References: <20130510193957.89870@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41414 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab3ENSuX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 May 2013 14:50:23 -0400
In-Reply-To: <20130510193957.89870@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tibor Billes <tbilles@gmx.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Dave Turvene <dturvene@dahetral.com>, Kevin Cernekee <cernekee@gmail.com>

On 05/10/2013 03:39 PM, Tibor Billes wrote:
> From: Dmitry Torokhov Sent: 05/10/13 12:54 AM
>>
>> On Thu, May 09, 2013 at 10:59:58PM +0200, Tibor Billes wrote:
>>> Hi,
>>>
>>> I found that after upgrading my kernel from 3.8.7 to 3.9 my touchpad only
>>> works partly. By that I mean I can use the touchpad to move the cursor
>>> around, but I cannot click with it by tapping.
>>
>> Is the touchpad recognized as ALPS or PS/2 mouse in 3.8.7? Also, can you
>> check that touchpad tapping is enabled in your desktop environment?
> 
> In 3.8.7 it is recognized as PS/2 mouse and the desktop environment doesn't even offer any touchpad settings. In 3.9.1 the touchpad is recognized as 'AlpsPS/2 ALPS DualPoint TouchPad' and yes, the touchpad settings appeared, and yes, clicking was disabled. Enabled it, works like a charm :)
> 
> So what happened is that the 3.8.7 kernel did not recognize my touchpad, so it fell back to PS/2 which worked well for me. The 3.9 kernel recongizes my touchpad correctly because Kevin updated the driver, and my system started using a different configuration as it knew it was a touchpad and not some PS/2 device. Am I right? I recall looking for touchpad settings in one of the 3.8.x kernels and I didn't find any so I didn't bother looking for it again in 3.9...
> 
> In this case I'm sorry for the false report, and thank you guys for the driver update :)

This sounds about right. I expect that if you enable tap to click in
your settings (should be under "Mouse and Touchpad" if you're using
gnome-control-center) you should be good.

> 
>> Thanks.
>>
>>> My machine is a Dell
>>> Latitude E5530. Since it is 100% reproducible on my machine, I bisected it,
>>> and found this commit:
>>>
>>> commit 1302bac33d9e88cd43e482191a806998f3ed43cc
>>> Author: Kevin Cernekee <cernekee@gmail.com>
>>> Date:   Wed Feb 13 22:27:08 2013 -0800
>>>
>>>    Input: ALPS - add support for "Rushmore" touchpads
>>>    
>>>    Rushmore touchpads are found on Dell E6230/E6430/E6530.  They use the V3
>>>    protocol with slightly tweaked init sequences and report formats.
>>>    
>>>    The E7 report is 73 03 0a, and the EC report is 88 08 1d
>>>    
>>>    Credits: Emmanuel Thome reported the MT bitmap changes.
>>>    
>>>    Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>>    Tested-by: Dave Turvene <dturvene@dahetral.com>
>>>    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>
>>> I did the bisection between 3.8.7 and 3.9, but also tried 3.9.1, it is bad
>>> too. I also tried reverting that commit to make sure that it really is
>>> what made my touchpad not working. The revert did fix my problem.
>>>
>>> That's all I gathered so far, but I'd be happy to help further in any way
>>> I can, just let me know.
>>>
>>> Thanks,
>>> Tibor
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> -- 
>> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

