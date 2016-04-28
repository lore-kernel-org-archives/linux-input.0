From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: I'd like to donate an Asus Q500A laptop
Date: Wed, 27 Apr 2016 22:54:55 -0600
Message-ID: <CAMMLpeScA1qMpe07m92N_h+bPC13qmyuOKBF+5VSu63T0uAY_Q@mail.gmail.com>
References: <CAMMLpeSMi_pXSwHgMUy3MS_c0gaQgtSU6DHO1cN4qgAHC_dnmQ@mail.gmail.com>
 <CAMMLpeSFSsn14C_pp4dpPPs3rAsripMXetV0GJg9kM-gOvvt_w@mail.gmail.com> <57171045.5050507@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37184 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbcD1EzR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2016 00:55:17 -0400
Received: by mail-wm0-f41.google.com with SMTP id a17so44947383wme.0
        for <linux-input@vger.kernel.org>; Wed, 27 Apr 2016 21:55:16 -0700 (PDT)
In-Reply-To: <57171045.5050507@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, linux@rempel-privat.de

2016-04-19 23:14 GMT-06:00 fixed-term.Oleksij.Rempel
<fixed-term.Oleksij.Rempel@de.bosch.com>:
>
>
> On 20.04.2016 07:04, Alex Henrie wrote:
>> 2016-04-19 15:14 GMT-06:00 Alex Henrie <alexhenrie24@gmail.com>:
>>> Dear kernel developers,
>>>
>>> I have been trying to use Linux on an Asus Q500A laptop, but ran into
>>> a couple of problems:
>>>
>>> 1. The Caps Lock and Num Lock LEDs do not turn on
>>> 2. The volume control keys act like stuck letter keys (see
>>> http://ubuntuforums.org/showthread.php?t=2170285 for an example of
>>> another Q500A owner complaining about this)
>>>
>>> I am quite certain that these are both kernel bugs. I contacted the
>>> Asus platform driver maintainer, Corentin Chary, but he said that the
>>> bugs are more likely problems in the input drivers. If you are a
>>> kernel developer interested in looking into them, the Q500A is
>>> currently going for about $200-300 on eBay, which is low enough that
>>> it would not be a problem at all for me to just buy one and send it to
>>> you as a donation.
>>>
>>> Let me know, and thank you for your work on Linux!
>>
>> Correction: The Caps Lock LED works, the Num Lock LED does not. There
>> is no Scroll Lock LED.
>
>
> Hm... somewhat similar i already did for ASUS Zenbook ux31a. May be it
> is about ACPI and not about Input device driver. I can take this challenge.

Okay, this is weird: The Q500A-BSI5N04 has the bug, but the
Q500A-BHI5N01 does not have the bug. They look identical, and I
flashed the same BIOS firmware onto both. Maybe I should send you both
models so that you can compare the two...

-Alex
