From: Andrea <andrea.deangelis93@gmail.com>
Subject: Re: keyboard problem on linux
Date: Wed, 20 Jan 2016 10:29:45 +0100
Message-ID: <569F5389.8040800@gmail.com>
References: <569E3B62.6050407@gmail.com> <20160120001340.GC31589@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35221 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934038AbcATJ3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2016 04:29:47 -0500
Received: by mail-wm0-f43.google.com with SMTP id r129so122913356wmr.0
        for <linux-input@vger.kernel.org>; Wed, 20 Jan 2016 01:29:47 -0800 (PST)
In-Reply-To: <20160120001340.GC31589@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi, Dmitry
i've the same problem on console without X.
this is an output of evtest on console:
http://pastebin.com/4aWYYhwN
(as you can see, after a while i'm pressing Left_Alt (from line 434 of 
pastebin) or Left_Ctrl (from line 605 of pastebin) or Left_Shift (from 
line 786 of pastebin), these keys are released and then pressed again.
but when i press only left_shift for some seconds, the issue don't occurs.)

i haven't found nothing on BIOS settings, the only options relative to 
keyboard is:

Action Keys Mode:
[Enabled]: Requires pressing only F1 throug F12 to activate action keys
[Disabled]: Requires pressing FN Key + F1 throug F12 to activate action keys

but the problem occurs in both modes


Il 20/01/2016 01:13, Dmitry Torokhov ha scritto:
> Hi Andera,
>
> On Tue, Jan 19, 2016 at 02:34:26PM +0100, Andrea wrote:
>> [1.] i've a problem with keyboard of my notebook HP Pavilion 15
>> ab062nl; CTRL SHIFT and ALT buttons not works as they should. in
>> particular, it is as if these keys are pressed and released alone.
>> isn't an hardware problem, because on windows 10 and windows 8.1 i
>> haven't these problems, is only a linux problem (all distro).
>>
>> [2.] the bug is always active, every time i start a linux Distro
>> (also from live, and also without DE/WM) i've this problem with
>> keyboard, the only way to fix temporarily the bug, is pressing the
>> only Left SHIFT key for some seconds, then all problems disappear
>> indefinitely, and in any case, if i shutdown or if i reboot the PC,
>> the problem recurs.
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1532746
>
> Hmm, this is weird. Do you observe the same issue in text console (not
> in X)? It would be nice to see events as emitted by the kernel - you can
> use evtest utility for that.
>
> Is sounds like some accessibility feature, is there anything in BIOS to
> that effect?
>
> Thanks.
>
