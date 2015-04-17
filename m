From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Unusual Focaltech driver behavior
Date: Fri, 17 Apr 2015 09:57:58 -0400
Message-ID: <CAN+gG=HGgdoBy1ugoawU2t6rkW1jq=HsBsWiq9T34d=fYvwaEg@mail.gmail.com>
References: <5530C7D2.8090106@gmail.com>
	<5530D8DE.7070604@gmail.com>
	<CAN+gG=G-uTfBNOjcQuFrRKcywwsb1HLtXg=TFnv0gPXaTuPc2A@mail.gmail.com>
	<55310D09.8010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34580 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbbDQN57 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2015 09:57:59 -0400
Received: by qgfi89 with SMTP id i89so21641806qgf.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2015 06:57:59 -0700 (PDT)
In-Reply-To: <55310D09.8010001@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Mathias Gottschlag <mgottschlag@gmail.com>

On Fri, Apr 17, 2015 at 9:39 AM, Dmitry Tunin <hanipouspilot@gmail.com> wrote:
>> Hi Dmitry,
>>
>> On Fri, Apr 17, 2015 at 5:56 AM, Dmitry Tunin <hanipouspilot@gmail.com> wrote:
>>>> I noticed that myself and got some complaints like this.
>>>> https://github.com/hanipouspilot/ubuntu-fixes/issues/2
>>>>
>>>> General issue is that when one finger is on the touchpad, movement of a second finger is ignored, if the first finger does not move.
>>>> Usually with other touchpads, when you have one finger on the touchpad and move the other, it is recognized as two-finger scrolling.
>>>> The device itself sends relative packages as normal in that case, but linux driver ignores them, until first finger is moved.
>>>>
>>>> I guess, Windows driver behaves same way. I can't test it, since I do not have Windows installed on that laptop.
>>>>
>>>> As I understood, Windows driver ignores that one finger is on button area and recognizes movement of the other as one-finger movement.
>>>>
>>>> It is clear that we do not know the full protocol or parameters of all touchpad models to have that button area always correct.
>>>> But it looks like button area is set when 3rd byte in abs package is 00. There is a good chance that it is common for all touchpad models.
>>>>
>>>> Do you have ideas how to fix it the easiest way?
>>>>
>>>> Regards,
>>>>
>>>> Dmitry
>>>>
>>>
>>> I looked at it some more and noticed that if I put one finger on touchpad, then another, then move the second one, rel packets are ignored.
>>> But if keeping both fingers on touchpad, I move the first one, rel packets work OK.
>>> This is wrong. I can't get what's wrong with the code at the moment.
>>
>>
>> It looks like your touchpad is in the mouse emulation mode, not the
>> raw touch mode. What you get is fed by the touchpad FW ans there is
>> nothing we can do in userspace to fix that.
>> That being said, there has been a lot of work with the focaltech
>> drivers in the previous kernel releases, and maybe trying a v4.0 will
>> switch your touchpad in the raw mode.
>> Once it is in raw mode, the software buttons, scrolling and gestures
>> are all treated in userspace and you will get the expected behavior.
>>
>> Cheers,
>> Benjamin
>>
>
> No, the mouse is in proprietary mode. Multitouch is supported. In emulation mode it is not supported at all.
> I am testing actually the driver from kernel 4.0. Everything works great except this strange problem, when some relative packets are ignored.
> I mentioned above the test case. Now I added some debug and trying to figure it out. But no success so far.
>
>

If you are in absolute (raw) mode, then can you share the evemu-record
of the gesture you are trying to support?
We should be able to see what is going on and be able to pinpoint if
this is a kernel problem or a user space problem.

Cheers,
Benjamin
