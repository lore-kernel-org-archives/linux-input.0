From: Grateful Frog <gratefulfrog@gmail.com>
Subject: Re: [Asus UX303LN] F9 disable/enable Touchpad doesn't produce evdev
 event Edit
Date: Tue, 16 Jun 2015 09:28:55 +0200
Message-ID: <CAFoCoqUjhmwKivseHxQZB+CsxU3Brk_d5gsvVixm1nWf7h8u+w@mail.gmail.com>
References: <CAFoCoqUfhkw65U7rwTRyY6SU-0Vr619iO56Zt-PvHUS3k3J2ew@mail.gmail.com>
	<13554265.q0fZY7p6zo@sakuya>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36712 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbbFPH25 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 03:28:57 -0400
Received: by oial131 with SMTP id l131so5724261oia.3
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2015 00:28:56 -0700 (PDT)
In-Reply-To: <13554265.q0fZY7p6zo@sakuya>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Herkt <lachs0r@srsfckn.biz>
Cc: linux-input@vger.kernel.org

Yes, there are lots of people on the web talking about it, but I saw
no solutions... But there are also lots of Asus laptops where the
function keys do work, like my previous one, for example...

Just to be clear, the most important key for me is the touchpad
toggle, F9. The sleep and airplane mode I will never use. the screen
brightness is nice to have.  All the other keys DO work, though.

Thanks for taking this on!

I am available for more testing.

Cheers,
Bob

On Tue, Jun 16, 2015 at 6:26 AM, Martin Herkt <lachs0r@srsfckn.biz> wrote:
> On Monday 15 June 2015 22:46:46 Grateful Frog wrote:
>> I am reporting this bug according to the instructions.
>>
>> [1.]  One line summary of the problem
>> [Asus UX303LN] F9 disable/enable Touchpad doesn't produce evdev event
>>
>> [2.] Full description of the problem/report:
>> While booted into the newest mainline kernel (4.1.0-40100 -rc8)
>> The touchpad disable/enable hotkey (F9) does nothing. This makes it
>> very hard to use the machine since the touchpad is constantly
>> capturing random "mouse movements", making it impossible to enter text
>> in the right place.
>> Further, the F1,F2,F5,F6 keys do not work (sleep, airplane mode,
>> lower/higher screen brightness).
>
> Seems to be a common problem with ASUS laptops.
> http://www.spinics.net/lists/linux-input/msg38965.html
