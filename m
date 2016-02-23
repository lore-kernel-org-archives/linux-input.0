From: Andrea <andrea.deangelis93@gmail.com>
Subject: Re: keyboard problem on linux
Date: Tue, 23 Feb 2016 13:45:52 +0100
Message-ID: <56CC5480.6080305@gmail.com>
References: <569E3B62.6050407@gmail.com> <20160120001340.GC31589@dtor-ws>
 <569F5389.8040800@gmail.com> <56A92E09.9020009@gmail.com>
 <56CB1C44.8000004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36557 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbcBWMqF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 07:46:05 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so220259189wme.1
        for <linux-input@vger.kernel.org>; Tue, 23 Feb 2016 04:46:04 -0800 (PST)
In-Reply-To: <56CB1C44.8000004@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

seems that when i play game (on steam), i haven't any problem when i'm 
playing, but i'm not sure



Il 22/02/2016 15:33, Andrea ha scritto:
> the problem occurs also when i logout to login manager.
>
> for example if in this moment i haven't the problem (because i've
> pressed for some seconds MAIUSC key) and i logout, the problem occurs
> again infact sometimes, when i logout, and then i try to login again,
> the login manager doesn't accpet the password because the passowrd
> contains uppercase letters, but sometimes the OS don't take maiusc key
> (I hope I explained well)
>
> i hope that this information can be useful.
> thanks
>
> Il 27/01/2016 21:52, Andrea ha scritto:
>> i've installed the new kernel 4.5 RC1, but i've the same problem.
>> i've also tried start ubuntu with upstart, same problem.
>> i don't know why i've this strange problem.
>>
>> i've also tried GhostBSD on live (i don't know if this information can
>> be useful), the problems occurs also on BSD but seem that is less severe
>> than on Linux, because on BSD seems that the problem occurs only one
>> time every boot, then disappears without do nothing (don't need to press
>> MAIUSC key for some seconds).
>>
>> I hope that this bug can be solved.
>>
>>
>> Il 20/01/2016 10:29, Andrea ha scritto:
>>> Hi, Dmitry
>>> i've the same problem on console without X.
>>> this is an output of evtest on console:
>>> http://pastebin.com/4aWYYhwN
>>> (as you can see, after a while i'm pressing Left_Alt (from line 434 of
>>> pastebin) or Left_Ctrl (from line 605 of pastebin) or Left_Shift (from
>>> line 786 of pastebin), these keys are released and then pressed again.
>>> but when i press only left_shift for some seconds, the issue don't
>>> occurs.)
>>>
>>> i haven't found nothing on BIOS settings, the only options relative to
>>> keyboard is:
>>>
>>> Action Keys Mode:
>>> [Enabled]: Requires pressing only F1 throug F12 to activate action keys
>>> [Disabled]: Requires pressing FN Key + F1 throug F12 to activate action
>>> keys
>>>
>>> but the problem occurs in both modes
>>>
>>>
>>> Il 20/01/2016 01:13, Dmitry Torokhov ha scritto:
>>>> Hi Andera,
>>>>
>>>> On Tue, Jan 19, 2016 at 02:34:26PM +0100, Andrea wrote:
>>>>> [1.] i've a problem with keyboard of my notebook HP Pavilion 15
>>>>> ab062nl; CTRL SHIFT and ALT buttons not works as they should. in
>>>>> particular, it is as if these keys are pressed and released alone.
>>>>> isn't an hardware problem, because on windows 10 and windows 8.1 i
>>>>> haven't these problems, is only a linux problem (all distro).
>>>>>
>>>>> [2.] the bug is always active, every time i start a linux Distro
>>>>> (also from live, and also without DE/WM) i've this problem with
>>>>> keyboard, the only way to fix temporarily the bug, is pressing the
>>>>> only Left SHIFT key for some seconds, then all problems disappear
>>>>> indefinitely, and in any case, if i shutdown or if i reboot the PC,
>>>>> the problem recurs.
>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1532746
>>>>
>>>> Hmm, this is weird. Do you observe the same issue in text console (not
>>>> in X)? It would be nice to see events as emitted by the kernel - you
>>>> can
>>>> use evtest utility for that.
>>>>
>>>> Is sounds like some accessibility feature, is there anything in BIOS to
>>>> that effect?
>>>>
>>>> Thanks.
>>>>
